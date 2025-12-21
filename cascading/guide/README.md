# Intent Cascading: The Living Specification

This is the authoritative, living specification for Intent Cascading. This framework evolves through **molting**, not iteration — documentation outside this directory should be treated as legacy, the shed exoskeleton of earlier design phases.

---

## Structure

### [Truth Calculus](00_truth_calculus/)
The foundational mathematical framework. Defines truth as a scalar field, introduces metabolic chirality, and maps cognitive operations onto orbital mechanics. While developed after Intent Cascading, it provides the theoretical substrate that explains why the system works.

**Read this:** After Chapters 1-5 for formal grounding, or independently for cognitive systems theory.

### [Intent Cascading](01_intent%20cascading/)
The core Intent Cascading specification, presented sequentially:

- **[00 - Problem Description](01_intent%20cascading/01_00_problem_description_and_limitations.md)**: What Intent Cascading solves and its boundaries
- **[01 - Semantic Intent](01_intent%20cascading/01_01_semantic_intent.md)**: The philosophy of intent-first design
- **[02 - Precept Foundations](01_intent%20cascading/01_02_precept_foundations.md)**: The atomic unit of executable intent
- **[03 - RequiredInstrument](01_intent%20cascading/01_03_requiredinstrument.md)**: Dependency resolution without function calls
- **[04 - Variable & Address Space Model](01_intent%20cascading/01_04_variable_address_space_model.md)**: Why there are no variables (only global world model)
- **[05 - Domains, Capabilities, Procedural Generation](01_intent%20cascading/01_05_domains_capabilities_procedural_generation.md)**: Semantic binding and provider selection
- **[06 - Multi-Job Qualia Convergence](01_intent%20cascading/01_06_multi_job_qualia_convergence.md)**: R⁻/N⁺/TAC optimization across parallel jobs

### [Examples & Internal Representation](internal_representation_example.md)
Concrete implementation details showing how the global world model represents code artifacts (bitmap embeddings, role maps, reuse maps).

---

## Reading Paths

### For Implementers
1. Chapters 00-05 (sequential)
2. Chapter 06 for multi-job optimization
3. Truth Calculus as needed for mathematical rigor
4. Legacy docs in `/cascading/` for historical context

### For Theorists
1. Truth Calculus (complete volume)
2. Chapter 04 (Variable/Address Space Model)
3. Chapter 06 (Multi-Job Convergence) 
4. Appendix 2 in Truth Calculus (Orbital Mechanics)

### For Safety Engineers
1. Truth Calculus § Metabolic Chirality
2. Chapter 02 (Precepts)
3. Chapter 03 (RequiredInstrument)
4. Legacy `/cascading/disrupt_handlers.md`

---

## The Molting Process

Intent Cascading evolves by **molting**. Old specifications are not deleted — they remain as historical context in `/cascading/`. But the living, authoritative specification is here in `/guide/`.

When conflicts arise between guide and legacy documentation, **the guide takes precedence.**

---

## Contributing

New documentation should be added to `/guide/`. Use the existing chapter numbering for core specification work, or create new documents in appropriate subdirectories for specialized topics (hardware, integration, examples).

Follow the Φ⁺ principle: lead with concrete examples, then compose formal definitions from observed components.
