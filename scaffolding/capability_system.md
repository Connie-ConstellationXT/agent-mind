# Capability System and RESOLVE Mode

**Advanced Features**: Capability declarations, RESOLVE mode, R:Precept syntax, and goal decomposition

---

## Overview

The capability system enables automatic goal decomposition by declaring what precepts can handle in specific contexts. Combined with RESOLVE mode, this allows the executive to find and instantiate appropriate precepts dynamically.

**Note:** Most RESOLVE calls now happen during preflight validation, not runtime STALLs. See `dependency_resolution_architecture.md` for the complete resolution strategy.

---

## Capability Declaration

### **Basic Capability Declaration**
```xml
<Precept name="FileSystemAnalyzer">
  <Provides>
    <Capability name="workspace_scanning" domain="UnixOfficeEnvironment" />
    <Capability name="project_structure_analysis" domain="SoftwareDevelopment" />
    <Capability name="file_metadata_extraction" domain="UnixOfficeEnvironment" />
  </Provides>
</Precept>
```

### **Key Principles**
- **Domain-married capabilities**: Every capability must specify its applicable domain
- **Domain universality**: Domain encompasses applicability scope, subject areas, constraint sets, organizational contexts, and any other relevant boundary - the system does not distinguish between these conceptual categories
- **NOT data flow**: Unlike instruments, capabilities are not about passing data between precepts
- **Resolver optimization**: Domain enables lightning-fast search space filtering
- **Multiple capabilities**: One precept can handle several related sub-goals across different domains
- **Optimization-level agnostic**: Precepts declare capabilities without optimization level awareness - executive manages complexity selection

### **Instrument vs Capability Distinction**
- **Instruments** (`RequiredInstrument`): Concrete resources needed for precept execution - physical objects, knowledge, other agents, validated states, and abstract resources are all treated uniformly
- **Capabilities** (`Provides`): Abstract problem-solving abilities that help RESOLVE decompose complex goals
- **Optimization Levels**: Executive strategy for precept selection complexity, never declared in precepts themselves
- **Separation of concerns**: Instruments handle "what do I need", capabilities handle "what can I do", executive handles "how sophisticated should this be"
- **Universal abstraction**: Both instruments and domains operate above ontological categories - the system treats all dependencies and boundaries uniformly

## Multi-Domain Capabilities

### **XML Syntax Flexibility**
XML provides multiple equivalent ways to express domain specifications. All of these are semantically identical:

```xml
<!-- Attribute syntax -->
<Capability name="file_scanning" domain="UnixEnvironment" />

<!-- Child element syntax -->
<Capability name="file_scanning">
  <Domain>UnixEnvironment</Domain>
</Capability>

<!-- Self-closing element -->
<Capability name="file_scanning">
  <Domain>UnixEnvironment</Domain>
</Capability>
```

Choose the syntax that best fits your document structure and readability preferences.

### **Domain Conceptual Universality**
Just as `RequiredInstrument` treats knowledge, physical tools, and other agents uniformly as dependencies, `Domain` treats all boundary concepts uniformly:

- **Subject areas**: `food_safety`, `software_development`, `mathematics`
- **Applicability scopes**: `kitchen_environment`, `office_setting`, `emergency_response`
- **Organizational contexts**: `engineering_team`, `corporate_environment`, `family_household`
- **Constraint sets**: `real_time_systems`, `privacy_sensitive`, `safety_critical`
- **Cultural contexts**: `european_workplace`, `academic_research`, `startup_culture`

The system does not distinguish between these conceptual categories - they are all just domains that can be referenced, composed, and filtered upon.

### **Set Theory Operations**
```xml
<Precept name="UniversalFileProcessor">
  <Provides>
    <Capability name="file_scanning">
      <DomainSet>
        <Union>
          <Domain ref="UnixEnvironment" />
          <Domain ref="WindowsEnvironment" />
          <Domain ref="MacOSEnvironment" />
        </Union>
      </DomainSet>
    </Capability>
    
    <Capability name="code_analysis">
      <DomainSet>
        <Intersect>
          <Domain ref="SoftwareDevelopment" />
          <Domain ref="OfficeEnvironment" />
        </Intersect>
      </DomainSet>
    </Capability>
    
    <Capability name="security_validation">
      <DomainSet>
        <Subtract>
          <Domain ref="CorporateEnvironment" />
          <Domain ref="PersonalProjects" />
        </Subtract>
      </DomainSet>
    </Capability>
  </Provides>
</Precept>
```

### **Set Operations**
- `Union` - Capability applies across multiple domains (additive scope)
- `Intersect` - Capability requires combination of domains (restrictive scope)  
- `Subtract` - Capability applies except in certain domains (exclusion scope)
- `SymmetricDifference` - Capability applies in conflicting domains (alternative scope)

## R:Precept Syntax

### **Core R:Precept Pattern**
```xml
<R:Precept name="PreceptName" 
           providing="capability_filter_expression"
           parameter_name="parameter_value"
           description="Human-readable description of intent">
  <!-- Optional: Override outputs or add local behavior -->
</R:Precept>
```

### **Required Attributes**
- **`name`**: Exact name of the precept to resolve from the repository
- **`providing`**: Boolean filter expression for capability matching using AND/OR logic
- **`description`**: Human-readable explanation of what this precept does in context

### **Parameter Binding**
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

**Note**: Domain filters in `providing` expressions match against the domain specifications declared in `<Provides>` capability declarations. The RALN compilation system uses these domain relationships for network topology optimization.

## Complete R:Precept Examples

### **Basic Validation**
```xml
<R:Precept name="TestEggFreshness" 
           providing="domain:food_safety AND capability:egg_validation" 
           instrument="chosen_eggs"
           description="Perform canonical water float test to verify egg quality" />
```

