Executive — Runtime Router (Apollo-inspired)

Purpose
- Define an executive (runtime router) modeled on the Apollo Guidance Computer executive for intent-scaffolding agents.
- Provide a canonical design for job queues, interrupts (DISRUPT / M), reshuffling, atomic mutations, and error semantics (mapping to legacy 1201/1202 style alarms).

Core concepts
- Job Descriptor (JD): { id, preceptRef, priority, realtime_promise, deadline, resources[], estimated_cost, state }
- JD storage model (AGC-style vectors):
  - Following AGC practice, Job Descriptors should be implemented as compact vector tables (thin descriptors) that reference the actual job data stored in erasable runtime memory. The JD vector contains pointers/offsets to the intent DOM root, resolver frames, and any per-job state rather than embedding large DOMs inline in the descriptor.
  - Benefits: fast, predictable admission checks (inspect vector fields), minimal descriptor copy cost when scheduling, and clear separation between descriptor metadata and bulk DOM frames which live in erasable memory and are managed lifecycled by the executive.
  - Implementation note: maintain a free-list or slab allocator for erasable job frames so the executive can quickly allocate/deallocate DOM storage and account for VMFrameCount or accelSlotsNeeded at admission time.

- Intent DOM ownership (one intent DOM per JD):
  - Each Job Descriptor owns exactly one intent DOM — a self-contained, structured representation of the single intent the job will execute. The intent DOM includes the JD's preceptRef as its root and any transient child precepts, resource bindings, and parameters created for the job's execution.
  - Ownership semantics: the JD owns the DOM's runtime frames (resolver bindings, variable state, temporary artifacts). These frames are isolated to the JD to avoid cross-job interference and to make admission, preemption, and TAC semantics deterministic.
  - Resource implications: admitting a JD allocates measurable resources tied to its DOM and declared executionContext: memory for the DOM and resolver frames, VM frames and inference quota for "scaffold-vm", or reserved accelerated slots and warmed bindings for "accelerated". This is why job admission consumes headroom and must be checked by the executive.
  - Accounting & estimation: the JD's resources[] and estimated_cost fields should quantify per-context costs so the executive can perform admission checks and overload attribution (e.g., cacheHitRate, VMFrameCount, accelSlotsNeeded).
  - Lifecycle and cleanup: upon job completion, failure, or preemption (if the job is pageable), the executive must reliably free DOM-associated frames and quotas, update telemetry, and, if needed, persist a compact job trace for auditing.
  - Operational benefits: one DOM per JD makes TAC atomicity simpler (TAC can refer to the intent-tree being mutated), simplifies diagnostics (affected JD id + DOM snapshot), and enforces isolation that reduces resource contention and nondeterminism.

- Job List: ordered list of JDs (ready queue) plus wait sets, blocked sets, realtime set.
- Executive Core: scheduler + dispatcher + monitor + ISR layer.
- Memory model: erasable (volatile runtime state) + fixed (canonical precepts/docs). Volatile cache protocol integrates here.

- Checkpointing and recovery (AGC-inspired persistence):
  - Checkpoint principle: the executive should support compact, periodic checkpoints of minimal erasable state so the system can recover job progress across planned restarts or unexpected reboots. Checkpoints capture the JD vectors, pointers to intent DOM roots in erasable memory, minimal resolver snapshot (only fields needed to resume), timeslice counters, and resource reservation marks.
  - Atomicity and durability: write checkpoints atomically to a durable store (nonvolatile file, flash region, or replicated persistence) and persist any STOP/1202 diagnostics alongside. Ensure checkpoint writes are small and bounded to avoid long blocking in critical paths.
  - Recovery flow: on boot, the executive reads the latest checkpoint, rehydrates JD vectors and intent DOM roots (re-mapping erasable offsets to current memory layout or reloading preserved frames), reruns admission/resource checks, and resumes admitted jobs or demotes/prunes as necessary according to current resource availability. If accelerated admission fails during recovery, treat as 1202 and run immediate mitigation.
  - Frequency and policy: balance checkpoint frequency with runtime overhead; prefer application-level consistency points (job completion, TAC commit, or safe yield ticks) for checkpoints. Provide operators with configuration for checkpoint interval, retention, and safe-mode behavior after recovery.

