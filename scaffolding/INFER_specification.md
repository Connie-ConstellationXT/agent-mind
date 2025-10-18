## Operational model (canonical)

INFER is a first-class runtime mirror that runs alongside EXECUTE; it is not merely an occasional fallback. The runtime architecture treats each precept instantiation as two concurrent job descriptors (mirrors): an EXECUTE mirror (physical world) and an INFER mirror (simulation). Both mirrors may run continuously, perform resolution, and produce candidate outcomes. RESOLVE, INFER and EXECUTE are complementary components of a single, integrated runtime system.

When to consult INFER:
 - Any subsystem may consult INFER's simulation outputs as a soft prior (resolver cache) to bias selection.
 - INFER is especially valuable when candidate outcomes differ in expected risk, when multiple plausible strategies exist, or when costs of physical trial are high.
 - INFER is also used continuously to populate resolver caches and to monitor predictive health (verbosity/health fields). These continuous outputs are considered canonical inputs to the resolver policy rather than exceptional fallbacks.
# INFER & EXECUTE: Dual-Mirror Runtime Architecture

**Core principle**: Every precept instantiation spawns two paired, first-class job descriptors (mirrors) that cooperate under the executive's cooperative-multitasking scheduler.

---

## Runtime Mirrors

### **EXECUTE Mirror**
- **Application surface at Turtle-0**: Physical world (reality)
- **Semantics**: Direct hardware/embodied sensor feedback; real consequences
- **Termination**: Actual actions in the agent's environment

### **INFER Mirror**
- **Application surface at Turtle-0**: Predictive neural network world model (simulation)
- **Semantics**: Same intent scaffolding execution; simulated sensors and actuators
- **Termination**: Actions projected into the agent's mental model

---

## Cooperative Multitasking & Mirror Yield

Both mirrors run concurrently in the cooperative scheduler. Each mirror maintains its own:
- Dependency resolution state
- Provider/precept bindings
- Instrument view and cache

**Yield Protocol**: When a mirror cannot find required instruments or providers, it yields CPU/scheduler priority to its counterpart. This allows the better-equipped mirror to advance. The system is fully symmetric — either mirror may be the first to resolve a plan.

**Outcome**: The exec merges mirror results (freshness, confidence, safety policies, and XML fallback rules). Neither mirror is inherently primary; the most useful plan emerges from the mirror-yield interplay.

---

## The Blinkenlights Panel

The blinkenlights panel is a **usage dashboard**, not a mode switch:
- Reports where runtime spends most busy cycles (EXECUTE-dominant, INFER-dominant, or mixed)
- Shows health/verbosity of the predictor (quiet, chatty, shouting)
- Displays per-mirror confidence and drift estimates

The panel reflects reality: both mirrors always run. Operators see the locus of productive work, not a forced global mode.

---

## Precept Semantics Under Dual Mirrors

Every precept maintains identical structure in both mirrors:
- Same `<Requires>`, `<Provides>`, `<Action>` definitions
- Same dependency resolution logic
- Same artifact output contracts
- Only difference: terminal actions connect to different realities (physical vs. simulated)

Precepts are **indifferent** to which reality they write to — the scaffolding is substrate-agnostic.

---

## Mirror Switching & Emergent Preference

The mirror-yield mechanism creates natural, emergent preference switching:

1. INFER generates predictions (resolver cache artifact) continuously in background.
2. If INFER finds a viable plan but EXECUTE is missing instruments, INFER mirror advances.
3. As sensor evidence or drift changes, INFER mirror's confidence updates; cached predictions shift.
4. Mirrors yield based on availability and freshness — the one with better evidence/confidence takes the lead.
5. No explicit switching rules; preference emerges from the cooperative dynamics.

**Why this works**: The predictor (INFER) never shuts up. It continuously updates its cache and health signals. EXECUTE watches these signals and yields when appropriate, allowing INFER to guide. When reality provides evidence that contradicts INFER's world model, EXECUTE reasserts priority. The interplay is continuous, dynamic, and driven by data, not by hardcoded mode transitions.

