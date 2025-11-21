<!--
  Mechanical-specific precepts for fiber optic splicing example
  Domain tags include 'mechanical_splicing' for discoverability and filtering
-->

<IntentDOM root="MechanicalSplicingPrecepts">
  <Objective>Mechanical splicing method precepts and dependent precepts (mechanical_splicing domain)</Objective>

  <Precept name="MechanicalSpliceProcedure" providing="capability:mechanical_splice AND domain:fiber_optics AND domain:mechanical_splicing">
    <Description>Mechanical splicing: align fibers in precision sleeve/aligner, secure clamp, apply adhesive or index matching gel if required, trim excess, and protect splice.
    </Description>
    <Domains>
      <Domain ref="fiber_optics" />
      <Domain ref="mechanical_splicing" />
    </Domains>
    <RequiredInstrument instrumentName="chosen_splicing_impl" />
    <RequiredInstrument instrumentName="prepared_end_a" />
    <RequiredInstrument instrumentName="prepared_end_b" />
    <Action>Insert fibers into mechanical sleeve/aligner, close sleeve to mechanically align, apply adhesive or index-matching gel as required</Action>
    <YieldSafePoint name="adhesive_cure">
      <StateVector>
        <State key="adhesive_present" value="true" />
      </StateVector>
      <WaitCondition duration="120s" reason="Adhesive cure" />
      <ResumeCondition>
        <Check state="adhesive_cured" target="true" />
      </ResumeCondition>
    </YieldSafePoint>
    <Action>Trim excess fiber, apply protective sleeve or crimp per spec</Action>
    <Output>
      <Artifact name="spliced_fiber">
        <Type>turtle-0</Type>
        <Description>Fiber end A and B joined by mechanical splice</Description>
      </Artifact>
      <Artifact name="splice_protection_installed" />
    </Output>
  </Precept>

  <!-- Mechanical-specific inspection and adhesive application precepts -->
  <Precept name="MechanicalSpliceAlignerCheck" providing="capability:tool_validation AND domain:mechanical_splicing">
    <Domains>
      <Domain ref="mechanical_splicing" />
      <Domain ref="fiber_optics" />
    </Domains>
    <Action>Verify aligner pins, check sleeve for debris, inspect adhesives and gel expiration</Action>
    <Output>
      <Artifact name="mechanical_aligner_ok" />
    </Output>
  </Precept>

  <Precept name="ApplyCrimpOrProtectionForMechanicalSplice" providing="capability:splice_protection AND domain:mechanical_splicing">
    <Domains>
      <Domain ref="mechanical_splicing" />
      <Domain ref="fiber_optics" />
    </Domains>
    <RequiredInstrument instrumentName="spliced_fiber" />
    <Action>Install protective sleeve or crimp assembly according to spec</Action>
    <Output>
      <Artifact name="mechanical_splice_protected" />
    </Output>
  </Precept>

</IntentDOM>
