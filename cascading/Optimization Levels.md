# Optimization Levels in Intent Cascading

Optimization levels in intent cascading represent the **executive's computational elegance budget**—how much complexity the system is willing to spend on building sophisticated precept genealogies. The model is inspired by a gearbox: each level (1 through 5, plus GE) is a "gear" that controls precept selection strategy and stack composition elegance.

**Critical Design Principle**: Optimization levels are **executive strategy**, not precept behavior. Precepts themselves are optimization-level agnostic—they simply declare capabilities and STALL when they cannot continue. The executive manages optimization through **precept selection heuristics** and **genealogy complexity budgeting**.

## Gearbox Analogy: Complexity Management

The gearbox manages the trade-off between **Robustness** and **Optimization Depth**.

- **Low Gears (T, L, A):** High robustness, low assumption. Works in chaos. Atomic operations.
- **High Gears (P, H, NP, GE):** High optimization, high assumption. Works in order. Non-atomic (transactional) operations.
- **Momentum:** The degree to which the environment matches the agent's predictive model. High momentum allows the use of NP-level solvers because the search space is constrained.

### Transactional State & Atomicity

A critical distinction lies in the **atomicity** of the agent's operations:

- **Low Gears (T, L, A) are Atomic:** They operate on immediate perception and retrieved priors. Each decision is a self-contained transaction. They are **stateless** regarding the trajectory history.
- **High Gears (P, H, NP, GE) are Non-Atomic:** They rely on maintaining a **transactional context** across time (e.g., trajectory buffers, multi-stage inference). They are **stateful**.

**The Fragility of High Gears:**
Because high gears depend on a valid historical context (momentum), they are vulnerable to **Context Invalidation**. If the environment changes faster than the transactional context can update, the plan becomes incoherent.

**Stall Recovery:**
Downshifting is a **Context Flush**. The system discards the invalidated transactional state and reverts to atomic, stateless operation to re-acquire the environment.

---

## Executive Optimization Strategy by Level (Complexity Classes)

The optimization levels are not just arbitrary "gears" but represent distinct **computational complexity classes** of decision making.

- **Level 1: T (Lookup (T)able)**
  - **Strategy:** **Externalized Decision.**
  - **Behavior:** The agent follows a static lookup table, a strict checklist, or real-time commands from an instructor/operator.
  - **Complexity:** $O(1)$. No internal search or calculation.
  - **Use Case:** Emergency recovery, cold start, "safe mode".

- **Level 2: L (Linear)**
  - **Strategy:** **Simple Heuristic / Reactivity.**
  - **Behavior:** The agent uses simple, robust algorithms (e.g., Bang-Bang control, basic PID). Decisions are fast and robust but may lack elegance or handle edge cases poorly.
  - **Complexity:** $O(n)$. Linear scaling with input.
  - **Use Case:** Building momentum, stabilizing chaotic states.

- **Level 3: A (Associative)**
  - **Strategy:** **Pattern Matching / Prior Search.**
  - **Behavior:** The agent actively searches for priors to "attach" actions to. It stabilizes the necessary actions into an understanding scaffold by recognizing the current state pattern and retrieving a stored schema. Pre-Grokking learning can occur here.
  - **Complexity:** $O(n \log n)$. Search and retrieval.
  - **Use Case:** Context recognition, scaffolding understanding, bridging reactivity and planning.

- **Level 4: P (Polynomial)**
  - **Strategy:** **Algorithmic Verification.**
  - **Behavior:** Standard planning and optimization. The agent solves problems that are verifiable within the resource budget.
  - **Complexity:** $P$. Solvable in polynomial time.
  - **Use Case:** Normal operation, standard cruising.

- **Level 5: H (Heuristic)**
  - **Strategy:** **Bounded Optimization.**
  - **Behavior:** The agent faces an NP-hard problem but applies a "Rule of Thumb" to prune the search space. It accepts a suboptimal solution to stay within the P-time budget.
  - **Complexity:** $APX$ (Approximable within P).
  - **Use Case:** High-speed decision making under uncertainty, "good enough" optimization.

- **Level 6: NP (Non-Deterministic / Deep Optimization)**
  - **Strategy:** **High-Dimensional Optimization.**
  - **Behavior:** The agent employs sophisticated, multi-variable control (e.g., Quaternion-based smooth control, deep genealogy generation).
  - **Constraint:** This level assumes the problem has been constrained enough (by momentum/context) that the NP-hard search space is locally tractable.
  - **Complexity:** $NP$. Requires "momentum" to avoid hitting the Computational Horizon.
  - **Use Case:** Elegant cruising, high-precision maneuvers.

- **Level 7: GE (Gamma Entrainment)**
  - **Strategy:** **Creative Restructuring.**
  - **Behavior:** Insight-driven precept composition. Attempts novel genealogy patterns and semantic cascade restructuring.
  - **Complexity:** Meta-cognitive.
  - **Use Case:** Breakthroughs, reframing the problem space. What machine learning would call "grokking" generalization.

## Precept Selection Heuristics

The executive uses **Lines of Code (LOC)** and **Algorithmic Density** as heuristics:

- **T / L (Levels 1-2):** Select precepts with **Explicit Logic** (often higher LOC, unrolled loops, hardcoded checks). Robustness > Elegance.
- **A / P / H (Levels 3-5):** Select precepts with **Structured Patterns** (moderate LOC, schema-based). Balance between search and execution.
- **NP (Level 6):** Select precepts with **Elegant Math** (often lower LOC, dense matrix operations, solver calls). Elegance > Robustness (relies on solver convergence).
- **STALL recovery:** Executive downshifts (e.g., NP $\to$ H $\to$ A) to trade elegance for robust recovery.



## A/B Level
- **A/B:** A distinct optimization level where the system runs in autonomous background mode. Tasks at this level are managed with minimal active attention, using spare resources and deferring to higher-priority processes. 

---

## Clutch Protection and Executive Function Regulation

Optimization levels provide **executive function regulation** through computational elegance budgeting:

- **Prevents premature complexity** - Starting in high gear burns out the clutch (causes STALL)
- **Forces momentum building** - System must progress through lower gears to establish context
- **Natural downshift recovery** - STALL triggers optimization downgrade and simpler precept selection
- **Adaptive complexity management** - Executive learns optimal gear selection patterns for different contexts

The system serves as a **cognitive clutch protection mechanism**, preventing overoptimization by enforcing appropriate precept selection based on current task momentum and established context.

## Integration with Executive Runtime

Optimization levels are stored in the **Job Descriptor** as executive state, never in precept declarations:

```c
typedef struct {
  // ... other fields ...
  optimization_level_t current_optimization; // T, L, A, P, H, NP, GE
} modern_job_descriptor_t;
```

The executive manages optimization through:
1. **Precept selection strategy** based on LOC heuristics
2. **Genealogy complexity budgeting** for stack composition  
3. **Automatic downshift** on STALL recovery
4. **Learning from cache state** to improve selection patterns
