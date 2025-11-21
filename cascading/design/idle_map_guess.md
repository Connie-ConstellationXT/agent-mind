## IdleMapGuess (Interruptibility / Lifecycle Mask)

### Purpose
- `IdleMapGuess` is an *interruptibility* lifecycle mask placed inline with a `Precept` declaration that provides a compact, low-cost heuristics about where the precept is busy (non-interruptible) and where it is idle (preemptive/interruptible) across its expected execution timeline.

This attribute is not semantic; it's a scheduling and execution guidance tool the runtime uses for attention scheduling, yield decisions, subdivision heuristics, and fast-path routing without instantiating the precept's full logic.

### High-Level Interpretation
- The `IdleMapGuess` vector encodes the relative interruptibility across sequential slices of a precept's execution timeline. The number of elements approximates resolution; each element represents a sub-interval.
- Each element's numeric value encodes a *busy intensity* for that sub-interval, with `0` meaning "idle / yield now" (contrary to many heuristics), and non-zero values indicating degrees of busy (1..N). Larger values denote stronger busy or non-interruptible blocks.

### Syntax
```xml
<Precept name="boilWaterForPasta" IdleMapGuess="10,0,0,0,V,8" />
<Precept name="driveCar" IdleMapGuess="9" />
```

#### Conventions
- **Vector length**: The number of elements maps to the sampling resolution. More elements = finer-grained lifecycle profiling.
- **Element semantics**: Integer in range `0..N` with `0` == idle (yield preferred), `>0` == busy intensity.
-- **Single scalar**: When the attribute is a single integer (e.g., `9`), treat it as a shorthand for a single busy block across the runtime of the precept; it is effectively a coarse profile.
-- **`V` (Vigil)**: The token `V` identifies a *vigil* or background monitoring phase in the precept timeline (not a variable). It indicates a background monitoring presence — low CPU but continuous engagement — that the planner should account for when scheduling interactive tasks.

### Planner Behavior (scheduling / preflight)
1. **Scheduling Heuristic (Planner)**: `IdleMapGuess` is primarily a planning-time heuristic for the scheduler and compiler. It helps place a precept’s start time, order tasks with similar deadlines, and estimate whether a task can run as a background job or should be subdivided.
2. **Start-time placement**: When multiple tasks share deadlines, the planner favors starting tasks with long idle phases early (e.g., starting the dishwasher) so their idle windows don't overlap with interactive tasks (e.g., vacuuming) which require immediate attention.
3. **Yield suggestion & division**: `0` indicates where the planner can safely schedule other work. The planner suggests `YieldSafePoint`s at these indices, and can recommend splitting the task into multiple precepts at boundaries where many zeros separate busy blocks.
4. **Vigil (`V`) semantics**: `V` indicates the sub-interval is a background monitoring phase. The planner treats `V` slots as continuous low-priority monitors; it should not block interactive tasks but still require resource availability.
5. **Runtime Hinting**: The runtime can choose to consult `IdleMapGuess` as a scheduling hint, but the cooperative multitasker is not controlled by this attribute alone: `IdleMapGuess` is advisory for planning, not an authoritative runtime mechanism.

### Compiler & Tooling Guidance
- **Validation**: A sanity check warns if there are no `0`s in a long precept; such precepts may be long non-interruptible and should be reviewed.
- **Automatic Subdivision**: If `fraction_zero > THRESHOLD` (e.g., 60%), mark precept as a candidate for auto-subdivision with default yield-safe checkpoints at `0` indices.
- **Optimization**: `IdleMapGuess` should be annotated in `Precept` metadata for the scheduler to use without parsing full XML.

### Examples
- `boilWaterForPasta`: The sequence typically has initial heating busy, long idle (waiting for boil), finishing busy. Example: `10,0,0,0,8`.
- `driveCar`: Continuous driving where interruptions are costly: `9` (single-block busy).
- Voyager Launch Monitoring (example from user): long timeline with sparse busy blocks should be considered for subdivision. `10,8,0,0,0,10,0,...` indicates frequent idle windows where the task could yield or be split. The planner would likely recommend splitting into multiple monitoring precepts for each busy window and schedule them to avoid conflicts with interactive, high-attention tasks.

**Practical planner example (Dishwasher vs Vacuum)**:
*Two tasks*:
 - `startDishwasher` IdleMap: `10,0,0,0,0` (busy startup then long idle)
 - `vacuumCarpet` IdleMap: `9` (continuous busy)

If both must finish by `t+1h`, the planner will schedule `startDishwasher` first, so its idle blocks allow `vacuumCarpet` to run in the high-interactivity window. This reduces contention for the user's attention and interactive resources.

### Heuristic Rules
- **0 -> Yield**: A `0` indicates nothing to do and is an explicit yield hint to the executive.
- **Long non-zero blocks**: Suggest encapsulation into a `H:Precept` or incorporate `YieldSafePoint` only at natural boundaries.
- **Subdividing**: If many zero blocks exist across timeline, split into multiple precepts each capturing contiguous busy sections with idle boundaries.

## Edge Cases
- **Unknown duration**: When precept duration cannot be statically predicted, `IdleMapGuess`'s sampling is interpreted distributionally; the executive uses observed runtime to adapt.
- **Dynamic decomposition**: Some precepts are programmatically decomposable; the compiler may flag them and create sub-precepts using `IdleMapGuess` boundaries.

## Notes to Designers
- `IdleMapGuess` is a soft advisory attribute and must be validated by runtime observability. The executive learns to refine guesses from telemetry; the compile-time `IdleMapGuess` sets a starting heuristic.
- Prefer clarity: vector length should be consistent with intent's semantic time resolution. Use sparingly—prefer design-level `YieldSafePoint`s for critical pause points.

---