- Execution Contexts (runtime execution modes and resource accounting)
  - Overview: The executive supports two primary execution contexts that reflect different resource models, latency expectations, and resolver/cache dependencies.

  - Accelerated / native context:
    - Intended for tasks whose resolver/cache state is rich and concrete (compiled or previously resolved precepts, cached implementations, warmed resources).
    - Characteristics: low-latency execution, minimal scaffolding overhead, constrained and predictable resource needs. Best for practiced, deterministic behaviors and strict realtime promises.
    - Resource model: conservative fixed-cost budget, favors cache hits and pre-bound resources.

  - Scaffolding / VM context ("scaffold-vm"):
    - Intended for tasks that require on-the-fly synthesis, inference, or runtime scaffolding (speculative RESOLVE, model inference, dynamic assembly of precepts).
    - Characteristics: higher latency, additional bookkeeping, dynamic resource consumption (memory for VM frames, inference cycles), and looser timing guarantees.
    - Resource model: elastic budget with higher per-job variance; often depends on resolver health and speculative warming.

  - JD hinting and selection policy:
    - Each Job Descriptor MUST declare an executionContext type: "accelerated" or "scaffold-vm". This declaration is a requirement for admission, not a mere preference.
    - On job admission the executive performs a context-specific resource check: it verifies that the resources required to run a JD in the declared executionContext are available (e.g., warmed cache and reserved accelerated slots for "accelerated", VM frames, resolver budget and inference quota for "scaffold-vm").
    - If the resource check succeeds the executive admits the new JD and schedules it according to its priority/realtime_promise/deadline. Admission may cause the active job (job 0) to be preempted or reshuffled per the preemption rules.
    - If the resource check fails the executive does not attempt implicit admission or optimistic migration at creation time — it bails with a deterministic alarm:
      - If the JD requested "scaffold-vm" and VM/resolve resources are insufficient => emit 1201 (Context/Control-loop Miss, scaffold-vm admission failure).
      - If the JD requested "accelerated" and accelerated resources (or disjoint realtime slots) are insufficient => emit 1202 (Overflow / STOP-level, accelerated admission failure).
    - Explicit migration between contexts (accelerated <-> scaffold-vm) remains an executive action but occurs only for already-admitted jobs and must account for the context-switch cost. Admission-time failures are classified immediately by the rules above rather than silently accepting and migrating.

  - Cost, accounting, and TAC interactions:
    - Account resources separately per context so that overload detection can attribute misses to context mismatch vs global exhaustion.
    - TAC operations that mutate the intent-tree may temporarily increase scaffold-vm load (synthesis/resolve steps). TAC should declare its expected context impact so scheduler heuristics can reserve headroom.

  - Guidance:
    - Prefer accelerated context for tight deadlines and realtime_promise-bearing JDs. Use scaffold-vm for identification, synthesis, or large structural edits.
    - Warm caches proactively for anticipated accelerated workloads when safe (speculative RESOLVE), and prefer conservative migration policies to avoid thrashing.

Interrupt model
- DISRUPT (D): true realtime external interrupt. Highest preemption authority. D handlers (D_ISR) may:
  - perform immediate context sync
  - mark or inject JDs into the realtime set
  - request preemption or resource reservation
  - must respect hard realtime invariants (no long blocking inside ISR)
- M (MLP): identification/recognition interrupt. Lower privilege than D. M handlers (M_ISR) may:
  - be generated directly by sensing pipelines or as a follow-up result from a D handler after parsing/latent-embedding and identification steps; M represents identification/recognition work rather than raw realtime servicing
  - identify signals and propose JDs (suggest jobs) to the executive
  - request TAC-style atomic tree mutation but do not directly preempt realtime tasks
  - can request soft-reschedule or enqueue jobs
- ISR Ordering: D ISR > TAC atomic ops > normal scheduling > M ISR proposals

Atomic mutation and TAC
- Use TAC (Tree Atomic Change) as the executive primitive for applying multi-step intent-tree mutations atomically.
- TAC should be executed by the executive with transactional semantics: lock affected subtree(s), apply changes, update Job List, release.

Scheduling policy
- Multi-queue scheduler with tiers:
  1. Realtime set: jobs with exclusive realtime_promise — preemptive, strict deadlines
  2. High priority: interactive / user-facing
  3. Normal / background
- Preemption rules: Realtime JDs can preempt lower tiers; D ISR can temporarily stall or reshuffle queues to satisfy realtime constraints.
- Soft limits: count and CPU budget heuristics to detect overload early.

