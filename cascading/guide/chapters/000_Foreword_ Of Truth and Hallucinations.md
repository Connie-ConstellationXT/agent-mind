# Foreword: Of Truth and Hallucinations

It follows from truth.md that truth is not a discrete boolean property that can be bitmasked to some kind of absolute reference reality. Instead, truth is a scalar property of a statement s that, when internalized (that is to say *when the statement is believed*) by a predictive system such as a human mind, an artificial intelligence, or even an organization, increases the ability of that system to successfully predict future states of the world.

In this light, truth is not an absolute, binary, discrete, or objective property. Truth is a continuous, scalar, signed, measurable property that is only meaningful in the context of a predictive system. Truth is a property of statements relative to predictive systems.

A predictive system internalizes statements about the world in order to build a model of the world that it can use to predict future states of the world. The more accurate the model, the better the predictions. The better the predictions, the more successful the predictive system is at achieving its goals.

When a predictive system internalizes a statement s that increases its ability to predict future states of the world, we say that s has positive truth value relative to that predictive system. Conversely, when a predictive system internalizes a statement s that decreases its ability to predict future states of the world, we say that s has negative truth value, or positive falsehood value, relative to that predictive system.


### Statements

We can formalize the set of all statements S as a set of statements s_i where i is an index over the set of all statements. 

s₁, s₂, s₃ … ∈ Σ

Σ is the set of all statements( rules, facts, beliefs).

### Models 

M is a Model in the set of all Models ℳ that a predictive system P constructs by internalizing a subset of statements S' ⊆ Σ. It has internal state space and Qualia mapping.


### Qualia
A Qualia Q is a sensory or experiential state that a predictive system P can experience. 
Q ∈ 𝒬 
𝒬 is the set of all Qualia.


### Formalization
A Model can internalise statements to build a mapping from Qualia to predicted Qualia.

M ⊢ s -> M[s]

Where M[s] is the internal state of Model M after internalizing statement s.

When a predictive system P uses Model M to predict future Qualia Q' based on current Qualia Q, we denote this as:

Predicts(M1, {s1, s2, s3, ... , sn}) -> Q'

"from internalizing statements (s1, s2, s3), M1 is a model that predicts Q' when faced with input qualia Q."

#### Truth Value Function

The truth value fuction T is 

T(M,s) = Δℒ(M, s) = ℒ(M0) - ℒ(M[s])

Where ℒ(M) is the loss function of Model M, M0 is the model before internalizing statement s, and M[s] is the model after internalizing statement s.

If T(M,s) > 0, then s has positive truth value relative to model M.
If T(M,s) < 0, then s has negative truth value, or positive falsehood value, relative to model M.

## Derived Constructs

### conjunction
The conjunction of two statements s1 and s2 is a new statement s3 that is true if both s1 and s2 are true.
s3 = s1 ∧ s2. Internalizing s3 should have a truth value that reflects the combined predictive power of s1 and s2, if they do not contradict each other.

### negation
The negation is not a logical flop, but an inverted gradient flow. If internalizing s1 decreases predictive power, then internalizing ¬s1 should increase predictive power, and vice versa.
¬s := inverse(M, s) which means "internalize the contradictory statement to s".

### implication

s₁ ⇒ s₂ ⇔ T(M, s₁ ∧ s₂) ≥ T(M, s₁)
The implication states that if internalizing s1 leads to internalizing s2, then the truth value of the conjunction of s1 and s2 should be at least as high as the truth value of s1 alone.


## Example belief statement about reality

s1: "all bodies fall.", s2: "The moon is a body.",

let M1 be a model that has internalized s1 and s2.

we write 
M1 ⊢ (s1, s2) -> M1[s1, s2]

When M1 uses its internalized statements to predict the fall of the moon, we denote this as:
Predicts(M1, {s1, s2}, Q) -> Q' where Q is the current qualia of the moon's state and Q' is the predicted qualia of the moon falling. 

