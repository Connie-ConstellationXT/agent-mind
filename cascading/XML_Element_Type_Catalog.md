# XML Element Type Catalog for Intent Cascading System

*Generated: October 16, 2025*
# XML Element Type Catalog for Intent Cascading System

---

*Purpose: Comprehensive catalog of all XML element types found across the intent cascading documentation for type-safety refactoring analysis*

## 1. STRUCTURAL/CONTAINER TYPES

### IntentCascade
**Purpose**: Root container for complete intent definitions with metadata
**Attributes**: `date`
**Children**: Objective, PreceptList, ContextSwitchProtocol, Notes, STOPCodes, NextActions
**Example Context**: Task management cascades, project planning

### IntentDOM  
**Purpose**: Root container for domain-specific intent trees
**Attributes**: `root` (specifies root precept name)
**Children**: Domain-specific precepts, D:Precepts, Vigils
**Example Context**: Cooking workflows, specific task domains

### YieldSafePoint
**Purpose**: Explicit declaration of safe interruption points within precept execution
**Attributes**: `name` (checkpoint identifier)
**Children**: StateVector, WaitCondition, ResumeCondition
**Example Context**: Long-running operations with expected idle time, context switch points

### StateVector
**Purpose**: Captures minimal state information needed to safely resume execution
**Attributes**: None
**Children**: Multiple State elements
**Example Context**: Context switching, resumption after interruption

### State
**Purpose**: Individual state variable capture for resumption
**Attributes**: `key` (variable name), `value` (current value)
**Children**: None (self-closing)
**Example Context**: Temporal context, physical state, progress markers

### WaitCondition
**Purpose**: Describes expected waiting period during yield-safe point
**Attributes**: `duration` (expected time), `reason` (explanation)
**Children**: None (self-closing)
**Example Context**: Pan heating, dough rising, compilation

### ResumeCondition
**Purpose**: Specifies conditions that indicate readiness to resume execution
**Attributes**: None
**Children**: Check elements
**Example Context**: Temperature targets, completion signals

### Vigil
**Purpose**: Background monitoring tasks that execute when attention is available
**Attributes**: `name` (task identifier), `frequency` (scheduling), `during` (yield-safe point binding)
**Children**: Description, Action, Condition
**Example Context**: Periodic checking, optional monitoring, background maintenance

### Check
**Purpose**: Condition evaluation for resume readiness
**Attributes**: `state` (variable to check), `target` (expected value)
**Children**: None (self-closing)
**Example Context**: Temperature checks, completion verification

### MLPTrigger
**Purpose**: Hardware neural wiring declaration that connects specific output neurons from trained MLPs directly to the power latch of precepts/vigils. When the neuron fires above threshold, it instantly activates the circuit - pure hardware event-driven activation with zero software polling overhead.
**Attributes**: `model` (trained MLP model identifier), `symbol` (specific output neuron name), `confidence_threshold` (float 0-1 for power latch activation threshold)
**Children**: None (self-closing)
**Example Context**: Wire "egg_cracking_detected" neuron to cleanup daemon, "system_degradation_pattern" neuron to emergency handler, "cascading_test_failures" neuron to build failure response.

**Emergent Pattern Discovery**: MLP models continuously observe all system signals (internal state, external sensors, qualia patterns, physical manifestations). Over time, they learn to recognize patterns like "every time agent cracks an egg" or "system about to crash". MLPTrigger enables pure emergent coordination - precepts can respond to learned patterns without explicit dependencies or coordination overhead.

### PreceptList
**Purpose**: Container for multiple precepts within an intent cascade
**Attributes**: None
**Children**: Multiple precept elements
**Example Context**: Task organization, grouping related actions

### StagingPhase
**Purpose**: Container for preflight validation or execution segmentation phases
**Attributes**: `type` (preflight|execution), `name` (stage identifier)
**Children**: Precepts, validation elements, Output declarations
**Example Context**: Preflight assertions, execution checkpoints, state vector boundaries

**Two Staging Subtypes**:

1. **`type="preflight"`**: Readiness validation before execution begins
   - Automatically triggered when precept is imported/referenced
   - Quality assurance, instrument validation, precondition checking
   - Aligns with existing preflight assertion system from Intent Cascading Key Concepts
   - Can reference external manifest capabilities
   - Stateless pass/fail gates

