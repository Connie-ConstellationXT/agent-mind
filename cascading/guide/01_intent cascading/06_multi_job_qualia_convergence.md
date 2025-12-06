# Chapter 6: Multi-Job Qualia Convergence

## Example: Trash and Beans

I'm in the kitchen. I have two tasks:

1. **Job₁:** "Put the plastic wrapping in the gelbesack"
2. **Job₂:** "Get a can of beans for my wife"

The gelbesack is in the corridor, right in front of the prepper room where the canned goods are stored.

A naive executor runs these as independent jobs: walk to corridor, deposit trash, return to kitchen, walk to corridor again, enter prepper room, fetch beans, return. Two round trips.

But that's not what happens. Instead, I carry the trash to the gelbesack, deposit it, continue into the prepper room, grab the beans, and return once. One trip.

How does this optimization arise?

---

## What Each Job Knows

Each job plans independently. Neither knows about the other. Each job's INFER mirror runs **R⁻ (radial-in / self-projection)** to imagine its own future trajectory:

```
Job₁ plans:
  Q′₁[0]: kitchen, holding trash
  Q′₁[1]: corridor, at gelbesack
  Q′₁[2]: deposit trash (done here)
  Q′₁[3]: return to kitchen

Job₂ plans:
  Q′₂[0]: kitchen, empty-handed
  Q′₂[1]: corridor, passing through
  Q′₂[2]: prepper room, locating beans
  Q′₂[3]: return to kitchen with beans
```

These are separate planning processes. They don't coordinate. They just each imagine their own path forward.

---

## The Shared Latent Space

Each job's R⁻ projection produces a sequence of **frames** — each Q′ₙ is a compressed latent representation of a predicted future state. A job with 4 planning steps produces 4 frames. Two jobs produce 8 frames. Ten jobs with varying depths might produce 50+ frames.

These frames exist as variables in vast memory, like textures resident in VRAM.

**The convergence problem is n-to-m.** Every frame from every job must be checked against every frame from every other job for structural equivalence under N⁺. That's O(n×m) pairwise comparisons, and each comparison is a high-dimensional frame-rotation equivalence check.

This is computationally prohibitive without parallelism. The GPU analogy isn't a metaphor — it's architectural: **N⁺ convergence detection is fundamentally SIMD or it doesn't happen.**

The runtime doesn't iterate through frames asking "do these match?" — it applies N⁺ as a shader pass across all resident frames simultaneously. Convergent regions produce correlated outputs; non-convergent regions don't. The structure of parallel execution *is* the detection mechanism.

---

## Invariant Map Caching

A single frame Q′ₙ may be compared against dozens of other frames as new R⁻ projections appear. Recomputing topological invariants for each comparison would be wasteful.

Instead, when R⁻ creates a frame, it immediately computes and caches the **topological invariant map** — the features that survive N⁺ frame rotation:

- **Spatial topology:** adjacency, reachability, containment
- **Resource state:** holding X, near Y, capacity remaining
- **Agent capability posture:** hands free, in motion, stationary
- **Not semantic purpose:** that's what N⁺ rotates away

This is the PSX trick. The original PlayStation couldn't afford per-particle lighting calculations, so it precomputed lookup tables (CLUTs, lighting ramps) at asset-load time. Per-frame cost collapsed to table indexing. The torch's particle cloud rendered in real-time because the expensive work happened once.

**For N⁺ convergence, the same principle applies:**

```
On R⁻ frame creation:
  1. Compute latent representation Q′ₙ
  2. Compute invariant map I(Q′ₙ) — the LUT
  3. Cache [Q′ₙ, I(Q′ₙ)] together

On new frame Q′ₘ appearance (triggers shader):
  1. Compute I(Q′ₘ) once
  2. Shader pass: compare I(Q′ₘ) against all cached I(Q′ₖ)
  3. No recomputation — parallel lookups only
```

**The LUT analogy extends further.** Just as PSX CLUTs let you recolor sprites without recomputing geometry, cached invariant maps let you run N⁺ with different rotation parameters without recomputing the underlying latent structure. 

You could ask:
- "Do these converge spatially?" (spatial invariants only)
- "Do these converge resource-wise?" (resource state invariants only)
- "Do these converge in agent posture?" (capability invariants only)

Each is a separate shader pass over the same cached invariants. The frame is computed once; the questions are cheap.

---

## Finding the Convergence

The runtime continuously applies **N⁺ (frame rotation)** across the world model, looking for structural equivalence between qualia states from different jobs.

N⁺ asks: "Ignoring *why* you're there, are these two states the same *place*?"

