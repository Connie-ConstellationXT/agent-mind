# RALN Acceptance Criteria — Active Condition Monitoring and Signaling

Acceptance criteria enable RALNs to implement condition monitoring and signaling behaviors—not just waiting for conditions to be met, but actively communicating status to neighbors, especially ancestors. This document details how condition monitoring is implemented using only the three fundamental building blocks (RALN, JUNCTION, MLP_CLUSTER) plus edge-owned latches.

---

##  The condition monitoring problem

Traditional sequential systems use explicit state machines or conditional branches to implement "wait until ready" behaviors. In a RALN fabric, we need:

- **Active condition monitoring**: Continuously evaluate criteria and signal status changes
- **Neighbor notification**: Inform connected components, especially ancestors, about condition states
- **Conditional advancement**: Don't proceed to the next phase until acceptance criteria are satisfied
- **Parallel evaluation**: Multiple criteria can be evaluated simultaneously
- **Hysteresis**: Avoid chattering at decision thresholds
- **No architectural changes**: Achieve staging using existing component types

The solution: **acceptance criteria live in domain constraints, are evaluated by downstream MLP arrays, and actively signal condition states to neighbors through standard message envelopes**.

---

## The acceptance pattern (detailed)

### Basic topology with neighbor signaling

**Component roles:**
- `RALN[0]`: Owns the current phase, makes staging decisions, signals neighbors
- `MLP[1..m]`: Array of criterion evaluators (one per acceptance condition)
- `RALN[1]`: Aggregates criterion scores and actively signals condition status
- `RALN[2]`: Next phase (dormant until latch opens)
- `RALN[ancestor]`: Receives condition status notifications

### Message flow sequence with active signaling

1. **Criterion broadcast**: `RALN[0]` sends `STATE_DELTA + ACCEPTANCE_QUERY` to MLP array
2. **Parallel evaluation**: Each `MLP[i]` evaluates its specific criterion independently
3. **Score collection**: MLPs return `ACCEPTANCE_VECTOR` scores `{p_i}` to aggregator `RALN[1]`
4. **Readiness computation**: `RALN[1]` reduces scores to scalar readiness `A` plus reasons `R`
5. **Local feedback**: `RALN[1]` sends `SUMMARY(A,R)` back to `RALN[0]`
6. **Neighbor notification**: `RALN[1]` sends condition status to ancestors and peers:
   - `HOLD(reasons)` when criteria not met
   - `PROCEED` when criteria satisfied
   - `FAULT(details)` when criteria evaluation fails
7. **Latch control**: `RALN[0]` uses domain constraints + `A` to control downstream latch



## MLP criterion evaluators

Each MLP in the acceptance array specializes in one type of criterion evaluation:

### Example: Code generation acceptance criteria

```
MLP_SYNTAX_VALID {
  criterion: "generated code is syntactically correct"
  input: current_program_state
  output: validity_score ∈ [0,1]
  
  learned_patterns: {
    balanced_brackets,
    proper_indentation,
    valid_keywords,
    string_termination
  }
}

MLP_COMPLETENESS_CHECK {
  criterion: "program satisfies target specification"
  input: {current_program, target_spec}
  output: completeness_score ∈ [0,1]
  
  learned_patterns: {
    required_functions_present,
    expected_output_capability,
    target_behavior_match
  }
}

MLP_STYLE_CONFORMANCE {
  criterion: "code follows style guidelines"
  input: current_program_state
  output: style_score ∈ [0,1]
  
  learned_patterns: {
    naming_conventions,
    comment_density,
    line_length_limits,
    formatting_consistency
  }
}
```

### Criterion specialization benefits

- **Independent evaluation**: Each MLP can be trained/updated separately
- **Composable criteria**: Mix and match criterion types for different contexts
- **Parallel processing**: All criteria evaluated simultaneously
- **Explainable decisions**: Each MLP provides specific reason for its score

---

##  Aggregation and readiness computation

The aggregator `RALN[1]` combines criterion scores using domain-specific logic:

### Weighted combination
```
A = Σ(w_i × p_i) where Σ(w_i) = 1
```

### Minimum threshold (all criteria must pass)
```
A = min(p_1, p_2, ..., p_m)
```

### Adaptive weighting (context-dependent)
```
A = f(context) × weighted_combination(p_i)
```

### Reason vector construction
```
R = {
  overall_readiness: A,
  criterion_scores: {p_1, p_2, ..., p_m},
  blocking_factors: {i | p_i < threshold_i},
  confidence: variance_measure(p_i)
}
```

---
## Why this pattern works

**No new node types**: Uses only RALN/JUNCTION/MLP_CLUSTER + edge latches
**Active communication**: RALNs signal condition status to neighbors, not just local waiting
**Composable criteria**: Mix and match MLPs for different staging needs
**Parallel evaluation**: All criteria assessed simultaneously
**Explainable signaling**: Clear reasons when conditions are not met, with actionable requests
**Hysteresis stability**: Prevents chattering at decision boundaries
**Neighbor coordination**: Enables distributed problem-solving when conditions block
**Executive controlled**: All topology pre-compiled, no runtime rewiring

The acceptance criteria pattern transforms the inherently passive concept of "wait until ready" into an active, communicative system where RALNs coordinate with their neighbors to resolve blocking conditions and maintain distributed awareness of system state.