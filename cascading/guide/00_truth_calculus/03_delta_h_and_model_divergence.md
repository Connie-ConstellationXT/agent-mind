# Delta-H: Model Divergence and Metabolic Provisioning

## Origin: The Apollo Guidance Computer

During the Apollo 11 lunar descent, the guidance computer tracked altitude using two sources: the Inertial Measurement Unit (IMU) and the landing radar. The IMU provided continuous dead-reckoning estimates but accumulated drift over time. The radar provided accurate ground-truth measurements but was only available during specific phases of descent.

The difference between these two measurements — the IMU's *prediction* versus the radar's *observation* — was the **ΔH** (delta-H).

**This was not a fault.** The engineers knew IMUs drift. They designed the AGC to *integrate* radar data with IMU predictions, using ΔH as a signal for when and how much correction to apply. When ΔH grew large, it meant "my predictive model has drifted; I need to update it with ground truth."

The critical insight: **ΔH is a designed-in metric for model divergence. The system uses it to know when to provision more resources, when to update beliefs, and when to shed load.**

---

## Delta-H as a Cognitive Metric

For modeling cognitive epistemology, we borrow and adapt **ΔH** as a metric for observed divergence between world models held simultaneously by the same cognitive system.

In the AGC, ΔH measured the difference between two altitude estimates (IMU prediction vs. radar observation) — both *present in the system at the same time*. In cognitive systems, we generalize this: **ΔH measures the observed divergence when a system holds two predictive models that make conflicting predictions about the same observable.**

Critically: **ΔH is observed divergence, not latent divergence.** A model can be wrong about reality without producing ΔH if there is no competing model in the system to contradict it. ΔH only becomes a cognitive force when two models make incompatible predictions.

**Three sources of ΔH:**

1. **Inferred external agent model vs. internal model**: When you apply R⁺ to another agent's behavior, you generate an inferred model M_other of their beliefs. This conflicts with your own M_self, producing ΔH(M_self, M_other). ΔH can be low for cases where the other agent says or does things you expect, and high when they say or do things that contradict your expectations.

2. **Internal model vs. sensory qualia**: When your model predicts one thing but sensory input delivers something else, that's ΔH(M, internal, Q_sensory). **Note:** Sensory qualia are themselves an internalized model — the perceptual apparatus is not a window to "raw reality," but another model M_sensory. The divergence is between M_cognitive and M_sensory. This is why humans, and even dogs and primates can be surprised by magic tricks - their internal models diverge from sensory qualia in unexpected ways.

3. **Planned future vs. present reality**: When you project a complex plan over many steps (M', Q')ₙ through R⁻, you must hold two models simultaneously: the planned future states *and* the current actual state. ΔH grows with plan complexity and length because you're maintaining a large divergence between "what I plan to do" and "what is currently true." Without externalization (checklists, Jira, written plans), this divergence must be held entirely in working memory. This is why you cannot plan an entire space program in your head — the ΔH between the planned Apollo trajectory and the 1961 present state is so large that the metabolic cost of maintaining it exceeds what your brain can provision.


### Formal Definition

ΔH measures the divergence between any two predictive sources. Given a qualia space Q, we compare what two sources predict when applied to Q:

**ΔH(Source₁, Source₂, Q) = ‖P(Source₁, Q) - P(Source₂, Q)‖²**

Where each source can be:
- A **model M with beliefs S**: P(M, S, Q) — model's prediction
- An **observed qualia**: Q directly — ground truth
- A **model inferred from statements**: R⁺(M_other, Q_observed, Q_inferred) — latent belief inference

This generalizes to three use cases:

1. **Agent vs. Other Agent** (model divergence)
   - Source₁: M_self (my model)
   - Source₂: M_inferred from other's statements (their latent model)
   - Q: shared context

2. **Plan vs. Environment** (predictive drift)
   - Source₁: R⁻(M, task) — predicted future state
   - Source₂: Q_observed — current/actual environment
   - Q: the situation without having executed the plan.

3. **World Model vs. Missed Prediction** (correction signal)
   - Source₁: P(M, S, Q) → (M', S', Q') — what the model predicted would happen
   - Source₂: Q_actual — what actually happened
   - Q: the situation

In all cases, ΔH > 0 signals divergence; ΔH ≈ 0 signals alignment.
