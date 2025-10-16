# Intent Scaffold Guidelines & Rules

## Purpose
This document defines the canonical rules and patterns for generating intent scaffolds and implementation examples in this workspace. It is designed for reuse whenever you request a new scaffold, implementation, or protocol.

**Updated**: October 16, 2025 - Enhanced with type-safe XML patterns and hardware-aligned terminology

---

## 1. Type-Safe Precept Structure
- Every actionable item is a type-safe precept: `<Precept name="GenerateProjectArchitectureDoc">`, `<Precept name="SearchWorkspaceForCodeFiles">`, etc.
- Direct XML element naming is deprecated in favor of explicit type safety: `<GenerateProjectArchitectureDoc>` → `<Precept name="GenerateProjectArchitectureDoc">`
- There is no distinction between root intents and subtasks; all are precepts and can be nested arbitrarily.
- Avoid generic tags like `<Subtask>` or `<Task>`.

## 2. Instrument Declaration (Hardware-Aligned)
- Instruments required by a precept are declared using `RequiredInstrument` (aligned with RALN architecture):
  ```xml
  <RequiredInstrument instrumentName="eggs" quantity="2-3" />
  <RequiredInstrument instrumentName="non_stick_pan" />
  ```
- Use React-style inline function syntax for instrument metadata when needed:
  ```xml
  <RequiredInstrument instrumentName={() => (
    <Meta>
      <Source>...</Source>
      <Context>...</Context>
      <Purpose>...</Purpose>
    </Meta>
  )} />
  ```
- The intent compiler is responsible for resolving instrument dependencies.

## 3. Context-Aware Capability Declaration for RESOLVE System
- **Purpose**: Capabilities enable automatic goal decomposition by declaring what a precept can handle in specific contexts
- **NOT data flow**: Unlike instruments, capabilities are not about passing data between precepts
- **Resolver optimization**: Context is a **required parameter** of each capability, enabling lightning-fast search space filtering
- Precepts declare capabilities with mandatory context references:
  ```xml
  <Precept name="FileSystemAnalyzer">
    <Provides>
      <Capability name="workspace_scanning" context="UnixOfficeEnvironment" />
      <Capability name="project_structure_analysis" context="SoftwareDevelopment" />
      <Capability name="file_metadata_extraction" context="UnixOfficeEnvironment" />
    </Provides>
  </Precept>
  ```
- **Context-married capabilities**: Every capability must specify its applicable context for precise resolver matching
- **Hierarchical filtering**: RESOLVE first filters by context compatibility, then by capability match
- **RALN compiler simplification**: Context + capability = deterministic network topology selection
- **Multiple capabilities**: One precept can handle several related types of sub-goals across different contexts

## 3.5. Instrument vs Capability Distinction
- **Instruments** (`RequiredInstrument`): Concrete resources needed for precept execution (data, tools, validated states)
- **Capabilities** (`Provides`): Abstract problem-solving abilities that help RESOLVE decompose complex goals and find suitable precepts to insert dynamically into the intent tree.
- **Separation of concerns**: Instruments handle "what do I need", capabilities handle "what can I do"
- **Resolver workflow**: RESOLVE uses capabilities to select precepts, then validates instrument availability before execution

## 4. Context as First-Class Repository Objects
- **Context Repository**: Agents maintain hierarchical repositories of context objects that precepts reference
- **Context definitions** are referenceable objects with inheritance:
  ```xml
  <Context name="MyOffice">
    <Description>The office where I work</Description>
    <References>
      <Context ref="GermanMidSizedTown" />
      <Context ref="EuropeanOfficeSpace" />
      <Context ref="EngineeringTeamCulture" />
    </References>
  </Context>
  ```
- **Salience-based memory**: Agents remember salient contexts (e.g., "MyOffice"), resolver expands context graphs automatically
- **Capability context marriage**: Context is a **required attribute** of every capability:
  ```xml
  <Provides>
    <Capability name="filesystem_scanning" context="UnixOfficeEnvironment" />
    <Capability name="project_analysis" context="SoftwareDevelopment" />
  </Provides>
  ```
- **Repository architecture**: Hierarchical context trees enable efficient indexing:
  ```
  ContextRepository/
    ├── Geographic/European/German/MidSizedTown/
    ├── Organizational/Office/Engineering/
    └── Technical/Unix/FileSystem/
  
  PreceptIndex: (capability_name, context_id) → precept_list
  ```
