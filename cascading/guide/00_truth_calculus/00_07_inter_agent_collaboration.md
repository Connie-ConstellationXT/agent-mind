# Chapter 7: X-Path: Cross-Agent Segments in a Plan Manifold

## The problem this formalization solves

Most planning models quietly assume that “my plan” is something I can execute end-to-end. Real life is not like that.

A large fraction of human plans contain dependencies that are not “tools” and not “knowledge,” but other agents. That dependency is qualitatively different from “I need a hammer,” because a hammer does not run its own manifold and does not decide when to act. A human collaborator does.

Without a dedicated representation, collaboration gets incorrectly modeled as either:

1. a sequential step (“wait”), which destroys the reality that collaboration is often nonblocking and asynchronous, or
2. an unmodeled externality (“it’ll happen somehow”), which collapses auditability, timing reasoning, and failure handling.

Intent cascading already treats “other agents” as first-class dependencies via `RequiredInstrument` and resolution infrastructure.  What is missing is a clear, didactic way to represent the *cross-agent* segment as a structural object in the plan graph, with explicit fork and reconvergence semantics.

That structural object is the X-Path.

“X” is for exchange / cross-agent / crossing: it is the part of *my* plan that must be completed by a different agent.

## Definition (reader-first)

An **X-Path** is a cross-agent arc embedded in my plan manifold, defined by two shared contact points:

1. **Fork point (start coupling):** a qualia/state in my plan where another agent must become engaged (triggered, asked, prompted, cued, or allowed to infer a need).
2. **Reconvergence point (termination coupling):** a qualia/state in my plan whose satisfaction is achieved only when that agent produces a specific output artifact.

Everything between those two contact points is “their manifold,” not mine. I may model it at low resolution, or I may know it in detail, but execution responsibility is exogenous.

Crucially, the X-Path is typically **nonblocking**: my citerior path can continue doing other work while the X-agent’s path unfolds. This matches the dependency-driven concurrency model: precepts can spawn and later activate when a dependency appears, rather than forcing a linear “wait step.” 

## The two things an X-Path must always specify

An X-Path is not “collaboration vibes.” It is a contract with two invariants:

A) **Start coupling invariant:** “The other agent receives *some* trigger that causes their relevant path to start.”
B) **End coupling invariant:** “The other agent produces an output artifact that I can recognize as the reconvergence condition of my plan.”

The *mechanism* of the trigger (explicit order, message, object left in a place, turning on a light, tacit inference) is irrelevant to the plan manifold graph; it is simply the physical/semantic carrier that lets the other agent build the required internal multilayer perceptron neuron 

## Why fork and reconvergence both matter

If you only model reconvergence (“I’m waiting for their output”), you still have an unmodeled question: “When do they start?”

In practice, collaborations fail at the fork far more often than at the join:

* I never asked.
* I asked, but too early / too late.
* I asked in a format that didn’t bind to their perception model.
* They were never in a position to accept the dependency.

So the X-Path is explicitly a *coupled pair*: a start-bond and an end-bond. Think “two solder joints,” not “one magic portal.”

## Relationship to RequiredInstrument and continuous identity

From the dependency system’s perspective, an X-Path is a special case of an instrument dependency: a precept on my citerior path requires an artifact that I cannot produce locally, so the executive must resolve a provider. 

However, collaboration introduces a specific twist: the provider is an agent whose output must be bound to my input with **continuous identity**, not loose substitution. The architecture already names this as the core contract of dependency resolution: pattern descriptor → provider selection → `allocateOutput` identity continuity. 

X-Path is the *graph-level* representation of the same contract, but across agent boundaries.

## Preflight negotiation (why it is mandatory)

A plan manifold cannot be constructed if a reconvergence node is undefined.

So X-Paths require **preflight negotiation**: I need to know what artifact I am going to treat as the reconvergence point, and the other agent needs to know what counts as “done.”

This aligns with the broader system principle that most resolution work is pushed to preflight rather than discovered late via runtime stalls. 

In human terms, this is the difference between:

* “Can you pick me up later?” (no reconvergence artifact defined)
  and
* “Text me when you know your arrival time; I’ll leave when I get the time.” (reconvergence artifact defined)

## The cognitive epistemology violation (and why it’s narrowly allowed here)

You called this out correctly: the formal question

“What Q′ is the termination of your normal path where ‘shares an identity with the reconvergence point in my plan manifold’ is true?”

is a **qualia translation schema**. Ordinarily, cognitive epistemology forbids treating someone else’s internal state as directly comparable to mine.

X-Path is the narrow exception: it does not translate inner qualia directly. It translates **via a shared external referent** (a message, an object, a state of the world) that both agents can bind to their own internal representations.

That shared referent is the “bond.”

## Molecule framing (shared electron)

If two minds are two separate molecules, then an X-Path is not “the same molecule.” It is a **bond** between two molecules: each molecule remains itself, but they share a constraint that has objective footprint in the world.

Sometimes described as “alloyed or semiconductored in the citerior path… subjective qualia but they share an electron.” That is a useful metaphor. The shared electron is the *identity-bearing artifact* that both agents bind to.

A minimal ASCII “bond” sketch:

