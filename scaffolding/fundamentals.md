# Intent Scaffolding — Friendly Fundamentals

This is a short, plain-English introduction to the vocabulary and mental model used across this repository. It’s intended for people who land here and ask: “what do you even mean by ‘intent’, ‘precept’, or ‘artifact’?”

For full technical details and formal definitions, see the specialized files linked at the end of this page.

## Quick glossary

- Intent
  A high-level goal or purpose the system is trying to accomplish (e.g., “Make a sandwich”, “Find relevant source files”). Intents describe *what* to achieve, not how to do it.

- Precept
  A single, named unit of work inside the intent DOM. Precepts are declarative, typed, and composable — they are the building blocks of intent trees. Example:
  ```xml
  <Precept name="MakeOmelette">
    <Description>Prepare a basic cheese omelette</Description>
  </Precept>
  ```

- RequiredInstrument (or instrument)
  A declared dependency a precept needs before it can run. This can be a physical object, a piece of knowledge, another agent, or abstract resources like time or attention. Example:
  ```xml
  <RequiredInstrument instrumentName="eggs" quantity="2" />
  ```

- Artifact / Output
  The product a precept promises to produce. Outputs become instruments for downstream precepts.
  ```xml
  <Output><Artifact name="cracked_eggs" /></Output>
  ```

- Domain / Context
  Labels that give situational meaning and restrict where certain knowledge or behaviors apply. Domains tell the system which physical laws, conventions, norms, or reasoning modes are relevant — for example, `kitchen` vs `quantum_lab`, or `FrenchCuisine` vs `CorporatePolicy`. The same observation or technique may be valid in one domain but invalid in another (you don't reason about electron behavior the same way you reason about apples; social behaviors that are OK in one culture may be inappropriate in another). Domains are used to guide RESOLVE searches, validation, and runtime selection of behavior.

- YieldSafePoint & Vigil (short)
  YieldSafePoint: a safe place in a precept tree to pause and capture state.  
  Vigil: a low-priority background check that runs opportunistically when attention is available.

- MLP cluster (super simple)
  A group of learned neural components that recognize patterns in system activity. In plain language: “a trained detector that notices useful or risky patterns (habits, faults, anomalies) and can trigger precepts or background checks.” They are pattern detectors, not oracle brains.

## How things run — short overview



- Authoring: you write an Intent DOM using `Precept`s, `RequiredInstrument`s, `Output`s and the other elements.
- precepts are instantiated into executable units called **job descriptors** or simply **jobs** by the runtime.
- Each precept is instantiated into two jobs: one for EXECUTE ()
- all jobs are managed in a central job queue and will attempt to run immediately when created.
- There is no guaranteed order of execution beyond the dependencies declared by required instruments, but the runtime will attempt to run precepts in document order.
- Jobs that cannot run yet (due to missing instruments) will trigger RESOLVE to find providers and yield (wait) until the instruments are available.
- Execution: precepts are evaluated in document order;
- Missing instruments: RESOLVE is invoked to find providers (hot cache → warm cache → repository). If RESOLVE is uncertain, INFER can run simulations to validate candidate providers before committing.

For the full algorithms and runtime semantics see `dependency_resolution_architecture.md` and `INFER_specification.md`.

## From intent to action — turtles all the way down

At a high level, a precept declares that it either (a) knows how to produce a desired output directly, or (b) knows a group of other precepts that can be composed to produce that output. The runtime composes and expands these declarations into an executable tree of jobs — potentially hundreds or thousands of layers deep — until it reaches precepts that actually affect hardware or the environment.

Think "turtles all the way down": each precept may be implemented by lower-level precepts, and those by still lower-level precepts. Eventually you reach a leaf precept we call turtle-0. A turtle-0 precept is the only layer that directly manipulates physical or virtual I/O: moving a muscle, setting an actuator, flipping a valve, toggling an IO port, or emitting a single, verifiable sensor reading. Turtle-0 is intentionally small and simple so its behavior is easy to audit and reason about.

Why this matters:

- Declarative composition: higher-level precepts stay declarative — they don't need to know exactly how an actuator works, only which capabilities (instruments) are required and which lower-level precepts provide them.
- Verifiability: by pushing side-effects to turtle-0, we keep the majority of the runtime analyzable and testable; only a narrow, auditable boundary touches the world.
- Graceful degradation: if a low-level provider fails, RESOLVE can find alternative providers or INFER can validate fallbacks before the higher-level precept commits to a plan.

Example (informal):

- `MakeOmelette` -> composes `CrackEggs`, `MixEggs`, `HeatPan`, `CookEggs` (mid-level precepts)
- `HeatPan` -> composes `FindPan`, `PlacePanOnStove`, `SetBurnerPower` (lower-level precepts)
- `SetBurnerPower` -> turtle-0 precept: set hardware PWM to X (actuator-level command)

In this way the runtime scales from declarative intent to precise actuator commands while preserving traceability and the ability to simulate candidate paths with INFER before touching real hardware.

## Tiny example (end-to-end)
```xml
<Precept name="CrackEggs">
  <Output><Artifact name="cracked_eggs" /></Output>
</Precept>

<Precept name="SeasonEggs">
  <RequiredInstrument instrumentName="cracked_eggs" />
  <Output><Artifact name="seasoned_eggs" /></Output>
</Precept>
```

Read this as: `CrackEggs` produces `cracked_eggs`. `SeasonEggs` depends on `cracked_eggs` and will wait until they exist.

## Where to read next

- `scaffolding/XML_Element_Type_Catalog.md` — full element catalog and examples
- `scaffolding/dependency_resolution_architecture.md` — how RESOLVE finds providers
- `scaffolding/INFER_specification.md` — simulation-based validation
- `scaffolding/capability_system.md` — capability modeling and provides/consumes

## Why the Apollo guidance computer of all things?

# "a 1960s analog digital converter for a gyroscope can't possibly be useful for solving the hard problem of general intelligence, right???"

So why are the ideas expressed here explicitly inspired by the Apollo Guidance Computer (AGC)?

Short answer: space is cool. Fite me irl.

Longer answer:

The AGC shows up in our language because its engineering questions and constraints mirror a mindset we value: the very first design question the team at MIT Instrumentation Laboratory asked was not "how should it run when everything is fine?" but rather "how can it keep running when the unexpected happens and our most basic assumptions collapse?" That emphasis on graceful continuity under failure — deterministic, auditable primitives, tiny trusted boundaries, and a hard focus on what must remain correct even while everything else degrades — is what the AGC teaches us.

Put another way, asking "how does the system continue to run when things break in surprising ways?" is an operational form of asking "what does it mean to act robustly?" That question is close to the start of agency: systems that can plan, detect when their plan's assumptions are violated, and switch to verified fallback behaviors are expressing a minimal, practical form of agency. In the same way, recognizing "I don't know" is the beginning of practical wisdom; recognizing failure modes and planning for them is the beginning of trustworthy action.

We borrow the AGC's stance, not its hardware. The goal is to design small, verifiable building blocks (the turtle-0 boundary among them), clear interfaces between perception, decision, and action, and a runtime that favors auditable fallbacks and simulation-validated choices (INFER) over opaque, monolithic behaviors. This engineering stance helps prevent learned components from becoming unmoored black boxes — it gives learned subsystems discipline and a narrow, testable surface where they interact with the world.

If you want a deeper historical or technical tie, see `scaffolding/Hardware/RALN.md` and `scaffolding/Hardware/ULEM.md` for how the hardware/compilation target and semantic embedding themes map to that engineering stance.

