# Executive Runtime Architecture

**Modern AGC-Inspired Cognitive Executive**: Cooperative multitasking for universal cognitive architecture

---

## Purpose

Define a modern executive (runtime router) for intent scaffolding agents, inspired by the Apollo Guidance Computer but adapted for emergent singleton behavior, three-tier dependency resolution, and universal cognitive patterns.

**Key Evolution from Legacy**: The executive now manages **emergent control flow** where execution order arises from dependency resolution rather than explicit scheduling, while maintaining AGC-style cooperative multitasking principles.

---

## Core Architecture

### **Job Descriptor (JD) - Modern Design**
```c
typedef struct {
  uint32_t id;                           // Unique job identifier
  precept_ref_t root_precept;           // Root precept of Intent DOM
  priority_level_t priority;            // Scheduling priority
  realtime_promise_t deadline;          // Realtime constraints (if any)
  intent_compilation_level_t compilation; // Fully deterministic vs runtime-mutable
  dependency_state_t dependencies;      // Three-tier dependency tracking
  emergent_singleton_map_t singletons;  // Tracks singleton provider assignments
  uint64_t estimated_cycles;            // Resource estimation
  job_state_t state;                    // WAITING, READY, RUNNING, BLOCKED, COMPLETE
} modern_job_descriptor_t;
```

### **Three-Tier Memory Architecture**
```c
typedef struct {
  // Priority 1: Active Runtime (Hot Cache)
  artifact_cache_t active_artifacts;    // Currently executing precept outputs
  provider_cache_t hot_providers;       // Recently used precept instances
  
  // Priority 2: Intent DOM (Warm Cache)  
  intent_dom_t current_dom;            // Static declarations in active file
  precept_registry_t dom_precepts;     // Declared precepts and capabilities
  
  // Priority 3: Repository (Cold Storage)
  capability_index_t global_capabilities; // Global precept repository
  context_hierarchy_t contexts;           // Hierarchical context trees
} three_tier_memory_t;
```

---

## Emergent Execution Model

### **Dependency-Driven Activation**
Unlike traditional job scheduling, the modern executive uses **emergent singleton behavior** where execution order emerges from dependency resolution:

```c
// Core execution loop - interrupt priority ordering critical
void executive_main_loop() {
  while (system_active) {
    // 1. HIGHEST PRIORITY: Service emergency DISRUPT handlers first
    //    Must run at highest IRQL to prevent priority inversion
    service_disrupt_interrupts();
    
    // 2. Check for jobs preempted by emergency handlers
    process_emergency_preemption();
    
    // 3. Scan remaining jobs for satisfied dependencies
    scan_dependency_satisfaction();
    
    // 4. Execute ready precepts (emergent order)
    execute_ready_precepts();
    
    // 5. Resolve missing dependencies through three-tier lookup
    process_dependency_resolution();
    
    // 6. Handle cooperative yields and context switches (lowest priority)
    process_cooperative_yields();
  }
}
```

### **Emergent Singleton Resolution**
```c
// Unified resolution for both instruments and capabilities
provider_ref_t resolve_dependency(resolve_query_t query, job_id_t requesting_job) {
  // query can be:
  // - instrument_query_t: { .type=INSTRUMENT, .name="eggs", .quantity=3 }
  // - capability_query_t: { .type=CAPABILITY, .capability="food_prep", .context="kitchen" }
  
  // Priority-based deduplication prevents redundant providers
  
  // Priority 1: Check active runtime
  provider_ref_t provider = lookup_active_provider(query);
  if (provider.valid) return provider;
  
  // Priority 2: Check Intent DOM for declared precepts
  provider = lookup_dom_provider(query, requesting_job->dom_scope);
  if (provider.valid) {
    // "Closer providers win" - prefer already-declared over repository
    return instantiate_dom_provider(provider, requesting_job);
  }
  
  // Priority 3: Repository query with "heavy sigh"
  // Works for both instrument and capability queries
  provider = repository_resolve(query);
  if (provider.valid) {
    // Cache for future use, promote to Priority 2
    cache_resolved_provider(provider, requesting_job->dom_scope);
    return provider;
  }
  
  // Dependency cannot be satisfied (instrument or capability)
  emit_dependency_failure(query, requesting_job);
  return PROVIDER_NOT_FOUND;
}

// Resolve query type definitions
typedef enum {
  RESOLVE_INSTRUMENT,  // Looking for specific instrument/artifact
  RESOLVE_CAPABILITY,  // Looking for precept with capability
  RESOLVE_R_PRECEPT    // Looking for specific R:Precept by name
} resolve_query_type_t;

typedef struct {
  resolve_query_type_t type;
  union {
    struct {
      instrument_name_t name;
      uint32_t quantity;
      quality_spec_t quality;
    } instrument;
    
    struct {
      capability_name_t capability;
      context_filter_t context;
      parameter_set_t params;
    } capability;
    
    struct {
      precept_name_t name;
      parameter_bindings_t bindings;
      context_filter_t providing_filter;
    } r_precept;
  };
} resolve_query_t;
```