```text
Agent A (citerior manifold)                 Agent X (exogenous manifold)

   Q'c_fork  o······(trigger artifact τ)······o  Q'x_start
              shared referent / "bond"

   Q'c_join  o······(output artifact ω)·······o  Q'x_end
              shared referent / "bond"
```

The bond is not telepathy. It is a shared referent that creates a legal bridge for identity assertions.

## The math of X-Path (formal section)

### Notation recap

* My citerior plan manifold: ( Q'^c(i, k, p) )
* The X-agent’s manifold (as it matters to me): ( Q'^x(i, k, p) )
* (i): temporal progression index (“what comes after what”)
* (k): resolution (“how finely this frame is unfolded”)
* (p): branch index / path selector (“which alternative strand”)

X-Paths add a cross-agent coupling constraint, not a third agent-global axis.

### The core predicate: shared identity at reconvergence

Define a predicate:

ShareID(A, B) := “A and B bind to the same external referent / artifact identity.”

Then an X-Path is characterized by the existence of a termination node in the X-agent’s path such that:

There exists Q'^x(i_end, k, p_0) such that ShareID(Q'^x(i_end, k, p_0), Q'^c(i_join, k, p_1)).

In plain language: there exists an output artifact on their path that shares identity with my reconvergence qualia.

### The preflight question

Preflight negotiation is me asking the other agent to provide the missing identifier for my join node:

Find Q'^x(i_end, k, p_0) such that ShareID(Q'^x(i_end, k, p_0), Q'^c(i_join, k, p_1)) = true.

Or, as dialogue:

“I need the identity/value of (Q'^c(i_{\text{join}}, k, p_1)). What artifact will you produce that I can bind to that reconvergence point?”

you are asking for the identity of the reconvergence artifact (“the message containing time (T)”), not for the internal details of their travel plan.

### Fork coupling (start signal) is symmetric

Similarly, there is a fork bond. Let ( τ ) be the trigger artifact (message, cue, agreed signal). Then:

ShareID(Q'^c(i_fork, k, p_*), Q'^x(i_start, k, p_0))

This is why fork modeling matters: without the fork bond, the X-agent’s path is not even guaranteed to be *instantiated*.

### “Their full resolution path might be contained in my X-Path”

There are two valid representations:

1. **Black-box X-Path:** I only represent fork and join; the interior is a spring/unknown duration. This is the common case, and it is usually optimal for my cognitive cost.
2. **White-box X-Path:** I include a high-resolution internal model of their steps *inside my X-Path segment*, while still acknowledging that execution is exogenous. This is common when the collaborator is predictable (a service desk workflow, a recurring teammate procedure, a spouse’s habitual routine).

Both are the same X-Path structure. The difference is only how much of (Q'^x) I choose to render.

## Canonical diagram

```text
X-Path (Exogenous agent's plan)
                                    
                    Q'x(i₁,k,p₀) ~~~~\/\/\/~~~~ Q'x(i_end,k,p₀)
                    "Journey of       [spring]      "Return time
                     indeterminate    [resolution]   becomes known"
                     length"                         [shared identity
                          ║                           qualia]
                          ║                                ║
                          ║                                ║
    Citerior path    Q'c(i₁,k,p₁)                    Q'c(i₄,k,p₁)
    (alternative)    "Bring X-Agent                   "Receive msg:
                      to train                         time = T"
                      station"                         [THIS IS WHAT
                          │                             WE'RE ASKING]
                          │                                │
                          │                                │
    Citerior path ───Q'c(i₀,k,p₀)───Q'c(i₂,k,p₀)───Q'c(i₃,k,p₀)───Q'c(i₅,k,p₀)───Q'c(i₆,k,p₀)
    (main)           "Do other         "Continue         "Still        "Pick up     "Return
                      activities"       activities"      working"      X-Agent"     home"
                          
         PREFLIGHT NEGOTIATION:
         "What is the identity/value of Q'c(i₄,k,p₁)?"
         "I need this to construct my plan manifold"
         
         start                                                                    final
```

Two details worth noticing:

First, the X-Path spring is not a “wait.” It is an uncertainty placeholder whose resolution collapses when the reconvergence artifact appears.

Second, the citerior path continues to accumulate progress while the X-agent’s path is unresolved. This is the structural reason collaboration can be nonblocking rather than a forced pause. 

## Practical consequences (why X-Path is a real upgrade)

1. It makes collaboration auditable. A reader can point at a reconvergence node and ask: “What external artifact satisfies this?” and there is a formal answer path. 
2. It makes asynchronous collaboration first-class, rather than treated as a planning failure mode.
3. It explains a common human experience: collaboration feels “hard” because it requires preflight negotiation of identity, plus maintaining two bonds (fork and join), not one.
4. It dovetails with RESOLVE thinking: the question becomes “who can provide this instrument?”—not “how do I personally grind it out?” 

## Summary (one sentence)

An X-Path is a cross-agent subgraph embedded in my plan manifold, defined by a fork bond and a reconvergence bond, where the interior path executes in another agent’s manifold, and coordination is achieved by identity-bearing external artifacts rather than forbidden qualia translation.
