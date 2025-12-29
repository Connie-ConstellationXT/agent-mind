# Truth Calculus

This volume presents the foundational mathematical framework underlying Intent Cascading. While chronologically developed after the initial Intent Cascading work, the Truth Calculus provides the theoretical substrate that explains *why* the system works and *how* cognitive agents navigate the manifold of meaning.

## Contents

### [00 - Foreword: Of Truth and Hallucinations](00_00_foreword.md)
An exploration of truth, hallucination, and the nature of belief in predictive systems. Introduces the core question: what does it mean for a statement to be "true" to a model?

### [01 - Truth Gradient and Metabolic Chirality](00_01_truth_gradient_and_metabolic_chirality.md)
Formalizes truth as a scalar field $T(M, s) = \Delta\mathcal{L}(M, s)$ and derives the truth gradient. Introduces the concept of **Metabolic Chirality** — the asymmetric cost of associative traversal — and explains why structural scaffolding (checklists, precepts) is necessary to overcome it.

**Key concepts:**
- Truth function and gradient
- Differentiable "is truer" predicate
- Chirality of associativity (recognition vs. generation)
- Safety-critical failure modes
- Intrinsic properties vs. extrinsic relations

### [02 - Cognition as Orbital Mechanics](00_02_cognition_as_orbital_mechanics.md)
Maps cognitive primitives onto orbital maneuver directions. Defines the six fundamental operators:
- **A⁺/A⁻** (Azimuth): Prediction and interpretation
- **R⁺/R⁻** (Radial): Theory of mind and self-projection
- **N⁺/N⁻** (Normal): Frame rotation and meta-scope
- **Φ⁺/Φ⁻** (Phase): Composition and decomposition

Shows that backpropagation is not a primitive but a composite maneuver.

### [03 - Delta-H and Model Divergence](00_03_delta_h_and_model_divergence.md)
Introduces **ΔH** (delta-H), the metric for model divergence borrowed from the Apollo Guidance Computer. Defines three regimes:
- **Self vs. Reality:** Epistemic drift
- **Self vs. Other:** Interpersonal ontology drift (ALARM 1204)
- **Plan vs. Execution:** Predictive drift

Shows that ΔH determines the **metabolic cost** (ATP provisioning) required to maintain coherent operation. Explains why you can't plan an entire space program in your head, and why externalization (checklists, precepts) is necessary to manage ΔH.

**Key insight:** High ΔH requires high metabolic provisioning. External structure anchors models to reduce divergence cost.

### [04 - Inward Self-Projection: The Planning Manifold](00_04_inward_planning_manifold.md)
Expands the definition of **R⁻** (Inward Self-Projection) into a full theory of planning as procedural generation.
- **M' as Promise:** Planning outputs a promise of future resolvability, not just steps.
- **Resolution Parameter (k):** Plans exist on a surface Q'(i, k) of time and resolution.
- **Manifold Rotation:** Alternatives are generated as orthogonal trajectories in the embedding space.
- **Reconvergence:** Orthogonal paths can intersect at shared structural states.
- **Late Crystallization:** The collapse of superposition into a viable path, governed by ΔH limits.

### [05 - P vs NP: The Computational Horizon of Reconvergence](00_05_p_vs_np_and_fault_tolerance.md)
Frames the system's fault handling (Alarms/Stopcodes) as a response to the P vs NP problem.
- **Reconvergence is NP-Hard:** Finding a path to reconcile divergent models is computationally expensive.
- **Verification is P:** Checking a proposed solution is cheap.
- **The Computational Horizon:** The resource budget acts as a hard boundary, converting undecidable problems into decidable "budget exhausted" faults.
- **Truth Value of P != NP:** Asserts that assuming P != NP has positive truth value because it enables the design of fault-tolerant systems that fail safely rather than looping infinitely.

---

## Relationship to Intent Cascading

The Truth Calculus provides the mathematical lens through which Intent Cascading can be understood and reasoned about. It explains:

- Why **RequiredInstruments** use semantic bindings rather than function parameters
- Why **Precepts** and **Staging Phases** act as cognitive prosthetics
- Why **SIMD N⁺ convergence detection** (Chapter 6) is architecturally necessary
- Why the **Global World Model** (Chapter 4) must be persistent and unified

The Truth Calculus is to Intent Cascading what differential geometry is to general relativity — the formal language in which the system's behavior becomes natural and inevitable.

---

## Reading Order

For understanding Intent Cascading:
1. Read Intent Cascading Chapters 1-5 first to build intuition
2. Return to Truth Calculus for the formal foundation
3. Use Truth Calculus as reference when exploring advanced topics (multi-job convergence, RALN hardware, etc.)

For understanding cognitive systems generally:
- Truth Calculus can be read independently as a framework for reasoning about belief, prediction, and metabolic constraints in neural systems
