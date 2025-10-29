# Dependency Resolution Architecture

**Core Integration:** RequiredInstrument, Preflight Validation, and RESOLVE Mode

---

## Overview

The dependency resolution system handles three interconnected concerns:
1. **Instrument Dependencies** - What a precept needs to execute
2. **Preflight Validation** - Ensuring dependencies will be available before execution starts
3. **RESOLVE Mode** - Finding and instantiating precepts to satisfy dependencies

This system has evolved where **most RESOLVE calls happen during preflight validation**, not during runtime STALLs.

---

## RequiredInstrument Syntax

### **Basic Instrument Declaration**
```xml
<RequiredInstrument instrumentName="eggs" quantity="2-3" alias="chosen_eggs" />
```

### **Simple Preflight Validation**
```xml
<RequiredInstrument instrumentName="ice_pack" preflight="true" location="freezer" />
```
- Executive checks instrument exists during Intent DOM loading
- Fails fast if instrument unavailable

### **R:Precept Preflight Validation**
```xml
<RequiredInstrument instrumentName="emergency_kit" 
                    preflight="R:ValidateEmergencyKit"
                    providing="capability:emergency_validation AND domain:kitchen" />
```
- Executive resolves and executes validation precept during Intent DOM loading
- Complex validation logic with branching and acceptance criteria

### **Emergent Preflight Validation**
```xml
<PreflightValidation>
  <R:Precept name="ValidateEmergencyKit" 
             providing="capability:emergency_validation AND domain:kitchen"
             description="Comprehensive emergency kit validation with branching logic" />
  <RequiredInstrument instrumentName="emergency_kit" />
</PreflightValidation>
```
- Validation precepts **produce** the required instrument
- Multiple validation precepts can contribute to single instrument
- Instrument only becomes available if all validations pass

### **Runtime Dependency Resolution**
```xml
<RequiredInstrument instrumentName="ingredients_ready" providing="execution:concurrent_preparation" />
```
- Traditional runtime dependency - waits for artifact from previous precept/stage
- No preflight validation - resolved during execution

---

## Canonical Query Resolution Priorities

When the executive needs to resolve a dependency (R:Precept, providing="...", or missing instrument), it searches in this order:

### **Priority 1: Active Runtime (Hot Cache)**
```
Current working memory:
├── All spawned precepts from current intent DOM
├── Runtime-resolved precepts (R:Precept instantiations)  
├── DISRUPT-injected precepts (emergency handlers, environmental responses)
├── Context-switched precepts still in volatile cache
└── Artifacts produced by currently executing precepts
```
- **Performance**: O(1) lookup
- **Relevance**: Highest - currently executing or just executed
- **Cache Policy**: LRU eviction when memory pressure

### **Priority 2: Intent DOM Declaration (Warm Cache)**  
```
Static declarations in current active file:
├── Explicitly declared precepts in staging phases
├── D:Precept emergency handlers
├── R:Precept placeholders (before resolution)
├── Cross-stage dependencies and artifacts
└── Capability declarations and context references
```
- **Performance**: O(log n) lookup via DOM traversal
- **Relevance**: Medium - planned for this execution session
- **Cache Policy**: Cached for lifetime of Intent DOM

### **Priority 3: Repository Query (Cold Storage)**
```
Database/repository lookup:
├── Capability-based precept search with context filtering
├── Hierarchical context tree traversal
├── New precept instantiation and parameter binding
├── Network-distributed precept repositories
└── Cross-domain precept adaptation
```
- **Performance**: O(n) lookup, but results cached after first hit
- **Relevance**: Variable - potentially very relevant but unknown cost
- **Cache Policy**: Promote to Priority 1 or 2 after successful resolution

---

## Instrument Resolution & Output Binding

**Core contract**: `RequiredInstrument` declares a name and optional constraints. The runtime resolves that name to a provider precept using RESOLVE (searching the three priority tiers above), and then binds the provider's output to the instrument name via `allocateOutput`.

### Simple case (no constraints)
```xml
<RequiredInstrument instrumentName="eggs" quantity="2" />
```
Runtime finds any precept that produces output named `eggs` and binds it.

### With constraints (clean pattern — example 3)
```xml
<RequiredInstrument instrumentName="lunar_module" />

<R:Precept name="AcquireGrummanLM"
           providing="capability:lunar_surface_landing AND 
                      manufacturer:Grumman AND
                      contract:NAS_9-1100"
           allocateOutput="lm as lunar_module" />
```
The `providing` attribute includes capability, domain, and constraint filters. When resolved, `allocateOutput` binds the provider's output (`lm`) to the requester's instrument name (`lunar_module`).

### Alternative patterns (also valid)
```xml
<!-- Inline constraints as child nodes -->
<RequiredInstrument instrumentName="component">
  <Constraint type="manufacturer">Company Name</Constraint>
  <Constraint type="model">Model Number</Constraint>
</RequiredInstrument>

<!-- Constraint attributes -->
<RequiredInstrument instrumentName="lunar_module"
                    manufacturer="Grumman"
                    model="LM-5"
                    contract="NAS_9-1100" />
```

**How it works**: RESOLVE matches RequiredInstrument constraints against provider precept metadata (from `providing` attribute and capability declarations). Once matched and executed (or retrieved from cache), the provider's Output is aliased to the instrument name via `allocateOutput`. Downstream precepts reference the instrument by name, and the runtime resolves that name to the provider's artifact.

---

## RESOLVE Mode Integration

### **Preflight RESOLVE (Most Common)**
```xml
<R:Precept name="ValidateEmergencyKit" 
           providing="capability:emergency_validation AND domain:kitchen" />
```
- **When**: During Intent DOM loading
- **Purpose**: Validate dependencies before execution starts
- **Failure Mode**: Intent DOM fails to load, provides early error feedback
- **Caching**: Results cached in Priority 2 (Intent DOM scope)

