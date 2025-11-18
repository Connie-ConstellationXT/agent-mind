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