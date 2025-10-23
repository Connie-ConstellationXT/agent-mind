# IntentDOM: Craft Spacefly Caviar

```xml
<IntentDOM root="CraftSpaceflyCaviar">
  <Precept name="CraftSpaceflyCaviar">
    <Description>Craft spacefly caviar used for high-end diplomatic gifts</Description>
    <RequiredInstrument instrumentName="crafting_bench" />
    <RequiredInstrument instrumentName="rare_spices" quantity="5" />
    <RequiredInstrument instrumentName="spacefly_eggs" quantity="25" />
    <Output>
      <Artifact name="spacefly_caviar" quantity="1" />
    </Output>
  </Precept>

  <Precept name="AcquireCommonItem_RareSpices">
    <Description>Acquire rare spices via a common item mission (spy action)</Description>
    <RequiredInstrument instrumentName="mission_type" value="acquire_common_item" />
    <RequiredInstrument instrumentName="agent" level="competent" skill="espionage" />
    <RequiredInstrument instrumentName="credits" quantity="14000" />
    <RequiredInstrument instrumentName="intelligence_network" influenceLevel="low" />
    <Output>
      <Artifact name="rare_spices" quantity="2..5" randomized ="true" />
    </Output>
  </Precept>

  <Precept name="AcquireUncommonItem_SpaceflyEggs">
    <Description>Acquire spacefly eggs via an uncommon item mission (spy action)</Description>
    <RequiredInstrument instrumentName="mission_type" value="acquire_uncommon_item" />
    <RequiredInstrument instrumentName="agent" level="proficient" skill="espionage" />
    <RequiredInstrument instrumentName="intelligence_network" influenceLevel="low_to_medium" />
    <RequiredInstrument instrumentName="credits" quantity="11000" />
    <Output>
      <Artifact name="spacefly_eggs" quantity="1..3" randomized ="true" />
    </Output>
  </Precept>
</IntentDOM>
```

*Produces 1x spacefly_caviar.*