### **Runtime RESOLVE (Traditional)**
```xml
<!-- Precept STALLs because dependency not satisfied -->
<RequiredInstrument instrumentName="complex_analysis_result" providing="capability:data_analysis" />
```
- **When**: During precept execution when dependency missing
- **Purpose**: Goal decomposition - find precept to produce missing dependency
- **Failure Mode**: Precept STALLs until dependency resolved or times out
- **Caching**: Results promoted to Priority 1 (active runtime)

### **D:Precept RESOLVE (Emergency)**
```xml
<D:Precept name="HandleBurnInjury" providing="capability:emergency_response" />
```
- **When**: DISRUPT handler activation
- **Purpose**: Fast emergency response with pre-validated equipment
- **Failure Mode**: Fallback to repository lookup (Priority 3)
- **Caching**: Pre-loaded in Priority 1 for zero-latency access

---

## Execution Flow Integration

### **Intent DOM Loading Sequence**
1. **Parse DOM Structure** - Build precept tree and staging phases
2. **Extract Preflight Requirements** - Find all `preflight="..."` and `<PreflightValidation>` blocks
3. **Execute Preflight RESOLVE** - Instantiate and run validation precepts
4. **Validate Emergent Instruments** - Confirm all `RequiredInstrument` dependencies satisfied
5. **Cache Resolved Precepts** - Promote validation results to Priority 2 cache
6. **Ready for Execution** - Intent DOM validated and ready to execute

### **Runtime Execution Sequence**
1. **Document Order Traversal** - Execute precepts depth-first from top to bottom
2. **Dependency Check** - For each `RequiredInstrument`, check Priority 1 → 2 → 3
3. **Conditional Execution** - If dependencies satisfied → execute, else → STALL/wait
4. **Artifact Production** - Cache outputs in Priority 1 for subsequent precepts
5. **DISRUPT Handling** - Emergency precepts interrupt normal flow if needed

### **Speculative Execution Model**
```xml
<Precept name="MaybeExecute">
  <RequiredInstrument instrumentName="optional_input" />
  <!-- Will NOP if optional_input never becomes available -->
  <!-- Will execute when optional_input appears in Priority 1 cache -->
</Precept>
```
- All precepts spawn and check dependencies continuously
- NOPs transformed into "wait for dependency" with timeout
- Natural concurrency through dependency-driven activation

---

## Performance Characteristics

### **Cold Start (New Intent DOM)**
- Heavy preflight RESOLVE activity
- Repository queries dominate
- Caching builds up Priority 2 cache

### **Warm Execution (Established Session)**  
- Most queries hit Priority 1 or 2 cache
- Minimal repository lookups
- Fast dependency resolution

### **Hot Execution (Repetitive Tasks)**
- All dependencies in Priority 1 cache  
- Near-zero resolution latency
- Optimal performance

---

## Emergent Singleton Behavior

### **Priority-Based Deduplication**
The three-tier priority system creates **natural deduplication** that prevents redundant provider instantiation. When a dependency is missing, the resolver searches priorities in order and selects the **closest available provider**, creating emergent singleton behavior.

### **Example: Preventing Redundant Providers**
```xml
<Precept name="MakeOmelette">
  <Precept name="CrackEggs">
    <Output><Artifact name="cracked_eggs" /></Output>
  </Precept>
  
  <!-- Later in document order -->
  <Precept name="SeasonEggs">
    <RequiredInstrument instrumentName="cracked_eggs" preflight="true" />
  </Precept>
</Precept>
```

**Scenario**: During DOM loading, `SeasonEggs` runs preflight validation and finds `cracked_eggs` missing.

**Resolution Process**:
1. **Priority 1 (Active Runtime)**: Empty - DOM just loaded
2. **Priority 2 (Intent DOM)**: Finds `CrackEggs` precept already declared 
3. **Priority 3 (Repository)**: Has `BuyEggsFromStore` precept available

**Result**: Resolver selects the **already-declared** `CrackEggs` from Priority 2, not the repository's `BuyEggsFromStore`.

### **"Closer Providers Win" Principle**
- **Intent DOM providers** (Priority 2) are preferred over repository providers (Priority 3)
- **Active runtime providers** (Priority 1) are preferred over planned providers (Priority 2)
- This prevents spawning redundant providers when a suitable one already exists in the execution scope
- **Natural deduplication**: The same dependency will consistently resolve to the same provider within an execution context

### **Benefits of Emergent Singleton Behavior**
- **Resource conflict prevention**: Avoids multiple precepts trying to satisfy the same dependency
- **Execution efficiency**: No duplicate work (e.g., buying eggs when already cracking eggs)
- **Predictable behavior**: Same dependency → same provider within execution scope
- **Locality preference**: Closer providers reduce coordination overhead and latency

This emergent singleton behavior arises from the priority search order, not explicit singleton enforcement. The architecture naturally prevents redundant instantiation through **locality preference**.

---

## Design Implications

### **Most RESOLVE is Now Preflight**
The system has evolved where dependency validation happens upfront rather than during execution STALLs. This provides:
- **Early Error Detection** - Problems found before execution starts
- **Predictable Performance** - Validation cost paid once during loading
- **Better Resource Management** - No surprise resource demands during execution

### **Repository as Last Resort**
The "heavy sigh" repository query is truly last resort:
- **Smart Caching** prevents repeated expensive lookups
- **Priority Promotion** moves successful resolutions to faster tiers
- **Context Filtering** reduces search space before expensive operations

This architecture provides fast, predictable dependency resolution while maintaining the flexibility to handle novel situations through repository lookup.