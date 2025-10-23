# X4 Agent Skill Context Map

This file formally declares the allowed agent skills for the `x4_ingame_mechanics` domain and provides a small MLP-inspired associative context map to help RESOLVE select or validate skills.

## Declaration
- Domain: `x4_ingame_mechanics`
- Agent skills allowed: `negotiation`, `espionage`

This file asserts: "Any x that is an agent skill in the domain `x4_ingame_mechanics` is either `negotiation` or `espionage`."

## Canonical statement (machine-friendly)
```xml
<ContextMap name="x4_agent_skills" domain="x4_ingame_mechanics">
  <AllowedValues slot="agent_skill">
    <Value>negotiation</Value>
    <Value>espionage</Value>
  </AllowedValues>
</ContextMap>
```

## MLP-inspired associative map (conceptual)
- Nodes: agent_skill, capability, instrument_production
- Associations (weights are illustrative):
  - espionage -> instrument_production (weight: 0.9)
  - negotiation -> instrument_production (weight: 0.2)
  - espionage -> capability:acquire_uncommon_item (weight: 0.8)
  - negotiation -> capability:acquire_common_item (weight: 0.7)

## Usage notes
- RESOLVE should consult this context map when evaluating `RequiredInstrument` agent skill qualifiers in the `x4_ingame_mechanics` domain.
- The MLP-inspired section is intentionally conceptual; implementers may convert associations and weights to their preferred format (e.g., JSON, ONNX model metadata, or a numeric similarity table).

*File created to remove ambiguity about agent skill values for X4 gameplay intents.*