---

## Execution Contexts

### **Runtime-Mutable Context**
For intents requiring extensive dependency resolution:
```c
typedef struct {
  uint32_t max_repository_queries;     // Budget for cold storage lookups
  uint32_t resolve_timeout_ms;         // Timeout for complex resolutions  
  capability_cache_t warm_capabilities; // Pre-warmed capability cache
  bool allow_speculative_warming;     // Can pre-populate cache
} runtime_mutable_context_t;
```

**Use Cases:**
- First-time execution of complex workflows
- Novel problem decomposition requiring repository queries
- Extensive preflight validation with multiple R:Precept resolutions

### **Fully Deterministic Context**
For intents with pre-resolved dependencies:
```c
typedef struct {
  artifact_cache_t pre_bound_artifacts; // All dependencies pre-resolved
  provider_cache_t cached_providers;    // Known singleton providers
  uint32_t max_execution_cycles;        // Bounded execution time
  bool realtime_guaranteed;             // Hard realtime promises
} fully_deterministic_context_t;
```

**Use Cases:**
- Repeated execution of well-practiced workflows
- Emergency handlers (D:Precept) with pre-validated equipment
- Realtime-critical precepts with deadline guarantees

---

## Modern Interrupt Model

### **DISRUPT (D) - Emergency Response**
```c
// Modern D:Precept handler integration
void d_isr_handler(disrupt_signal_t signal) {
  // 1. Identify emergency type and required capability
  capability_query_t emergency_query = classify_emergency(signal);
  
  // 2. Check for pre-loaded emergency handlers (D:Precept)
  d_precept_ref_t handler = lookup_emergency_handler(emergency_query);
  if (!handler.valid) {
    // No handler available - normal STALL/TAC resolution will handle this
    return;
  }
  
  // 3. Validate emergency equipment (should be pre-validated)
  if (!validate_emergency_readiness(handler)) {
    // Equipment not ready - normal STALL/TAC resolution will handle this
    return;
  }
  
  // 4. Create high-priority emergency job
  job_descriptor_t emergency_job = {
    .priority = PRIORITY_EMERGENCY,
    .compilation = INTENT_FULLY_DETERMINISTIC,  // Emergency handlers must be fast
    .realtime_promise = signal.deadline,
    .root_precept = handler.precept_ref
  };
  
  // 5. Preempt current jobs if necessary
  preempt_for_emergency(&emergency_job);
  enqueue_job(emergency_job);
}
```

### **M (MLP) - Recognition and Identification**
```c
// Modern recognition integration with RESOLVE
void m_isr_handler(recognition_signal_t signal) {
  // 1. Perform pattern recognition
  recognition_result_t result = mlp_recognize(signal);
  
  // 2. Generate appropriate precept response
  precept_ref_t response_precept = generate_response_precept(result);
  
  // 3. Create job with runtime-mutable context for flexibility
  job_descriptor_t recognition_job = {
    .priority = PRIORITY_RECOGNITION,
    .compilation = INTENT_RUNTIME_MUTABLE,  // May need repository queries
    .root_precept = response_precept
  };
  
  enqueue_job(recognition_job);
}
```

---

## Cooperative Multitasking

### **AGC-Style CCS (Count-Compare-Skip)**
```c
// Modern timer tick with dependency checking
void timer_tick_handler() {
  // AGC-inspired CCS operation
  ccs_result_t result = ccs_check_timer();
  
  switch (result) {
    case CCS_POSITIVE:
      // Timer running normally
      return;
      
    case CCS_ZERO_POSITIVE:
    case CCS_ZERO_NEGATIVE:
      // Time slice expired - cooperative yield point
      check_cooperative_yields();
      update_job_priorities();
      break;
      
    case CCS_NEGATIVE:
      // Timer disabled - diagnostic mode
      emit_diagnostic(TIMER_DISABLED);
      break;
  }
}

void check_cooperative_yields() {
  // Check if current job can yield cooperatively
  job_descriptor_t* current = get_current_job();
  
  if (current->state == JOB_WAITING_DEPENDENCIES) {
    // Job is blocked on dependencies - natural yield point
    cooperative_yield(current);
  } else if (current->compilation == INTENT_RUNTIME_MUTABLE && 
             current->execution_time > time_slice_budget) {
    // Long-running runtime-mutable job should yield
    cooperative_yield(current);
  }
  // Fully deterministic jobs complete quickly - no forced yields
}
```

