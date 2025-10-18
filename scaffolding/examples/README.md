# Intent Scaffolding Examples

**Quick Start for New Engineers:** Start with `omelette_concise.xml` - it demonstrates all current patterns.

---

## ✅ Current Examples (Use These)

### **`omelette_concise.xml`** - Complete Working Example
Comprehensive demonstration of all modern intent scaffolding patterns:
- **D:Precept emergency handlers** with preflight validation  
- **Three preflight validation patterns** (simple, R:Precept, emergent)
- **R:Precept universal precepts** with parameter binding
- **Staging phases** with temporal optimization
- **Cross-stage dependencies** and artifact pipelining
- **Document order execution** with speculative waiting
- **Emergency preparedness** philosophy

### **`validate_emergency_kit.xml`** - Complex Validation Precept
Multi-step validation with branching logic:
- AcceptanceCriteria with multiple conditions
- Nested precept structure for organized validation
- Aggregated validation results
- Real-world emergency preparedness example

### **`test_egg_freshness.xml`** - Simple Validation Precept
Canonical example of food safety validation:
- Simple validation logic
- AcceptanceCriteria patterns
- Output artifact generation
- Reusable across food preparation contexts

### **`season_food.xml`** - Universal Reusable Precept
Example of capability-based reusable logic:
- Parameter binding and customization
- Cross-recipe compatibility
- Capability declarations for RESOLVE mode
- Universal food preparation pattern

---

## 🎯 Patterns Demonstrated

| Pattern | Example Location | Use Case |
|---------|------------------|----------|
| **Basic Precept** | `omelette_concise.xml` | Standard action with dependencies |
| **Simple Preflight** | `omelette_concise.xml` | `preflight="true"` existence checks |
| **R:Precept Preflight** | `omelette_concise.xml` | `preflight="R:ValidateSomething"` |
| **Emergent Validation** | `omelette_concise.xml` | `<PreflightValidation>` blocks |
| **Emergency Handlers** | `omelette_concise.xml` | `<D:Precept>` for safety |
| **Staging Phases** | `omelette_concise.xml` | Execution boundaries |
| **Universal Precepts** | `season_food.xml` | Reusable parameterized logic |
| **Complex Validation** | `validate_emergency_kit.xml` | Multi-step validation workflows |

---

## 🚀 Copy-Paste Templates

### **Basic Action**
```xml
<Precept name="YourAction">
  <Description>What this precept does</Description>
  <RequiredInstrument instrumentName="dependency" />
  <Action>Do something</Action>
  <Output>
    <Artifact name="result" />
  </Output>
</Precept>
```

### **Action with Simple Validation**
```xml
<Precept name="YourAction">
  <RequiredInstrument instrumentName="equipment" preflight="true" />
  <Action>Do something safely</Action>
</Precept>
```

### **Emergency Handler**
```xml
<D:Precept name="HandleEmergency" providing="capability:emergency_response">
  <RequiredInstrument instrumentName="safety_equipment" preflight="true" />
  <Action>Immediate emergency response</Action>
</D:Precept>
```

### **Reusable Precept**
```xml
<R:Precept name="UniversalAction" 
           providing="capability:your_capability AND domain:your_domain"
           parameter1="value1" 
           parameter2="value2"
           description="What this does in this context" />
```

---

## 📚 Learning Path

### **Beginner (5 minutes)**
1. Open `omelette_concise.xml`
2. Find the basic `<Precept name="CrackEggs">` pattern
3. Copy and modify for your use case

### **Intermediate (15 minutes)**
1. Study the preflight validation patterns in `omelette_concise.xml`
2. Look at emergency handlers (`<D:Precept>`)
3. Understand staging phases for complex workflows

### **Advanced (30 minutes)**
1. Study `validate_emergency_kit.xml` for complex validation logic
2. Examine `season_food.xml` for reusable precept design
3. Review the three-tier caching strategy in dependency resolution

---

## ⚠️ Avoid Legacy Patterns

**Do NOT use these deprecated patterns:**
```xml
<!-- ❌ OLD - Don't copy these -->
<RequiredResource resourceName="eggs" />
<DirectElementName />
<RequiredInstrument providing="preflight" />

<!-- ✅ NEW - Use these instead -->
<RequiredInstrument instrumentName="eggs" />
<Precept name="DirectElementName" />
<RequiredInstrument preflight="true" />
```

---

**Next:** See the main [README.md](../README.md) for complete documentation modules.
