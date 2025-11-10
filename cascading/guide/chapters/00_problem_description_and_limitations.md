# Chapter 0: Problem Description and Limitations

## The Theoretical Scope

Intent cascading formalizes how an agent decomposes goals into interdependent workflows—making the compositional nature of problem-solving explicit and auditable.
At its heart, this is a response to a fundamental challenge: how do you take a high-level objective and systematically break it down into concrete actions in a way that the agent (and any observer) can trace, verify, and debug?
Traditional imperative programming answers this with branching logic and function calls. Intent cascading answers it by making dependencies and composition first-class concepts. 
Instead of hiding the structure of a problem inside procedural code, we expose it as a graph where every node represents a decision or action, and every edge represents a dependency. This makes problem decomposition itself visible and auditable—not just the execution, but the reasoning that led to the execution plan.

## Prerequisite Capabilities

Intent cascading assumes the agent already possesses two critical capabilities: predictive perception and natural language processing. Predictive perception means the agent can recognize patterns in sensory data—it can look at the world and identify "a coffee cup," "water that is boiling," "a person in distress"—through learned pattern recognition.
Natural language processing means the agent can understand semantic relationships between concepts—it can grasp that "brewing" and "steeping" are related actions, that "fresh" and "stale" are opposite states, that "coffee" and "espresso" are semantically connected. 
Modern attention-based transformers have already demonstrated this capability: they can learn to model semantic relationships between tokens without explicit programming. Intent cascading doesn't replace or build these capabilities from scratch. Instead, it takes what the agent already understands—through its perceptual and linguistic models—and orchestrates it into formal, executable workflows. 
This is the key point: we are not solving perception or semantics here. These capabilities are treated as prior art—solved and available; our focus is on coordinating them into formal, auditable workflows.

## The Core Problem

How do you move beyond pure natural language instructions to workflows that are composable, debuggable, and auditable in real time? Consider the difference: a pure NLP instruction might be "make coffee."
The system might understand this semantically and execute it, but when something goes wrong—when the water doesn't heat, or the filter is missing, or the process takes too long—there's nowhere to look.
The reasoning is embedded in learned weights or scattered across multiple function calls.
Contrast this with a formal workflow: "to make coffee, you need: a coffee maker (check if available), water (check if available), ground coffee (check if available). First, fill the maker with water. Then, add grounds. Then, heat." Now when something fails, we know exactly where it failed, what was assumed, and what to fix. Intent cascading is designed for this second scenario. 
It transforms a goal into a structure that makes every assumption, dependency, and decision point explicit.

## Why Rigidity Matters

Natural language is fluid and ambiguous. A single sentence can be interpreted a dozen different ways depending on context, prior knowledge, and implicit assumptions. This flexibility is wonderful for human communication—it lets us say more with less, rely on shared understanding, and adapt on the fly. 
But it's terrible for systems that need to coordinate complex, multi-step workflows where failure in one step breaks everything downstream.
Formal structure removes this ambiguity. When we rigidly specify what must exist before an action can happen, what that action produces, and how those outputs feed into the next steps, we eliminate the possibility that two different parts of the agent are operating under different assumptions.
The rigidity is not a bug; it's a feature. It trades the flexibility of natural language for the precision and auditability that real workflows require. It means the agent (and anyone inspecting its work) can point to any step in the execution and ask: "Why did this happen?" and get a definitive answer traced through the formal structure.

## From Goal to Decomposition

A semantic goal description—expressed in natural language—becomes a formal structure that exposes every dependency and decision point. This transformation is the heart of intent cascading. You start with "I want to brew excellent coffee." 
That's a semantic goal: the agent understands the concepts involved and roughly what needs to happen.
But it doesn't yet expose the structure. From that single goal, intent cascading asks: "What must be true before I can even attempt this? What sub-goals do I need to achieve first? What could go wrong?"
The answers to these questions become nodes and edges in a dependency graph. "I need fresh water" becomes a node. "I need a coffee maker" becomes a node. 
"The water must be heated to between 195 and 205 degrees Fahrenheit" becomes a constraint. "If the water is too hot, I might scald the grounds" becomes a contingency. Each of these emerges from rigorous decomposition of the original semantic goal. 
The result is a structure that is both formal (auditable, debuggable) and traceable back to the original intention.

## Auditability as a First Principle

Every step is inspectable; the agent's reasoning is not hidden in learned weights but explicit in the graph. This is a radical shift in how we think about agency.
In traditional machine learning systems, the "why" of a decision is often opaque. The model learned it from data; the weights reflect statistical patterns; good luck explaining it. 
In intent cascading, the "why" is always accessible. Why did the agent decide to heat the water before adding grounds? 
Because the precept for "adding grounds" declares that it requires "hot water" as a prerequisite. Why did it check whether the coffee maker was available? Because the precept is explicit about its requirements.
Why did it try a different brewing method when the first one failed? Because the dependency graph allowed for multiple paths, and the first path was blocked. 
This auditability is not just helpful for debugging—it's essential for trust. If an agent is coordinating with humans, with other agents, or with critical infrastructure, those parties need to understand not just what the agent did, but why.
Formal structure provides this. It makes the agent's reasoning transparent and inspectable at every level.

## Where This Breaks

Intent cascading is not a panacea. There are real limits to what this approach can do, and it's important to name them upfront. First, when the problem domain hasn't been formally modeled yet, the system fails at the boundary. 
If no one has yet specified the prerequisites, constraints, and decompositions for a particular type of goal, intent cascading can't magic them into existence. It requires domain expertise to build the formal model. 
Second, when real-world constraints don't fit the dependency structure—when goals are interdependent in ways that don't resolve to a clean acyclic graph, when timing and concurrency create race conditions, when the world changes faster than the agent can replan—the formal structure can become brittle.
Intent cascading assumes that dependencies can be resolved and that the world stays relatively stable during execution. If that assumption breaks, so does the system.
Third, when the agent lacks the semantic understanding to begin with—when it doesn't really know what "coffee" is, or can't distinguish fresh water from stale—no amount of formal structure will help.
Intent cascading is a layer on top of perception and semantics. If those fail, everything fails.
These limitations don't invalidate the approach; they just define its scope.
Intent cascading is powerful for well-modeled domains where dependencies matter and auditability is valuable. It's weaker at the frontiers of new problems, in chaotic environments, and where perception itself is the bottleneck.

