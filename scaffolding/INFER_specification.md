# INFER: Simulation-Based Precept Validation

**Purpose**: Mental model execution for uncertain RESOLVE results

---

## What INFER Does

INFER is the **simulation-based validation system** that executes precept trees against a world model when RESOLVE cannot confidently select the right precept path.

**Core Concept**: Run the same intent scaffolding execution, but with Turtle-0 terminating in a **predictive neural network world model** instead of physical hardware interfaces.

---

## When INFER Is Needed

INFER is invoked when RESOLVE returns uncertain results:

### **Low Confidence Results**
```
RESOLVE query: "capability:food_preparation AND domain:kitchen"
RESOLVE result: {
  candidates: [BasicCooking, AdvancedCuisine], 
  confidence: 0.4
}
→ Executive invokes INFER for validation
```

### **No Candidates Found**
```
RESOLVE query: "capability:exotic_repair AND domain:spacecraft"
RESOLVE result: {
  candidates: [], 
  confidence: 0.0
}
→ Executive invokes INFER with broader search
```

### **Multiple Equivalent Candidates**
```
RESOLVE query: "capability:data_analysis"
RESOLVE result: {
  candidates: [StatisticalAnalysis, MLAnalysis, HeuristicAnalysis],
  confidence: [0.33, 0.33, 0.34]
}
→ Executive invokes INFER to simulate outcomes
```

---

## How INFER Works

### **1. Broader Search Resolution**
- INFER has its own resolver with **broader aggregation** than normal RESOLVE
- Searches wider parameter spaces and considers more creative precept combinations
- Less constrained by optimization level limitations

### **2. Full Precept Tree Execution**
- Spawns complete precept trees for each candidate solution
- Executes the entire intent scaffolding system normally
- All dependency resolution, R:Precept instantiation, and staging phases proceed

### **3. World Model Termination**
- **Critical difference**: Turtle-0 operations connect to **world model simulation**
- Physical actions become **simulated actions** in the predictive neural network
- Same precept semantics, different reality substrate

### **4. Outcome Comparison**
- Multiple candidate trees execute in parallel simulations
- INFER compares simulated outcomes for success probability
- Returns validated precept recommendation to executive

---

## Mental Model Frame

INFER operates in the same **epistemic space** as ALARM 1204's model inversion:

- **Agent's world model** (how the agent believes reality works)
- **Simulation execution** (testing precept chains against that model)
- **Confidence assessment** (does this precept chain make sense in my world model?)

**Key Insight**: INFER uses the agent's own mental model to validate uncertain precept selections to prepare for real-world execution.

---

## World Model Interface

The world model is **outside the scope of this repository** - it's a separate universe requiring:
- Pretrained predictive neural networks
- Continuous learning from experience
- Physics simulation capabilities
- Semantic understanding of precept actions

**For this specification**: World model is treated as a **black box interface** that can:
- Accept precept actions as inputs
- Return believable state transitions
- Maintain simulation coherence across precept chains

---

## Integration with RESOLVE

### **RESOLVE First**
Normal execution always tries RESOLVE first:
- Fast cache lookups (Priority 1, 2, 3)
- LOC-based precept selection
- Confidence assessment

### **INFER Escalation**
Only when RESOLVE confidence is insufficient:
- Executive escalates to INFER
- Broader search and simulation validation
- Returns to normal execution with validated precept

### **No Competition**
RESOLVE and INFER are **complementary**, not competitive:
- RESOLVE: Fast, cached, confidence-based selection
- INFER: Slow, simulated, validation-based selection

---

## Example Flow

### **Uncertain Cooking Scenario**
```
1. Precept: "Make dinner for vegetarian guest"
2. RESOLVE query: "capability:vegetarian_cooking"
3. RESOLVE result: {
     candidates: [VeganCuisine, VegetarianAdaptation], 
     confidence: 0.5
   }
4. Executive → INFER escalation
5. INFER spawns both precept trees
6. VeganCuisine simulation: Guest satisfied, but misses dairy
7. VegetarianAdaptation simulation: Guest satisfied, uses cheese
8. INFER recommendation: VegetarianAdaptation (better outcome)
9. Executive proceeds with VegetarianAdaptation in physical reality
```

---

## Design Principles

### **Same Scaffolding System**
- INFER uses identical intent scaffolding execution
- Same precept syntax, dependencies, artifacts
- Only difference: simulation vs. physical termination

### **Mental Rehearsal**
- "Dream-state execution" for epistemic validation
- Test precept chains without physical consequences
- Validate complex precept genealogies before commitment

### **Bounded Exploration**
- INFER has resource budgets like normal execution
- Can timeout and return "inconclusive" result
- Broader search doesn't mean infinite search

### **Confidence Restoration**
- Primary goal: Convert uncertain RESOLVE → confident precept selection
- Secondary goal: Discover novel precept combinations through broader search
- Tertiary goal: Prevent expensive physical trial-and-error

---

## Relationship to ALARM 1204

INFER is **normal runtime strategy**, not fault recovery:
- Handles uncertainty the same way a pagefault handles memory access - expected operational behavior
- Uses agent's own world model for simulation validation
- May prevent some cases of model inversion overflow, but that's a side effect, not its purpose

**INFER vs. 1204 Recovery**: INFER is standard uncertainty handling; Inter-agent reconciliation protocol handles actual epistemic contradictions.

---

## Implementation Notes

### **Execution Integration**
- INFER uses the same **EXECUTE** system as normal precept execution
- Precepts neither know nor care what lies beyond Turtle-0 termination
- World model vs. physical hardware is transparent to precept execution

### **Agent Interface** 
- INFER overrides the **EXECUTE annunciator** on agent's blinkenlights panel
- Visual indication that execution is in simulation mode
- Operator can distinguish simulated vs. physical execution states

---

**Status**: Conceptual specification complete. World model implementation and INFER-RESOLVE integration APIs remain future work.