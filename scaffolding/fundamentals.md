# Intent Scaffolding Fundamentals

**Core Concepts**: Type-safe precepts, instruments, and basic execution model

---

## Purpose

Intent scaffolding is a TypeScript-inspired, hierarchical XML markup language for declaratively describing tasks, workflows, and goals for intelligent agents. It compiles to hardware-accelerated RALN networks while maintaining semantic continuity through ULEM (Universal Latent Embedding Microcode).

## Core Principles

### **1. Type-Safe Precept Structure**
- Every actionable item is a type-safe precept: `<Precept name="GenerateProjectArchitectureDoc">`, `<Precept name="SearchWorkspaceForCodeFiles">`, etc.
- Direct XML element naming is deprecated in favor of explicit type safety: `<GenerateProjectArchitectureDoc>` → `<Precept name="GenerateProjectArchitectureDoc">`
- There is no distinction between root intents and subtasks; all are precepts and can be nested arbitrarily.
- Avoid generic tags like `<Subtask>` or `<Task>`.

### **2. Hardware-Aligned Terminology**
- Use `RequiredInstrument` to align with RALN architecture
- Use `instrumentName`  for parameter names
- Instruments represent concrete dependencies needed for precept execution

### **3. Infinite Composability**
- A precept must not care if it's a root or child element
- Dependencies and provisions are declared, not hardcoded
- All precepts are modular and indifferent to their position in the hierarchy

### **4. Emergent Coordination through Learned Patterns**
- MLP models continuously observe all system activity (internal state, external signals, qualia patterns, physical manifestations)
- Neural networks learn behavioral signatures like "every time agent cracks an egg" or "system about to crash"
- MLPTrigger enables pure hardware event-driven activation: when learned pattern detected → instant precept/vigil activation
- Zero coordination overhead: daemons auto-spawn based on neural pattern recognition without explicit dependencies
- Creates biological-inspired reflexes in synthetic systems through emergent intelligence

## Basic Syntax

### **Precept Declaration**
```xml
<Precept name="MakeOmelette">
  <Description>Prepare and cook a basic cheese omelette</Description>
  
  <!-- Child precepts -->
  <Precept name="CrackEggs" />
  <Precept name="CookEggs" />
</Precept>
```

### **Instrument Dependencies**
```xml
<RequiredInstrument instrumentName="eggs" quantity="2-3" alias="chosen_eggs" />
<RequiredInstrument instrumentName="non_stick_pan" />
```

**Instrument Universality**: `RequiredInstrument` treats all dependency types uniformly - physical objects (`eggs`, `pan`), knowledge (`recipe_knowledge`, `technique_mastery`), other agents (`chef_assistant`, `safety_monitor`), validated states (`ingredients_fresh`, `equipment_ready`), and abstract resources (`time_allocation`, `attention_capacity`) are all handled identically by the dependency resolution system.

### **Output Artifacts**
```xml
<Output>
  <Artifact name="finished_omelette">
    <Type>food_item</Type>
    <Description>Completed omelette ready to serve</Description>
  </Artifact>
</Output>
```

### **Constraints and Context**
```xml
<Constraint type="temperature">Medium heat throughout cooking</Constraint>
<Context type="food_preparation" />
```

**Note**: Optimization levels (E1-E5, GE) are **executive strategy**, not precept declarations. Precepts focus on capabilities and constraints; the executive manages computational elegance and complexity selection.

## Execution Model

### **Document Order Execution**
- Precepts execute from top to bottom (document order)
- Nested precepts run depth-first: parent → first child → second child, etc.
- This provides predictable, human-intuitive execution flow

### **Dependency-Driven Activation**
- Precepts check `RequiredInstrument` dependencies before executing
- If dependencies satisfied → execute

