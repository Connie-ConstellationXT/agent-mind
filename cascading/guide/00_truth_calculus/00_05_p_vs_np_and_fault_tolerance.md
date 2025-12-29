# P vs NP: The Computational Horizon of Reconvergence

The Truth Calculus provides the theoretical substrate for Intent Cascading, much like UML describes the structure of source code. In this framework, we encounter a fundamental computational limit that defines our fault handling strategy: the distinction between verifying a solution and finding one.

## 1. Reconvergence is NP-Hard

As established in Chapter 4, planning involves generating trajectories in a high-dimensional manifold. **Reconvergence** is the discovery of an intersection point between two orthogonal trajectories (e.g., Agent Model vs. Operator Model, or Intent A vs. Intent B).

Finding this intersection—proving that two divergent states can be reconciled—is an **NP-hard** search problem. The search space of possible epistemic bridges, discourse mappings, or schedule interleavings grows exponentially with the complexity of the state vector.

## 2. Verification is Polynomial (P)

However, **verifying** a proposed reconvergence path is efficient.
- If an oracle provides a mapping between referent $R$ and topic $T$, the system can verify it in polynomial time (ALARM 1205).
- If an oracle provides a schedule that satisfies two realtime promises, the system can verify it in polynomial time (STOPCODE 0xE2).

## 3. The Curtain Wall: Resource-Bounded Decidability

The system operates under strict metabolic and temporal constraints (the "Resource Budget"). This budget imposes a **Polynomial Time Limit** on all reconvergence searches.

When an alarm fires (e.g., `ALARM 1204 MODEL_INVERSION_OVERFLOW`), it does not signify that reconvergence is ontologically impossible. It signifies that:

$$ \text{SearchCost}(\text{Reconvergence}) > \text{Budget} $$

The alarm is a **P-time proof-of-work guard**. It asserts that the system cannot find a solution within the allocated polynomial time slice.

### The "Computational Horizon"
We adopt the term **Computational Horizon** to describe this hard resource boundary. Like the event horizon in physics, it defines the limit of the observable (or solvable) universe for the agent. Outside the Computational Horizon lies the chaotic, exponential space of unbounded search.

## 4. Truth Value of P != NP

In the context of Truth Calculus, the statement $s = \text{"P} \neq \text{NP"}$ is not just a mathematical conjecture; it is an architectural necessity.

If we assumed $P = NP$, the system would be obligated to solve reconvergence problems perfectly in real-time. By assuming $P \neq NP$, we acknowledge that there exist problems whose solutions cannot be found efficiently, even if they can be verified efficiently.

Therefore, **assuming P != NP has a positive truth value** ($T(M, s) > 0$) for the system.

**Why?**
Because this assumption justifies the existence of the **Stopcode**. It allows the system to treat "budget exhaustion" as a valid, safe termination state rather than a failure of the algorithm. It transforms an infinite loop (searching forever for a solution) into a handled fault (acknowledging the Curtain Wall).

This assumption is the foundation of **fault tolerance** in Intent Cascading. It allows the agent to survive in a complex world by failing fast when faced with intractable complexity.
