# Operational Subsystems & Concepts

This document describes the core subsystems and concepts in the intent scaffolding runtime. The runtime architecture is based on **concurrent dual mirrors** (see `INFER_specification.md`): an EXECUTE mirror (physical world) and an INFER mirror (simulation) run in parallel, cooperating via a shared scheduler. This section defines the subsystems, operational modes, and atomic operations that work within that architecture.

---

## Core Runtime Subsystems

### RESOLVE
A capability-query subsystem used to enumerate and select candidate precepts from the repository. RESOLVE is invoked by both EXECUTE and INFER mirrors:
- Performs fast cache lookups (Priority 1, 2, 3 caches).
- Filters precepts by capability and context.
- Returns scored candidates with confidence estimates.
- Is not a global mode; it is a shared service called by both mirrors.

### EXECUTE Mirror
The job descriptor whose Turtle-0 termination is the physical world (reality):
- Traverses intent trees and triggers precept execution.
- Interacts with the environment through actual hardware.
- Maintains state vectors reflecting real outcomes.
- Runs concurrently with the INFER mirror.

### INFER Mirror
The job descriptor whose Turtle-0 termination is the predictive world model (simulation):
- Traverses identical intent trees in parallel with EXECUTE.
- Simulates precept execution against the agent's world model.
- Maintains predicted state vectors and confidence estimates.
- Continuously populates resolver cache artifacts (e.g., `finger_delta_cache`).
- Never shuts up: always running, always generating predictions.

**Cooperative multitasking**: If a mirror lacks required instruments/providers,it yields and the other mirror gets a timeslice, allowing the better-equipped mirror to advance. The mirrors do not interrupt each other; they cooperate via a scheduler and shared outcome merging policy.

---

## Operational Concepts

### NAVIGATE (N)
A capability that allows precepts to perform internal database or knowledge queries without leaving the intent tree. NAVIGATE is strictly internal:
- Used when the agent needs to look up facts, retrieve documentation, or consult its own knowledge base.
- If required information is not available internally, NAVIGATE reports STALL.
- Works within both EXECUTE and INFER mirrors (queries the agent's own models/databases).
- Does not directly access external sources; if external resources are needed, the precept escalates via DISRUPT or spawns a new sub-intent via normal resolution.

### LEAP (L)
Integrates the result of a successful creative breakthrough (eureka moment) into the active intent scaffold:
- Triggered by semantic scaffold collapse or sudden insight.
- Restructures, optimizes, or generalizes the current intent tree.
- Allows rapid adaptation and major efficiency gains based on new understanding.
- May be invoked by either mirror independently or by merged policy when both mirrors converge on a novel solution.

### PURGE / PRUNE (P)
Removes components or subtrees from the intent tree for error handling, constraint violation, or normal adaptation:
- Invoked when a task becomes invalid, unsafe, or irrelevant.
- Ensures resources are not wasted on infeasible actions.
- May be triggered by either mirror independently (e.g., INFER predicts a branch will fail; EXECUTE detects failure in real-time).
- "Purge" and "Prune" are synonyms; both remove subtrees.

### DISRUPT (D)
Handles external sensory input or asynchronous events (speech, alarms, environmental changes):
- Operates at the root level of the intent DOM.
- Receives input that cannot be scheduled or deferred in normal gearbox fashion.
- May interrupt or context-shift ongoing execution.
- Essential for real-time, interactive, and safety-critical scenarios.
- Works through D:Precepts (preloaded, high-priority emergency handlers).

See `disrupt_handlers.md` for comprehensive DISRUPT semantics, MLPTrigger usage, and emergency preparedness patterns.

### M (Multilayer Perceptron / Pattern Recognition)
Recognizes and maps external or internal stimuli:
- High-frequency pattern identification and stimulus classification.
- Used by INFER to detect predictive patterns and by EXECUTE to classify sensory input.
- Can trigger DISRUPT handlers via MLPTrigger references (NL-based signal matching).
- Designed for continuous, low-latency feature extraction, not real-time synchronous processing.
- Real-time signal processing (e.g., speech) is handled by DISRUPT mode.

### STALL (S)
Signals that a precept or component cannot currently fulfill its constraints or requirements:
- Not a failure; simply indicates the agent does not know how to proceed at this moment.
- Triggered explicitly by a precept or implicitly by timeout.
- May bubble up the intent tree for further handling, trigger fallbacks (onStall/Fallback rules), or prompt information-seeking.
- Supports graceful degradation and adaptive recovery.
- Either mirror may STALL independently; the exec merges outcomes and applies policy.

---

## Atomic Runtime Operations

### TAC (Tree Atomic Change)
A special, atomic runtime operation inspired by the Apollo guidance computer's "Count, Compare, Skip" and x86 SSE. TAC performs rare, complex, or specific manipulations of the intent tree in a single indivisible step:

**TAC Operation Steps (Atomic):**
1. Prune, add, or move a branch in the intent/precept tree (choose one action).
2. Swap the positions of any two branches in the tree.
3. Immediately activate (execute) the affected precept.

All three steps are performed as a single, indivisible operation. TAC is not an exception handler or emergency-only operation; it is an accelerator for precise, atomic intent tree mutations.

**Use Cases:**
- Accelerating specific, high-efficiency intent tree mutations in a single step.
- Performing complex, multi-branch manipulations that would otherwise require multiple passes.
- Enabling advanced workflows and creative recombinations inspired by hardware-level atomic instructions.

---

## Architecture Integration

All operational concepts (NAVIGATE, LEAP, PURGE, DISRUPT, M, STALL, TAC) work within the concurrent dual-mirror architecture:
- Both EXECUTE and INFER mirrors may invoke these concepts independently.
- When mirrors disagree (e.g., INFER predicts STALL but EXECUTE sees success), the executive applies merge policy.
- ALARM 1204 (mirror divergence or interpersonal ontology drift) may trigger escalation of these concepts to human-in-the-loop or reconciliation.

See `INFER_specification.md` for the dual-mirror architecture, cooperative multitasking, and ALARM 1204 semantics.

---

**Status**: Operational concepts framework aligned with concurrent dual-mirror runtime. Scheduler implementation and policy merge strategies remain active development areas.