2. **`type="execution"`**: Hot execution segmentation at natural breakpoints
   - Segments execution where complex state vectors can be simplified across boundaries
   - Decision criteria: "You don't need to remember fine-grained state across stage boundaries"
   - Enables context switch resilience and RALN network modularity
   - Each stage compiles to self-contained RALN subnet with clean interfaces

**Example Usage**:
```xml
<StagingPhase type="preflight" name="ingredient_validation">
  <TestEggFreshness />
  <ValidateInstrumentCondition instrument="pan" conditionSet="clean_non_stick_intact" />
  <Output>
    <Artifact name="ingredients_validated">
      <Type>instrument</Type>
      <Type>validation_data</Type>
      <Description>Validated fresh ingredients ready for use</Description>
    </Artifact>
  </Output>
</StagingPhase>

<StagingPhase type="execution" name="base_cooking">
  <RequiredInstrument instrumentName="ingredients_validated" />
  <HeatPan />
  <AddButter />
  <CookBase />
  <Output>
    <Artifact name="base_ready">
      <Type>instrument</Type>
      <Type>state_vector</Type>
      <Description>Eggs properly set and ready for next stage</Description>
    </Artifact>
  </Output>
</StagingPhase>

<StagingPhase type="execution" name="finishing">
  <RequiredInstrument instrumentName="base_ready" />
  <AddCheese />
  <FoldAndFinish />
</StagingPhase>
```

### ContextSwitchProtocol
**Purpose**: Container for context switching procedures and robustness protocols
**Attributes**: None
**Children**: Step elements
**Example Context**: Task interruption handling, state preservation

### Notes
**Purpose**: Container for metadata notes and documentation
**Attributes**: None
**Children**: Note elements
**Example Context**: Documentation, cross-references

### STOPCodes
**Purpose**: Container for error/completion codes
**Attributes**: None
**Children**: Code elements with id attributes
**Example Context**: Error handling, completion signaling

### NextActions
**Purpose**: Container for follow-up actions after cascade completion
**Attributes**: None
**Children**: Action elements
**Example Context**: Task continuation, next steps

### RecipeTimeline
**Purpose**: Container for time-sequenced cooking instructions
**Attributes**: None
**Children**: Step, SyncPoint elements
**Example Context**: Recipe coordination, temporal workflows

## 2. PRECEPT TYPES

### Precept
**Purpose**: Named actionable component representing concrete actions, operations, or behaviors
**Attributes**: Implicit `name` (from XML element name), plus domain-specific attributes
**Children**: Can contain any infrastructure elements (RequiredResource, Description, Constraint, Output) plus sub-precepts
**Example Context**: All actionable items in intent cascading

**Examples of Precept Names Found in Documentation**:
- `GenerateProjectArchitectureDoc`
- `SearchWorkspaceForCodeFiles`
- `MakeOmelette`
- `PrepareIngredients`
- `CookOmelette` 
- `HeatPan`
- `AddButter`
- `CrackEggs`
- `SeasonEggs`
- `WhiskEggs`
- `TestEggFreshness`
- `ValidateOtherIngredients`
- `CheckCheese`
- `FillBowl`
- `SubmergeEgg`
- `ObserveFloat`
- `PreheatOven`
- `SeasonChicken`
- `PrepareVegetables`
- `RoastChickenAndVegetables`
- `CheckDoneness`
- `RestChicken`
- `Serve`
- *[Plus many others - these are instance names, not distinct types]*

**Note**: Per established guidelines, "Every actionable item is a named XML node (precept/component)". These are all instances of the single `Precept` type, distinguished by their `name` attribute (derived from XML element name).

## 3. INSTRUMENT/DEPENDENCY TYPES

### RequiredInstrument
**Purpose**: Declares global pattern descriptors that reference shared world model memory (kernel space). Not function parameters, but reactive triggers based on pattern availability in global cognitive/perceptual space.
**Architecture**: Precepts activate when matching patterns become available in global memory, following three-tier pattern recognition hierarchy.
**Attributes**: `instrumentName` (pattern descriptor), plus constraint attributes (`quantity`, `type`, `temperature`, etc.)
**Children**: Optional constraint child elements for complex pattern matching
**Identity Binding**: Connected to provider outputs via `allocateOutput` which asserts continuous ontological identity through transformation
**Example Context**: Pattern dependency declaration, reactive precept activation, world model pattern matching