- **Resolver optimization**: Context filtering happens **first**, dramatically reducing search space before capability matching
- **RALN compilation**: Context + capability pairs enable deterministic MLP_CLUSTER and network topology selection

## 5. Enhanced Staging System
- Use `StagingPhase` with explicit type attributes for execution control:
  ```xml
  <StagingPhase type="preflight" name="quality_assurance">
    <!-- Automatic validation when precept is imported -->
    <ValidateInstrumentCondition instrument="eggs" conditionSet="freshness" domain="food_safety" />
  </StagingPhase>
  
  <StagingPhase type="execution" name="ingredient_preparation">
    <!-- Hot execution phase with state vector boundaries -->
    <Precept name="CrackEggs" quantity="2-3" into="bowl" />
    <Output>
      <Artifact name="ingredients_ready">
        <Type>instrument</Type>
        <Type>state_vector</Type>
        <Description>All ingredients prepared and ready for cooking</Description>
      </Artifact>
    </Output>
  </StagingPhase>
  ```
- Staging phases enable context switch resilience and RALN network modularity.
- Decision criteria for execution staging: "You don't need to remember fine-grained state across stage boundaries"

## 6. Logical Validation
- Use `ValidateInstrumentCondition` for systematic instrument validation:
  ```xml
  <ValidateInstrumentCondition instrument="cheese" conditionSet="mold_signs" domain="food_safety">
    <AcceptanceCriteria>
      <Condition state="acceptable" test="no_visible_mold" action="Proceed with cooking" />
      <Condition state="unacceptable" test="visible_mold_present" action="Discard and replace" />
    </AcceptanceCriteria>
    <Constraint type="safety">Never use moldy ingredients</Constraint>
  </ValidateInstrumentCondition>
  ```
- Lojban-Inspired Pattern: "Precept X enables agent to check instrument Y for fulfilling condition set Z under domain constraints W"

## 7. RESOLVE Mode and Goal Decomposition
- **RESOLVE mode** is the automatic precept selection system for complex goal decomposition
- **Core function**: When a precept is too complex for direct execution, RESOLVE queries the precept repository to find suitable sub-precepts
- **Capability-driven matching process**:
  1. **Analyze complex precept**: Extract goal requirements, constraints, and context
  2. **Query by capabilities**: Search precept repository using `<Provides><Capability>` declarations
  3. **Context filtering**: Use context reference graphs to find contextually compatible precepts
  4. **Sub-precept selection**: Choose appropriate precepts that can handle pieces of the complex goal
  5. **Dynamic nesting**: Automatically inject selected precepts as decomposed sub-goals
  6. **Dependency resolution**: Ensure instrument requirements are satisfied across the decomposed structure
- **Repository scale**: Designed to efficiently search billions of precepts using indexed capabilities and hierarchical context graphs
- **Context-aware selection**: Enables culturally, environmentally, and technically appropriate precept choices through context-married capabilities
- **Resolver optimization**: Every capability declaration **must** include context parameter for lightning-fast repository filtering:
  ```xml
  <Provides>
    <Capability name="filesystem_scanning" context="UnixOfficeEnvironment" />
    <Capability name="file_analysis" context="SoftwareDevelopment" />
  </Provides>
  ```
- **Multi-context capabilities**: A precept can declare that its capabilities apply across multiple contexts using set operations:
  ```xml
  <Provides>
    <Capability name="text_processing">
      <ContextSet>
        <Union>
          <Context ref="SoftwareDevelopment" />
          <Context ref="TechnicalWriting" />
          <Context ref="DocumentationWork" />
        </Union>
      </ContextSet>
    </Capability>
    <Capability name="file_validation">
      <ContextSet>
        <Intersect>
          <Context ref="OfficeEnvironment" />
          <Context ref="QualityAssurance" />
        </Intersect>
      </ContextSet>
    </Capability>
  </Provides>
  ```
- **RALN compilation efficiency**: Context + capability pairs enable deterministic MLP_CLUSTER selection and network topology optimization