### **Staging Phase Boundaries as Yield Points**
```c
// Natural yield points at staging boundaries
void staging_phase_transition(job_descriptor_t* job, staging_phase_t new_phase) {
  // 1. Save current state vector
  state_vector_t simplified_state = extract_state_vector(job);
  save_staging_checkpoint(job, simplified_state);
  
  // 2. Natural cooperative yield point
  if (should_yield_at_staging_boundary(job)) {
    cooperative_yield_with_checkpoint(job, simplified_state);
    return; // Resume later from checkpoint
  }
  
  // 3. Continue to next phase
  transition_to_phase(job, new_phase);
}
```

---

## Intent Compilation Levels

### **Fully Deterministic Intents**
Intent trees where every precept path terminates in deterministic, atomic operations - no runtime mutation required.

**Characteristics:**
- **Execution path fully determined** at compile time
- **No runtime RESOLVE calls** - all dependencies pre-bound
- **Turtle-0 termination** - every branch ends in atomic hardware operations
- **Realtime guarantees possible** - bounded execution cycles
- **Fully deterministic execution** - minimal memory footprint

**Example: Human phoneme recognition**
```
Acoustic Input → Cochlear Processing → Phoneme Classification → Semantic Embedding
     ↓                    ↓                      ↓                     ↓
 (Hardware)          (Hardware)            (Hardware)            (Hardware)
```
*Note: Real fully deterministic intents have orders of magnitude more stack depth than enterprise applications*

### **Runtime-Mutable Intents**
Intent trees requiring dynamic decomposition, RESOLVE calls, or structural mutation during execution.

**Characteristics:**
- **Execution path unknown** until runtime
- **Requires VAC areas** for dynamic tree mutation
- **Repository queries expected** - novel problem decomposition
- **Non-deterministic resource usage** - variable execution time
- **Runtime-mutable execution context** required

**Examples:**
- Novel problem solving: "Design a bridge for this specific terrain"
- Dynamic workflow adaptation: "Respond to unexpected customer request"
- Learning scenarios: "Understand this new domain and create action plan"

### **Mixed Compilation Intents**
Intent trees with both fully deterministic branches and runtime-mutable sections.

**Characteristics:**
- **Hybrid execution model** - some paths deterministic, others dynamic
- **Conditional VAC usage** - only for mutable branches
- **Performance optimization** - deterministic paths run fast, mutable paths flexible
- **Complex admission logic** - requires analysis of execution probability

---

## Alarm System

### **Modern Alarm Codes**
```c
typedef enum {
  // Job admission alarms (AGC-style octal)
  ALARM_1201_NO_VAC_AREAS = 01201,         // No space for runtime-mutable intent DOM
  ALARM_1202_EXECUTIVE_OVERFLOW = 01202,   // No CPU cycles for any task
  
  // System integrity alarms
  ALARM_1401_INTENT_DOM_CORRUPT = 01401,   // Intent DOM structure corrupted
  ALARM_1402_THREE_TIER_INCONSISTENT = 01402, // Cache consistency violation
} modern_alarm_code_t;
```