### **Parameterized Food Processing**
```xml
<R:Precept name="SeasonFood" 
           providing="capability:seasoning_application AND domain:food_preparation"
           food_item="cracked_eggs" 
           seasonings="salt_pepper" 
           quantity="to_taste"
           description="Add salt and pepper to cracked eggs, seasoning to taste" />
```

### **Equipment Validation**
```xml
<R:Precept name="VerifyPanCondition" 
           providing="domain:kitchen AND capability:pan_validation" 
           instrument="chosen_pan"
           description="Check pan for cleanliness and non-stick coating integrity" />
```

## Human-Readability Principle

The `description` attribute ensures R:Precept placeholders are **self-documenting**. A human reader should understand the intent without examining the implementation precept:

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

## RESOLVE Mode Integration

### **Preflight RESOLVE (Most Common)**
```xml
<PreflightValidation>
  <R:Precept name="ValidateEmergencyKit" 
             providing="capability:emergency_validation AND domain:kitchen" />
  <RequiredInstrument instrumentName="emergency_kit" />
</PreflightValidation>
```
- **When**: During Intent DOM loading
- **Purpose**: Validate dependencies before execution starts
- **Failure Mode**: Intent DOM fails to load, provides early error feedback

### **Runtime RESOLVE (Traditional)**
```xml
<RequiredInstrument instrumentName="complex_analysis_result" providing="capability:data_analysis" />
```
- **When**: During precept execution when dependency missing
- **Purpose**: Goal decomposition - find precept to produce missing dependency
- **Failure Mode**: Precept STALLs until dependency resolved or times out

## Domain as First-Class Repository Objects

### **Domain Repository Architecture**
```
DomainRepository/
  ├── Geographic/European/German/MidSizedTown/
  ├── Organizational/Office/Engineering/
  └── Technical/Unix/FileSystem/

PreceptIndex: (capability_name, domain_id) → precept_list
```

### **Domain Definitions**
```xml
<Domain name="MyOffice">
  <Description>The office where I work</Description>
  <References>
    <Domain ref="GermanMidSizedTown" />
    <Domain ref="EuropeanOfficeSpace" />
    <Domain ref="EngineeringTeamCulture" />
  </References>
</Domain>
```

### **Resolver Workflow**
1. **Domain filtering happens first** - dramatically reduces search space
2. **Capability matching** - find precepts that provide needed capabilities
3. **Parameter binding** - instantiate precept with provided parameters
4. **Caching** - promote successful resolutions to faster cache tiers

**RALN Integration**: Domain hierarchies compile directly to RALN network topology, enabling hardware-accelerated domain constraint evaluation and capability resolution.

## RESOLVE System Benefits

- **Caching**: Precepts are cached for fast lookup and reuse
- **Parameterization**: Same logic works with different inputs across recipes
- **Modularity**: Universal precepts (seasoning, chopping, validation) separate from specific recipes
- **Scalability**: Repository can efficiently index and match precepts by capabilities and domains
- **Reusability**: Any recipe can resolve common food preparation patterns
- **Optimization-aware selection**: Executive uses LOC heuristics to select precepts appropriate for current optimization level

## Executive Precept Selection Strategy

When multiple precepts provide the same capability, the executive resolves ambiguity using **Lines of Code (LOC)** as a complexity proxy:

### **Simple vs. Sophisticated Alternatives**
```xml
<!-- Candidate 1: Simple approach (low LOC) -->
<Precept name="BasicDeskCleanup">
  <Provides>
    <Capability name="workspace_organization" domain="office_environment" />
  </Provides>
  <RequiredInstrument instrumentName="available_storage" />
  <Action>Sort items into basic categories and store</Action>
</Precept>

<!-- Candidate 2: Sophisticated approach (high LOC) -->
<Precept name="ErgonomicWorkspaceOptimization">
  <Provides> 
    <Capability name="workspace_organization" domain="office_environment" />
  </Provides>
  <RequiredInstrument instrumentName="available_storage" />
  <RequiredInstrument instrumentName="workflow_analysis_data" />
  <R:Precept name="AnalyzeUsagePatterns" providing="capability:ergonomic_analysis" />
  <R:Precept name="OptimizePlacement" providing="capability:spatial_optimization" />
  <R:Precept name="ValidateAccessibility" providing="capability:usability_testing" />
  <Action>Arrange workspace based on ergonomic principles and usage frequency</Action>
  <!-- ... additional complexity ... -->
</Precept>
```

### **Executive Selection Logic**
- **E1/E2**: Choose `BasicDeskCleanup` (lower LOC = appropriate complexity for building momentum)
- **E4/E5**: Choose `ErgonomicWorkspaceOptimization` (higher LOC = elegant solution when context supports it)
- **STALL Recovery**: Downgrade optimization level and re-select simpler precept

### **Natural Overoptimization Prevention**
- **Complex precepts STALL** when genealogy depth exceeds available context momentum
- **Executive downgrades gear** and selects simpler alternatives
- **System learns** from STALL patterns to prevent future overoptimization
- **Clutch protection** prevents starting complex tasks in inappropriate gears

## Implementation Guidelines

1. **Extract Universal Patterns**: Any frequently-used action should become a separate precept
2. **Use Descriptive Parameters**: Parameter names should be self-explanatory
3. **Provide Human Context**: Always include meaningful descriptions
4. **Filter Precisely**: Use specific capability/domain combinations for exact matching
5. **Design for Reuse**: Think beyond the current recipe - how would other recipes use this?

---

**Related:** See `dependency_resolution_architecture.md` for query resolution priorities, `context_management.md` for context switch protocols, and `preflight_validation.md` for validation patterns.