If T(M1, {s1, s2} < 0, the model should learn the implicit boundary condition, the limit of applicability of the statements, "all bodies fall" and "the moon is a body" in the context of predicting the moon's behavior.

Therefore, we define D as the set of boundary conditions di that limit the applicability of statements s1 and s2.

D = {d1, d2, d3 ... dn} where each di is a boundary condition, or "domain".

A meta–statement can mark the restricted evaluation domain of a statement s.

Let each domain predicate d ∈ D be a boolean function over extended evaluation tuples τ = (Q_current, Q_future, θ, M) where:

Q_current is present qualia
Q_future is target or observed subsequent qualia
θ collects contextual parameters (e.g. gravitational regime, velocity class, medium, frame)
We write d(τ) = true when the transition/context satisfies the boundary condition. The domain library is D = {d1, d2, …, dn}.

Define restricted truth evaluation by conditioning the loss distribution on d:

T(M, s ; D_eval | d) = ℒ(M ; D_eval | d) − ℒ(M[s] ; D_eval | d)

### Meta–statement notation:

↑₍d₎ s := “s has positive truth value for M under transitions satisfying d”
i.e. T(M, s ; D_eval | d) > 0.

Shorthand: Q ∈ d is an informal contraction for “there exists Q_future, θ such that (Q, Q_future, θ, M) ⊨ d”, keeping the visual Q.E.D. pun while acknowledging the transition/context basis.

#### Example:
For “all bodies fall” a domain predicate excluding stable orbital trajectories:
d_orbital_exclusion(τ) = (θ.orbital_trajectory = false).
Then ↑₍d_orbital_exclusion₎ s means the statement improves predictions only off orbital regimes.

#### Derived bounded statement:
s_bound := “s holds only over transitions τ with d(τ) = true”
Formal: ∀τ (d(τ) ⇒ T(M, s ; D_eval | d) > 0) and ∀τ (¬d(τ) ⇒ T(M, s ; D_eval | d) ≤ 0).

### Formal proof that internalising bounded statements improves model performance using the moon example:
Let s1_bound := ↑₍d_orbital_exclusion₎ s1 and s2_bound := ↑₍d_orbital_exclusion₎ s2. 
Then internalising s1_bound and s2_bound into M1 should yield a model M1' with improved predictive performance over M1 when predicting the moon's behavior across all regimes, including orbital trajectories.
M1' ⊢ (s1_bound, s2_bound) -> M1'[s1_bound, s2_bound] 

Predicts(M1', {s1_bound, s2_bound}, Q) -> Q'' where Q'' is the predicted qualia of the moon's behavior considering the bounded statements.

If T(M1', {s1_bound, s2_bound}) > T(M1, {s1, s2}), then internalizing the bounded statements has improved the model's predictive performance across all regimes.
This formalism allows predictive systems to internalize statements with an understanding of their applicable domains, enhancing their ability to model complex realities without succumbing to overgeneralization or falsehoods.

### Deriving the truth gradient

We already have the truth function defined as a scalar field over model–statement pairs:
T(M,s) = Δℒ(M, s) = ℒ(M0) - ℒ(M[s])
This gives a signed scalar value indicating the change in predictive performance upon internalizing statement s into model M.

To speak of 'truer' or 'more false' statements is to talk about the rate of change of truth value - how fast truth increases (loss decreases) or decreases (loss increases) as a function of internalization depth, parameter updates, or epistemic commitment.

We can define the truth gradient ∇T as the vector of partial derivatives of the truth function with respect to the parameters φ of model M:
∇φ T = -∇φ ℒ(M[φ]) 

This gradient indicates the direction and rate of change of truth value as we adjust the model parameters φ. A positive component in the gradient indicates that increasing that parameter will increase the truth value (decrease loss), while a negative component indicates that increasing that parameter will decrease the truth value (increase loss).
This formalism allows us to quantify not just whether a statement is true or false relative to a model, but how 'true' or 'false' it is in terms of its impact on the model's predictive performance as we adjust our beliefs and internal representations, making the notions of 'truer' and 'more false' mathematically precise.

### step 2: making 'truer' derivable

"Is truer" is conceptually a comparative predicate:
s₁ is truer than s₂  ⇔  T(M, s₁) > T(M, s₂)

That is a hard step function H(x) over the difference in truth values:
H(T(M, s₁) - T(M, s₂)) = 
    { 1 if T(M, s₁) > T(M, s₂)
    { 0 otherwise 

To make "is truer" differentiable, we can replace the hard step function H(x) with a smooth approximation, such as the logistic (sigmoid) function σ(x):
σ(x) = 1 / (1 + e^(-kx))
where k is a steepness parameter that controls how quickly the function transitions from 0 to 1.
Then we define the differentiable "is truer" function as:
is_truer(s₁, s₂) = σ(T(M, s₁) - T(M, s₂))

The gradient of is_truer with respect to individual truth values shows how the trueness predicate flows through changes in model parameters:

∂(is_truer)/∂T(M, s₁) = k · σ(ΔT) · (1 − σ(ΔT))
∂(is_truer)/∂T(M, s₂) = −k · σ(ΔT) · (1 − σ(ΔT))

where ΔT = T(M, s₁) − T(M, s₂). This shows that increasing s₁'s truth value increases is_truer, while increasing s₂'s decreases it—the sigmoid acts as a smooth, differentiable comparison operator whose sensitivity peaks near equality and flattens at extremes.

# Formal Definitions: Idea, Innovation, and Hallucination
## Definition 1: Idea
An idea is a novel statement s ∉ M (not yet internalized) for which a predictive system assigns a predicted truth value T̂(M,s).
Formally: Idea(s) ≡ [s ∉ M ∧ ∃T̂(M,s)]
An idea is the generative output before evaluation - a candidate statement from Σ \ S' that the system considers for internalization.

## Definition 2: Innovation
An innovation is an idea whose actual truth value, upon evaluation, is positive.
Formally: Innovation(s) ≡ [Idea(s) ∧ T(M,s)|ₜ₊δ > 0]
Expanding:

Innovation(s) ≡ [s ∉ M ∧ T̂(M,s)|ₜ > 0 ∧ T(M,s)|ₜ₊δ > 0]
            ≡ [s ∉ M ∧ ℒ(M₀) - ℒ(M[s]) > 0]
An innovation is an idea that, when internalized, improves the model's predictive performance, i.e. reduces loss.

## Definition 3: Hallucination
A hallucination is an idea whose actual truth value, upon evaluation, is negative.
Formally: Hallucination(s) ≡ [Idea(s) ∧ T(M,s)|ₜ₊δ < 0]
Expanding:
Hallucination(s) ≡ [s ∉ M ∧ T̂(M,s)|ₜ > 0 ∧ T(M,s)|ₜ₊δ < 0]
                 ≡ [s ∉ M ∧ ℒ(M₀) - ℒ(M[s]) < 0]
A hallucination is an idea that, when internalized, degrades the model's predictive performance, i.e. increases loss.


## The Core Identity
All three emerge from the same generative function:
G: ℳ → Σ \ S'
Where G samples novel statements from the space of non-internalized statements.
The classification depends solely on sgn(T(M,s)):

         ┌─ T(M,s) > 0  → Innovation
Idea(s) ─┤
         └─ T(M,s) < 0  → Hallucination

## Theorem: Mechanical Indistinguishability at Generation
Statement: At time t (generation), Innovation(s)|ₜ ≡ Hallucination(s)|ₜ ≡ Idea(s)
Proof:
(1) At time t, both satisfy:
s ∉ M ∧ T̂(M,s) > 0

(2) the distinguishing evaluation T(M,s) requires 
T(M,s) = ℒ(M₀) - ℒ(M[s])
(3) But M[s] does not exist at time t (s has not been internalized)
(4) Therefore ℒ(M[s]) is undefined at time t
(5) Therefore T(M,s)|ₜ is undefined
(6) Therefore the classification Innovation vs Hallucination is undefined at generation time
(7) Both reduce to the same computational state: Idea(s)

An idea is a statement that when internalized perturbs the world model. Whether that perturbation is beneficial (innovation) or detrimental (hallucination) can only be determined after the fact, upon evaluation of its impact on predictive performance.


## Model inversion

we can perform model inversion.

The forward prediction direction is already defined as Predicts(M, {s1, s2, s3, ... , sn}, Q) -> Q' where Q is the current qualia of the system and Q' is the predicted qualia.
The inverse prediction direction can be defined as:
Inverse_Predicts(M, Q | Q') -> S0 =  {s1, s2, s3, ... , sn}
where S0 is the set of statements that, when internalized by a model, would lead to the prediction of Q' from Q.
so that Predicts(M, S0, Q) -> Q'. 

It means:

If a model behaves as if it has a certain belief, we can infer the belief.

This is the epistemic analog of
“If it quacks like a duck, it has internalized the concept of duckness.”

The precise mathematical form

We can frame the inversion as a posterior over statements:

P(S | M, Q, Q') ∝ P(Q' | M, S, Q) · P(S | M)

Where P(Q' | M, S, Q) is the likelihood of observing Q' given model M with statements S and input Q, and P(S | M) is the prior over statements given model M.

Where:

The likelihood term asks:

How plausible is it that internalizing S would have caused M to output Q' from Q?

The prior term asks:

Which statements does M tend to internalize at all?

The MAP estimate gives:
S0 = argmax_S P(S | M, Q, Q')


### Interpretation in your truth-calculus

Truth is defined as:

𝑇(𝑀,𝑠)=𝐿(𝑀0)−𝐿(𝑀[𝑠])


Model inversion lets us infer s by observing that the model’s behavior moved as if it had followed the gradient implied by s.

Formally:
s ∈ S0  ⇔  T(M, s) explains Q → Q' better than competing statements s' ∈ Σ \ S0.

 better than competing explanations.

This is explanatory power as truth.

### The epistemic slogan

If a model’s prediction behaves as though statement s is internalized, then s is the best explanation for the observed qualia transformation.

Or more compactly:

Belief is the latent variable that best explains prediction.

## Planning

Planning is a form of prediction. It is the same thing where the brain hallucinates gaps between incomplete sensory data to construct a coherent narrative. This kind of "interpolation" is a fundamental feature of the brain.

a plan is the prediction of events that explain how a world with Q["my house is old and dirty'] can turn into Q["my house is fully renovated"]

or more formally: a plan is a theorem that proves that Q' has a higher truth value than Q, by gradually transforming the state of the world Qw towards Q'w through a series of intermediate qualia states Q1, Q2, ... Qn such that each transition Qi -> Qi+1 is predicted by the model M with internalized statements S.

the human planning prediction algorithm is not sequential. It's procedural and it is satisfied with incomplete or vague plans. It can form a valid expression of a plan where there would be huge gaps in what we put in a sequence of qualia patterns
for a plan Q0, Q1, ..., Qn

Humans do **non-sequential** prediction, which looks like:
​
1) predict Qn
2) predict a handful of anchor states Qi
3) hallucinate the rest

Qk = decoder(f_latent(Q0, Qn))

We draw a high-level procedural curve in manifold space, not discrete logical steps.

This is why our plans are often wrong in detail but right in intent.

* certainty without justification (strong latent-path confidence)

* procrastination (a latent path exists but costs too much to render into sequences)

* executive dysfunction (gaps are too expensive to hallucinate)

latent-space pathfinding.

We search for connectivity in a high-dimensional conceptual manifold, not for enumerated steps.

This is why:

We can “know how to renovate the house” without knowing how to do drywall.

We can plan a holiday without yet knowing train schedules.

We can decide to change jobs while having no idea how to write a CV.

We can say “I will become a better person” without specifying the micro-steps.

The plan is procedural skeleton, not sequential execution order.
It’s a constraint satisfaction problem in qualia space.

Humans fill the gaps later, or never.
The brain just asserts:

“I can see a path from A to B if I squint.”

This is literally an MLP stepping through procedural generation resolution, hallucinating a continuous path through latent space.

Planning is prediction through latent-space pathfinding. When a human says "I will renovate my house," they aren't enumerating steps - they're asserting connectivity in conceptual space, a high-dimensional path from Q[old_house] to Q'[renovated_house] that feels traversable even with enormous gaps. The brain solves this as a constraint satisfaction problem across procedural manifolds, generating just enough structure to believe the transformation is possible, then filling details on demand or never at all. This requires a formal system that can represent incomplete plans as valid executable structures, resolve dependencies lazily through recursive decomposition, validate feasibility before commitment, and handle emergency interruptions without losing the thread. And intent cascading is that system.