## 8. Context Set Theory for Multi-Context Capabilities
- **Built-in multi-context capabilities**: Precepts declare which contexts their capabilities apply to using set theory operations
- **Core pattern** for context-aware capability declarations:
  ```xml
  <Precept name="UniversalFileProcessor">
    <Provides>
      <Capability name="file_scanning">
        <ContextSet>
          <Union>
            <Context ref="UnixEnvironment" />
            <Context ref="WindowsEnvironment" />
            <Context ref="MacOSEnvironment" />
          </Union>
        </ContextSet>
      </Capability>
      <Capability name="code_analysis">
        <ContextSet>
          <Intersect>
            <Context ref="SoftwareDevelopment" />
            <Context ref="OfficeEnvironment" />
          </Intersect>
        </ContextSet>
      </Capability>
      <Capability name="security_validation">
        <ContextSet>
          <Subtract>
            <Context ref="CorporateEnvironment" />
            <Context ref="PersonalProjects" />
          </Subtract>
        </ContextSet>
      </Capability>
    </Provides>
  </Precept>
  ```
- **Set operations enable precise capability scope**:
  - `Union` - Capability applies across multiple contexts (additive scope)
  - `Intersect` - Capability requires combination of contexts (restrictive scope)
  - `Subtract` - Capability applies except in certain contexts (exclusion scope)
  - `SymmetricDifference` - Capability applies in conflicting contexts (alternative scope)
- **Repository efficiency**: RESOLVE can precisely match precepts based on complex context requirements
- **Resolver integration**: Multi-context capabilities enable one precept to serve many situations through mathematical context composition
- **Optional extension**: `ExportFrom` with `ContextTransform` enables precept adaptation across environments for repository reuse

## 9. Behavioral Control & Semantic Elements
- Use `<Constraint>` nodes to specify execution requirements, behavioral limits, and domain restrictions.
- Use `<Description>` for human-readable explanations of each precept.
- Semantic elements that affect agent behavior include:
  - `Context` - Provides situational information for agent reasoning
  - `Source` - Indicates information source for credibility assessment
  - `Location` - Enables spatial reasoning and resource proximity decisions
  - `Purpose` - Guides goal alignment and optimization decisions

## 10. Enhanced Dependency Management
- Use `WaitForPrecept` with optional output specification:
  ```xml
  <!-- Single output precepts (output optional) -->
  <WaitForPrecept ref="HeatPan" />
  
  <!-- Multiple output precepts (output recommended) -->
  <WaitForPrecept ref="ObserveFloat" output="fresh" />
  
  <!-- Explicit documentation (output for clarity) -->
  <WaitForPrecept ref="WhiskEggs" output="well_combined" />
  ```

## 11. Output Declaration
- Use an `<Output>` node to specify the expected result, format, and audience of each precept/component.
- Outputs serve as state vector boundaries in execution staging.

## 12. Modularity & Composability
- All precepts are modular and indifferent to their position in the hierarchy.
- No precept should assume whether it is a root or a subtask.
- Dependencies and provisions are declared, not hardcoded.
- `AcceptanceCriteria` and `Condition` elements are fully composable across all contexts.
- Capability declarations enable automatic precept selection and goal decomposition.
- Context references enable precept adaptation across different environments.
- This composability and flexibility is the system's strength.

## 13. Context Switch Protocols
- Include a `<ContextSwitchProtocol>` node to specify how intent continuity is preserved across context switches.
- Use explicit steps and STOP codes for robustness.
- Leverage staging boundaries for resilient state preservation.

