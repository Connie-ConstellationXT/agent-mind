# Chapter 5: Domains, Capabilities, and Procedural Generation

## The Setup

A domain is a **composable, recursive mathematical object**—defined via set theory operations and potentially lambda calculus. Each domain is a separate **manifold** with its own procedural rules. When you activate multiple domains, you compose manifolds; they don't collapse to a single point.

---

## What is a Domain?

Domains are defined recursively via set operations:
```
Domain1 ∩ Domain2       // Intersection: both active
Domain1 ∪ Domain2       // Union: either active
Domain1 \ Domain2       // Difference: Domain1 but not Domain2
λ(context) . Domain(context)  // Lambda abstraction
∀ x ∈ set . Domain(x)   // Quantification
```

### Complex Domain Definition (XML Child Syntax)

```xml
<Domain name="CodeGenerationStrategy">
  <Description>Procedurally generated code for a specific project context</Description>
  
  <Intersection>
    <Domain name="base_generation_rules">
      <Intersection>
        <Domain name="code_generation" />
        <Domain name="csharp_syntax" />
      </Intersection>
    </Domain>
    
    <Union>
      <Domain name="framework_specific">
        <Union>
          <Intersection>
            <Domain name="entity_framework_v8" />
            <Domain name="dotnet_orm" />
          </Intersection>
          
          <Intersection>
            <Domain name="entity_framework_v7" />
            <Domain name="dotnet_orm" />
          </Intersection>
        </Union>
      </Domain>
      
      <Domain name="nhibernate_strategy">
        <Intersection>
          <Domain name="nhibernate" />
          <Domain name="dotnet_orm" />
        </Intersection>
      </Domain>
    </Union>
    
    <Lambda param="project">
      <Body>
        <Intersection>
          <Domain name="type_inference" />
          <DomainRef expr="runtime_context_for(project.DbContextType)" />
        </Intersection>
      </Body>
    </Lambda>
  </Intersection>
  
  <Exclusion>
    <Domain name="legacy_patterns" />
    <Domain name="deprecated_apis" />
  </Exclusion>
</Domain>
```

This domain reads: **(base_generation_rules) ∩ (framework_specific ∪ nhibernate_strategy) ∩ λ(project).[type_inference ∩ runtime_context_for(project.DbContextType)] \ (legacy_patterns ∪ deprecated_apis)**

---

## Domain Manifolds Are Separate, Not Points

Domains are **separate manifolds**, not coordinates on one bitmap.

Example: generating DesignTimeDbContextFactory involves multiple active domains:
- `code_generation`: where/how to place code (bitmap structure)
- `csharp_syntax`: what syntax is valid (grammar constraints)
- `type_inference`: binding `APPLICATION_DBCONTEXT_NAME` → `ApplicationDbContext`
- `entity_framework_v8`: EF-specific APIs and patterns
- `runtime_context_ApplicationDbContext`: project-specific metadata

Each manifold unfolds independently. A bitmap pixel at `[5, 2]` represents different things in different manifolds:
- In `code_generation`: a placeholder location
- In `type_inference`: an unresolved type reference
- In `entity_framework_v8`: part of DbContextOptionsBuilder sequence

Cross-manifold references are coordinated through the global world model via pointer pairs and RequiredInstruments.

---

## What is a Capability?

A capability declares procedural competence within a domain:

```xml
<Precept name="GenerateDesignTimeDbContextFactory">
  <Provides>
    <Capability name="factory_code_generation"
                 domain="dotnet_orm ∩ csharp_syntax ∩ code_generation ∩ entity_framework_v8"
                 confidence="0.92" />
  </Provides>
  <RequiredInstrument instrumentName="DbContextType" />
  <Output>
    <Artifact name="FactoryClassCode" />
  </Output>
</Precept>
```

The domain specifies the **manifold context** in which the precept operates. It's not a filter; it's the intersection of manifolds where this precept is competent.

---

## Procedural Generation via Domain Unfolding

When a resolver "zooms into" a pixel, it activates domain-specific procedural rules.

**Coarse resolution**: bitmap is a seed, active domains: `{code_generation}`

**Medium resolution**: manifolds activate, domains: `{code_generation, csharp_syntax, type_inference}`

**Fine resolution**: full intersection active, domains: `{code_generation, csharp_syntax, entity_framework_v8, type_inference, runtime_context_ApplicationDbContext}`

At fine resolution, multiple manifold resolvers fire simultaneously, each producing outputs in their manifold space. The world model synchronizes them via pointer pairs. Final code emerges as composition of all manifold outputs.

---

## Resolver Activation

Resolvers register for specific domain expressions:

```python
class PlaceholderResolver:
    activation_domain = code_generation AND type_inference AND (entity_framework_v8 OR entity_framework_v7)
    
    def activate(self, domain_context):
        if self.domain_satisfied(domain_context):
            return self.resolve_placeholders(domain_context)
```

**RESOLVE** finds the right resolver:
1. Evaluate active domain expression
2. Query all registered resolvers matching that expression
3. Rank by confidence
4. Activate highest-ranked resolver
5. Record binding in world model with provenance

---

## Summary

- Domains are composable, recursive objects (set operations, lambda, quantification)
- Each domain is a separate manifold with its own procedural rules
- Capabilities declare competence within domain expressions
- Procedural generation unfolds as domain expressions evaluate and manifolds compose
- Resolvers activate based on domain expressions
- Cross-manifold coordination: global world model via pointer pairs

