# Intent Scaffolding Runtime Modes

This document defines the distinct runtime modes available in the intent scaffolding system. Each mode represents a unique operational context or phase in the lifecycle of intent execution.

---

## RESOLVE (R)
Fetches a cached precept or implementation for a component, similar to dynamic linking (e.g., `ld(1)`). Used when a task or component has been previously learned, practiced, or stored in memory. This mode enables rapid, low-latency retrieval of known solutions, minimizing inference cost and maximizing efficiency. If a precept is not found in the cache, the system may escalate to INFER mode. RESOLVE is the default for routine, well-understood actions.
The primary purpose of RESOLVE is to assist in the decomposition of complex tasks into manageable sub-tasks by leveraging previously learned or cached partial solutions.

## INFER (I)
Handles zero-shot or few-shot challenges, uncached tasks, or tasks requiring ongoing adaptation. Uses inference, synthesis, or reasoning to generate a solution or plan when no cached precept is available. INFER mode is invoked for novel, ambiguous, or complex problems where the agent must generalize from prior experience or improvise. This mode may involve machine learning, analogical reasoning, or creative synthesis, and is typically more resource-intensive than RESOLVE.

## EXECUTE (E)
Traverses the intent tree and triggers the execution of precepts and atoms of intent. This is the phase where actionable behaviors are performed, side effects occur, and the agent interacts with the environment. EXECUTE mode may include monitoring for success, failure, or unexpected outcomes, and can trigger runtime mutation or error handling if needed. It is the operational core of intent fulfillment.

## NAVIGATE (N)
Performs internal database or knowledge queries to gather contextual information required to fulfill the intent. NAVIGATE mode is strictly internal: it is used when the agent needs to look up facts, retrieve documentation, or consult its own knowledge base or memory. If the required information is not available internally, NAVIGATE reports STALL. At this point, INFER may reason about who to ask or which external resource (e.g., wiki, coworker) to query. The agent then uses a mix of RESOLVE, EXECUTE, and sometimes INFER to create a new branch under the in-progress precept, continuing until the original question is answered and EXECUTE can resume. NAVIGATE does not directly access external sources.

## LEAP (L)
Integrates the result of a successful gamma entrainment (creative breakthrough or eureka moment) into the active intent scaffold. LEAP mode represents a restructuring, shortcutting, or optimization of the scaffold based on new insight, compression, or abstraction. It is triggered by a semantic scaffold collapse or a eureka moment, allowing the agent to rapidly adapt, reframe, or generalize its approach. LEAP is essential for creative problem-solving and major efficiency gains.

## PURGE / PRUNE (P)
Removes components or subtrees from the intent tree, either for error handling, constraint violation, or as part of normal adaptation. This mode is invoked when a task becomes invalid, unsafe, or irrelevant, or when a constraint (such as fitness or legality) is violated. PURGE/PRUNE ensures that the agent does not waste resources on infeasible or undesirable actions. "Purge" is a legacy synonym for "prune," retained for backward compatibility.

## DISRUPT (D)
Handles external sensory input or asynchronous events, such as someone speaking to the agent or other real-time signals. DISRUPT mode is invoked when the agent receives input that acts as a disrupt—distinct from normal intent tree traversal or gearbox-driven optimization. These disruptions may carry real-time promises or demands that are not connectible to the gearbox (i.e., they cannot be scheduled, optimized, or deferred in the usual way). DISRUPT mode ensures that the agent can respond to urgent, context-shifting, or externally imposed events, such as speech, alarms, or environmental changes. Handling in this mode may involve prioritizing, queuing, or immediate context switching, and is essential for real-time, interactive, or safety-critical scenarios. The single-letter opcode for DISRUPT is `D`, aligning with the D state of Linux processes.

## M (Multilayer Perceptron)
Recognizes and maps (identifies) external or internal stimuli. 

If real-time support is required (such as for speech or other time-sensitive signals), this is handled by D (DISRUPT) mode. M and D may be used in rapid alternation for workflows like listening, but only D provides real-time guarantees and synchronous processing. Listening to speech that cannot be replayed requires realtime Processing. The agent only supports listening when its attention was called, such as by speaking its name.

Use Cases:
- Stimulus identification and mapping
- Pattern recognition
- Context mapping
M mode is designed for high-frequency identification and mapping, not for real-time or synchronous signal processing.

## STALL (S)

Indicates that a precept or component cannot currently fulfill its constraints or requirements. STALL is not necessarily a dramatic failure; it is simply a signal that, at this time, the agent does not know how to proceed. STALL can be triggered explicitly by a precept or implicitly by a timeout—both are functionally equivalent, representing the inability to fulfill the current intent. This signal may bubble up the intent tree for further handling, trigger fallback strategies, or prompt the agent to seek additional information or context. STALL supports graceful degradation and adaptive recovery in complex or uncertain situations.

---

## Special Operation: TAC

**TAC** (Tree Atomic Change) is a special, atomic runtime operation inspired by the Apollo guidance computer's "Count, Compare, Skip" and the highly specific instructions of x86 SSE. It is designed for rare, complex, or absurdly specific manipulations of the intent tree.

### TAC Operation Steps (Atomic):
1. Prune, add, or move a branch in the intent/precept tree (choose one action).
2. Swap the positions of any two branches in the tree.
3. Immediately activate (execute) a precept that was affected by the above operation.

All three steps are performed as a single, indivisible operation. TAC is intended for edge cases where normal runtime modes are insufficiently expressive or efficient.


#### Use Cases
- Accelerating specific, high-efficiency intent tree mutations in a single atomic step.
- Performing complex, multi-branch manipulations that would otherwise require multiple runtime passes.
- Enabling advanced workflows, optimizations, or creative recombinations inspired by hardware-level atomic instructions (e.g., SSE, CCS).


#### Notes
- TAC is not an exception handler or emergency-only operation; it is an accelerator for precise, atomic intent tree mutations.
- Use when atomicity, specificity, or performance is required for intent tree manipulation.
- The operation is intentionally non-standard and highly specific, reflecting its inspiration and intended use for advanced scenarios.

---

These runtime modes provide a flexible and robust framework for managing the lifecycle of intent execution, adaptation, and error handling in intelligent agents.
