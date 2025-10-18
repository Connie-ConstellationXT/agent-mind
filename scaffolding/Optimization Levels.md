# Optimization Levels in Intent Scaffolding

Optimization levels in intent scaffolding represent the **executive's computational elegance budget**—how much complexity the system is willing to spend on building sophisticated precept genealogies. The model is inspired by a gearbox: each level (1 through 5, plus GE) is a "gear" that controls precept selection strategy and stack composition elegance.

**Critical Design Principle**: Optimization levels are **executive strategy**, not precept behavior. Precepts themselves are optimization-level agnostic—they simply declare capabilities and STALL when they cannot continue. The executive manages optimization through **precept selection heuristics** and **genealogy complexity budgeting**.

## Gearbox Analogy: Clutch Protection vs. Performance

- **Higher gears enable elegant cruising** when you have momentum and established context
- **Starting in high gear burns out the clutch** - attempting complex solutions without foundational work causes STALL
- **STALL in E5 = clutch failure**, not redlining - inappropriate gear selection for current task momentum
- **Proper gear progression** builds momentum through lower gears before enabling high-performance operation

---


## Executive Optimization Strategy by Level

- **Level 1:** **Foundation Building** - Executive selects simplest precepts (lowest LOC), prioritizes basic functionality over elegance. Suitable for starting new tasks or uncertain contexts. Minimal clutch load.

- **Level 2:** **Building Momentum** - Executive begins selecting slightly more sophisticated precepts while maintaining stability bias. Allows some genealogy depth but prefers proven patterns.

- **Level 3:** **Balanced Selection** - Executive actively pursues more elegant precept combinations, building deeper genealogies when beneficial. Balance between sophistication and reliability.

- **Level 4:** **Sophisticated Cruising** - Executive selects complex, feature-rich precepts for well-understood domains. Builds deep genealogies with advanced capabilities. Requires established momentum.

- **Level 5:** **Elegant Cruising** - Executive selects the most sophisticated available precepts, building maximally elegant genealogies. Only appropriate when full context and momentum are established. High clutch protection sensitivity.

- **GE (Gamma Entrainment):** **Creative Restructuring** - Special mode for insight-driven precept composition. Attempts novel genealogy patterns and semantic scaffold restructuring. Not sequential with other levels.

## Precept Selection Heuristics

The executive uses **Lines of Code (LOC)** as the primary heuristic for optimization-appropriate precept selection:

- **Lower optimization levels** → Select precepts with **larger LOC** (more thorough genealogies — prefer coverage over speed)
- **Higher optimization levels** → Select precepts with **smaller LOC** (concise, corner-cutting precepts optimized for speed)
- **Multiple candidates** → LOC serves as tiebreaker based on current optimization level
- **STALL recovery** → Executive downgrades optimization level and re-selects simpler precepts



## A/B Level
- **A/B:** A distinct optimization level where the system runs in autonomous background mode. Tasks at this level are managed with minimal active attention, using spare resources and deferring to higher-priority processes. 

---

## Clutch Protection and Executive Function Regulation

Optimization levels provide **executive function regulation** through computational elegance budgeting:

- **Prevents premature complexity** - Starting in high gear burns out the clutch (causes STALL)
- **Forces momentum building** - System must progress through lower gears to establish context
- **Natural downshift recovery** - STALL triggers optimization downgrade and simpler precept selection
- **Adaptive complexity management** - Executive learns optimal gear selection patterns for different contexts

The system serves as a **cognitive clutch protection mechanism**, preventing overoptimization by enforcing appropriate precept selection based on current task momentum and established context.

## Integration with Executive Runtime

Optimization levels are stored in the **Job Descriptor** as executive state, never in precept declarations:

```c
typedef struct {
  // ... other fields ...
  optimization_level_t current_optimization; // E1-E5, GE - executive's current gear
} modern_job_descriptor_t;
```

The executive manages optimization through:
1. **Precept selection strategy** based on LOC heuristics
2. **Genealogy complexity budgeting** for stack composition  
3. **Automatic downshift** on STALL recovery
4. **Learning from cache state** to improve selection patterns
