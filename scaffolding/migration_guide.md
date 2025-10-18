# Migration Guide: Legacy to Modular Intent Scaffolding

**Transition Guide**: Updating from legacy patterns to current modular architecture

---

## Overview

The intent scaffolding system has evolved significantly, with major changes in dependency resolution, preflight validation, and RESOLVE mode usage. This guide helps migrate from legacy patterns to current best practices.

---

## Breaking Changes

### **1. Preflight Validation Syntax**

#### **Legacy (Deprecated)**
```xml
<RequiredInstrument instrumentName="ingredients_validated" providing="preflight" />
```

#### **Current (Recommended)**
```xml
<!-- Simple validation -->
<RequiredInstrument instrumentName="ice_pack" preflight="true" />

<!-- Complex validation -->
<RequiredInstrument instrumentName="emergency_kit" preflight="R:ValidateEmergencyKit" />

<!-- Emergent validation -->
<PreflightValidation>
  <R:Precept name="ValidateEmergencyKit" />
  <RequiredInstrument instrumentName="emergency_kit" />
</PreflightValidation>
```

### **2. Resource → Instrument Terminology**

#### **Legacy (Deprecated)**
```xml
<RequiredResource resourceName="eggs" />
```

#### **Current (Required)**
```xml
<RequiredInstrument instrumentName="eggs" />
```

### **3. Direct Element Names → Type-Safe Precepts**

#### **Legacy (Deprecated)**
```xml
<GenerateReport>
  <AnalyzeData />
  <CreateSummary />
</GenerateReport>
```

#### **Current (Required)**
```xml
<Precept name="GenerateReport">
  <Precept name="AnalyzeData" />
  <Precept name="CreateSummary" />
</Precept>
```

---

## Architectural Shifts

### **1. RESOLVE Mode Usage**

#### **Legacy Understanding**
- RESOLVE primarily for runtime goal decomposition
- Called during precept STALLs
- Repository queries during execution

#### **Current Reality**
- **Most RESOLVE calls are preflight-related**
- Heavy usage during Intent DOM loading
- Repository queries minimized through smart caching

```xml
<!-- Modern preflight-heavy pattern -->
<PreflightValidation>
  <R:Precept name="ValidateEnvironment" />
  <R:Precept name="ValidateEquipment" />
  <R:Precept name="ValidateSupplies" />
  <RequiredInstrument instrumentName="cooking_readiness" />
</PreflightValidation>
```

### **2. Control Flow Evolution**

#### **Legacy Approach**
- Explicit control flow constructs (if/then/loop)
- Imperative execution model
- Manual orchestration

#### **Current Approach**
- **Dependency-driven activation**
- **Speculative execution with waiting**
- **Document order + artifact pipelining**

```xml
<!-- Modern speculative execution -->
<Precept name="HeatPan">
  <!-- Runs first in document order -->
  <Output><Artifact name="pan_ready" /></Output>
</Precept>

<Precept name="AddEggs">
  <!-- Spawns immediately but waits for pan_ready -->
  <RequiredInstrument instrumentName="pan_ready" />
</Precept>
```

### **3. Emergency Handling**

#### **Legacy Approach**
- Exception handling within normal precepts
- Try/catch patterns
- Inline error recovery

#### **Current Approach**
- **D:Precept handlers outside normal workflow**
- **Preloaded emergency responses**
- **Intent DOM generation for complex emergencies**

```xml
<!-- Modern emergency preparedness -->
<D:Precept name="HandleBurnInjury">
  <PreflightValidation>
    <R:Precept name="ValidateFirstAidKit" />
    <RequiredInstrument instrumentName="first_aid_ready" />
  </PreflightValidation>
  <!-- Emergency actions... -->
</D:Precept>
```

---

## Migration Checklist

### **Immediate Required Changes**

- [ ] Replace `RequiredResource` with `RequiredInstrument`
- [ ] Replace `resourceName` with `instrumentName`
- [ ] Wrap direct element names in `<Precept name="...">`
- [ ] Update `providing="preflight"` to `preflight="true"`

### **Recommended Modernizations**

- [ ] Extract universal patterns into R:Precept references
- [ ] Add preflight validation for dependencies
- [ ] Convert exception handling to D:Precept patterns
- [ ] Use emergent validation for complex dependencies
- [ ] Add capability declarations for RESOLVE compatibility

### **Optional Optimizations**

- [ ] Implement speculative execution patterns
- [ ] Add temporal optimization with sleepable steps
- [ ] Create comprehensive emergency preparedness
- [ ] Design for three-tier caching strategy