## 14. Example Pattern (Updated)
```xml
<IntentDOM root="MakeDish">
  <Precept name="MakeDish">
    <Description>Prepare a complete meal with quality assurance</Description>
    <Output format="cooked_dish" audience="cook">Ready-to-eat meal on plate</Output>
    
    <Provides>
      <Capability name="meal_preparation" />
      <Capability name="food_safety_validation" />
      <Capability name="cooking_techniques" />
    </Provides>
    
    <RequiredInstrument instrumentName="primary_ingredient" quantity="..." />
    <Constraint type="safety">Follow food safety protocols</Constraint>
    
    <!-- Preflight Staging: Automatic validation -->
    <StagingPhase type="preflight" name="quality_assurance">
      <ValidateInstrumentCondition instrument="primary_ingredient" conditionSet="freshness" domain="food_safety">
        <AcceptanceCriteria>
          <Condition state="fresh" test="passes_quality_check" action="Proceed with cooking" />
          <Condition state="spoiled" test="fails_quality_check" action="Discard and replace" />
        </AcceptanceCriteria>
      </ValidateInstrumentCondition>
      <Output>
        <Artifact name="ingredients_validated">
          <Type>instrument</Type>
          <Type>validation_data</Type>
          <Description>Ingredients verified for safety and quality</Description>
        </Artifact>
      </Output>
    </StagingPhase>
    
    <!-- Execution Staging: State vector boundaries -->
    <StagingPhase type="execution" name="preparation">
      <RequiredInstrument instrumentName="ingredients_validated" />
      <Precept name="PrepareIngredients">
        <Provides>
          <Capability name="ingredient_preparation" />
        </Provides>
      </Precept>
      <Output>
        <Artifact name="ingredients_ready">
          <Type>instrument</Type>
          <Type>state_vector</Type>
          <Description>All ingredients prepared and ready</Description>
        </Artifact>
      </Output>
    </StagingPhase>
    
    <StagingPhase type="execution" name="cooking">
      <RequiredInstrument instrumentName="ingredients_ready" />
      
      <SyncPoint name="ReadyToCook">
        <WaitForPrecept ref="PrepareIngredients" />
        <Action>Begin cooking process</Action>
      </SyncPoint>
      
      <Precept name="ExecuteCooking">
        <Provides>
          <Capability name="heat_application" />
          <Capability name="timing_control" />
        </Provides>
      </Precept>
      <Output>
        <Artifact name="dish_ready">
          <Type>instrument</Type>
          <Type>validation_data</Type>
          <Type>state_vector</Type>
          <Description>Completed dish ready to serve</Description>
        </Artifact>
      </Output>
    </StagingPhase>
    
    <ContextSwitchProtocol>
      <Step>Preserve staging phase completion status in volatile cache</Step>
      <Step>Store current stage output state vector (simplified)</Step>
      <Step>On resumption: validate stage outputs and continue from last completed stage</Step>
    </ContextSwitchProtocol>
  </Precept>
</IntentDOM>
```
```xml
<IntentScaffold date="YYYY-MM-DD">
  <Objective>...</Objective>
  <PreceptList>
    <Precept name="SomeActionName">
      <RequiredInstrument instrumentName={() => (
        <Meta>
          <Author>...</Author>
          <Topic>...</Topic>
        </Meta>
      )} />
      <Description>...</Description>
      <Constraint>...</Constraint>
      <Precept name="SomeProviderAction">
        <Provides>
          <Capability name="data_provision" />
        </Provides>
      </Precept>
      <Output type="..." format="..." audience="..." />
    </Precept>
    <!-- ...other precepts/components... -->
  </PreceptList>
  <ContextSwitchProtocol>
    <Step>...</Step>
  </ContextSwitchProtocol>
  <Notes>
    <Note>...</Note>
  </Notes>
  <STOPCodes>
    <Code id="STOP-1">...</Code>
  </STOPCodes>
  <NextActions>
    <Action>...</Action>
  </NextActions>
</IntentScaffold>
```

## 14. Precept Repository Architecture
- **Scale**: System designed to handle billions of precepts with efficient query capabilities
- **Indexing strategy**: Multi-dimensional indexing on capabilities, contexts, and instrument requirements
- **Query optimization**: Hierarchical context graphs enable fast filtering by domain, then detailed matching
- **Capability clustering**: Related capabilities are grouped for efficient traversal during goal decomposition
- **Context inheritance**: Context graphs leverage inheritance to avoid redundant storage and enable similarity matching
- **Repository distribution**: Large-scale precept repositories can be distributed across networks with local caching
- **Version management**: Precepts can evolve while maintaining compatibility through context adaptation
- **Semantic search**: Natural language queries can be translated to capability and context searches

## 15. General Rules
- Use clear, descriptive names for all precepts.
- Prefer explicitness and composability over brevity.
- Avoid runtime-specific tags (e.g., `<RuntimeMode>`).
- All scaffolds must be platform-independent and declarative.
- A precept must not care if it's a root or child element - infinite composability is key.
- Use type-safe patterns: `<Precept name="ActionName">` instead of direct `<ActionName>`.
- Align terminology with RALN hardware architecture (instruments, not resources).

---

## Reuse
Whenever you request a new implementation or scaffold, reference this document to ensure conformity to the enhanced type-safe vision.

**Migration Notes**:
- Legacy `<DirectElementName>` patterns should be updated to `<Precept name="DirectElementName">`
- `RequiredResource` should be updated to `RequiredInstrument`
- `resourceName` should be updated to `instrumentName`
- Legacy `provides="..."` attributes should be converted to `<Provides><Capability>` nodes
- Add capability declarations to enable RESOLVE mode goal decomposition
- Consider adding context references for environment-aware precept selection
- Consider adding staging phases for complex precepts
- Implement validation patterns using `ValidateInstrumentCondition` where appropriate
