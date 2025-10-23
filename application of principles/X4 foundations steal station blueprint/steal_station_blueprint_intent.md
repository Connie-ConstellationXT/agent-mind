# IntentDOM: Steal Station Blueprint (X4 Foundations)


```xml
<IntentDOM root="StealStationBlueprint_X4">
  <Precept name="StealStationBlueprint">
    <Description>Send agent to steal a station blueprint in X4 Foundations</Description>
    <RequiredInstrument instrumentName="agent" level="experienced" skill="espionage" />
    <RequiredInstrument instrumentName="intelligence_network" influenceLevel="medium_to_high" />
    <RequiredInstrument instrumentName="credits" quantity="350000" />
    <RequiredInstrument type="ingame item" instrumentName="security_slicer" quantity="5" />
  </Precept>

  <Precept name="CraftSecuritySlicer">
    <Description>Craft a security slicer for use in espionage operations</Description>
    <RequiredInstrument instrumentName="crafting_bench" />
    <RequiredInstrument instrumentName="AGI_processor" quantity="1" />
    <RequiredInstrument instrumentName="decryption_module" quantity="1" />
    <RequiredInstrument instrumentName="interface_unit" quantity="1" />
    <Output>
      <Artifact name="security_slicer" />
    </Output>
  </Precept>

  <Precept name="AcquireCommonItem for Security slicer Components">
    <Description>Acquire either a decryption module or interface unit via a common item mission</Description>
    <RequiredInstrument instrumentName="mission_type" value="acquire_common_item" />
    <RequiredInstrument instrumentName="agent" level="competent" skill="espionage" />
    <RequiredInstrument instrumentName="credits" quantity="14000" />
    <RequiredInstrument instrumentName="intelligence_network" influenceLevel="low" />
    <RequiredInstrument instrumentName="selection" options="decryption_module,interface_unit" />
    <Output>
      <ExclusiveAny>
        <Artifact name="decryption_module" />
        <Artifact name="interface_unit" />
      </ExclusiveAny>
    </Output>
  </Precept>

    <Precept name="AcquireUncommonItem_AGIProcessor">
      <Description>Acquire an uncommon AGI processor via an uncommon item mission</Description>
      <RequiredInstrument instrumentName="mission_type" value="acquire_uncommon_item" />
      <RequiredInstrument instrumentName="agent" level="proficient" skill="espionage" />
      <RequiredInstrument instrumentName="intelligence_network" influenceLevel="low_to_medium" />
      <RequiredInstrument instrumentName="credits" quantity="" />
      <Output>
        <Artifact name="AGI_processor" />
      </Output>
    </Precept>
</IntentDOM>
```

*This file is the starting point for building a full intent tree for the action: send agent to steal a station blueprint in X4 Foundations, using canonical intent cascading syntax.*
