# Preflight Validation Patterns

**Validation Systems**: Preflight validation, emergent instruments, and dependency verification

---

## Overview

Preflight validation ensures dependencies are available before execution starts, providing early error detection and predictable performance. The system supports three levels of complexity using XML's natural flexibility.

**Integration Note:** Preflight validation is now the primary use case for RESOLVE mode. See `dependency_resolution_architecture.md` for complete query resolution strategy.

---

## Three Validation Patterns

### **Pattern 1: Simple Existence Check**
```xml
<RequiredInstrument instrumentName="ice_pack" preflight="true" location="freezer" />
```

**Use Case:**
- Basic existence validation
- Binary pass/fail check
- No complex logic needed

**Execution:**
- Executive checks instrument exists during Intent DOM loading
- Fails fast if instrument unavailable
- No precept resolution required, except on failure scenarios. Resolution is then handled via standard runtime STALL/TAC executive resolution at increased latency.

### **Pattern 2: R:Precept Reference**
```xml
<RequiredInstrument instrumentName="emergency_kit" 
                    preflight="R:ValidateEmergencyKit"
                    providing="capability:emergency_validation AND domain:kitchen" />
```

**Use Case:**
- Single validation precept with complex logic
- Reusable validation across multiple intents
- Standard validation patterns

**Execution:**
- Executive resolves validation precept by name and capability filter
- Executes validation during Intent DOM loading
- Caches results in Intent DOM scope (Priority 2)

### **Pattern 3: Emergent Instrument Validation**
```xml
<PreflightValidation>
  <R:Precept name="ValidateFireSafety" 
             providing="capability:fire_safety_validation AND domain:kitchen"
             description="Validate fire extinguisher and blanket readiness" />
  <R:Precept name="ValidateFirstAid" 
             providing="capability:first_aid_validation AND domain:emergency"
             description="Validate medical supplies and accessibility" />
  <R:Precept name="ValidateElectricalSafety" 
             providing="capability:electrical_validation AND domain:kitchen"
             description="Validate GFCI outlets and electrical safety" />
  
  <!-- Instrument emerges from successful validation -->
  <RequiredInstrument instrumentName="kitchen_safety_systems" />
</PreflightValidation>
```

**Use Case:**
- Multiple validation precepts contributing to single instrument
- Complex validation workflows with branching logic
- Conditional instrument availability

**Execution:**
- Execute all validation precepts in sequence
- Only if ALL validations pass → instrument becomes available
- If ANY validation fails → instrument unavailable, preflight fails

## Emergent Instrument Semantics

### **Causality Flow**
```
Validation Precepts → Execute Successfully → Instrument Becomes Available
```

The validation **produces** the instrument, not the other way around.

### **Multiple Sources Pattern**
```xml
<PreflightValidation>
  <R:Precept name="ValidateIngredients" />
  <R:Precept name="ValidateEquipment" />
  <R:Precept name="ValidateEnvironment" />
  
  <!-- All three must pass for cooking_readiness to be available -->
  <RequiredInstrument instrumentName="cooking_readiness" />
</PreflightValidation>
```

### **Conditional Availability**
```xml
<!-- Professional kitchen validation -->
<PreflightValidation>
  <R:Precept name="ValidateCommercialEquipment" />
  <RequiredInstrument instrumentName="professional_grade_tools" />
</PreflightValidation>

<!-- Home kitchen validation -->
<PreflightValidation>
  <R:Precept name="ValidateHomeEquipment" />
  <RequiredInstrument instrumentName="home_cooking_tools" />
</PreflightValidation>
```

Different validation tracks can produce different instrument sets based on context.

## Cross-Stage Validation

### **Stage Pipeline Validation**
```xml
<StagingPhase type="execution" name="cook_omelette">
  <PreflightValidation>
    <R:Precept name="ValidateStagePipeline" 
               required_stages="concurrent_preparation"
               expected_outputs="ingredients_ready,pan_ready"
               description="Validate that prerequisite stages can produce required artifacts" />
    <RequiredInstrument instrumentName="stage_pipeline_validated" />
  </PreflightValidation>
  
  <!-- Runtime dependencies -->
  <RequiredInstrument instrumentName="ingredients_ready" providing="execution:concurrent_preparation" />
  <RequiredInstrument instrumentName="pan_ready" providing="execution:concurrent_preparation" />
</StagingPhase>
```

### **Hybrid Validation Strategy**
1. **Preflight**: Validate that the stage dependency structure is correct
2. **Runtime**: Wait for actual artifacts to be produced during execution

