# Chapter 4: Variable, Address Space, and Calling Convention Model

## The Short Story

There are no variables, address spaces, or calling conventions in intent cascading.

## The Long Story

### Why Traditional Models Don't Apply

In imperative programming, a **variable** is a named memory location whose value can change. Variables live in **address spaces** (stack frames, heaps, static memory). When a function is called, arguments are passed via a **calling convention** (stack-based, register-based, etc.), and a new address space (stack frame) is created for local variables. When the function returns, that address space is destroyed.

Intent cascading rejects this entire model because it's fundamentally incompatible with **persistent, distributed, long-horizon reasoning**. Here's why:

1. **Stack frames are ephemeral**: They exist only during function execution, then vanish. Intent cascading needs state to persist across yields, retries, context switches, and multi-agent coordination.
2. **Address spaces are isolated**: Each function has its own namespace. Intent cascading needs a unified, global world model where all entities exist in a single semantic space.
3. **Calling conventions are synchronous**: They assume caller and callee are tightly coupled in time. Intent cascading allows asynchronous provider resolution, where a precept may yield for days waiting for a provider to become available.

### What Replaces Them: The Global World Model

Instead of variables scoped to functions, intent cascading uses a **single, persistent global world model**. This model is a structured, multi-vector representation of:

- **Semantic entities**: Everything that exists (objects, states, capabilities, artifacts) is represented as a semantic label in the world model.
- **Attribute vectors**: Each entity carries multiple vectors encoding its properties (semantic role, spatial position, lexical bindings, confidence scores, temporal windows, provenance metadata).
- **Pointer pairs and cross-references**: Vectors link to each other via learned similarity or explicit binding relationships (like attention mechanisms in transformers).
- **Persistent history**: Bindings, matches, and state updates are recorded globally. There's no "forgetting" when a function returns.

### Example: No Local Variables, All Global Bindings

**Traditional programming:**
```java
void pressHKey(Finger finger, Keyboard keyboard) {
  // Local variables: finger, keyboard are parameters (stack frame)
  Position alignedPos = calculateAlignment(finger, keyboard); // Local variable
  applyForce(alignedPos); // alignedPos passed as argument
  // Stack frame destroyed; alignedPos forgotten
}
```

**Intent cascading:**
```xml
<Precept name="PressHKey">
  <RequiredInstrument instrumentName="finger_aligned_h_key" type="statevector" />
  <H:Precept name="Actuate_Pin_17" id="A1B2-C3D4"/>
</Precept>
```

What happens:
- `finger_aligned_h_key` is a semantic label, not a variable name.
- When the precept executes, it queries the **global world model** for an entity matching that label.
- The world model returns a structured binding: semantic role vectors, positional vectors, confidence scores, and provenance (which perceptron or provider produced it).
- Once bound, that binding persists in the world model. Other precepts can reference it, audit it, or build upon it.
- There is no "return" that destroys the binding. The information remains globally available.



### Attention-Like Cross-Reference Instead of Passing Arguments

In traditional systems, data flows through **function call stacks**. Arguments are passed down; return values flow back up.

In intent cascading, data flows through **multi-vector attention-like mechanisms**:

1. **A precept declares a RequiredInstrument** (a query vector).
2. **The world model searches for matches** (vectors score similarity against keys).
3. **Bindings are established** (values are retrieved and linked).
4. **Provider precepts update the world model** if the binding was produced by action (not just perception).
5. **All downstream precepts** see the updated world model. There's no parameter passing; they simply query the same global space.

### No Calling Convention—Everything is Globally Addressable

In traditional programming, the calling convention determines how arguments reach a function. In intent cascading, there's no calling convention because:

- **Precepts don't call each other**. They declare dependencies (RequiredInstruments).
- **The resolver selects providers** based on semantic matching, not explicit function calls.
- **All communication is through the world model**, which is globally visible.

Example: If precept A requires `coffee_available` and precept B produces it, the system doesn't execute "A calls B". Instead:
1. A yields (waits).
2. RESOLVE finds B as a candidate provider.
3. B executes and updates the world model with `coffee_available`.
4. A resumes because its instrument is now satisfied.

There is no passing of arguments, no return value, no stack frame. Both precepts operate on the same global world model.


### What This Means for RequiredInstrument

A `RequiredInstrument` is not a function parameter. It's a **query into the global world model**. The label names a semantic entity. At runtime, the agent:

- Consults the world model for entities matching that label.
- Synthesizes bindings from perception, cached entries, or provider precepts.
- Records the binding globally (with provenance, confidence, timestamps).
- Allows all downstream precepts to see and use that binding.

There is no "scope". There is no "lifetime". There is only the persistent, ever-growing, multi-vector world model.

---

## Key Contrasts

| Traditional Programming | Intent Cascading |
|---|---|
| Variables are local (scoped to functions) | All entities are global (in the world model) |
| Arguments passed via calling convention | Dependencies declared as RequiredInstruments |
| Return values flow back up the call stack | Artifacts update the world model, visible to all |
| Stack frames created and destroyed | World model persists indefinitely |
| Isolated address spaces per function | Single, unified semantic space |
| Synchronous call/return | Asynchronous RESOLVE and yield |
| Function names determine execution | Semantic roles and confidence determine provider selection |

