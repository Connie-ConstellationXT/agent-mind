# Chapter 3: RequiredInstrument

## The Setup

To actually press the 'h' key, the agent must ensure that the finger is physically aligned with the key. This is not just a semantic requirement—it is a concrete state in the world, represented as a statevector.

## RequiredInstrument — what, why, how (concise)

What it is

A RequiredInstrument is a declarative precondition in the intent DOM: a semantic label that names a world-state, resource, or capability that must be provided for the precept to execute successfully. It declares "I require X to be present" rather than describing how X is produced. Example labels: `finger_aligned_h_key`, `power_available`, `capability:touch_alignment`.

Why the system needs it

Explicit RequiredInstruments allow the agent to declare its dependencies clearly and separately from the action logic. This separation of concerns enables flexible binding strategies at runtime, where the agent can choose how to satisfy the requirement based on current context, available resources, and confidence levels.

### How it is interpreted 

1. A RequiredInstrument label is semantic, not a memory address. It names a perceptual or motor concept in the agent's ontology; it does not directly point at hardware or a fixed storage slot.
2. At runtime, the agent must consult its internal world model—a structured representation of what exists in its environment and its own state. This world model is the foundation for interpreting RequiredInstrument labels. The agent then attempts to bind the label to something concrete, typically by:
   - Perception outputs: a fused statevector computed from sensors (vision, proprioception, touch) that matches the concept.
   - Cached world-model entries: recent observations or previously computed statevectors.
   - Provider precepts: other precepts that, when executed, will produce the required state.
3. Matching uses a similarity/match score and optional constraints (shape, tolerance, temporal window). The intent DOM may carry metadata such as `type`, `constraints`, and `matchThreshold` to guide interpretation.

## Example: Precept for Pressing 'h' Key

```xml
<Precept name="PressHKey">
  <RequiredInstrument instrumentName="finger_aligned_h_key" type="statevector" />
  <H:Precept name="Actuate_Pin_17" id="A1B2-C3D4"/>
</Precept>
```


This XML shows a semantic precept: it names a procedure (`PressHKey`), declares a required world-state (`finger_aligned_h_key` of type `statevector`), and references a hardlinked turtle-0 actuator by GUID.

---
### Contract

- The DOM declares the need and optional constraints. It is intentionally silent about *how* the need is satisfied.
- The agent's semantic and sensorimotor subsystems decide how to bind the label: by perception, by composing provider precepts, or by hybrid strategies.
- The resolver should record provenance (which perceptron, which provider, match score, timestamps) whenever an instrument becomes provided.

Next (binding will follow)

Once this conceptual ground is clear, the next step is to document the runtime binding mechanics (perception matching, provider selection, confidence thresholds, yield/ retry behaviors, and logging). I can add that next as a focused, step-by-step runtime trace and a short provider example (`MoveFingerToH`) if you want.


