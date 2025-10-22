# Emergency Kit Validation

This example demonstrates comprehensive emergency kit validation with branching logic, multiple validation steps, and detailed acceptance criteria.

```xml
<!-- Emergency Kit Validation - Comprehensive Safety Preparedness Precept -->
<IntentDOM root="ValidateEmergencyKit">
  <Precept name="ValidateEmergencyKit">
    <Description>Multi-step validation of kitchen emergency kit with branching logic</Description>
    <Domains>
      <Domain ref="kitchen_safety" />
      <Domain ref="emergency_preparedness" />
      <Domain ref="first_aid" />
    </Domains>
    
    <Provides>
      <Capability name="emergency_validation" context="kitchen" />
      <Capability name="safety_assessment" context="home" />
      <Capability name="first_aid_verification" context="emergency_prep" />
    </Provides>
    
    <RequiredInstrument instrumentName="emergency_storage_location" />
    <RequiredInstrument instrumentName="inspection_checklist" />
    
    <Precept name="CheckFirstAidSupplies">
      <Description>Validate medical emergency supplies</Description>
      
      <Precept name="ValidateBandages">
        <Action>Count available bandages</Action>
        <Action>Check expiration dates</Action>
        <AcceptanceCriteria>
          <Condition state="adequate" test="count >= 10 AND not_expired" action="Mark as ready" />
          <Condition state="insufficient" test="count < 10" action="Add to shopping list" />
          <Condition state="expired" test="expiry_date < today" action="Replace immediately" />
        </AcceptanceCriteria>
        <Output>
          <Artifact name="bandage_status">
            <Type>validation_data</Type>
            <Description>Bandage inventory and condition assessment</Description>
          </Artifact>
        </Output>
      </Precept>
      
      <Precept name="ValidateAntiseptic">
        <Action>Check antiseptic bottle presence</Action>
        <Action>Verify adequate volume</Action>
        <AcceptanceCriteria>
          <Condition state="present" test="bottle_exists AND volume > 50ml" action="Approved for use" />
          <Condition state="low" test="volume < 50ml AND volume > 10ml" action="Restock soon" />
          <Condition state="missing" test="not_found OR volume <= 10ml" action="Purchase immediately" />
        </AcceptanceCriteria>
        <Output>
          <Artifact name="antiseptic_status">
            <Type>validation_data</Type>
            <Description>Antiseptic availability and volume assessment</Description>
          </Artifact>
        </Output>
      </Precept>
      
      <Precept name="ValidateBurnTreatment">
        <Action>Check for burn gel or cool compresses</Action>
        <Action>Verify ice pack availability in freezer</Action>
        <AcceptanceCriteria>
          <Condition state="complete" test="burn_gel_present AND ice_pack_ready" action="Burn treatment ready" />
          <Condition state="partial" test="burn_gel_present OR ice_pack_ready" action="Complete burn treatment supplies" />
          <Condition state="missing" test="no_burn_treatment_available" action="Acquire burn treatment supplies" />
        </AcceptanceCriteria>
        <Output>
          <Artifact name="burn_treatment_status">
            <Type>validation_data</Type>
            <Description>Burn treatment readiness assessment</Description>
          </Artifact>
        </Output>
      </Precept>
    </Precept>

    <Precept name="CheckFireSafety">
      <Description>Validate fire suppression equipment</Description>
      
      <Precept name="ValidateExtinguisher">
        <Action>Check pressure gauge reading</Action>
        <Action>Verify expiration date</Action>
        <Action>Confirm accessibility</Action>
        <AcceptanceCriteria>
          <Condition state="ready" test="pressure_good AND not_expired AND accessible" action="Fire extinguisher approved" />
          <Condition state="needs_service" test="pressure_low OR expired" action="Schedule maintenance" />
          <Condition state="blocked" test="not_accessible" action="Clear access path" />
        </AcceptanceCriteria>
        <Output>
          <Artifact name="extinguisher_status">
            <Type>validation_data</Type>
            <Description>Fire extinguisher readiness assessment</Description>
          </Artifact>
        </Output>
      </Precept>
      
      <Precept name="ValidateFireBlanket">
        <Action>Check for tears or damage</Action>
        <Action>Verify proper storage and accessibility</Action>
        <Action>Confirm size adequacy for kitchen fires</Action>
        <AcceptanceCriteria>
          <Condition state="ready" test="no_damage AND accessible AND adequate_size" action="Fire blanket approved" />
          <Condition state="damaged" test="tears_or_holes_present" action="Replace fire blanket" />
          <Condition state="inaccessible" test="blocked_or_misplaced" action="Relocate for easy access" />
        </AcceptanceCriteria>
        <Output>
          <Artifact name="fire_blanket_status">
            <Type>validation_data</Type>
            <Description>Fire blanket condition and accessibility</Description>
          </Artifact>
        </Output>
      </Precept>
    </Precept>

    <Precept name="CheckAccessibilityAndResponse">
      <Description>Validate emergency response readiness</Description>
      
      <Precept name="ValidateAccessTimes">
        <Action>Time access to each emergency item</Action>
        <Action>Verify all items reachable within 30 seconds</Action>
        <Constraint type="safety">All emergency items must be accessible within 30 seconds</Constraint>
        <Output>
          <Artifact name="access_time_assessment">
            <Type>validation_data</Type>
            <Description>Emergency item accessibility timing</Description>
          </Artifact>
        </Output>
      </Precept>
      
      <Precept name="ValidateEmergencyContacts">
        <Action>Verify emergency contact numbers are current</Action>
        <Action>Confirm contact information is easily accessible</Action>
        <AcceptanceCriteria>
          <Condition state="ready" test="contacts_current AND easily_accessible" action="Emergency contacts verified" />
          <Condition state="outdated" test="contacts_old OR not_accessible" action="Update emergency contact information" />
        </AcceptanceCriteria>
        <Output>
          <Artifact name="emergency_contacts_status">
            <Type>validation_data</Type>
            <Description>Emergency contact information readiness</Description>
          </Artifact>
        </Output>
      </Precept>
    </Precept>

    <!-- Aggregate all validation results -->
    <Output>
      <Artifact name="emergency_kit_validated">
        <Type>validation_data</Type>
        <Type>state_vector</Type>
        <Description>Complete emergency kit validation with detailed status</Description>
        <Source>
          <Union>
            <From ref="ValidateBandages" artifact="bandage_status" />
            <From ref="ValidateAntiseptic" artifact="antiseptic_status" />
            <From ref="ValidateBurnTreatment" artifact="burn_treatment_status" />
            <From ref="ValidateExtinguisher" artifact="extinguisher_status" />
            <From ref="ValidateFireBlanket" artifact="fire_blanket_status" />
            <From ref="ValidateAccessTimes" artifact="access_time_assessment" />
            <From ref="ValidateEmergencyContacts" artifact="emergency_contacts_status" />
          </Union>
        </Source>
      </Artifact>
    </Output>
    
  </Precept>
</IntentDOM>
```