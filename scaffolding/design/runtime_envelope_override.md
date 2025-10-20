# Runtime Envelope Override: Intent and Trigger Example

This document illustrates how runtime envelope overrides work in intent scaffolding. The example includes two XML code blocks:
1. **Intent Definition**: The precept with a performance envelope that can be overridden.
2. **Trigger Definition**: The `D:Precept` and `MLPTrigger` that activate the override.

---

## How It Works

### **Overview**
Runtime envelope overrides allow the system to dynamically adjust performance constraints during execution. This is useful for mitigating risks or adapting to changing conditions without modifying the original intent tree.

1. **Intent Definition**:
   - The intent defines a performance envelope with constraints (e.g., execution time, confidence).
   - The envelope is identified by an `id` attribute, allowing it to be referenced at runtime.

2. **Trigger Mechanism**:
   - An `MLPTrigger` or INFER simulation predicts a risky condition or recognizes a pattern linked to a fail state.
   - This activates a `D:Precept`, which applies an override to the relevant performance envelope.

3. **Override Application**:
   - The override is applied as a temporary layer in the runtime, leaving the original envelope intact.
   - The override persists as long as the triggering condition is active.

4. **Restoration**:
   - Once the condition is resolved, the override is removed, and the original envelope is restored.

---

## Example: XML Code Blocks

### **1. Intent Definition**
```xml
<IntentDOM root="CarryObjectDownStairs">
  <Precept name="CarryObject">
    <Description>Safely carry an object down the stairs.</Description>

    <PerformanceEnvelope id="kinesthetic_control">
      <Constraint name="execution_time" type="hard" max="100ms" />
      <Constraint name="confidence" type="soft" min="0.8" />
    </PerformanceEnvelope>

    <Action>Perform kinesthetic movements to descend stairs.</Action>
  </Precept>
</IntentDOM>
```

### **2. Trigger Definition**
```xml
<D:Precept name="BalanceCorrection">
  <Description>Triggered by MLP or INFER to handle potential imbalance.</Description>

  <MLPTrigger model="balance_model"
              symbol="potential_imbalance"
              confidence_threshold="0.85" />

  <EnvelopeOverride target="kinesthetic_control">
    <Constraint name="execution_time" type="hard" max="50ms" />
    <Constraint name="confidence" type="soft" min="0.9" />
  </EnvelopeOverride>
</D:Precept>
```

---

## Explanation

1. **Intent Definition**:
   - The `CarryObject` precept includes a `PerformanceEnvelope` with constraints on execution time and confidence.
   - The envelope is identified by `id="kinesthetic_control"`, making it accessible for runtime overrides.

2. **Trigger Definition**:
   - The `BalanceCorrection` `D:Precept` is activated by an `MLPTrigger` when the `balance_model` detects a potential imbalance with a confidence ≥ 0.85.
   - The `EnvelopeOverride` modifies the `kinesthetic_control` envelope, tightening the constraints to reduce execution time and increase confidence.

3. **Runtime Behavior**:
   - When the `MLPTrigger` fires, the runtime applies the override to the `kinesthetic_control` envelope.
   - The override persists as long as the triggering condition is active.
   - Once the condition is resolved, the override is removed, and the original envelope is restored.

4. **Outcome**:
   - The system dynamically adapts to the predicted imbalance, ensuring safer and more precise movements while carrying the object down the stairs.

---

This example demonstrates how runtime envelope overrides enable dynamic adaptation in intent scaffolding, improving safety and reliability in complex scenarios.