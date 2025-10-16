# Intent Scaffolding Key Concepts

Canonical definitions for precepts, atoms of intent, components, runtime modes, and optimization levels. Extracted from workspace notes and cleaned for standalone use.

**Updated**: October 16, 2025 - Enhanced with type-safe XML patterns and hardware-aligned RALN integration.

# Component
A component is a modular, reusable unit within the intent scaffolding system, analogous to a function, class, or DOM element in TypeScript or web development. Components can be composed hierarchically to form complex intent trees, and may represent abstract groupings, control logic, or concrete actions (precepts).

Set-theoretically:
- The set of all precepts is a subset of the set of all components.
- The set of all atoms of intent is a subset of the set of all precepts.
- Not all components are precepts, and not all precepts are atoms of intent.

# Intent Scaffolding: Key Concepts Glossary

## Atom of Intent
The most fundamental, irreducible unit of actionable behavior in an intent scaffolding system. An Atom of Intent consists of:
- A hardcoded behavior (e.g., a specific actuator command such as PWM control of a stepper motor).
- A weighted activation (e.g., intensity, duration, or probability of execution).

In nature, the smallest known atom of intent is the complete behavioral loop of chemotaxis—a minimal, self-contained decision/action cycle.

## Precept (Type-Safe)
A precept is an actionable component within the intent scaffolding system that can be directly executed or invoked by an agent. In the enhanced type-safe system:
- **Legacy**: Direct XML element naming (`<WriteGroceryList />`)
- **Type-Safe**: Explicit precept declaration (`<Precept name="WriteGroceryList" />`)

Precepts represent concrete actions, operations, or behaviors within an intent tree and compile to RALN networks with goal/instrument/domain/compressedstate parameters.

## Intent Tree
A hierarchical structure representing tasks, goals, and their dependencies. Each node may be a composite (containing subtasks) or a precept (an actionable leaf). Enhanced with staging phases for execution resilience and context switch boundaries.

## Declarative Markup
A TypeScript-inspired, hierarchical language for describing tasks, workflows, and goals for intelligent agents. Supports runtime mutation, adaptation, and context-sensitive execution. Enhanced with hardware-aligned terminology (instruments vs resources) and semantic behavioral control elements.

# The `resolve` Feature and Preflight Extensions in Cognitive Intent Scaffolding

## Overview

The `resolve` feature is a runtime mechanism within cognitive intent scaffolding that enables on-demand, lazy binding of symbolic placeholders to concrete implementations. It reflects models drawn from linkers (`ld(1)`), DNS lookups, and component-oriented architectures like React, Angular, or Blazor. This document details its intended function, the necessity of preflight assertion layers, and reactive runtime mutation strategies required by mutable reality.

## Conceptual Foundations

### Intent Scaffolding

Cognitive intent scaffolding assembles declarative structures representing high-level goals (e.g., "Go to the grocery store"). These structures are composed of symbolic components, each representing a subtask or dependency. Placeholders for these components may not have their implementation details resolved at declaration time.

### Example: Simple Declarative Intent for Lazy Evaluation (Updated)

Consider the following deceptively complete-looking scaffold:

```xml
<Precept name="WriteGroceryList" />
<Precept name="LeaveHouseToDrive" destination="grocery store" />
```

At first glance, this appears to be a fully resolved sequence of actions. However, `WriteGroceryList` is merely a symbolic placeholder at this stage. The renderer does not load the concrete implementation of this precept until it attempts to read from the instrument binding associated with it:

```typescript
const shoppingList = WriteGroceryList.instrumentOutput;
```

At this moment, the runtime invokes `resolve` to bind `WriteGroceryList` to a component capable of producing `contents` when asked for a `grocery list` .  Until this dereference occurs, the placeholder simply occupies space in the scaffold without any backing behavior. `Resolve` does not refer to a kind of finality that the term often carries in the english language. It behaves like DNS or `ld (1)`. `resolve`  means to "query the brain for any component that implements the required handler."

The purpose of this lazy evaluation is to avoid the upfront cost of resolving components that might never be dereferenced. In this example, if the intent page proceeds to mutate into a different plan before `WriteGroceryList.contents` is queried, no resolution would occur at all.