- Timer tick and CCS (Count‑Compare‑Skip)
  - The executive's periodic yield/tick handler should execute an AGC-style CCS on the TIME6 counter to implement deterministic, low-cost rescheduling. CCS is a single instruction that atomically: loads a memory word, decrements it, classifies the original value into four categories (+, +0, -0, negative) and branches to one of four sequential targets.
  - Ones‑complement detail: +0 and -0 are distinct encodings in AGC; TIME6 counts down through +0 to -0 which CCS detects. When TIME6 reaches -0 it signals that a hardware T6 interrupt would fire but may be blocked; CCS detects this and lets software process the pending T6 work deterministically.
  - Typical CCS outcomes (mapped to the executive):
    - Positive (normal count > 0): return immediately (timer running)
    - +0 (rare): treat as diagnostic/soft-error (CCSHOLE)
    - -0 (the magic case): run the T6 job-check path now (process pending timer work / reschedule)
    - Negative / disabled: behave as timer-disabled (POSMAX) and return
  - Practical effect: a single deterministic 4‑cycle CCS in the yield handler performs the equivalent of multi-instruction test/decrement/branch logic and enables cooperative scheduling even when hardware interrupts are disabled. Use this path to trigger deadline checks, update timeslices, and move jobs between queues as a side-effect of the tick handler.
  - Implementation guidance: keep the CCS-based yield handler minimal and deterministic; any long processing triggered by -0 should enqueue JDs for normal execution rather than blocking the tick path.

Overflow / alarm semantics (1201 / 1202 analogs)
- See "Execution Contexts (runtime execution modes and resource accounting)" above for detailed definitions of the two contexts and their cost models.

- Simplified alarm definitions (spec built in context-first order):
  - 1201 (Context/Control-loop Miss, simplified): occurs when there are no available resources to instantiate a new Job Descriptor in the scaffold-VM context (i.e., the executive cannot admit a JD that explicitly requires or would fall back to the VM due to lack of VM/resolve resources). Treated as a recoverable/non-fatal alarm; remediation attempts should follow the scaffold-vm mitigation path (throttle, migrate, warm cache, demote background work, emit compact diagnostic).

  - 1202 (Overflow / STOP-level, simplified): occurs when there are no available resources even for an accelerated/native task — i.e., the executive cannot admit a JD that requires the accelerated context. This represents unrecoverable scheduling/resource conflicts for realtime or disjoint promises and should be treated as a STOP-level condition (prune conflicting JDs, emit STOP code like INTENT_REALTIME_PROMISE_NOT_DISJOINT, halt or isolate subsystems as policy dictates).

  - Accelerated/native admission semantics (clarification):
    - Tasks admitted into the accelerated/native context are by design very lightweight and bounded in CPU cost: the accelerated execution model assumes pre-warmed resources and short, deterministic instruction sequences so that realtime promises and timeslices complete predictably.
    - Therefore, failure to admit a correctly-declared accelerated JD is a strong signal that the system cannot complete currently scheduled timeslices on the available CPU budget. In other words, inability to create an accelerated job implies CPU exhaustion relative to realtime commitments, not merely a transient resolver or VM shortage.
    - Consequence: treat accelerated-admission failures as STOP-level events (1202). The executive should run immediate recovery: prune or demote lower-priority and non-disjoint JDs, emit rich diagnostics, persist or surface STOP codes to operators, and, if configured, isolate or restart overloaded subsystems.

- Note: The simplified 1201/1202 definitions make alarm classification deterministic and easy to reason about: attempt scaffold-vm remediation first (1201), escalate to STOP (1202) only when accelerated admission fails. For operational detail, map earlier cause lists and remediation steps (cache misses, TAC-heavy workloads, ISR thrash) into the scaffold-vm mitigation workflow when diagnosing 1201 events.

Monitoring & diagnostics
- Executive emits compact logs with mode+level tokens (e.g., D, M, E3, STALL, PRUNE, 1201, 1202-equivalents).
- Runtime telemetry: job latencies, preempt counts, TAC usage, ISR durations.

API / primitives (suggested)
- enqueueJob(JD)
- preemptJob(jobId)
- runTAC(tacDescriptor)
- registerISR(type, handler)
- emitAlarm(code, context)

Safety and rules
- No long blocking in ISRs; defer long work to enqueued JD.
- D must declare realtime_promise semantics; executive enforces disjointness or raises STOP.
- TAC atomicity required for multi-branch structural edits.

Example sequence
1. D ISR triggers on live speech; creates JD: HandleSpeech(realtime=true, deadline=now+200ms)
2. Executive preempts lower jobs, inserts HandleSpeech into realtime set.
3. M ISR later proposes a JD: IndexTranscript; executive enqueues it in high-priority (non-realtime).
4. If executive detects two conflicting realtime JDs that are not disjoint => emit STOP (1202-like) and run recovery (prune + diagnostics).

Notes
- This design stresses separation of identification (M) and realtime servicing (D), atomic structural edits (TAC), and explicit alarm semantics mapped to historical Apollo behavior for explainability.
- Keep executive small, deterministic, and auditable.