---

## Verbosity & Alarm States

The INFER predictor has internal verbosity levels:
- **Quiet**: Low prediction error, high confidence; predictor confidence > EXECUTE-led outcomes.
- **Chatty**: Moderate prediction error or uncertainty; predictor is informative but not commanding.
- **Shouting**: High persistent prediction error or anomaly detection (e.g., detected drift, conflicting sensor evidence). Shouting triggers DISRUPT-level handlers and may escalate to human-in-the-loop.

The blinkenlights panel displays verbosity; operators can monitor predictor health in real-time.

---

## ALARM 1204: Mirror Divergence & Manifold Alignment

ALARM 1204 fires when prediction error exceeds safe bounds. It applies both intrapersonally (within a single agent) and interpersonally (between agents). Both cases are unified by a geometric framework: manifold alignment and normalized distance.

### Intrapersonal 1204: Mirror Divergence

Within a single agent, ALARM 1204 detects when the INFER mirror (predicted state) diverges too far from the EXECUTE mirror (actual state):

- **INFER mirror**: Continuous simulation; maintains `predicted_state_manifold`.
- **EXECUTE mirror**: Physical reality; maintains `actual_state_manifold`.
- **Divergence metric**: `||predicted_state_manifold - actual_state_manifold||` (geometric distance between vertex clouds).
- **Threshold**: When divergence > `max_divergence_threshold`, predictor shouts. Example: you plan 10 code steps but write 0 lines; mental exhaustion is the alarm.



## World Model Interface

The world model accepts:
- Precept actions (same syntactic form as physical actions)
- Current state vectors
- Context and priors

And returns:
- Believable simulated state transitions
- Sensor readouts consistent with the simulation
- Prediction confidence and uncertainty estimates

The world model is **outside scope** (separate library/system) but is required for INFER mirrors to function.

---

## Design Principles

**1. Substrate Agnosticism**
- Precepts do not care whether Turtle-0 is physical hardware or a neural world model.
- Same execution semantics, different termination.

**2. Always-On Prediction**
- INFER runs continuously, not as an emergency fallback.
- Background chatter provides a constant epistemic check on EXECUTE's plans.

**3. Cooperative, Not Hierarchical**
- Neither mirror owns the other; they yield based on readiness and evidence.
- Emergent preference means no single rule prescribes "use INFER when..." or "use EXECUTE when..."

**4. Human Authority**
- Shouting (high alarm) brings human operators into the loop.
- Operators can audit both mirror outcomes and override based on domain expertise.

**5. Continuous Learning**
- Both mirrors log outcomes (actual vs. predicted) and update priors over time.
- Prediction errors feed back into INFER's world model for continuous refinement.

---

## Example: Typing Scenario

**Precept**: TypeCharacter  
**R:Precept call**: ComputeFingerDelta (capability:compute_finger_delta)

Both mirrors spawn:
1. **EXECUTE mirror**: Resolves to muscle-memory precept (last used, low latency). Sends motor command to physical hand.
2. **INFER mirror**: Simulates same muscle-memory command against world model. Predicts keystroke success.

If muscle-memory causes a keystroke error in EXECUTE:
- Sensor feedback (wrong key typed) updates EXECUTE's confidence.
- INFER continues simulating alternatives (visual, tactile).
- INFER's cache shows rising confidence for visual delta.
- On next keystroke, INFER may have found a better plan; both mirrors continue, and yield interplay favors whichever mirror is more confident.
- Preference shifts from muscle-memory to visual **naturally** as evidence accumulates.

---

## Precept Repository and Fallback

XML rules (onStall, <Fallback>) apply identically in both mirrors:
- If a mirror cannot resolve a precept, it attempts fallbacks in order.
- Fallbacks may succeed in one mirror and fail in the other.
- Asymmetric outcomes are expected and handled by merge policy (freshness, confidence thresholds).

---

**Status**: Architecture specification complete. Cooperative scheduler implementation, world model integration, and operator UI remain active development areas.