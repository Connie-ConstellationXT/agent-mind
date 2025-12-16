# Inward Self-Projection: The Planning Manifold

**R⁻ (Inward Self-Projection)** is the cognitive maneuver that turns "I want outcome Q'" into a workable commitment without requiring an enumerated procedure. In the orbital-mechanics basis, R⁻ is a radial-in maneuver that generates a future model-state and future qualia that are not yet available to the present model.

This chapter formalizes R⁻ as a procedural generation process over a multi-dimensional manifold, governed by metabolic cost (ΔH).

## 1. What R⁻ Actually Outputs

R⁻ does not output a list of steps. It outputs two things:

1.  **Q' (unnumbered):** The desired output artifact or target end-state ("the thing I am trying to have").
2.  **M':** A low-resolution assertion that "a more precise description of what to do next will crystallize when the time comes."

**M' is a promise of future resolvability.** It is not "I will have acquired skills," but rather "future-me will have enough situated detail to act correctly."

This is why turn-by-turn driving instructions do not specify curb curvature at the intersection: that detail becomes relevant only when the perceptual context collapses uncertainty at execution time. The plan is allowed to omit it until the last responsible moment.

Formally:
P(M, S, Q) → R⁻ → (Q', M')

## 2. Intermediate Frames are Not "The Plan"

When R⁻ projects intermediate structure, those projections are indexed:
Q'₀, Q'₁, ..., Q'ₙ

These are not "steps" in a linear plan. They are **frames**: partial future-state sketches that the system can use to test feasibility, detect convergence with other jobs, or decide where to refine.

As described in Chapter 6 (Multi-Job Convergence), these frames exist in a shared latent substrate. The object you manipulate is not a single chain, but a family of projected frames anchored on the single desired artifact Q'.

## 3. Planning as Procedural Generation: The Resolution Parameter (k)

Human planning is procedural and non-sequential. The brain "draws a high-level procedural curve in manifold space" and fills details later.

To express this, we introduce an explicit **resolution parameter k**:
Q'(..., k)

-   **Low k:** R⁻ yields a skeletal assertion of reachability.
-   **High k:** Additional manifold generators unfold. Constraints become explicit, RequiredInstruments appear, and dependencies become resolvable.

This mirrors procedural generation depth (octaves, LOD depth): the seed is stable; "more reality" appears as k increases.

## 4. The Plan Manifold Surface

Once resolution is explicit, the planning object stops being a 1D chain and becomes a surface:
Q'(i, k)

-   **i:** Temporal forward direction ("what happens after what").
-   **k:** Resolution ("how finely a given frame is unfolded").

**Progress is not monotone in i. It can be monotone in k.**
Sometimes increasing the resolution of an earlier frame gives you a cleaner path to the final outcome than marching forward in time with low-resolution guesses. You can move "up" in k at fixed i:
Q'(i₁, kₙ) → Q'(i₁, kₙ₊₁) → ... → Q'(i₁, kₘ)

This is a chain in **resolution space**, not temporal space. It is entirely compatible with "plans as procedural skeletons."

## 5. Manifold Rotation: Orthogonal Alternatives

Exploring alternative plans is not merely "branching"—it is a rotation of the plan manifold's frame in the high-dimensional embedding space.

In this space, alternative plans are generated as **orthogonal trajectories** relative to the current path. They do not merely diverge; they exist on perpendicular axes of the solution space, maximizing distinctness until a reconvergence point is found.

Q'(i, k, p)

Where **p** represents the orthogonal axis of alternatives.

This geometry implies that "Plan A" and "Plan B" are not just neighbors; they are independent basis vectors for reaching Q'. We rotate the manifold view to align with axis p₁, then p₂, revealing structurally distinct ways to preserve the invariants (Q and Q').

This aligns with the "Attention Is All You Need" paradigm: the system attends to different orthogonal subspaces of the latent manifold to construct valid paths. Reconvergence occurs only when these orthogonal paths collapse back into a shared state—a structural intersection in the embedding space.

## 6. Reconvergence

Branches (orthogonal trajectories) are allowed to reconverge. Reconvergence occurs when two plan variants, after refinement (k) or rotation (p), become equivalent under the current invariants.

This happens when distinct trajectories in the embedding space intersect at a shared structural state. They satisfy the same constraints or collapse to the same future self-posture M', even if their narrative histories differ.

Reconvergence is a mechanism of **exploration**: finding that multiple orthogonal paths lead to the same stable intermediate state allows the system to prune redundancy and build confidence in the path's viability.

## 7. Late Crystallization and ΔH

**Crystallization** is the event where a viable path from Q to Q' is established. It is the collapse of the exploration superposition into a single stable channel.

**Reconvergence precedes crystallization.** The system explores orthogonal alternatives, finds structural intersections (reconvergence), and then collapses the manifold into a committed path.

**Zero-shot planning** is simply crystallization without extensive exploration or reconvergence. An agent that zero-shots every problem 100% effectively crystallizes immediately. For bounded agents, exploration is necessary.

**ΔH is the metabolic governor.**
R⁻ planning is expensive because it forces the system to hold incompatible models simultaneously (superposition of paths). This divergence is ΔH.

**The system does not minimize planning steps (in any dimension); it minimizes ΔH.**

Because ΔH consumes metabolic resources, the system cannot sustain an indefinitely branched superposition. It must eventually crystallize—not because it found the "optimal" path, but because the metabolic cost of maintaining the superposition exceeds the value of further exploration.

The visible "plan" is the residue of this collapse.
