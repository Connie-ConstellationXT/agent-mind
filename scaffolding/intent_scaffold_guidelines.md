# Intent Scaffold Guidelines & Rules

## Purpose
This document serves as the main index for intent scaffolding documentation. The system has been modularized into focused topic areas for better maintainability and clarity.

**Updated**: October 18, 2025 - Modularized into focused documentation modules

---

## Documentation Architecture

### **Core Modules**
- **[Fundamentals](./fundamentals.md)** - Type-safe precepts, instruments, basic execution model
- **[Dependency Resolution Architecture](./dependency_resolution_architecture.md)** - RequiredInstrument, preflight validation, RESOLVE mode integration, query priorities
- **[Capability System](./capability_system.md)** - Capability declarations, RESOLVE mode, R:Precept syntax, goal decomposition
- **[Staging and Execution](./staging_and_execution.md)** - Staging phases, sync points, temporal optimization, speculative execution
- **[Preflight Validation](./preflight_validation.md)** - Validation patterns, emergent instruments, dependency verification
- **[DISRUPT Handlers](./disrupt_handlers.md)** - D:Precept syntax, emergency preparedness, DISRUPT mode integration

### **Implementation Guides**
- **[Migration Guide](./migration_guide.md)** - Legacy pattern updates, breaking changes, best practices

### **Examples**
- **[Omelette Concise Example](./examples/omelette_concise.xml)** - Comprehensive example demonstrating all patterns
- **[Emergency Kit Validation](./examples/validate_emergency_kit.xml)** - Complex validation precept example
- **[Egg Freshness Test](./examples/test_egg_freshness.xml)** - Simple validation precept example
- **[Universal Seasoning](./examples/season_food.xml)** - Reusable precept example

---

## Quick Reference

### **Modern Syntax Patterns**

#### **Basic Precept Structure**
```xml
<Precept name="ActionName">
  <Description>What this precept does</Description>
  <RequiredInstrument instrumentName="dependency" />
  <Action>Do something</Action>
  <Output>
    <Artifact name="result" />
  </Output>
</Precept>
```

#### **Three Preflight Validation Patterns**
```xml
<!-- Simple -->
<RequiredInstrument instrumentName="ice_pack" preflight="true" />

<!-- R:Precept -->
<RequiredInstrument instrumentName="emergency_kit" preflight="R:ValidateEmergencyKit" />

<!-- Emergent -->
<PreflightValidation>
  <R:Precept name="ValidateEmergencyKit" />
  <RequiredInstrument instrumentName="emergency_kit" />
</PreflightValidation>
```

#### **DISRUPT Handlers**
```xml
<D:Precept name="HandleEmergency" providing="capability:emergency_response">
  <PreflightValidation>
    <R:Precept name="ValidateEquipment" />
    <RequiredInstrument instrumentName="emergency_ready" />
  </PreflightValidation>
  <!-- Emergency actions... -->
</D:Precept>
```

#### **R:Precept Resolution**
```xml
<R:Precept name="SeasonFood" 
           providing="capability:seasoning_application AND domain:food_preparation"
           food_item="cracked_eggs" 
           seasonings="salt_pepper" 
           description="Add salt and pepper to cracked eggs, seasoning to taste" />
```

---

## General Rules

### **Syntax Requirements**
- Use clear, descriptive names for all precepts
- Use type-safe patterns: `<Precept name="ActionName">` instead of direct `<ActionName>`
- Align terminology with RALN hardware architecture (instruments, not resources)
- All scaffolds must be platform-independent and declarative

### **Composability Rules**
- A precept must not care if it's a root or child element - infinite composability is key
- Dependencies and provisions are declared, not hardcoded
- Avoid runtime-specific tags (e.g., `<RuntimeMode>`)
- Prefer explicitness and composability over brevity

### **Modern Architectural Principles**
- **Most RESOLVE calls are preflight-related** (not runtime STALLs)
- **Speculative execution with dependency-driven activation** (not imperative control flow)
- **Document order execution** with depth-first traversal
- **Emergency preparedness via D:Precept handlers** (not inline exception handling)
- **Three-tier caching strategy** (runtime → DOM → repository)

---

## Legacy Pattern Migration

### **Required Updates**
```xml
<!-- Old → New -->
<RequiredResource resourceName="eggs" /> → <RequiredInstrument instrumentName="eggs" />
<DirectElementName /> → <Precept name="DirectElementName" />
providing="preflight" → preflight="true"
```

See **[Migration Guide](./migration_guide.md)** for comprehensive transition instructions.

---

## Reuse Guidelines

Whenever you request a new implementation or scaffold, reference the appropriate module documentation:

