# Staging and Execution Control

**Execution Management**: Staging phases, sync points, temporal optimization, and speculative execution

---

## Overview

The staging system provides execution control through phases that create natural boundaries for state management, context switching, and temporal optimization. Combined with speculative execution, this enables efficient parallel processing while maintaining predictable execution order.

---

## Staging Phase Types

### **Preflight Staging**
```xml
<StagingPhase type="preflight" name="quality_assurance">
  <Description>Automatic validation when precept is imported</Description>
  
  <!-- Validation happens during Intent DOM loading -->
  <ValidateInstrumentCondition instrument="eggs" conditionSet="freshness" domain="food_safety" />
  
  <Output>
    <Artifact name="ingredients_validated">
      <Type>validation_data</Type>
      <Description>All ingredients validated for cooking</Description>
    </Artifact>
  </Output>
</StagingPhase>
```

**Characteristics:**
- **When**: Executed during Intent DOM loading
- **Purpose**: Validate dependencies before execution starts
- **Failure Mode**: Prevents Intent DOM from becoming ready
- **Caching**: Results cached in Intent DOM scope (Priority 2)

### **Execution Staging**
```xml
<StagingPhase type="execution" name="ingredient_preparation">
  <Description>Hot execution phase with state vector boundaries</Description>
  
  <Precept name="CrackEggs" quantity="2-3" into="bowl" />
  <Precept name="SeasonEggs" with="salt_pepper" />
  
  <Output>
    <Artifact name="ingredients_ready">
      <Type>instrument</Type>
      <Type>state_vector</Type>
      <Description>All ingredients prepared and ready for cooking</Description>
    </Artifact>
  </Output>
</StagingPhase>
```

**Characteristics:**
- **When**: Executed in document order after preflight validation
- **Purpose**: Actual work execution with state vector boundaries
- **Failure Mode**: Can be resumed from staging boundary after context switch
- **Caching**: Outputs cached in active runtime (Priority 1)

## State Vector Boundaries

### **Purpose**
Staging phases enable context switch resilience by creating natural checkpoints where execution can be paused and resumed without losing critical state.

### **Decision Criteria**
Use staging boundaries where: *"You don't need to remember fine-grained state across stage boundaries"*

### **State Vector Simplification**
```xml
<!-- Complex internal state during execution -->
<Precept name="ingredient_preparation">
  <Precept name="CrackEggs" /> <!-- → cracked_eggs artifact -->
  <Precept name="SeasonEggs" /> <!-- → seasoned_eggs artifact -->
  <Precept name="WhiskEggs" />  <!-- → whisked_eggs artifact -->
  
  <!-- Simplified to single state vector at stage boundary -->
  <Output>
    <Artifact name="ingredients_ready">
      <Type>state_vector</Type>
      <Description>All ingredients prepared</Description>
    </Artifact>
  </Output>
</Precept>
```

## Temporal Optimization

### **Sleepable Steps**
```xml
<Precept name="HeatPan" hasSleepableSteps="true">
  <Action>Place pan on stove and set to medium heat</Action>
  
  <Action ref="WaitForHeat" sleepable="true">Wait for proper temperature
    <IdleWait duration="1m" reason="Pan heating" />
  </Action>
  
  <Action>Add butter and swirl to coat</Action>
</Precept>
```

**Key Attributes:**
- `hasSleepableSteps="true"` - Declares precept has steps that can yield control
- `sleepable="true"` - Marks specific actions that can yield to other precepts
- `IdleWait` - Declares natural waiting periods for temporal optimization

### **Concurrent Execution Tracks**
```xml
<StagingPhase type="execution" name="concurrent_preparation">
  <!-- Equipment track -->
  <Precept name="equipment_prep">
    <Precept name="HeatPan" hasSleepableSteps="true">
      <!-- 1-minute sleepable wait for pan heating -->
    </Precept>
  </Precept>

  <!-- Ingredient track (runs during pan heating) -->
  <Precept name="ingredient_prep">
    <Precept name="CrackEggs" />
    <Precept name="SeasonEggs" />
    <Precept name="WhiskEggs" />
  </Precept>
</StagingPhase>
```

The executive can switch between tracks during sleepable steps, enabling natural concurrency.

## Synchronization and Coordination

### **Sync Points**
```xml
<SyncPoint name="ReadyToCook">
  <WaitForPrecept ref="WhiskEggs" />
  <WaitForPrecept ref="HeatPan" />
</SyncPoint>
```

