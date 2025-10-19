# Compiler Syntax & Job Classification (Design Note)

This note records two small but important decisions for the intent scaffolding compiler and runtime admission logic:

- The compiler's XML parser is *feed-forward only* (Pascal-style): the token immediately following the `<` determines the node type. No recursive signature deconstruction is required to classify the tag.
- The `dynlink` attribute is advisory/human-facing only and is *not* consulted by the compiler to decide compilation or admission behavior. The presence of `R:Precept` (or the `R:` tag) is the canonical signal that a tree contains runtime-mutability.

Keep this as a design reference (implementation detail) rather than example-level documentation.

## 1) Feed-forward tag classification rule

Parser rule (practical): when the parser sees a `<` it inspects the very next non-whitespace character sequence (up to either `:` or an alpha boundary) and classifies the tag by that first character(s):

- `<R:` or `<R` → R:Precept (runtime-resolve precept)
- `<D:` or `<D` → D:Precept (disrupt/emergency precept)
- `<H:` or `<H` → H:Precept (hard-linked precept)
- `<Precept` (or `<P`) → plain Precept (normal, possibly hard-linked inline)
- `<R:Precept` etc. follow the same rule but the classification is decided immediately by the leading character(s).

Why this rule?
- Feed-forward parsing keeps the compiler simple and fast: you never need to scan an entire attribute list or parse a full signature to know a node's classification.
- It avoids C-like recursive signature interpretation where you must parse the whole line to determine semantics.

Implementation note:
- The parser should skip initial `<` and any whitespace, then read the next token characters until it hits a non-identifier character (like `:` or whitespace). Use that token (or its first character) to dispatch a small finite-state handler for the node.

## 2) `dynlink` attribute: advisory only

Decision:
- The `dynlink` (or `dynlink="true"`) attribute is *not* used by the compiler to decide whether a precept is runtime-mutable.
- It may be present for human readability or tooling hints, but the compiler's analysis must be based on structural nodes, not on optional attributes.

Canonical rule for runtime mutability:
- A job is classified as `INTENT_RUNTIME_MUTABLE` if and only if the precept tree contains at least one `R:Precept` node (i.e., a node whose tag begins with `R`).
- Otherwise the job is `INTENT_FULLY_DETERMINISTIC` (hard-linked H:Precepts and inline Precept nodes do not make the job mutable).

Rationale:
- `R:Precept` semantics imply a dynamic repository resolve at runtime; the presence of such a node necessarily requires VAC areas and runtime mutation capability.
- Attributes are fragile and optional; structural markers are fast and reliable for compile-time classification.

## 3) Short-circuit classification algorithm (recommended)

Use a fast, non-recursive (stack-based) walk with an early exit on detection of any `R:Precept`. This both minimizes latency during job admission and guarantees correct classification.

Pseudocode (practical):

```text
function classify_job_compilation(root_precept):
  stack = [root_precept]
  while stack not empty:
    node = stack.pop()
    // classification by tag: parser stores canonical tag string per node
    if node.tag startsWith 'R':
      return INTENT_RUNTIME_MUTABLE
    // push children for inspection
    for child in node.children:
      stack.push(child)
  // no R:Precept found anywhere
  return INTENT_FULLY_DETERMINISTIC
```

Optimizations:
- Annotate nodes at compile/link time with a boolean `contains_R_precept` when possible. Then classification is O(1): check the root flag.
- Short-circuit as soon as you see an `R:Precept` to avoid deep traversal in common mutable cases.

## 4) Interaction with H:Precept (hard-linked) and MLP/NAVIGATE instantiation

- `H:Precept` remains a valid compile-time hard-link mechanism. A tree with arbitrarily many `H:Precept` nodes is still deterministic unless an `R:Precept` appears.
- When an MLP output neuron is wired to instantiate a precept, treat the origin as `NAVIGATE`. The NAVIGATE-origin job is classified via the same algorithm above to decide admission context (VAC or fully deterministic).

## 5) Example parser dispatch (very small)

- Read `<`, skip spaces
- Read identifier characters into `lead` until a non-identifier char
- Switch on `lead[0]` (or `lead`):
  - 'R' → parse as R:Precept node
  - 'D' → parse as D:Precept node
  - 'H' → parse as H:Precept node
  - 'P' or 'Precept' → parse as inline Precept
  - otherwise → generic element handling

This ensures a one-pass feed-forward parser for node classification.

---

If you want, I can add a short paragraph with this design note to `scaffolding/integration/executive_runtime_architecture.md` (job admission section) so it is colocated with the admission algorithm and alarms. I can also add the pseudocode block there. Say which file you prefer and I'll add it. I won't edit any files until you confirm.