### The Role of `resolve`

`resolve` performs dynamic, runtime binding. When the cognitive renderer encounters an unresolved component during execution, the runtime environment invokes `resolve` to locate and instantiate an appropriate implementation based on declared protocols, while the renderer remains entirely unaware of this process.

* **Analogy:** Like a dynamic linker resolving a symbol at load time.
* **Mechanism:** On first dereference, a missing component triggers a page-fault-like behavior that requests resolution.
* **Scope:** `resolve` does not belong to the declarative scaffold. It is part of the runtime system.

### Lazy Evaluation Principle

Components are not fully loaded until required. This allows flexibility and deferral of dependency resolution until strictly necessary.

### Opaqueness to Execution Components

Neither the renderer nor any other component involved with execution is aware of the `resolve` process. This mirrors how application logic is unaware of page faults handled by the memory subsystem. The mechanism operates independently, ensuring that the parent components within the cognitive DOM tree and the renderer itself remain entirely agnostic of how or when specific components are resolved, or how the resolved and loaded component assembles their data binding.&#x20;

In practice, this means that within your intent scaffolding, you do not embed specific implementations. Instead, you declaratively specify, "a component that implements protocol handler X/Y goes here." The non-deterministic nature of the runtime allows for this late binding. The internal behavior of the `resolve` mechanism remains opaque to both the parent component and the renderer, ensuring strict separation between intent declaration and runtime fulfillment.

---

## Preflight Assertions and the `.SemanticIntentProj` Manifest

### Motivation

Real-world cognition cannot rely solely on reactive resolution due to the risk of encountering missing dependencies mid-execution (e.g., forgetting keys). A preflight mechanism validates environmental constraints ahead of execution to minimize runtime faults. To the linter, it looks like&#x20;

### Manifest-Declared Capabilities

The purpose of the `.SemanticIntentProj` manifest is to declare components that claim to implement specific protocol handlers. These declarations allow the preflight mechanism to verify that the necessary handlers are nominally present for the intent to proceed. However, it is important to note that these declared components may not contain actual implementations of the required functionality. Instead, they may serve purely as placeholders, which will trigger a fault at runtime if dereferenced without having been properly resolved.

This behavior mirrors how stubs function in linker scenarios: they claim presence for the purposes of early validation but defer actual linkage until runtime resolution is demanded.

A `.SemanticIntentProj` manifest declares capabilities as protocol handlers.

```json
// Example manifest structure
{
  "handlers": {
    "residential.frontdoor.open": "FrontDoorOpenStub"
  }
}
```

Each declared capability maps to a stub implementation responsible for asserting that its required preconditions are met.

### Stub Behavior Example

```typescript
@Implements("residential.frontdoor.open")
export class FrontDoorOpenStub implements CapabilityPreflight {
    assert(): void {
        if (!physicalInventory.includes("car keys")) {
            throw new PreflightException("Cannot safely handle 'open front door' without keys.");
        }
    }
}
```

### Preflight Stub Execution Timing

Unlike the lazy, on-demand resolution of actual components, preflight stubs declared in the manifest are executed immediately when any page containing those components begins loading. This means that as soon as the intent scaffold references a component with a preflight stub, the assertion logic is triggered—often before the DOM tree has finished initializing. This early execution ensures that environmental constraints and dependencies are validated up front, reducing the risk of runtime faults and allowing for prompt user feedback or correction before further interaction occurs.

### Bulk Assertion Collection

Instead of fail-fast on the first error, preflight collects all failed assertions and presents them for batch resolution.

#### Benefits:

* Reduces iterative correction cycles (avoids multiple trips upstairs).
* Provides a comprehensive delta between declared intent and reality.

---

## Runtime Mutation of Intent Scaffold

### Necessity of Runtime Mutation

Despite thorough preflight, mutable reality requires the cognitive renderer to react to newly invalidated assumptions during execution. This mandates the ability to mutate the running scaffold dynamically.

#### Example:

```xml
<Precept name="ExitHouse" />
<Precept name="RealizeKeysMissing" />
<Precept name="ReEnterHouse" />
<Precept name="GetKeys" />
<Precept name="ExitHouse" />
<Precept name="ReachCar" />
```