### **Alarm Response Procedures**
```c
void handle_modern_alarm(modern_alarm_code_t alarm, void* context) {
  switch (alarm) {
    case ALARM_1201_NO_VAC_AREAS:
      // No space for runtime-mutable intent DOM - refuse job creation
      // This intent tree requires runtime mutation (not fully deterministic)
      log_alarm("1201: Intent DOM requires runtime mutation, no VAC areas available");
      refuse_job_creation(JOB_REFUSAL_RUNTIME_MUTABLE);
      break;
      
    case ALARM_1202_EXECUTIVE_OVERFLOW:
      // No CPU cycles for ANY task - critical system overload
      // Even fully deterministic intents cannot be admitted
      log_alarm("1202: Executive overflow, no cycles for any task");
      refuse_job_creation(JOB_REFUSAL_NO_CYCLES);
      prune_non_critical_jobs();
      break;
      
    case ALARM_1401_INTENT_DOM_CORRUPT:
      // Intent DOM structure corrupted - system integrity failure
      log_alarm("1401: Intent DOM corruption detected");
      initiate_dom_recovery();
      break;
      
    case ALARM_1402_THREE_TIER_INCONSISTENT:
      // Cache consistency violation - rebuild caches
      log_alarm("1402: Three-tier cache inconsistency");
      rebuild_cache_hierarchy();
      break;
  }
}

// Job creation with compilation analysis
typedef enum {
  INTENT_FULLY_DETERMINISTIC,  // Fully deterministic execution path (no runtime mutation)
  INTENT_RUNTIME_MUTABLE,      // Requires runtime tree mutation and resolve calls
  INTENT_MIXED_COMPILATION     // Some branches deterministic, others mutable
} intent_compilation_level_t;

job_admission_result_t attempt_job_creation(precept_ref_t root_precept) {
  // 1. Analyze intent tree compilation level
  intent_compilation_level_t compilation = analyze_intent_compilation(root_precept);
  
  // 2. Check system capacity based on compilation requirements
  if (compilation == INTENT_RUNTIME_MUTABLE) {
    if (!has_vac_areas_available()) {
      emit_alarm(ALARM_1201_NO_VAC_AREAS, root_precept);
      return JOB_ADMISSION_REFUSED_NO_VAC;
    }
  }
  
  // 3. Check basic CPU capacity (applies to all intent types)
  if (!has_executive_cycles_available()) {
    emit_alarm(ALARM_1202_EXECUTIVE_OVERFLOW, root_precept);
    return JOB_ADMISSION_REFUSED_NO_CYCLES;
  }
  
  // 4. Admit job with appropriate execution context
  return create_job_descriptor(root_precept, compilation);
}
```

---

## API Primitives

### **Modern Executive Interface**
```c
// Job management
job_id_t enqueue_precept(precept_ref_t precept, execution_context_t context);
bool yield_job(job_id_t job, yield_reason_t reason);
bool resume_job(job_id_t job, artifact_set_t new_artifacts);

// Dependency resolution (unified for instruments and capabilities)
provider_ref_t resolve_dependency(resolve_query_t query, capability_filter_t filter);
provider_ref_t resolve_instrument(instrument_name_t name, quality_spec_t quality);
provider_ref_t resolve_capability(capability_name_t cap, context_filter_t context);
provider_ref_t resolve_r_precept(precept_name_t name, parameter_bindings_t params);
bool register_singleton_provider(instrument_name_t name, provider_ref_t provider);
void promote_provider_cache(provider_ref_t provider, cache_tier_t target_tier);

// Emergency response
bool register_disrupt_handler(capability_filter_t emergency_type, d_precept_ref_t handler);
void emit_emergency_signal(disrupt_signal_t signal);

// System monitoring
executive_telemetry_t get_executive_stats();
alarm_log_t get_recent_alarms();
three_tier_stats_t get_cache_statistics();
```

---

## Safety and Operational Rules

### **Dependency Resolution Safety**
1. **Singleton enforcement**: Same dependency → same provider within execution scope
2. **Priority ordering**: Always search Priority 1 → 2 → 3, never skip levels
3. **Circular detection**: Detect and break dependency cycles with timeout + alarm
4. **Resource budgeting**: Track and limit repository query costs

### **Emergency Response Safety**
1. **Pre-validation requirement**: All D:Precept handlers must pass preflight validation
2. **Equipment readiness**: Emergency equipment validated before emergencies occur
3. **Preemption limits**: Emergency jobs can preempt, but must respect system integrity
4. **Recovery procedures**: Failed emergency response triggers system-level recovery

### **Cooperative Multitasking Safety**
1. **Yield point restriction**: Only yield at staging boundaries or dependency waits
2. **State vector integrity**: All yields must preserve simplified state vectors
3. **Resumption validation**: Validate execution context before resuming yielded jobs
4. **Timeout enforcement**: Jobs that don't yield cooperatively get forced preemption

---

## Integration with Current Architecture

This modern executive design integrates seamlessly with the current modular architecture:

- **Fundamentals**: Executes type-safe precepts with proper instrument dependencies
- **Dependency Resolution**: Implements the three-tier caching strategy directly
- **Capability System**: Routes R:Precept resolutions through repository queries  
- **Staging and Execution**: Uses staging boundaries as natural yield points
- **Preflight Validation**: Honors all three validation patterns during job admission
- **DISRUPT Handlers**: Provides fast path for pre-validated emergency responses

The executive serves as the **runtime substrate** that makes the universal cognitive architecture practical and performant while preserving the declarative nature of intent scaffolding.

---

**Status**: Modern architecture aligned with emergent singleton behavior, three-tier dependency resolution, and current preflight validation patterns. Ready for hardware integration through RALN compilation.