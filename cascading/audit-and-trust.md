# Audit and Trust: Termination-Confirmedness, Reuse-Trust, and the Apollo 13 Principle

This document defines the auditing lattice used to reason about trust, execution history, and safe reuse of intent trees and their constituent precepts.

---

## Core Definitions

### termination-confirmed(n)
A precept `n` is **termination-confirmed** iff there exists an execution of an intent in which:
1. `n` belonged to a branch that reached a turtle-0 leaf
2. The entire intent completed successfully
3. An audit record (precept id, job id, timestamps, outputs, side-effects) proves it

Termination-confirmation is **factual**: it is evidence of execution, not a promise about safety or reusability.

### Domainset & Domain Hierarchy

A **domainset** is an indexable label (or node) in a documented domain hierarchy. Examples:
- `kinematics:arm`
- `policy:auth:admin`
- `kitchen_equipment:pan`
- `emergency_response:life_support`

Domain labels support a **subsumption relation** (partial order):
- `policy` ⊇ `policy:auth` ⊇ `policy:auth:admin`
- `kitchen` ⊇ `kitchen_equipment` ⊇ `kitchen_equipment:pan`

A precept `n` carries a domainset `D(n)` — a set of domain labels indexing into the hierarchy. A parent's domainset can be a subset of a child's: `D(parent) ⊆ D(child)` means the parent's domains are all covered by the child's domains (under subsumption).

### reuse-trusted(n)

A precept `n` is **reuse-trusted** iff:
1. All direct children `c1..ck` of `n` are termination-confirmed
2. For **every** direct child `ci`: `D(n) ⊆ D(ci)` (strict per-child inclusion, not union)

This intersection rule is intentionally strict: **every child must individually cover the parent's domainset**. A parent cannot claim reuse-trust if only some children cover parts of its domains.

**Intuition**: If every child has proven behavior in domains that cover the parent's scope, then the parent's behavior (which composes those children) is trustworthy for reuse in similar contexts.

### The Trust Lattice

Ordered by increasing confidence:

1. **statically valid(tree)**: 
   - The tree is syntactically and semantically coherent
   - Every branch has at least one theoretical decomposition path to a turtle-0 surface
   - No execution history required; based on structure alone

2. **run-ready(tree)**:
   - The tree is statically valid
   - All `RequiredInstrument`s are either present/validated at preflight or reasonably expected to become available during execution (RESOLVE candidates or acquisition precepts exist)
   - Ready to attempt execution but may contain unproven compositions

3. **statically solvable(tree)**:
   - The tree is statically valid
   - Every precept in the tree is reuse-trusted (all children termination-confirmed + domainset coverage)
   - All compositions have prior proof through termination-confirmedness

4. **convergent-decidable(tree)**:
   - The tree is statically solvable **and** run-ready
   - Maximum confidence: proven components, complete trust propagation, and present/expected dependencies
   - Safe for routine execution and reuse

---

## The Apollo 13 Case Study: Statically Valid, Utterly Unproven

The Apollo 13 rescue illustrates the complete lattice and the cost/benefit of executing below convergent-decidable.

### The Problem

On April 13, 1970, an oxygen tank exploded, crippling the Command Module. Mission Control and the crew faced a stark reality: the only viable path to bring three astronauts home was an intent tree that **had never been executed, never been validated, and in many cases had never been attempted before**.

The rescue plan was **statically valid**: the structure held. The physics was sound. All branches could theoretically reach turtle-0. But it was **not statically solvable** and definitely **not convergent-decidable**.

### The Lattice Position

**Leaves (Turtle-0): termination-confirmed and reuse-trusted**

- "Fire RCS thruster for X seconds" — done thousands of times, domain coverage complete
- "Read instrument Y" — completely proven, all spacecraft telemetry procedures validated
- "Flip switch Z to configure power bus" — standard procedure, domain coverage complete
- "Calculate trajectory using Newtonian mechanics" — thoroughly validated physics
- "Human survives in N% oxygen for M hours" — well-understood physiology, domain coverage complete