1. **Start with [Fundamentals](./fundamentals.md)** for basic syntax and concepts
2. **Check [Dependency Resolution](./dependency_resolution_architecture.md)** for instrument and validation patterns  
3. **Use [Capability System](./capability_system.md)** for RESOLVE mode and R:Precept syntax
4. **Apply [Staging and Execution](./staging_and_execution.md)** for complex workflows
5. **Add [Preflight Validation](./preflight_validation.md)** for robust dependency checking
6. **Include [DISRUPT Handlers](./disrupt_handlers.md)** for emergency preparedness
7. **Follow [Migration Guide](./migration_guide.md)** when updating legacy patterns

---

**Architecture Status**: The intent scaffolding system has evolved to prioritize preflight validation, speculative execution, and emergency preparedness. The modular documentation reflects this mature architecture while maintaining backward compatibility through migration guidance.

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

## 7.5. R:Precept Syntax for RESOLVE Mode Integration

The `R:Precept` syntax provides a declarative way to request cached precept resolution with parameterized binding. The `R:` prefix signals to the executive that this is a RESOLVE mode operation requiring dynamic precept insertion.

### **Core R:Precept Pattern**
```xml
<R:Precept name="PreceptName" 
           providing="capability_filter_expression"
           parameter_name="parameter_value"
           description="Human-readable description of intent">
  <!-- Optional: Override outputs or add local behavior -->
</R:Precept>
```

### **Key Attributes**

#### **Required Attributes**
- **`name`**: Exact name of the precept to resolve from the repository
- **`providing`**: Boolean filter expression for capability matching using AND/OR logic
- **`description`**: Human-readable explanation of what this precept does in context

#### **Parameter Binding**
Any additional attributes become parameter bindings for the resolved precept:
```xml
<R:Precept name="SeasonFood" 
           food_item="cracked_eggs" 
           seasonings="salt_pepper" 
           quantity="to_taste" />
```

### **Providing Filter Expressions**
Use boolean logic to precisely match precept capabilities:
```xml
<!-- Single capability -->
providing="capability:egg_validation"

<!-- Domain + capability -->
providing="domain:food_safety AND capability:egg_validation"

<!-- Multiple options -->
providing="(capability:butter_validation OR capability:dairy_validation) AND domain:food_safety"

<!-- Complex filtering -->
providing="domain:kitchen AND (capability:seasoning_application OR capability:flavor_enhancement)"
```

### **Complete Examples**

#### **Basic Validation**
```xml
<R:Precept name="TestEggFreshness" 
           providing="domain:food_safety AND capability:egg_validation" 
           instrument="chosen_eggs"
           description="Perform canonical water float test to verify egg quality" />
```

#### **Parameterized Food Processing**
```xml
<R:Precept name="SeasonFood" 
           providing="capability:seasoning_application AND domain:food_preparation"
           food_item="cracked_eggs" 
           seasonings="salt_pepper" 
           quantity="to_taste"
           description="Add salt and pepper to cracked eggs, seasoning to taste" />
```

#### **Equipment Validation**
```xml
<R:Precept name="VerifyPanCondition" 
           providing="domain:kitchen AND capability:pan_validation" 
           instrument="chosen_pan"
           description="Check pan for cleanliness and non-stick coating integrity" />
```

### **Human-Readability Principle**
The `description` attribute ensures R:Precept placeholders are **self-documenting**. A human reader should be able to understand the intent without examining the implementation precept:

```xml
<!-- Good: Clear intent -->
<R:Precept name="ChopVegetables" 
           providing="capability:knife_work AND domain:food_prep"
           vegetables="carrots_celery_onions"
           cut_size="medium_dice"
           description="Dice carrots, celery, and onions into uniform medium cubes for mirepoix" />

<!-- Bad: Requires implementation knowledge -->
<R:Precept name="ChopVegetables" vegetables="carrots_celery_onions" />
```

### **RESOLVE System Benefits**
- **Caching**: Precepts are cached for fast lookup and reuse
- **Parameterization**: Same logic works with different inputs across recipes
- **Modularity**: Universal precepts (seasoning, chopping, validation) separate from specific recipes
- **Scalability**: Repository can efficiently index and match precepts by capabilities and domains
- **Reusability**: Any recipe can resolve common food preparation patterns

### **Implementation Guidelines**
1. **Extract Universal Patterns**: Any frequently-used action should become a separate precept
2. **Use Descriptive Parameters**: Parameter names should be self-explanatory
3. **Provide Human Context**: Always include meaningful descriptions
4. **Filter Precisely**: Use specific capability/domain combinations for exact matching
5. **Design for Reuse**: Think beyond the current recipe - how would other recipes use this?
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
- Legacy `provides="..."` attributes should be updated to `providing="..."` for capability queries
- Add explicit `<Provides><Capability name="..." /></Provides>` blocks for capability declarations
- Use `providing="..."` in `RequiredInstrument` to query for precepts with specific capabilities
- Add capability declarations to enable RESOLVE mode goal decomposition
- Consider adding context references for environment-aware precept selection
- Consider adding staging phases for complex precepts
- Implement validation patterns using `ValidateInstrumentCondition` where appropriate
