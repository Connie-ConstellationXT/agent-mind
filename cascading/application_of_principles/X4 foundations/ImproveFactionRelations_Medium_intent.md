# IntentDOM: Improve Faction Relations (Medium)

```xml
<IntentDOM root="ImproveFactionRelations_Medium">
  <Precept name="ImproveFactionRelations_Medium">
    <Description>Negotiate to improve faction relations by a medium amount</Description>
    <RequiredInstrument instrumentName="agent" level="novice" skill="negotiation" />
    <RequiredInstrument instrumentName="intelligence_network" influenceLevel="low_to_medium" />
    <RequiredInstrument instrumentName="credits" quantity="150000" />
    <RequiredInstrument type="ingame item" instrumentName="spacefly_caviar" quantity="1" />
    <Output>
      <Artifact name="faction_relations_improved" magnitude="medium" />
    </Output>
  </Precept>
</IntentDOM>
```

*Standalone intent for diplomatic improvement.*
