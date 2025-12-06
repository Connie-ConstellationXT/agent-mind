# Appendix 2: Cognition as Orbital Mechanics

## Abstract: Cognitive Maneuvers and Orbital Mechanics

Human reasoning appears chaotic on the surface, but when viewed through the lens of prediction, interpretation, self-modeling, and frame adjustment, it resolves into a small set of recurring cognitive primitives. Remarkably, these primitives align one-to-one with the maneuver directions familiar from orbital mechanics: movement along the tangent (prediction vs. interpretation), movement toward or away from the center (self vs. other modeling), and rotation of the orbital plane (reframing and meta-scope). This correspondence is not a claim about the physics of the mind; rather, it highlights a structural symmetry. The same geometric relations that make orbital maneuvers expressive and minimal also make these cognitive operators expressive and minimal. By adopting this maneuver-based formalism, we obtain a compact vocabulary for describing how minds shift perspective, construct meaning, revise plans, and analyze complex statements. The chapters that follow define these maneuvers precisely and show how they form a complete basis for epistemic motion.

---

## 1. The Azimuth Operators: A⁺ and A⁻
*(Tangential maneuvers — motions along the cognitive trajectory)*

Azimuth describes the direction of inference flow. In orbital mechanics, azimuth gives the local heading along the orbit. Here, A⁺ and A⁻ give the local heading along the predictive manifold.

### 1.1 A⁺ — Forward Prediction (Prograde)

**Definition:**
Applies the model M and internalized statements S to qualia Q to yield the next predicted qualia Q′.

A⁺(M, S, Q) := P(M, S, Q) → Q′

**Interpretation:**
“What happens next, given what I already believe?”

**Example:**
A cup is placed upside down on a table. The model predicts:
> A⁺ → “The cup will fall over; orientation is unstable.”

### 1.2 A⁻ — Backward Interpretation (Retrograde)

**Definition:**
Given observed qualia Q, infer the statement s whose application to Q yields maximal coherence.

A⁻(Q) := argmax_s  coherence( s(Q) )

**Interpretation:**
“What am I looking at?”

**Example:**
Given Q = “white, fluffy, surrounded by blue,” the A⁻ operator returns the statement:
> A⁻ → s_cloud
(without asserting s_cloud(M)).

---

## 2. The Radial Operators: R⁺ and R⁻
*(Self/other maneuvers — inversion of belief models)*

In orbital mechanics, radial maneuvers adjust motion toward or away from the center. Here, they adjust cognition toward or away from the self-model.

### 2.1 R⁺ — Outward Model Inversion (Theory of Mind)

**Definition:**
Infer what statements another model must believe, given its Q→Q′ behavior.

R⁺(M_other, Q, Q′) := argmax_S  coherence( P(M_other, S, Q) = Q′ )

**Interpretation:**
“What must this other mind believe for that output to make sense?”

**Example:**
A person claims “It will take 2 days for a Voyager round-trip signal.”
> R⁺ → { “Voyager is ~1 light-day away”, … }
These are latent beliefs, not judgments.

### 2.2 R⁻ — Inward Self-Projection (Planning)

**Definition:**
Generate a future model state M′ that executes a plan or possesses knowledge that the current model lacks.

