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

## Execution Model

### **Document Order Execution**
- Precepts execute from top to bottom (document order)
- Nested precepts run depth-first: parent → first child → second child, etc.
- This provides predictable, human-intuitive execution flow

### **Dependency-Driven Activation**
- Precepts check `RequiredInstrument` dependencies before executing
- If dependencies satisfied → execute
- If dependencies missing → wait (don't NOP immediately)
- Speculative execution: all precepts can spawn and wait for their conditions

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