**Usage:**
- Explicit coordination between parallel execution tracks
- Ensures all prerequisite precepts complete before continuing
- Can specify specific outputs for complex precepts

### **WaitForPrecept Patterns**
```xml
<!-- Single output precepts (output optional) -->
<WaitForPrecept ref="HeatPan" />

<!-- Multiple output precepts (output recommended) -->
<WaitForPrecept ref="ObserveFloat" output="fresh" />

<!-- Explicit documentation (output for clarity) -->
<WaitForPrecept ref="WhiskEggs" output="well_combined" />
```

## Speculative Execution Model

### **Execution Philosophy**
All precepts spawn and attempt to execute immediately, but check dependencies before actual execution:

```xml
<Precept name="AddEggs">
  <RequiredInstrument instrumentName="pan_ready" />
  <!-- Spawns immediately, waits for pan_ready to become available -->
</Precept>

<Precept name="HeatPan">
  <!-- Runs first in document order, produces pan_ready -->
</Precept>
```

### **Missing Dependencies**
When a precept finds dependencies missing:
- The Runtime invokes the RESOLVE process to locate providers of the missing instruments/artifacts.
- The dependent precept yields (suspends) until the required instruments/artifacts become available
- There is no semantic "NOP" or explicit flow control; the precept simply waits for its dependencies to be satisfied before proceeding.
- This allows natural concurrency, as multiple precepts can be waiting for their dependencies simultaneously.
- if a dependency cannot be resolved, the affected precept raises STALL and the parent precept must now handle that failure according to its own logic, such as trying alternative strategies or failing gracefully or propagating the failure up.


### **Dependency-Driven Activation**
```xml
<Precept name="FinishOmelette">
  <RequiredInstrument instrumentName="base_set" />
  <RequiredInstrument instrumentName="grated_cheese" />
  
  <!-- Only executes when BOTH dependencies are available -->
  <Action>Sprinkle cheese over half</Action>
  <Action>Fold omelette in half</Action>
</Precept>
```

## Document Order Execution

### **Predictable Sequencing**
```xml
<StagingPhase name="cooking">
  <Precept name="A">           <!-- 1st: Execute A -->
    <Precept name="A1">         <!-- 2nd: A's first child -->
      <Precept name="A1a">      <!-- 3rd: A1's first child -->
      <Precept name="A1b">      <!-- 4th: A1's second child -->
                                <!-- Complete A1 here -->
    </Precept>
    <Precept name="A2">         <!-- 5th: A's second child -->
  </Precept>
  <Precept name="B">            <!-- 6th: Execute B -->
</StagingPhase>
```

### **Natural Dependency Resolution**
Document order provides implicit dependency ordering - earlier precepts typically produce artifacts that later precepts consume.

### **Depth-First Traversal**
- Parent precept starts
- First child executes completely (including its children)
- Second child executes completely
- Parent completes

## Context Switch Protocols

### **Staging-Based Resilience**
```xml
<ContextSwitchProtocol>
  <Step>Preserve staging phase completion status in volatile cache</Step>
  <Step>Store current stage output state vector (simplified)</Step>
  <Step>Log stage boundaries for resumption points</Step>
  <Step>On resumption: validate stage outputs and continue from last completed stage</Step>
</ContextSwitchProtocol>
```

### **State Vector Boundaries**
- Staging phases create natural checkpoints
- Complex internal state simplified to single state vectors at boundaries
- Context switches can only occur at staging boundaries (not mid-precept)
- Resumption validates state vectors and continues from last completed stage

## DISRUPT Handler Integration

### **Emergency Precepts**
```xml
<D:Precept name="HandleBurnInjury" 
           providing="capability:emergency_response AND domain:kitchen_safety">
  <!-- Outside normal staging - preloaded for immediate activation -->
</D:Precept>
```

**Characteristics:**
- Outside normal staging workflow
- Pre-validated during Intent DOM loading
- Cached for zero-latency activation during DISRUPT events
- Can interrupt normal execution at staging boundaries

### **DISRUPT as Intent DOM Generator**
DISRUPT handlers generate new Intent DOMs that get injected into the execution queue:

```
DISRUPT(spill_detected) → 
  Generate new Intent DOM:
  <IntentDOM root="SpillResponse" priority="critical">
    <Precept name="ImmediateResponse" />
    <Precept name="AssessSpillType" />
    <Precept name="SelectCleanupMethod" />
  </IntentDOM>
```

---

**Related:** See `dependency_resolution_architecture.md` for execution priorities, `preflight_validation.md` for validation patterns, and `disrupt_handlers.md` for emergency response patterns.