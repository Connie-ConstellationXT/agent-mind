<!--
  Fusion-specific precepts for fiber optic splicing example
  Domain tags include 'fusion_splicing' for discoverability and filtering
-->

<IntentDOM root="FusionSplicingPrecepts">
  <Objective>Fusion splicing method precepts and dependent precepts (fusion_splicing domain)</Objective>

  <Precept name="FusionSpliceProcedure" providing="capability:fusion_splice AND domain:fiber_optics AND domain:fusion_splicing">
    <Description>Fusion splicing: mount prepared fiber ends, align, perform arc fusion, inspect, and protect splice.
    </Description>
    <Domains>
      <Domain ref="fiber_optics" />
      <Domain ref="fusion_splicing" />
    </Domains>
    <RequiredInstrument instrumentName="chosen_splicing_impl" />
    <RequiredInstrument instrumentName="prepared_end_a" />
    <RequiredInstrument instrumentName="prepared_end_b" />
    <Action>Mount fibers in fusion splicer; perform arc fusion according to machine profile</Action>
    <YieldSafePoint name="fusion_arc_cycle">
      <StateVector>
        <State key="splicer_cycle_in_progress" value="true" />
        <State key="arc_count" value="1" />
      </StateVector>
      <WaitCondition duration="10s" reason="Arc fusion cycle" />
      <ResumeCondition>
        <Check state="splice_temperature" target="cooled" />
      </ResumeCondition>
    </YieldSafePoint>
    <Action>Inspect splice with microscope/cameras and apply heat-shrink protection sleeve per spec</Action>
    <Output>
      <Artifact name="spliced_fiber">
        <Type>turtle-0</Type>
        <Description>Fiber end A and B fused into single optical path</Description>
      </Artifact>
      <Artifact name="splice_protection_installed" />
    </Output>
  </Precept>

  <!-- Tool health and maintenance precepts specific to fusion splicer -->
  <Precept name="FusionSplicerHealthCheck" providing="capability:tool_validation AND domain:fusion_splicing">
    <Domains>
      <Domain ref="fusion_splicing" />
      <Domain ref="fiber_optics" />
    </Domains>
    <Action>Verify electrode condition, perform calibration, verify cooling fan and heater elements</Action>
    <Output>
      <Artifact name="fusion_splicer_ok" />
    </Output>
  </Precept>

  <Precept name="ApplyHeatShrinkToFusionSplice" providing="capability:splice_protection AND domain:fusion_splicing">
    <Domains>
      <Domain ref="fusion_splicing" />
      <Domain ref="fiber_optics" />
    </Domains>
    <RequiredInstrument instrumentName="spliced_fiber" />
    <Action>Install and shrink protection sleeve per manufacturer spec</Action>
    <Output>
      <Artifact name="fusion_splice_protected" />
    </Output>
  </Precept>

</IntentDOM>