```
Q′₁[2] ≡_{N⁺} Q′₂[1]
```

Both describe "agent in corridor near prepper room." Job₁ is there to deposit trash. Job₂ is there in transit. The purposes differ, but the spatial-navigational frame sees equivalence.

Convergence detected.

---

## Exploiting the Convergence

Once convergence is found, **TAC (Tree Atomic Change)** atomically injects a dependency. It does *not* merge the jobs. It keeps the precepts separate but adds a scheduling constraint:

- Job₁ produces an artifact: `agent_at_corridor_near_prepper`
- TAC adds that artifact as a `RequiredInstrument` in Job₂'s staging phase
- Job₂ now waits for Job₁ to reach the corridor before proceeding

```xml
<!-- Job₁'s precept (unchanged) -->
<Precept name="depositTrashInGelbesack">
  <Artifact name="agent_at_corridor_near_prepper" type="statevector" />
</Precept>

<!-- Job₂'s precept (TAC-modified staging phase) -->
<Precept name="fetchCanOfBeans">
  <StagingPhase>
    <RequiredInstrument instrumentName="agent_at_corridor_near_prepper" />
  </StagingPhase>
  <H:Precept name="enterPrepperRoom" />
  <H:Precept name="locateBeans" />
  <H:Precept name="returnToKitchen" />
</Precept>
```

**Result:** Walk to corridor once, deposit trash, continue to prepper room, fetch beans, return. Two jobs, one optimized path.

---

## The Mechanism (Φ⁺ Composition)

Now we can name what we observed:

### 1. Independent R⁻ Per Job

Each job's INFER mirror runs R⁻ to project future-self states:

```
Job₁: R⁻(M, task₁) → projects Q′₁[0], Q′₁[1], ... into world model
Job₂: R⁻(M, task₂) → projects Q′₂[0], Q′₂[1], ... into world model
```

The jobs don't coordinate. They populate the shared world model with their predicted trajectories.

### 2. N⁺ Convergence Detection

The runtime continuously scans for structural equivalence:

```
N⁺ scan: ∀ (i,j) where i ≠ j:
  if Q′ᵢ[n] ≡_{N⁺} Q′ⱼ[m]:
    emit convergence_point(Jobᵢ, step_n, Jobⱼ, step_m)
```

This is not identity checking — it's equivalence under frame rotation.

### 3. TAC Dependency Injection

When convergence is detected, TAC atomically:
1. Identifies the artifact produced by Job₁ at the convergence point
2. Injects that artifact as a `RequiredInstrument` in Job₂'s staging phase
3. Keeps the precepts separate — only adds a dependency edge

---

## Relationship to IdleMapGuess

`IdleMapGuess` remains relevant but operates at a different layer:

| Mechanism | Purpose |
|-----------|---------|
| **R⁻** | Projects future qualia states per job |
| **N⁺** | Detects structural convergence across jobs |
| **TAC** | Atomically injects dependency edges |
| **IdleMapGuess** | Advises *when* to schedule within a job's timeline |

IdleMapGuess helps the scheduler decide *when* Job₂ should start relative to Job₁'s idle phases. N⁺/TAC decides *whether* a dependency should exist at all.

For example, if Job₁'s `IdleMapGuess` is `10,0,0,0,8` (busy startup, long idle, busy finish), and convergence is detected at step 2 (during idle), the scheduler knows Job₂ can begin its corridor approach without contending for attention resources.

---

## Formal Summary

```
Multi-Job Optimization := 
  1. Each job runs R⁻(M, taskₖ) independently → Q′ₖ trajectories
  2. All Q′ₖ populate the shared transient world model
  3. Runtime continuously applies N⁺ across world model
  4. On convergence: N⁺(Q′ᵢ[n], Q′ⱼ[m]) → equivalence detected
  5. TAC atomically injects: Artifact(Jobᵢ, n) → RequiredInstrument(Jobⱼ, staging)
  6. IdleMapGuess advises scheduling of the now-dependent jobs
```

The key insight: **R⁻ is not just single-task planning.** When multiple jobs project into a shared world model, their R⁻ trajectories form a planning manifold. N⁺ finds the intersection points. TAC exploits them.

---

## Why This Works

This mechanism succeeds because of three architectural choices:

1. **Global world model (Chapter 4):** All entities exist in a single semantic space. There are no isolated address spaces per job.

2. **N⁺ as frame rotation (Appendix 2):** Convergence detection is not equality checking — it's structural equivalence under interpretive rotation. This allows semantically different jobs to share navigational or resource states.

3. **TAC atomicity:** The dependency injection is indivisible. There's no race condition between detecting convergence and modifying the job trees.

