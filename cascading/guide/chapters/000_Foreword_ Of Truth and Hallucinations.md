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

Consider three statements:

s1: "opened containers of liquid can leak their contents"
s2: "stuff falls down"
s3: "the moon is made of cheese"

Let M1 be a model that has internalized all three: M1 ⊢ (s1, s2, s3) -> M1[s1, s2, s3]

Now consider a current qualia Q = "I am pouring a bottle of water over my carpet" and the predicted outcome Q' = "my carpet is wet and damaged."

We can use s1 and s2 together to predict Q': the bottle is open, liquid will leak, and gravity will pull the liquid onto the carpet below.

But what about s3? Believing or not believing that the moon is made of cheese has absolutely no impact on P(M1, {s1, s2, s3}, Q) -> Q' in this scenario. The truth value of s3 is functionally irrelevant to the prediction.

In our example, s3 ("the moon is made of cheese") belongs to the domain d_astronomy, while Q ("pouring water on carpet") belongs to d_household. These domains are disjoint. In the household domain, we observe:

T(M₁, s₃ | d_household) ≈ 0    and    T(M₁, {s₁, s₂} | d_household) ≫ 0

The statements s1 and s2 have strong positive truth value for household predictions, while s3 contributes nothing.

For most of human life, beliefs about the moon's composition have truth value near zero in the domains humans actually inhabit, even though s3, "the moon is made of cheese," can easily be falsified in the appropriate domain.

Unless you work in astronomy or a space program—domains where d_moon_properties overlaps with d_practice—then the moon's composition becomes deeply relevant to prediction and planning:

T(M₁, s₃ | d_astronomy) ≪ 0    and    T(M₁, s₃ | d_space_program) ≪ 0

Here, s3 has significantly negative truth value—it directly contradicts reality and degrades predictive performance in those domains.

In the carpet example, s1 and s2 together imply a generalized statement s4: "the net effect of gravity and container dynamics applies universally and is derivable from deeper principles of Newtonian physics." This s4 unifies s1 and s2 within a common domain structure, giving their conjunction predictive power.

Therefore, we define D as the set of boundary conditions di that limit the applicability of statements s1 and s2.

D = {d1, d2, d3 ... dn} where each di is a boundary condition, or "domain".

The key insight is that **statements S are only relevant for prediction within the domain set {d} they apply to, and only if the observed qualia Q also exists within that domain set {d}.**

Formally: A statement s has predictive relevance only when both the observation Q and the statement s are elements of the same domain: Q ∈ d ∧ s ∈ d.

### Meta–statement notation:
A meta–statement can mark the restricted evaluation domain of a statement s.

↑₍d₎ s := “s has positive truth value for M under transitions satisfying d”
i.e. T(M, s ; D_eval | d) > 0.


#### Derived bounded statement:
s_bound := “s holds only over transitions τ with d(τ) = true”
Formal: ∀τ (d(τ) ⇒ T(M, s ; D_eval | d) > 0) and ∀τ (¬d(τ) ⇒ T(M, s ; D_eval | d) ≤ 0).

### Formal proof that internalising bounded statements improves model performance using the household domain example:

Let s1_bound := ↑₍d_household₎ s1 and s2_bound := ↑₍d_household₎ s2. Then internalising s1_bound and s2_bound into M1 should yield a model M1' with improved predictive performance when predicting household scenarios across all contexts.

M1' ⊢ (s1_bound, s2_bound) -> M1'[s1_bound, s2_bound]

Predicts(M1', {s1_bound, s2_bound}, Q) -> Q'' where Q'' is the predicted qualia of the carpet damage considering the bounded statements.

The bounded statements explicitly encode: "In household contexts, s1 and s2 apply universally. Outside household contexts (e.g., in vacuum environments or space), they do not."

If T(M1', {s1_bound, s2_bound}) > T(M1, {s1, s2}), then internalizing the bounded statements has improved the model's predictive performance across all household regimes. Meanwhile, in domains where these statements don't apply—such as orbital mechanics or vacuum environments—the bounded versions correctly remain silent.

This formalism allows predictive systems to internalize statements with an explicit understanding of their applicable domains, preventing overgeneralization while preserving truth value within appropriate contexts.


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

### Self-modeling in Planning

No plan will incorporate all details down to every individual muscle movement, keystroke, or sensory feedback loop. A plan necessarily operates at some level of abstraction, leaving details to be filled in (or improvised) during execution.

But there is a critical constraint hidden in this formalism: **a plan necessarily predicts not just future qualia, but future model states.**

When a predictive system makes a plan that involves intermediate steps requiring knowledge or capabilities it does not currently possess, it is necessarily predicting that at some point during execution, the model M will have changed into a new model M'. The system is asserting: "At step i, I will know X" or "At step i, I will have learned Y" or "At step i, I will have acquired tool Z."

This is self-modeling: the model predicts its own transformation.

The full form of a plan is therefore:

$$P(M, \{s\}, Q) \to (Q', M')$$

Where M' is the predicted state of the model after executing the plan. This is not just a prediction about the world; it is a prediction about the predictor itself.

Consider the example of renovating a house. The plan predicts intermediate states: "First, I will assess the structural integrity. Then, I will identify problems and acquire the skills to fix them. Then, I will execute repairs." At the moment of planning, the agent may not know what problems will be found behind the walls, nor what skills will be required to fix them. But the plan implicitly asserts: "After step 1 (assessment), I will have acquired knowledge of the problems. After step 2 (discovery), I will have learned or acquired the tools to address them." The prediction encodes M → M': from "a model that didn't know about hidden water damage" to "a model that does and knows how to remediate it."

This is why planning often feels aspirational or involves faith: the agent is predicting that it will become a different agent, one more capable or knowledgeable than it currently is. And this prediction may be wrong—the model may fail to acquire the necessary knowledge, may discover that the problems are more complex than anticipated, may lack resources to address them, or may find that its predictions about its own learning trajectory were overly optimistic.

All planning requires some form of self-modeling.

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


Note: Predictive Truth Theory does not claim to be a universally applicable epistemology. It is bounded to the domain of predictive systems that build internal models to forecast future states of the world.