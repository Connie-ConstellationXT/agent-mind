<!--
  Intent Cascading Example: Fiber Optic Cable Splicing
  - Demonstrates two primary industrial methods: fusion splicing and mechanical splicing
  - Includes preflight validation, staging phases, yield-safe points, vigils, and DISRUPT handlers
  - Author: Copilot-style generated example for repository demonstration
-->

<IntentDOM root="SpliceFiberOpticCable">
  <Objective>Splice two fiber optic cable ends using an industry-standard method preserving performance and safety</Objective>

  <Precept name="SpliceFiberOpticCable">
    <Description>High-level intent to join two fiber optic cables using either fusion or mechanical splicing. Validate, prepare, splice, protect, and test the splice.</Description>
    <Provides>
      <Capability name="fiber_splicing" domain="telecom" />
      <Capability name="fiber_testing" domain="telecom" />
    </Provides>
    <Domains>
      <Domain ref="telecom" />
      <Domain ref="fiber_optics" />
      <Domain ref="industrial_safety" />
    </Domains>

    <!-- Input instruments: two fiber ends and a chosen splicing preference (fusion|mechanical) -->
    <RequiredInstrument instrumentName="fiber_end_a" alias="end_a" />
    <RequiredInstrument instrumentName="fiber_end_b" alias="end_b" />
    <RequiredInstrument instrumentName="splicing_method" alias="selected_method" description="Preferred method: fusion|mechanical" />
    <RequiredInstrument instrumentName="splicing_tool" alias="host_tool" />

    <Constraint type="safety">Wear optical safety goggles, avoid direct eye exposure to fiber-coupled lasers, observe ESD precautions</Constraint>

    <!-- Preflight phase: verify tools, safety kit, and testing equipment are present and functional -->
    <StagingPhase type="preflight" name="preflight_validation">
      <PreflightValidation>
        <R:Precept name="ValidateSplicingTools" providing="capability:tool_validation AND domain:fiber_optics" instrument="host_tool" description="Check fusion splicer or mechanical splicer readiness" />
        <R:Precept name="ValidateFiberCleanerKit" providing="capability:cleaning_validation AND domain:fiber_optics" instrument="fiber_cleaning_kit" description="Confirm cleaning swabs, alcohol, and lint-free wipes are available" />
        <R:Precept name="ValidateOTDR" providing="capability:otdr_validation AND domain:fiber_optics" instrument="otdr" onStall="fallback:VerifyPowerMeter" description="Confirm OTDR availability; fall back to power meter if absent" />
        <R:Precept name="ValidateSafetyKit" providing="capability:safety_validation AND domain:industrial_safety" instrument="safety_kit" description="Confirm eye protection, first aid, and ESD measures" />
      </PreflightValidation>
      <Output>
        <Artifact name="preflight_ok">
          <Type>validation_data</Type>
          <Description>Preflight verification data for tools, safety, and testing equipment</Description>
        </Artifact>
      </Output>
    </StagingPhase>

    <!-- Preparation: stripping, cleaning, inspection, and environment readiness -->
    <StagingPhase type="execution" name="preparation">
      <Precept name="PrepareEnvironment">
        <Provides>
          <Capability name="clean_workspace" domain="fiber_optics" />
        </Provides>
        <Action>Clear and lint-free workspace, set splicing tool on stable surface, enable fume extraction if adhesives used</Action>
        <Output>
          <Artifact name="workspace_ready">
            <Type>state_vector</Type>
            <Description>Workspace prepared for safe splicing</Description>
          </Artifact>
        </Output>
      </Precept>

      <Precept name="PrepareFiberEnds">
        <Provides>
          <Capability name="fiber_preparation" domain="fiber_optics" />
        </Provides>
        <RequiredInstrument instrumentName="end_a" />
        <RequiredInstrument instrumentName="end_b" />
        <Action>Strip, clean, and cleave fibre ends to industry tolerances for selected fiber type (single-mode/multimode)</Action>
        <Output>
          <Artifact name="prepared_end_a" />
          <Artifact name="prepared_end_b" />
        </Output>
      </Precept>

      <Precept name="InspectFiberEnds">
        <Provides>
          <Capability name="fiber_end_inspection" domain="fiber_optics" />
        </Provides>
        <RequiredInstrument instrumentName="prepared_end_a" />
        <RequiredInstrument instrumentName="prepared_end_b" />
        <Action>Inspect cleave quality with microscope; reject and re-cleave if defects exceed acceptance criteria</Action>
        <Output>
          <Artifact name="ends_inspected" />
        </Output>
      </Precept>

      <Output>
        <Artifact name="preparation_complete">
          <Type>state_vector</Type>
          <Description>All required preparation steps completed and verified</Description>
        </Artifact>
      </Output>
    </StagingPhase>

    <!-- Execution: splice via either fusion or mechanical path, chosen dynamically via RESOLVE -->
    <StagingPhase type="execution" name="splicing">
      <RequiredInstrument instrumentName="preparation_complete" />

      <!-- Dynamic resolution chooses the correct method implementation -->
      <R:Precept name="SelectSplicingMethod"
                providing="capability:splicing_method_resolution AND domain:fiber_optics"
                selected_method="selected_method"
                allocateOutput="chosen_splicing_impl as chosen_splicing_impl"
                onStall="fail"
                description="Resolve implementation for the selected splicing method (fusion or mechanical)">
        <Fallback>
          <R:Precept name="ResolveFusionSpliceImplementation"
                    providing="capability:fusion_splice AND domain:fiber_optics AND domain:fusion_splicing"
                    allocateOutput="chosen_splicing_impl as chosen_splicing_impl"
                    description="Resolve fusion splicer implementation" />
          <R:Precept name="ResolveMechanicalSpliceImplementation"
                    providing="capability:mechanical_splice AND domain:fiber_optics AND domain:mechanical_splicing"
                    allocateOutput="chosen_splicing_impl as chosen_splicing_impl"
                    description="Resolve mechanical splicer implementation" />
        </Fallback>
      </R:Precept>

      <!-- The chosen implementation must publish outputs conforming to 'spliced_fiber' -->
      <SyncPoint name="ReadyToSplice">
        <WaitForPrecept ref="InspectFiberEnds" />
      </SyncPoint>

      <!-- Method-specific implementations are defined in separate example files for clarity:
           - fusion splicing precepts: cascading/examples/fiber_optic_splicing_fusion.md
           - mechanical splicing precepts: cascading/examples/fiber_optic_splicing_mechanical.md
           The runtime should RESOLVE implementations by capability and domain filters.
      -->

      <!-- The R:Precept resolver can choose the appropriate precept from the repository based on the selected method and domain tags. -->

      <Vigil name="MonitorSpliceEnvironment" frequency="every_30s" during="splicing">
        <Description>Check splicer health, tool temperature, and fume extractor status while splicing</Description>
        <Action>Check splicer temperature and audible alarms; if abnormal, report a stall</Action>
        <Condition>Only if tool health metrics available</Condition>
      </Vigil>
    </StagingPhase>

    <!-- Post-splice testing and verification -->
    <StagingPhase type="execution" name="verification">
      <RequiredInstrument instrumentName="spliced_fiber" />
      <Precept name="TestSplice">
        <Provides>
          <Capability name="splice_test" domain="fiber_optics" />
        </Provides>
        <RequiredInstrument instrumentName="otdr" onStall="fallback:UsePowerMeter" />
        <Action>Run OTDR or power-meter measurements; verify insertion loss and reflectance against acceptance criteria for the fiber type</Action>
        <Output>
          <Artifact name="splice_test_result">
            <Type>validation_data</Type>
            <Description>OTDR/power-meter results and pass/fail judgement</Description>
          </Artifact>
        </Output>
      </Precept>

      <SyncPoint name="SpliceCompleted">
        <WaitForPrecept ref="TestSplice" output="splice_test_result" />
        <Action>Decide on pass/fail: if failed, create remediation precept branch (re-cleave, re-splice, or cancel)</Action>
      </SyncPoint>

      <Precept name="MarkAndDocumentSplice">
        <Provides>
          <Capability name="documentation" domain="telecom" />
        </Provides>
        <RequiredInstrument instrumentName="splice_test_result" />
        <Action>Label splice location, update record in repository with OTDR trace and test logs</Action>
        <Output>
          <Artifact name="splice_recorded">
            <Type>artifact</Type>
            <Description>Splice metadata and test traces recorded</Description>
          </Artifact>
        </Output>
      </Precept>
    </StagingPhase>

    <!-- Output: a validated, recorded splice or an instruction to remediate -->
    <Output>
      <Artifact name="splice_result">
        <Type>instrument</Type>
        <Description>Final pass/fail status and associated test artifacts</Description>
      </Artifact>
    </Output>

    <!-- DISRUPT/Emergency handlers -->
    <D:Precept name="HandleLaserExposure" description="Immediate first-aid for accidental laser exposure to eyes or skin">
      <Provides>
        <Capability name="emergency_response" domain="industrial_safety" />
      </Provides>
      <PreflightValidation>
        <R:Precept name="ValidateLaserSafetyKit" providing="capability:laser_safety_validation AND domain:industrial_safety" instrument="safety_kit" />
      </PreflightValidation>
      <RequiredInstrument instrumentName="safety_kit" preflight="true" />
      <Action>Stop laser, secure eye exposure, apply first-aid per training, escalate to medical if needed</Action>
      <Output>
        <Artifact name="laser_incident_logged">
          <Type>stopcode</Type>
          <Description>Incident recorded and mitigated</Description>
        </Artifact>
      </Output>
    </D:Precept>

    <D:Precept name="HandleToolFailure" description="Emergency response for tool errors (splicer fault, power loss)">
      <Provides>
        <Capability name="emergency_response" domain="fiber_optics" />
      </Provides>
      <Action>Halt current cycle, remove fibers safely, and call backup tool provider via RESOLVE</Action>
      <R:Precept name="FindBackupTool" providing="capability:tool_provision AND domain:fiber_optics" allocateOutput="backup_tool as backup_tool" onStall="fail" />
    </D:Precept>

    <Notes>
      <Note>Method-specific precepts and implementations are split into separate example files for readability:
        <Source>cascading/examples/fiber_optic_splicing_fusion.md</Source>
        <Source>cascading/examples/fiber_optic_splicing_mechanical.md</Source>
      </Note>
    </Notes>

  </Precept>
</IntentDOM>
