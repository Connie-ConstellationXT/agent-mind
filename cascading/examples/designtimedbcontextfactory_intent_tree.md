# Intent Cascading Tree: DesignTimeDbContextFactory Name Placement

This is an illustrative, incomplete intent cascading tree for the process of writing a `DesignTimeDbContextFactory` in Entity Framework, focusing on the recursive, dynlinked, and ML-driven reasoning needed to remember where the DbContext name goes.

```xml
<IntentDOM root="WriteDesignTimeDbContextFactory">

  <Precept name="WriteDesignTimeDbContextFactory">
    <Description>Produce a correct DesignTimeDbContextFactory implementation for Entity Framework</Description>
    <Provides>
      <Capability name="ef_factory_generation" domain="dotnet_orm" />
    </Provides>
    <RequiredInstrument instrumentName="DbContextType" description="The name/type of the target DbContext" />
    <RequiredInstrument instrumentName="IDEState" description="Current code buffer and UI context" />

    <StagingPhase type="execution" name="factory_cascading">
      <Precept name="WhereDoesTheNameGo">
        <Description>Resolve the correct placeholder for the DbContext name in the factory</Description>
        <Provides>
          <Capability name="placeholder_resolution" domain="code_generation" />
        </Provides>
        <RequiredInstrument instrumentName="DbContextType" />
        <RequiredInstrument instrumentName="IDEState" />

        <!-- Dynlink: delegate to a precept that can answer this, possibly using ML/qualia -->
        <R:Precept name="InjectSimulatedQualia"
                  providing="capability:qualia_injection AND domain=mlp_pattern_recognition"
                  context="IDEState"
                  qualia="uncertainty_about_placeholder"
                  description="Inject simulated qualia into MLP to recognize the correct spot for the name" />

        <!-- Vigil: watches for the correct spot to appear in the UI/code buffer -->
        <Vigil name="SpotRecognitionVigil" frequency="every_500ms" during="factory_cascading">
          <Description>Monitor IDE/code buffer for the qualia/neuron firing that signals the correct placeholder</Description>
          <MLPTrigger model="placeholder_spot_detector"
                      symbol="dbcontext_name_placeholder"
                      confidence_threshold="0.85" />
          <Action>When neuron fires, reenter and bind DbContextType to the recognized spot</Action>
        </Vigil>

        <Output>
          <Artifact name="DbContextNamePlaced">
            <Type>code_location_binding</Type>
            <Description>DbContext name correctly placed in factory code</Description>
          </Artifact>
        </Output>
      </Precept>

      <!-- Continue with normal code generation using the resolved placeholder -->
      <Precept name="GenerateFactoryCode">
        <RequiredInstrument instrumentName="DbContextNamePlaced" />
        <Action>Emit class and method boilerplate</Action>
        <Action>Insert DbContextType at resolved placeholder</Action>
        <Output>
          <Artifact name="FactoryCodeGenerated">
            <Type>code_artifact</Type>
            <Description>Complete DesignTimeDbContextFactory code</Description>
          </Artifact>
        </Output>
      </Precept>
    </StagingPhase>
  </Precept>

</IntentDOM>
```

---

## Key Features Illustrated

- **Dynlinking**: `WhereDoesTheNameGo` doesn't know the answer statically; it dynlinks to a precept that can inject qualia and use ML to resolve the spot.
- **Simulated Qualia**: The qualia of "uncertainty about placeholder" is injected into the MLP, which can then recognize the correct spot when it appears.
- **MLP Output Neuron**: The vigil watches for the output neuron to fire, indicating the correct location for the DbContext name.
- **Vigil Reentry**: When the neuron fires, the vigil reenters the intent, binding the name to the recognized spot and continuing code generation.
- **Embodied, Interactive Reasoning**: The process is not static; it is interactive, context-sensitive, and can retry or adapt as new evidence appears in the IDE or code buffer.

This tree is incomplete but captures the recursive, event-driven, and ML-integrated nature of intent cascading for real-world programming tasks.