This provides both early error detection and natural execution flow.

## Validation Precept Patterns

### **AcceptanceCriteria with Branching**
```xml
<Precept name="ValidateBandages">
  <Action>Count available bandages</Action>
  <Action>Check expiration dates</Action>
  
  <AcceptanceCriteria>
    <Condition state="adequate" test="count >= 10 AND not_expired" action="Mark as ready" />
    <Condition state="insufficient" test="count < 10" action="Add to shopping list" />
    <Condition state="expired" test="expiry_date < today" action="Replace immediately" />
  </AcceptanceCriteria>
  
  <Output>
    <Artifact name="bandage_status">
      <Type>validation_data</Type>
      <Description>Bandage inventory and condition assessment</Description>
    </Artifact>
  </Output>
</Precept>
```

### **Aggregated Validation Results**
```xml
<Output>
  <Artifact name="emergency_kit_validated">
    <Type>validation_data</Type>
    <Type>state_vector</Type>
    <Description>Complete emergency kit validation with detailed status</Description>
    <Source>
      <Union>
        <From ref="ValidateBandages" artifact="bandage_status" />
        <From ref="ValidateAntiseptic" artifact="antiseptic_status" />
        <From ref="ValidateExtinguisher" artifact="extinguisher_status" />
      </Union>
    </Source>
  </Artifact>
</Output>
```

## DISRUPT Handler Preflight

### **Emergency Preparedness**
```xml
<D:Precept name="HandleBurnInjury" 
           providing="capability:emergency_response AND domain:kitchen_safety">
  <PreflightValidation>
    <R:Precept name="ValidateEmergencyKit" />
    <RequiredInstrument instrumentName="emergency_kit" />
  </PreflightValidation>
  
  <RequiredInstrument instrumentName="ice_pack" preflight="true" />
  <RequiredInstrument instrumentName="clean_towel" preflight="true" />
  
  <!-- Emergency actions... -->
</D:Precept>
```

**Benefits:**
- Emergency equipment validated before cooking starts
- Zero-latency emergency response (no validation during crisis)
- Early feedback if emergency preparedness incomplete

## Logical Validation with Lojban-Inspired Patterns

### **Systematic Instrument Validation**
```xml
<ValidateInstrumentCondition instrument="cheese" conditionSet="mold_signs" domain="food_safety">
  <AcceptanceCriteria>
    <Condition state="acceptable" test="no_visible_mold" action="Proceed with cooking" />
    <Condition state="questionable" test="slight_discoloration" action="Inspect more closely" />
    <Condition state="unacceptable" test="visible_mold_present" action="Discard and replace" />
  </AcceptanceCriteria>
  <Constraint type="safety">Never use moldy ingredients</Constraint>
</ValidateInstrumentCondition>
```

**Pattern:** "Precept X enables agent to check instrument Y for fulfilling condition set Z under domain constraints W"

## Performance Characteristics

### **Cold Start Validation**
- Heavy preflight RESOLVE activity during Intent DOM loading
- Repository queries to find validation precepts
- Results cached in Intent DOM scope for reuse

### **Warm Execution**
- Validation results cached from previous loads
- Fast preflight validation using cached precepts
- Minimal repository queries

### **Validation Failure Modes**
```xml
<!-- Preflight failure prevents execution -->
Preflight Validation Fails → Intent DOM Load Fails → Early Error Feedback

<!-- Runtime failure during execution -->
Runtime Dependency Missing → Precept STALLs → Goal Decomposition via RESOLVE
```

## Implementation Guidelines

### **When to Use Each Pattern**

| Pattern | Use Case | Examples |
|---------|----------|----------|
| `preflight="true"` | Simple existence check | File exists, tool available |
| `preflight="R:Precept"` | Standard validation | Egg freshness test, equipment check |
| `<PreflightValidation>` | Complex multi-step validation | Emergency kit, professional certification |

### **Design Principles**
1. **Start Simple**: Use `preflight="true"` for basic checks
2. **Scale Naturally**: Add R:Precept for reusable validations
3. **Compose Complexity**: Use PreflightValidation blocks for multi-step workflows
4. **Cache Results**: Validation results should be reusable across similar intents
5. **Fail Fast**: Preflight should catch problems before execution starts

---

**Related:** See `dependency_resolution_architecture.md` for query resolution priorities, `capability_system.md` for R:Precept syntax, and `disrupt_handlers.md` for emergency validation patterns.