---

## Pattern Migration Examples

### **Simple Validation Migration**

#### **Before**
```xml
<Precept name="StartCooking">
  <RequiredResource resourceName="ingredients" />
  <!-- Manual validation logic inline -->
</Precept>
```

#### **After**
```xml
<Precept name="StartCooking">
  <RequiredInstrument instrumentName="ingredients" preflight="true" />
  <!-- Validation handled by executive -->
</Precept>
```

### **Complex Validation Migration**

#### **Before**
```xml
<Precept name="BeginSurgery">
  <Precept name="CheckSterileField" />
  <Precept name="ValidateInstruments" />
  <Precept name="ConfirmPatientPrep" />
  <!-- Inline validation logic -->
</Precept>
```

#### **After**
```xml
<Precept name="BeginSurgery">
  <PreflightValidation>
    <R:Precept name="ValidateSterileField" />
    <R:Precept name="ValidateInstruments" />
    <R:Precept name="ValidatePatientPrep" />
    <RequiredInstrument instrumentName="surgical_readiness" />
  </PreflightValidation>
  <!-- Actual surgery precepts -->
</Precept>
```

### **Emergency Handling Migration**

#### **Before**
```xml
<Precept name="CookMeal">
  <Try>
    <Precept name="ApplyHeat" />
    <Catch condition="burn">
      <Precept name="TreatBurn" />
    </Catch>
  </Try>
</Precept>
```

#### **After**
```xml
<!-- Normal cooking -->
<Precept name="CookMeal">
  <Precept name="ApplyHeat" />
  <!-- No inline exception handling -->
</Precept>

<!-- Emergency handler (at Intent DOM root) -->
<D:Precept name="HandleBurnInjury">
  <PreflightValidation>
    <R:Precept name="ValidateFirstAidSupplies" />
    <RequiredInstrument instrumentName="burn_treatment_ready" />
  </PreflightValidation>
  <!-- Immediate burn response -->
</D:Precept>
```

### **Capability Declaration Migration**

#### **Before**
```xml
<Precept name="AnalyzeData">
  <!-- No capability declarations -->
</Precept>
```

#### **After**
```xml
<Precept name="AnalyzeData">
  <Provides>
    <Capability name="data_analysis" context="research_environment" />
    <Capability name="statistical_processing" context="scientific_computing" />
  </Provides>
  <!-- Enables RESOLVE to find this precept -->
</Precept>
```

---

## Performance Migration

### **Legacy Performance Characteristics**
- Runtime goal decomposition during STALLs
- Repository queries during execution
- Unpredictable resolution latency

### **Modern Performance Characteristics**
- Front-loaded validation during Intent DOM loading
- Three-tier caching strategy (runtime → DOM → repository)
- Predictable execution performance after loading

### **Migration Strategy**
1. **Identify heavy runtime RESOLVE usage** - convert to preflight where possible
2. **Add capability declarations** - enable efficient repository indexing
3. **Implement caching-friendly patterns** - design for reuse across similar intents
4. **Use emergent validation** - validate complex dependencies once during loading

---

## Validation and Testing

### **Migration Validation Steps**
1. **Syntax Check**: Ensure all legacy patterns updated
2. **Dependency Check**: Verify all instrument dependencies declared
3. **Capability Check**: Confirm R:Precept references can be resolved
4. **Emergency Check**: Verify D:Precept handlers have preflight validation
5. **Performance Check**: Measure Intent DOM loading vs execution time

### **Expected Changes**
- **Longer Intent DOM loading time** (due to preflight validation)
- **Faster execution time** (dependencies pre-resolved)
- **Better error detection** (problems found during loading)
- **More predictable performance** (no surprise repository queries)

---

## Common Migration Issues

### **Issue 1: Missing Capability Declarations**
```
Error: R:Precept "ValidateEquipment" not found
Solution: Add capability declarations to validation precepts
```

### **Issue 2: Circular Preflight Dependencies**
```
Error: Preflight validation cycle detected
Solution: Break cycles using staging phase boundaries
```

### **Issue 3: Over-Preflighting**
```
Warning: Intent DOM loading time excessive
Solution: Move some validations to runtime dependencies
```

### **Issue 4: Missing Emergency Preparedness**
```
Warning: D:Precept has no preflight validation
Solution: Add comprehensive emergency equipment validation
```

---

**Next Steps:** After migration, see the individual module documentation for advanced patterns: `capability_system.md`, `preflight_validation.md`, `disrupt_handlers.md`, and `staging_and_execution.md`.