These capillary branches were bulletproof. Every low-level action was reuse-trusted because D(leaf) fully covered its operational domain. Flight controllers could rely on "if we send this command, the thruster fires" with absolute confidence.

**Mid-Level Precepts: Mostly reuse-trusted, some novel**

- "Power-down non-essential systems sequentially" — standard procedure, but not in this configuration
- "Vent CO2 using lithium hydroxide cartridges" — proven, but not with improvised adapters
- "Perform midcourse correction burn" — routine, but with crippled attitude control

These were compositions of reuse-trusted children, but some had domain mismatches: the parent's domain (crippled-spacecraft-life-support) was not covered by children's domains (nominal-procedures). They were statically valid but lacked termination-confirmation in the novel configuration.

**High-Level Trunks: Statically valid but completely unproven**

- "Use Aquarius as a three-person lifeboat for 4 days" — unprecedented
  - D(parent) = {emergency-lifeboat, three-crew, duration-4-days}
  - Children: life-support, power management, thermal control
  - No child had D(lifeboat:three-person) or D(duration:4-days-extended)
  - **Result**: reuse-trusted propagation failed

- "Adapt square Command Module CO2 scrubbers to round Lunar Module sockets" — novel integration
  - D(parent) = {life-support-integration, emergency-adaptation}
  - Children: mechanical adaptation, validation
  - No child had prior termination-confirmation for this specific configuration
  - **Result**: statically valid, but not reuse-trusted

- "Power-up frozen Command Module after days in cold soak" — entirely theoretical
  - D(parent) = {cold-start, crippled-systems, time-critical}
  - No termination-confirmation in this domain combination
  - **Result**: unproven

- "Execute trans-Earth injection with degraded attitude control" — new configuration
  - D(parent) = {navigation, crippled-control, precision-required}
  - Known procedures in unknown configuration
  - **Result**: statically valid, not reuse-trusted

### The Tree State

The Apollo 13 rescue plan was:
- **statically valid**: ✓ (structure coherent, physics sound, theoretical paths to turtle-0)
- **run-ready**: ✓ (physical components present, RESOLVE candidates for novel subsystems)
- **statically solvable**: ✗ (novel parent compositions with no termination-confirmed ancestors in matching domains)
- **convergent-decidable**: ✗ (no proof that the entire composition would work)

### Why They Executed Anyway: Trusted Atoms, Untested Molecules

The team could execute this statically-valid-but-not-convergent-decidable tree because:

1. **Atomic trust was rock-solid**: Every leaf precept was termination-confirmed and reuse-trusted. D(thruster-fire) fully covered D(RCS-command). D(read-instrument) fully covered D(telemetry). The foundation was proven.

2. **Structural validity was sound**: The tree decomposed correctly. Branches reached turtle-0. The physics was defensible on paper.

3. **Risk was granular**: They understood exactly which parts were proven (leaves) and which were novel (trunks). They could measure the risk:
   - Novel composition of proven atoms: **acceptable risk under necessity**
   - Novel atoms with novel composition: **unacceptable, would not attempt**

4. **Desperation + competence = execution**: The alternative to executing this unproven tree was accepting three deaths. The choice was: "execute a statically-valid tree with novel compositions but proven atoms" vs. "guarantee failure". They chose measured risk over certain loss.

### The Proof of Execution

Every precept in the Apollo 13 tree became termination-confirmed through execution. When the Command Module powered up, the three astronauts returned safely, the entire intent completed successfully. Retroactively, the tree that was statically-valid-but-unproven became convergent-decidable through execution.

But here's the key: **they didn't have convergent-decidability before launch. They created it by executing a well-structured, atomic-trust-based intent tree under controlled desperation.**

The tree's success proved the atoms held, the molecules integrated correctly, and the novel compositions worked. The proof came from flying it, not from prior validation.

---

## The Bidirectional Filter: Why This Works