### GC and Runtime Concerns

Dynamic mutation is despised by the garbage collector (literal or cognitive) due to:

* Orphaned components
* Broken memoization
* Increased complexity in state tracking

Nevertheless, reality mandates resilience over elegance.

### Best Practices:

* Constrain reactive mutation within clear fault boundaries.
* Design corrective subtrees as first-class components.
* Accept that cognitive runtime must tolerate impurity.

---

## Wax On, Wax Off: Building the Resolver Cache

Repetitive, foundational actions that gradually build up the resolver cache. Just as in martial arts training, where routine movements prepare the practitioner for real challenges, these background operations accumulate mappings between symbolic placeholders and their concrete implementations.

### Why the Resolver Cache Matters

When the system is faced with a sudden, complex demand, the resolver cache enables rapid, instinctive binding of components. Without this cache, the system would be forced to resolve every dependency from scratch, leading to delays and potential faults. The cache is built not through dramatic, one-time actions, but through the steady accumulation of routine resolutions over time.

### Analogy to Training

- **Wax On, Wax Off:** Routine, preparatory actions that seem mundane but are essential for readiness.
- **Resolver Cache:** The result of these actions—a store of previously resolved bindings that can be accessed instantly when needed.
- **Real-World Readiness:** Just as foundational training enables quick defense, a well-built resolver cache ensures the system can respond efficiently to new or unexpected requirements.

### Practical Implications

- Every time a component is resolved, its mapping is added to the cache.
- The cache grows with use, improving system responsiveness and reliability.
- This process is invisible to the declarative intent and renderer, but critical for robust runtime behavior.

---

## Summary Model

### Ideal Flow:

1. Intent Declaration
2. Preflight Constraint Collection
3. Bulk Correction and Revalidation
4. Clean Execution via Renderer

### Realistic Flow:

1. Intent Declaration
2. Preflight Pass
3. Bulk Correction
4. Execution Begins
5. Mid-Execution Reality Fault
6. Reactive Scaffold Mutation
7. Continued Execution

---

## Conclusion

The `resolve` feature provides flexible, dynamic binding for cognitive intent scaffolding. To mitigate predictable failures, preflight assertion layers validate environmental readiness upfront. However, due to reality's mutability, runtime mutation remains a necessary, albeit GC-hostile, feature. These extensions together allow cognitive systems to operate with both declarative rigor and reactive adaptability.

Despite the declarative nature of intent scaffolding, the runtime remains non-deterministic, and its internal behaviors are intentionally opaque to both parent components and the renderer.

---

## Enhanced Concepts (Type-Safe Era)

## Staging Phase
A containerized execution boundary within precepts that enables either preflight validation or execution segmentation:
- **Preflight Staging**: Automatic validation triggered when precepts are imported/referenced
- **Execution Staging**: Hot execution segmentation at natural breakpoints where state vectors can be simplified

Decision criteria for execution staging: "You don't need to remember fine-grained state across stage boundaries"

## Instrument (Hardware-Aligned)
Resources required by precepts, aligned with RALN architecture terminology. Instruments represent learned procedures, methods, or tools that precepts use for acting. Replaces legacy "resource" terminology to maintain consistency with hardware compilation targets.

## Validation Precept
Lojban-inspired logical precepts that enable systematic instrument validation following the pattern: "Precept X enables agent to check instrument Y for fulfilling condition set Z under domain constraints W"

## Behavioral Control Elements
XML elements that directly influence agent behavior, execution flow, and decision-making processes, as opposed to pure documentation elements. Includes Constraint, AcceptanceCriteria, Condition, Context, Source, Location, and Purpose.

## Prune
An imperative keyword used to remove a component (and, recursively, its parents if unhandled) from the active intent tree, analogous to `throw` in exception handling.

## Runtime Mutation
The ability for the intent tree to adapt, extend, or restructure itself dynamically in response to context, feedback, or execution outcomes.

---
This glossary provides concise definitions for core concepts in intent scaffolding. For detailed usage and examples, refer to the main overview, language reference, and the XML Element Type Catalog.