### Output
**Purpose**: Declares expected patterns to be created in global world model and their characteristics
**Attributes**: `type`, `format`, `audience`
**Children**: Text content describing output pattern
**Identity Continuity**: Bound to downstream RequiredInstruments via `allocateOutput` assertions that maintain ontological continuity
**Example Context**: Pattern creation specification, continuous identity preservation

## 4. CONTROL FLOW TYPES

### SyncPoint
**Purpose**: Synchronization coordination point for multiple precepts
**Attributes**: `name`
**Children**: WaitForPrecept, Limiter, Action
**Example Context**: Coordination, dependency management

### WaitForPrecept
**Purpose**: Dependency waiting for specific precept completion or specific output state
**Attributes**: `ref` (precept reference), `output` (optional - specific output to wait for)
**Children**: None
**Example Context**: Synchronization, ordering, conditional dependencies

**Output Attribute Usage**:
- **Optional when precept has single output**: `<WaitForPrecept ref="AddButter" />` (waits for completion)
- **Required when precept has multiple outputs**: `<WaitForPrecept ref="ObserveFloat" output="fresh" />` (waits for specific state)
- **Optional for clarity/documentation**: `<WaitForPrecept ref="WhiskEggs" output="well_combined" />` (explicit about what we're waiting for)

**Examples**:
```xml
<!-- Single output precepts (output attribute optional) -->
<WaitForPrecept ref="HeatPan" />
<WaitForPrecept ref="AddButter" />

<!-- Multiple output precepts (output attribute recommended) -->
<WaitForPrecept ref="ValidateInstrumentCondition" output="acceptable" />
<WaitForPrecept ref="ObserveFloat" output="fresh" />

<!-- Explicit documentation (output attribute for clarity) -->
<WaitForPrecept ref="WhiskEggs" output="well_combined" />
```

### WaitForSignal
**Purpose**: Signal waiting for specific conditions
**Attributes**: `signal` (signal name)
**Children**: None
**Example Context**: Event-driven coordination

### IdleWait
**Purpose**: Timed waiting for specified duration
**Attributes**: `duration`, `reason`
**Children**: None
**Example Context**: Timing control, delays

### StartWorkerThread
**Purpose**: Parallel execution initiation
**Attributes**: None
**Children**: None
**Example Context**: Concurrency, parallel processing

### Limiter
**Purpose**: Constraint enforcement with timeouts
**Attributes**: `type`, `value`, `after`
**Children**: None
**Example Context**: Safety limits, timeout control

### Step
**Purpose**: Individual step in temporal sequence
**Attributes**: `time`, `label`
**Children**: Action, control flow elements
**Example Context**: Timeline coordination, sequencing

## 5. BEHAVIORAL CONTROL TYPES

### Constraint
**Purpose**: Requirements and limitations that affect precept execution behavior
**Attributes**: `type` (optional for categorization)
**Children**: Text content
**Example Context**: Execution constraints, behavioral limits, safety requirements, domain restrictions

### AcceptanceCriteria
**Purpose**: Container for validation conditions and decision logic that controls execution flow
**Attributes**: None
**Children**: Condition elements with parameterized logic
**Example Context**: Quality gates, decision points, execution branching, conditional behavior control

### Condition
**Purpose**: Generic condition evaluation that determines agent behavior and execution paths
**Attributes**: `state` (condition outcome), `test` (what to evaluate), `action` (response instruction)
**Children**: Text content or sub-conditions
**Example Context**: Decision logic, behavioral branching, execution control, conditional actions

**Note**: These elements directly influence agent behavior, execution flow, and decision-making processes.

### Context
**Purpose**: Provide situational information
**Attributes**: None
**Children**: Structured context elements
**Example Context**: Situational metadata

### Source
**Purpose**: Indicate information source
**Attributes**: None
**Children**: Text content
**Example Context**: Attribution, verification

### Location
**Purpose**: Specify physical or logical location 
**Attributes**: None
**Children**: Text content
**Example Context**: Resource location, context

### Purpose
**Purpose**: Explain intent or goal 
**Attributes**: None
**Children**: Text content
**Example Context**: Goal clarification, context

### Meta
**Purpose**: Metadata containers with structured information (documentation only)
**Attributes**: None
**Children**: Author, Topic, Context, Source, Location, Purpose, etc.
**Example Context**: Resource metadata, context information, human reference


## 6. DOCUMENTATION/METADATA TYPES

### Description
**Purpose**: Human-readable explanations of precepts (documentation only)
**Attributes**: None
**Children**: Text content
**Example Context**: Documentation, understanding, human reference

### Action
**Purpose**: Explicit action descriptions for human understanding
**Attributes**: None
**Children**: Text content or precept references
**Example Context**: Step description, explicit instructions, documentation

### Note
**Purpose**: Individual notes and cross-references (documentation only)
**Attributes**: None
**Children**: Text content with markup
**Example Context**: Documentation, references, human annotations

### Code
**Purpose**: Error/stop codes with descriptions (may affect execution through error handling)
**Attributes**: `id`
**Children**: Text description
**Example Context**: Error handling, state signaling, execution control

### Author
**Purpose**: Specify content creator (metadata only)
**Attributes**: None
**Children**: Text content
**Example Context**: Attribution, metadata

### Topic
**Purpose**: Specify subject matter (metadata only)
**Attributes**: None
**Children**: Text content
**Example Context**: Categorization, metadata


## 7. INSTRUMENT VALIDATION TYPES
**Children**: Text content
**Example Context**: Resource location, context

### Purpose
**Purpose**: Explain intent or goal
**Attributes**: None
**Children**: Text content
**Example Context**: Goal clarification, context

## 7. INSTRUMENT VALIDATION TYPES

### ValidateInstrumentCondition
**Purpose**: Generic precept that enables the agent to check instrument for fulfilling condition set under domain constraints
**Attributes**: `instrument` (what to validate), `conditionSet` (what to check for), `domain` (contextual constraints)
**Children**: AcceptanceCriteria, Constraint (domain-specific)
**Example Context**: Quality assurance, instrument readiness verification

**Lojban Logic Pattern**: 
*Precept X is a precept that enables the agent to check instrument Y for fulfilling condition set Z under domain constraints W*

**XML/DOM Expression**:
```xml
<ValidateInstrumentCondition instrument="cheese" conditionSet="mold_signs" domain="food_safety">
  <AcceptanceCriteria>
    <Condition state="acceptable" test="no_visible_mold" action="Proceed with cooking" />
    <Condition state="questionable" test="slight_discoloration" action="Inspect more closely" />
    <Condition state="unacceptable" test="visible_mold_present" action="Discard and replace" />
  </AcceptanceCriteria>
  <Constraint type="safety">Never use moldy ingredients</Constraint>
</ValidateInstrumentCondition>

<ValidateInstrumentCondition instrument="butter" conditionSet="rancidity" domain="flavor_quality">
  <AcceptanceCriteria>
    <Condition state="fresh" test="sweet_smell" action="Use for cooking" />
    <Condition state="degraded" test="off_odor" action="Replace with fresh butter" />
  </AcceptanceCriteria>
</ValidateInstrumentCondition>

<ValidateInstrumentCondition instrument="pan" conditionSet="clean_non_stick_intact" domain="cooking_equipment">
  <AcceptanceCriteria>
    <Condition state="ready" test="clean_surface_intact_coating" action="Proceed with cooking" />
    <Condition state="damaged" test="scratched_coating" action="Use different pan" />
  </AcceptanceCriteria>
</ValidateInstrumentCondition>
```

**Benefits**: 
- Hardware-aligned terminology (instruments vs resources)
- Unified validation pattern across all domains
- Lojban-inspired logical structure for clear semantic relationships
- Extensible to any instrument/condition combination

## 8. SPECIAL PURPOSE TYPES

### Objective
**Purpose**: High-level goal statement for intent cascade
**Attributes**: None
**Children**: Text content
**Example Context**: Goal setting, scope definition

---

## ANALYSIS SUMMARY

**Total Actual Element Types**: ~25 (down from 87 after recognizing precept naming patterns)
**Major Categories**: 8 (updated with enhanced staging)
**Infrastructure Elements**: ~20
**Precept Type**: 1 (with many named instances)

This corrected catalog reveals that most of what appeared to be distinct element types are actually named instances of the single `Precept` type. The true type system is much simpler than initially cataloged, focused on infrastructure elements that support the precept-based structure.

**Key Integration Points**:
- **StagingPhase** now unifies with existing preflight assertion system from Intent Cascading Key Concepts
- **Preflight staging** enables automatic validation when precepts are imported/referenced
- **Execution staging** provides natural breakpoints for RALN network compilation and context switch resilience
- **State vector boundaries** align with the principle: "You don't need to remember fine-grained state across stage boundaries"