The lattice creates a natural, bidirectional filter:

**Upward** (composition → parent trust):
- Leaves have broad domain coverage (they're fundamental: physics, actuators, proven procedures)
- Leaves naturally cover parent domains
- When all children are reuse-trusted and cover parent domains, parent can be promoted
- Trust propagates upward through proven composition

**Downward** (parent domains → required children):
- Parents have specific, narrower domains (mission-specific configurations, novel sequences)
- Parents depend on children to cover those specific domains
- If children don't cover parent domains, propagation blocks (prevents desk-slap-to-red-button)
- Unproven compositions are caught and flagged for validation or test-flights

The intersection rule (per-child inclusion, not union) ensures:
- Safe propagation: if any child lacks the domain, the parent cannot claim reuse-trust
- Natural convergence: when children are genuinely equivalent wrt parent domains, propagation succeeds automatically
- Risk transparency: when convergence fails, the runtime knows exactly which domain gaps exist and can schedule INFER test-flights or require explicit validation precepts

---

## Operational Implications

### Execution Under Uncertainty

When a tree is statically valid but not convergent-decidable:

1. **Measure the risk**: Identify which precepts are termination-confirmed (trusted leaves) and which are novel (unproven trunks)
2. **Validate structure**: Confirm the tree is syntactically valid and decomposition paths exist
3. **Plan for failure**: Design fallback precepts, have contingency plans, understand which failures are recoverable
4. **Execute if justified**: If atomic trust is high and necessity warrants it, execute and generate proof through execution

Apollo 13 followed this pattern exactly. They measured the risk, validated the structure, had contingencies, and executed under necessity.

### Promotion Policy: When Does Statically-Valid Become Statically-Solvable?

A successfully-executed statically-valid tree becomes termination-confirmed, but when is it promoted to reuse-trusted or statically-solvable?

**Recommended promotion rules** (policy-dependent):

- **Single execution, same context**: After one successful execution, the tree's precepts become termination-confirmed in that specific domain context. Reuse-trust requires either:
  - Repeated execution across varied conditions, or
  - Explicit validation/certification by a domain expert, or
  - Automated validation by INFER simulations covering the domain space

- **Context-dependent reuse**: Apollo 13 precepts became reuse-trusted for **emergency-life-support** and **crippled-spacecraft** domains, but not automatically for routine operations. The domain set matters.

- **Confidence scores**: Store execution history and allow probabilistic trust: a tree executed successfully 100 times under varied conditions earns higher reuse-trust score than one executed once.

### Test-Flights and Validation

When a tree is statically valid but convergence fails:

1. The runtime identifies domain gaps (parent domainsets not covered by all children)
2. It may schedule INFER test-flights: simulations validating candidate compositions
3. It may require explicit validation precepts: domain experts or automated checks confirming the novel composition is safe
4. It may fail-fast: reject execution and demand either pruning the tree or adding validation

This is INFER's role: to **convert statically-valid-but-unproven into statically-solvable without physical execution** when possible.

---



## Summary: Trust as a Lattice, Not a Binary

The framework rejects the binary "trusted vs. untrusted" model. Instead:

- **statically valid** = structure is sound (no prior proof required)
- **run-ready** = dependencies are present (may contain unproven compositions)
- **statically solvable** = all compositions have prior termination-confirmed ancestors (reuse-safe via domain coverage)
- **convergent-decidable** = maximum confidence (proven + present + ready)

Apollo 13 proved you can execute a statically-valid tree successfully even when it's not convergent-decidable, provided:
1. The atomic operations are proven
2. The structure is sound
3. The necessity justifies the risk
4. The team understands the risk granularly

The phrase **"Failure is not an option"** gains its power not from bravado but from this discipline: measuring risk precisely, executing well-structured plans, and committing to unproven compositions only when built on proven atoms and driven by existential necessity.

That is the Apollo 13 principle, and it is the foundation of the audit-and-trust lattice.
