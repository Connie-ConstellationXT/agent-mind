# Runtime Mode and Optimization Level Combinations

This document describes how operational concepts (NAVIGATE, LEAP, EXECUTE, PRUNE, DISRUPT, STALL, etc.) and optimization levels (E1–E5, GE) combine to form the **state transitions of a job descriptor** during its lifecycle. Job descriptors represent individual instantiations of intent trees.

**Key clarification**: These combinations describe states within a single job descriptor's lifecycle, not global system-wide mode switches. In the concurrent dual-mirror architecture, each mirror (EXECUTE job, INFER job) is its own job descriptor with independent state transitions. Both mirrors maintain separate operational states and may be in different modes simultaneously (e.g., EXECUTE in E1 while INFER is in NGE).

See `executive_runtime_architecture.md` for job descriptor semantics and the executive main loop.

---

## Syntax

Combinations are denoted as:

    <MODE><LEVEL>

Where:
- `<MODE>` is a runtime mode (e.g., INFER, EXECUTE, PRUNE)
- `<LEVEL>` is an optimization level (e.g., GE for gamma entrainment, 2 for low gear)

Examples:
- `IGE`: INFER mode running in Gamma Entrainment (GE) optimization level
- `E2`: EXECUTE mode running in optimization level 2 (low gear)

---

## Valid Combinations

- **IGE**: INFER mode + GE (gamma entrainment)
  - The agent is actively synthesizing or reasoning, leveraging creative or high-compression strategies (eureka moments, semantic scaffold collapse).
  - This is a valid and advanced operational state.

- **E2**: EXECUTE mode + 2 (low gear)
  - The agent is performing actions with minimal optimization, prioritizing reliability or safety over speed or efficiency.
  - This is a standard, valid state.

---

## Illegal/Invalid Combinations

- **PGE**: PRUNE mode + GE (gamma entrainment)
  - This is an illegal or nonsensical combination. Pruning is a constraint-driven, error-handling, or adaptation process, not a creative or high-compression operation.
  - GE is reserved for creative leaps, not for removal or error handling.

---

## Reference

- For runtime modes, see: `Intent Scaffolding Runtime Modes.md`
- For optimization levels, see: `Optimization Levels.md`


---

## Example: Logfile Walkthrough

Below is an example of a real-world logfile using runtime mode and optimization level combinations, with explanations for each line:

```
[timestamp] E1 [some description]
[timestamp] STALL
[timestamp(<1ms to the previous timestamp)] PRUNE
[timestamp] N1 [some description]
[timestamp] STALL
[timestamp] NGE
[timestamp(large interval)] L
[timestamp] E1
[timestamp] R1
[timestamp] E3
[timestamp(after some time)] HALT 0
```

**Explanation:**

- `E1`: EXECUTE mode, optimization level 1. The agent is performing an action in standard gear.
- `STALL`: The agent cannot proceed—requirements or constraints are unmet, or information is missing.
- `PRUNE`: Immediately after the stall, the agent prunes (removes) the current intent/subtree, likely as error handling or adaptation.
- `N1`: NAVIGATE mode, optimization level 1. The agent is performing an internal knowledge/database query.
- `STALL`: Again, the agent cannot proceed—internal query failed or was inconclusive.
- `NGE`: NAVIGATE mode, gamma entrainment (GE) optimization. The agent is now traversing the bounds of the query at an accellerating rate to force the storage controller to find a compressed representation of the query (the desired result)
- `L`: LEAP mode. After a significant delay, the agent has a creative breakthrough or eureka moment, restructuring the intent scaffold.
- `E1`: EXECUTE mode, optimization level 1. The agent resumes action, likely with a new or revised plan.
- `R1`: RESOLVE mode, optimization level 1. The agent retrieves a cached solution or precept.
- `E3`: EXECUTE mode, optimization level 3. The agent is now executing with greater optimization, possibly due to increased confidence or efficiency.
- `HALT 0`: The agent halts with code 0 (normal/clean shutdown or completion).

This sequence demonstrates how the agent transitions between modes and optimization levels in response to success, failure, adaptation, and creative breakthroughs.

---

## Example: Logfile with DISRUPT and STOP CODE

Below is an example logfile illustrating the use of DISRUPT (`D`) and a STOP code. For STOP code meanings, see: `STOPCODE_INTENT_REALTIME_PROMISE_NOT_DISJOINT.md` (or relevant STOP CODE documentation in this workspace).

```
[timestamp] E1 [some description]
[timestamp] D
[timestamp] E1
[timestamp] D
[timestamp] E1
[timestamp] D
[timestamp] E1
HALT STOP 0xE2
```

**Explanation:**

- `E1`: EXECUTE mode, optimization level 1. The agent is performing an action in standard gear.
- `D`: DISRUPT mode. The agent receives and handles an external sensory input or asynchronous event (e.g., speech, urgent signal). See `Intent Scaffolding Runtime Modes.md` for details on DISRUPT.
- `E1`: The agent resumes or continues execution after handling the disruption.
- `D`: Another DISRUPT event occurs and is handled.
- `E1`: Execution resumes.
- `D`: Yet another DISRUPT event is handled.
- `E1`: Execution resumes once more.
- `HALT STOP 0xE2`: The agent halts with STOP code 0xE2. The specific meaning of this code is documented in the STOP CODE documentation (see above reference).

This example demonstrates how the agent alternates between execution and handling disruptions, and how a STOP code is used to indicate a specific halt condition.

**Scenario:**

An agent is tasked with processing a critical system update. As it works (`E1`), it is repeatedly interrupted by urgent external events—such as multiple users issuing commands, system-level alerts, or environmental changes. Each time the agent resumes its main task, another disruption (`D`) occurs before meaningful progress can be made. After several cycles of resuming and being disrupted, the agent detects that it cannot make forward progress due to the frequency or severity of the disruptions. According to its safety or liveness guarantees, it halts with a STOP code (`HALT STOP 0xE2`), as defined in the STOP CODE documentation. This prevents deadlock or violation of real-time guarantees when mutually exclusive real-time promises cannot be resolved.


---
