# Precept Parser & Compilation Classification (Design Note)

Purpose
- Record a small, deterministic parser convention and the runtime compilation classification rules for precepts.
- Capture the decision to avoid `dynlink="true"` attributes and instead infer precept type feed-forward from the XML tag prefix (first character after `<`).

Design goals
- Simple, feed-forward parsing (one-pass, no recursive signature deconstruction).
- Deterministic compilation classification: any R:Precept implies runtime-mutable; otherwise the job is fully deterministic even if it contains many H:Precept nodes.
- Clear distinction between NAVIGATE-origin (MLP/recognition) vs RESOLVE-origin (repository lookup) instantiation.

Parser convention
- The parser determines precept kind from the first character(s) immediately after `<` in the tag name.
- Examples:
  - `<Precept ...>` or `<P:Precept ...>` → inline precept definition (hard-linked by structure)
  - `<H:Precept ...>` → hard-linked precept (compile/link-time id-based reference)
  - `<R:Precept ...>` → resolve/dynlink precept (repository resolution at runtime)
  - `<D:Precept ...>` → disrupt/emergency precept (IVT style interrupt vector)
  - `<Vigil ...>` / `<YieldSafePoint ...>` etc. follow the same feed-forward rule

Rationale
- Feed-forward parsing (look at tag name prefix) allows the compiler to decide compilation strategy without needing to interpret the entire element body.
- This mirrors simple, deterministic language grammars (Pascal-style), avoiding C-like recursive signature ambiguity.
- The `R:Precept` is the canonical marker for "this child may cause runtime mutation". No separate `dynlink` flag is required, but a developer may choose to include it for self-documentation.

H:Precept id encoding
- `H:Precept` nodes use an opaque `id` attribute representing an octree-like address (fixed-length integer, hex/base32, or variable-length path). Example:
```xml
<H:Precept name="db_context_factory_core" id="0xBEEFCAFE1234" allocateOutput="factory_impl as factory_ref">
  <Provides>...</Provides>
</H:Precept>
```
- The compiler/linker resolves `id` to a registry entry at compile time. If not found, compilation fails (fail-fast) or an explicit link-stage fetch is required.

Compilation classification (fast short-circuit)
- Rule: If any `R:Precept` (or equivalent resolve/dynlink tag) appears anywhere in the instantiated precept tree, the resulting job is `INTENT_RUNTIME_MUTABLE`.
- Otherwise (no R:Precept anywhere), the job is `INTENT_FULLY_DETERMINISTIC` (even if the tree contains many `H:Precept` nodes).

Efficient algorithm (pseudo-code)
```text
function classify_job_compilation(root_precept):
  stack = [root_precept]
  while stack not empty:
    node = stack.pop()
    if node.tag == 'R:Precept' or node.tag startswith 'R:' then
      return INTENT_RUNTIME_MUTABLE
    for child in node.children:
      stack.push(child)
  return INTENT_FULLY_DETERMINISTIC
```

Optimizations
- Annotate precepts at link/compile time with a boolean `contains_dynlink` (computed once) so classification is O(1) for loaded precept records.
- Short-circuit on first dynlink found to minimize traversal cost.

NAVIGATE vs RESOLVE origin semantics
- NAVIGATE origin: instantiation triggered by MLP/neuron recognition (memory-like operation). Treated as "navigate/instantiate from memory".
- RESOLVE origin: instantiation triggered by explicit RESOLVE/lookup operation (repository query / R:Precept invocation).
- Regardless of origin, use the compilation classification algorithm above to choose execution context (VAC vs deterministic).

Tooling notes
- Provide a tool to generate stable H:Precept `id` values (CLI or registry service).
- Maintain a manifest mapping human-friendly aliases → `id` to aid authoring and search.

Migration guidance
- Remove `dynlink="true"` from authoring. Authors should use `R:Precept` when runtime resolution is intended, and `H:Precept` or inline `Precept` for hard-linked precepts.

Where to document further
- This note belongs in `cascading/design/` and should be cross-referenced from `cascading/integration/executive_runtime_architecture.md` (job admission / compilation analysis section).