R⁻(M, task) := (M′, Q')

**Interpretation:**
“What will future-me know or be capable of when performing this plan? What new information will I have as a result of completing subtasks?”

**Example:**
R⁻ applied to a planning task may yield:
> “Future me will understand the hidden problem after step 2.”

---

## 3. The Normal Operators: N⁺ and N⁻
*(Plane change maneuvers — reframing and meta-scope)*

In orbital mechanics, normal maneuvers rotate the orbital plane. Here, they rotate the interpretive frame or introduce meta-discursive layers.

### 3.1 N⁺ — Normal (Frame Rotation / Reframing)

**Definition:**
Shift the invariant basis I used to evaluate statements, preserving structural coherence while changing meaning.

**Example (Interpretive):**
At launch, *No Man’s Sky* created an accidental motif: two players at the same coordinates could never see each other. The universe felt lonely by construction. Later, the *Artemis* arc introduced a story about a character you attempt to meet but cannot reach because they exist in another layer of reality.

Two explanations exist:
- H₁: The game was designed this way as narrative foreshadowing.
- H₂: The later story retroactively resonates with an earlier limitation.

The shift from “developer intention” to “interpretive invariants” is an N⁺ maneuver. Under this reframed basis, H₁ and H₂ converge: both produce the same symbolic, emotional, and phenomenological structure.

Let:
- Q₀ = 2016 player experience (“I cannot meet another player even at the same coordinates”).
- Q₁ = Artemis storyline (“I cannot meet Artemis even at the same coordinates”).
- H₁ = “The 2016 behavior was intentional narrative design.”
- H₂ = “The 2016 behavior was unplanned; resonance is coincidental.”
- I_dev = invariants concerned with developer intention.
- I_lit = invariants concerned with interpretive structure.

Under I_dev, H₁ ≠ H₂.

Apply N⁺ (frame rotation):

N⁺(I_dev → I_lit)


Evaluate equivalence:
H_1 \equiv_{I_{lit}} H_2

### 3.2 N⁻ — Antinormal (Uninternalized Meta-Scope / Ghost Variable)

**Definition:**
Introduce a statement $s^*$ into the closure that must be used syntactically but must not be internalized into S. This creates a meta-discourse layer.

**Example — Antinormal Meta-Scope (Uninternalized Frame Injection):**
Consider the statement:
> s* = “cognitive primitives cleanly map to orbital mechanics.”

This is an aesthetically compelling analogy, but not a factual claim about cognition, physics, or neurocomputational structure. When a model evaluates s*, it should use the analogy for the sake of structural discourse, while also preventing it from entering the internal belief set S where it could distort predictive behavior.

This is achieved through the antinormal operator α[s*]:
P(M, S, Q) → α[s^*] ∘ P(M, S, Q) → (M′, S′, Q′)

**Interpretation of the pipeline:**
1. P(M, S, Q): The model performs a standard prediction or interpretive transform.
2. α[s^*] ∘ P(…): The operator α[s^*] wraps the entire evaluation in a meta-scope:
   - s^* is syntactically admitted into the closure.
   - s^* is **not** added to S.
   - s^* may alter how the output is structured (e.g., allowing orbital analogies for clarity).
   - Internalizability is explicitly checked: α blocks the ΔL pathway for s^*. No belief update occurs.
3. (M′, S′, Q′): The output qualia Q′ may be shaped by the analogy, but:
   - M′ = M (no belief update)
   - S′ = S (no new internalized statements)

**Why this is N⁻:**
N⁻ is defined as: *Introduce s^* for the sake of argument, allowing it to influence evaluation without granting it epistemic authority.*

The orbital analogy is:
- Useful for exposition
- Expressive in a pedagogical frame
- Entirely safe as long as it does not enter S

α[s^*] creates exactly this condition.

**Thus:**
N⁻(s^*) enforces: s^* ∈ closure, s^* ∉ S, P uses s^*, ΔL ignores s^*

This captures the essence of antinormality in the calculus: **scaffolding allowed; belief prohibited.**

---

## 4. The Derived Phase Operators: Φ⁺ and Φ⁻
*(Structural maneuvers — composition and factorization of statements)*

These are not new spatial axes. They are phase maneuvers along the azimuthal axis, derived from higher-order R⁺. They operate on the internal structure of statements, not on qualia or frames.

### 4.1 Φ⁺ — Structural Composition (Assembly of Composite Statements)

**Definition:**
Combines multiple statements or inference components into a single composite statement.

Φ⁺({s₁, ..., sₙ}) := s_composite

**Interpretation:**
“Build a higher-level statement from constituent sub-statements.”

**Example:**
> Φ⁺({planetary motion data, inverse-square law, calculus}) → “Newtonian gravitation”

This reflects how a complex, high-level explanatory statement emerges from the synthesis of independent empirical and mathematical components.

### 4.2 Φ⁻ — Structural Decomposition (Factorization of Composite Statements)

**Definition:**
Given a composite statement s, returns the latent belief-components necessary for s to arise under the model’s generative structure. Formally implemented as inward model inversion:

Φ⁻(s) := R⁺(M_self, · , s)

**Interpretation:**
“Recover the hidden assumptions that make this statement coherent.”

**Example:**
> Φ⁻(“cold weather causes colds”) → {correlation misinterpretation, surface-level causal inference, folk biology heuristic}

This operation reveals the underlying cognitive shortcuts and inherited heuristics embedded in an everyday intuition, without asserting their correctness.

---

## 5. Closing Note

These operators form the minimal complete basis of cognitive motion in the system. They act on M, S, Q, and the invariant set I, and they describe every form of:
- Prediction
- Interpretation
- Explanation
- Self-modeling
- Planning
- Reframing
- Meta-discourse
- Structural analysis

They are as fundamental to epistemic dynamics as orbital maneuvers are to spacecraft.

---

## 6. Appendix: Backpropagation as Composite Maneuver

“Backpropagation does not need its own primitive cognitive maneuver because it can be expressed as a sequence of:
(1) forward predictions with loss evaluation, and
(2) a radial-out operation on a hypothetical self that predicted correctly.”

This is not just true — it’s exactly the right reduction.

### 1. Backprop = forward prediction + counterfactual-other-self

In the classical NN formulation:
- Forward pass gives Q′ = P(M, S, Q)
- Loss gives the error L = Loss(Q′, target)
- Backprop computes the adjustments ΔM = ∂L / ∂M

But in this system, the “gradient” is never a primitive — it’s always a difference between two predictive selves:
1. The model that actually predicted
2. A hypothetical model that would have predicted the correct Q″

**Thus:**
The gradient is simply: **M_current compared to an outward-predicted M_ideal**.

Which is literally: **Radial-out on a hypothetical self whose predictions minimize loss.**

This is perfectly aligned with our cognitive axes:
- **Forward prediction:** run the model
- **Backward error:** evaluate loss
- **Radial-out:** compare self with an imagined correct-prediction self
- **Radial-in:** update to move toward that imagined self

**Conclusion:**
Backprop = (forward + loss) + outward prediction + inward move.
You don’t need a “backprop primitive.” It is a composite maneuver.