### **Dependency-Driven Activation**
- Precepts check `RequiredInstrument` dependencies before executing.
- If dependencies are satisfied → the precept executes.
- If required dependencies are missing → the **RESOLVE** system is invoked immediately. RESOLVE queries for providers using the canonical priority order (Priority 1: Active runtime / hot cache → Priority 2: Intent DOM / warm cache → Priority 3: Repository / cold storage) as defined in `dependency_resolution_architecture.md`.
- If RESOLVE returns uncertain results (low confidence, no candidates, or multiple equivalent options) → the **INFER** system performs simulation-based validation by executing candidate precept trees against a world model rather than physical reality. See `INFER_specification.md` for complete simulation architecture.
- The dependent precept yields (suspends) until the resolver locates a validated provider and the required instrument/artifact becomes available, or until a configured timeout/failure occurs. There is no semantic "NOP" or explicit flow control; the precept simply waits for its dependencies to be satisfied before proceeding.
- How a provider is instantiated does not change this behavior — whether the provider was predeclared in the Intent DOM, resolved from cache, repository lookup, or validated through INFER simulation, the dependent precept simply yields until its dependency is satisfied. Execution order and yielding are therefore emergent from dependency-driven resolution and cache promotion policies.
- Yield/concurrency semantics are equivalent to a blocking call that returns when the artifact is produced; function-call style delegation and yield-based concurrency are unified under the same resolution semantics.

### **Artifact Pipelining**
```xml
<Precept name="CrackEggs">
  <Output>
    <Artifact name="cracked_eggs" />
  </Output>
</Precept>

<Precept name="SeasonEggs">
  <RequiredInstrument instrumentName="cracked_eggs" />
  <Output>
    <Artifact name="seasoned_eggs" />
  </Output>
</Precept>
```

## Domain and Context Integration

### **Domain References**
```xml
<Domains>
  <Domain ref="kitchen" />
  <Domain ref="food_safety" />
  <Domain type="culture" ref="FrenchCuisine" />
</Domains>
```

### **Behavioral Control Elements**
Use semantic elements that affect agent reasoning:
- `Context` - Provides situational information for agent reasoning
- `Source` - Indicates information source for credibility assessment  
- `Location` - Enables spatial reasoning and resource proximity decisions
- `Purpose` - Guides goal alignment and optimization decisions

### **Yield-Safe Points and Background Monitoring**
```xml
<YieldSafePoint name="checkpoint_name">
  <StateVector>
    <State key="variable_name" value="current_value" />
  </StateVector>
  <WaitCondition duration="expected_time" reason="explanation" />
</YieldSafePoint>

<Vigil name="background_monitoring" 
       frequency="every_30s" 
       during="checkpoint_name">
  <Description>Optional periodic monitoring when attention is available</Description>
  <Action>Check status or perform light maintenance</Action>
  <Condition>Only if not busy with other tasks</Condition>
</Vigil>
```

**Yield-Safe Points** declare explicit checkpoints where precept execution can be safely interrupted and resumed later. They capture sufficient state to enable context switching without losing progress.

**Vigils** represent background monitoring tasks that run periodically when the executive has spare attention. Unlike interrupts, vigils are optional and only execute when the agent is not busy with higher-priority tasks. The executive/runtime may wake vigil tasks earlier than their scheduled frequency if conditions warrant attention.

## RALN Compilation Target

### **Hardware Alignment**
- Precepts compile to RALN goal/instrument/domain/compressedstate parameters
- `RequiredInstrument` maps to RALN input requirements
- `Output` artifacts map to RALN state transitions
- Context and domain references enable deterministic network topology selection

### **Semantic Continuity**
- ULEM (Universal Latent Embedding Microcode) maintains semantic meaning across compilation
- Human-readable scaffolds → RALN networks without semantic loss
- Hardware acceleration while preserving intent semantics

---

## Key Differences from Traditional Programming

| Traditional Code | Intent Scaffolding |
|------------------|-------------------|
| Imperative steps | Declarative goals |
| Function calls | Precept dependencies |
| Return values | Artifact outputs |
| Control flow | Document order + dependencies |
| Error handling | Constraint validation |
| Resources | Instruments |

---

**Next:** See `dependency_resolution_architecture.md` for advanced dependency patterns, `staging_and_execution.md` for execution control, and `capability_system.md` for RESOLVE mode integration.