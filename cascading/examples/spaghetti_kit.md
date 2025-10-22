# Cheap Spaghetti Kit Recipe

This example demonstrates Intent Cascading with pre-packaged ingredients, showing workflow optimization, yield-safe points, and background task monitoring.

```xml
<!-- Cheap Spaghetti Kit Recipe - Demonstrating Intent Cascading with Pre-packaged Ingredients -->
<IntentDOM root="MakeSpaghettiKit">
<!-- DISRUPT Handlers: Emergency preparedness for pasta cooking -->
  <D:Precept name="HandleBoilOver" 
             description="Emergency response to pasta water boiling over">
    <MLPTrigger ref="pot_boiling_over" />
    
    <PreflightValidation>
      <R:Precept name="ValidateKitchenSafety" 
                 providing="capability:emergency_validation AND domain:kitchen"
                 description="Ensure stove safety and spill cleanup materials available" />
      <RequiredInstrument instrumentName="emergency_kit" />
    </PreflightValidation>
    <RequiredInstrument instrumentName="kitchen_towels" preflight="true" />
    <RequiredInstrument instrumentName="pot_holders" preflight="true" />
    
    <Action>Immediately reduce heat to medium</Action>
    <Action>Remove pot from heat temporarily if needed</Action>
    <Action>Clean up any spilled water safely</Action>
    <Action>Resume cooking at lower heat setting</Action>
    
    <Output>
      <Artifact name="boil_over_controlled">
        <Type>emergency_intervention</Type>
        <Description>Boil over emergency handled safely</Description>
      </Artifact>
    </Output>
  </D:Precept>

  <D:Precept name="HandleBurnedSauce" 
             description="Emergency response to burning sauce">
    <MLPTrigger ref="sauce_burning" />
    
    <PreflightValidation>
      <R:Precept name="ValidateBackupIngredients" 
                 providing="capability:ingredient_backup AND domain:food_preparation"
                 description="Check for backup sauce or ingredients if primary burns" />
      <RequiredInstrument instrumentName="backup_plan" />
    </PreflightValidation>
    
    <Action>Remove sauce from heat immediately</Action>
    <Action>Transfer to clean pan if salvageable</Action>
    <Action>Add water or broth to thin if too thick</Action>
    <Action>Taste and adjust seasoning</Action>
    
    <Output>
      <Artifact name="sauce_recovered">
        <Type>emergency_intervention</Type>
        <Description>Burned sauce rescued or replaced</Description>
      </Artifact>
    </Output>
  </D:Precept>

  <!-- Main spaghetti kit workflow -->
  <Precept name="MakeSpaghettiKit">
    <Description>Prepare cheap spaghetti using pre-packaged kit ingredients</Description>
    <Provides>
      <Capability name="spaghetti_kit_preparation" domain="food_preparation" />
      <Capability name="budget_cooking" domain="economical_meals" />
    </Provides>
    
    <Domains>
      <Domain ref="kitchen" />
      <Domain ref="food_preparation" />
      <Domain ref="budget_cooking" />
    </Domains>

    <RequiredInstrument instrumentName="spaghetti_kit" alias="chosen_kit"/>
    <RequiredInstrument instrumentName="large_pot" alias="pasta_pot"/>
    <RequiredInstrument instrumentName="medium_saucepan" alias="sauce_pan"/>
    <RequiredInstrument instrumentName="colander" alias="strainer"/>
    <RequiredInstrument instrumentName="wooden_spoon" alias="stirring_spoon"/>
    <RequiredInstrument instrumentName="water" quantity="4-6cups"/>
    <RequiredInstrument instrumentName="salt" quantity="1tsp"/>
    
    <Constraint type="timing">Coordinate pasta and sauce completion</Constraint>
    <Constraint type="temperature">Pasta water at rolling boil, sauce at gentle simmer</Constraint>
    
    <!-- Preflight: Kit validation and setup -->
    <StagingPhase type="preflight" name="validate_kit">
      <PreflightValidation>
        <R:Precept name="ValidateKitContents" providing="domain:food_safety AND capability:package_validation" instrument="chosen_kit"/>
        <R:Precept name="CheckPotSize" providing="domain:kitchen AND capability:equipment_validation" instrument="pasta_pot"/>
        <R:Precept name="VerifyColander" providing="domain:kitchen AND capability:utensil_validation" instrument="strainer"/>
        <R:Precept name="TestStoveFunction" providing="domain:kitchen AND capability:appliance_validation" instrument="stove"/>
      </PreflightValidation>
      <Output>
        <Artifact name="kit_validated">
          <Type>validation_data</Type>
          <Description>Kit contents and equipment validated for cooking</Description>
        </Artifact>
      </Output>
    </StagingPhase>

    <!-- Setup and cooking phase: Real workflow timing -->
    <StagingPhase type="execution" name="cooking_workflow">
      <Description>Start water, prepare sauce while waiting, then cook pasta</Description>
      
      <Precept name="StartWaterAndYield">
        <Provides>
          <Capability name="water_boiling" domain="pasta_cooking" />
          <Capability name="workflow_optimization" domain="cooking_logistics" />
        </Provides>
        
        <Action>Fill large pot with 4-6 cups water</Action>
        <Action>Add 1 teaspoon salt to water</Action>
        <Action>Place on stove and turn heat to high</Action>
        
        <!-- Yield immediately - use the waiting time productively -->
        <YieldSafePoint name="water_heating_background">
          <StateVector>
            <State key="pot_on_stove" value="true" />
            <State key="heat_setting" value="high" />
            <State key="salt_added" value="true" />
            <State key="start_time" value="timestamp" />
          </StateVector>
          <WaitCondition duration="6-8m" reason="Water slowly coming to boil - perfect time for sauce prep" />
          <ResumeCondition>
            <Check state="water_state" target="rolling_boil" />
          </ResumeCondition>
        </YieldSafePoint>
        
        <Output>
          <Artifact name="water_heating_started">
            <Type>state_vector</Type>
            <Description>Water heating process initiated, ready to work on other tasks</Description>
          </Artifact>
          <Artifact name="boiling_water">
            <Type>instrument</Type>
            <Description>Boiling water ready to receive uncooked pasta</Description>
          </Artifact>
        </Output>
        
        <!-- Background water monitoring -->
        <Vigil name="CheckWaterProgress" 
               frequency="every_2m" 
               during="water_heating_background">
          <Description>Glance at water pot while working on sauce</Description>
          <Action>Listen for increasing bubble sounds</Action>
          <Action>Notice steam levels increasing</Action>
          <Condition>Only when convenient during sauce prep</Condition>
        </Vigil>
      </Precept>
      
      <Precept name="PrepareSauceWhileWaiting">
        <Provides>
          <Capability name="sauce_preparation" domain="cooking" />
          <Capability name="time_efficiency" domain="cooking_logistics" />
        </Provides>
        
        <RequiredInstrument instrumentName="kit_unpacked" />
        <RequiredInstrument instrumentName="water_heating_started" />
        
        <Action>Place sauce pan on stove at medium-low heat</Action>
        <Action>Open sauce packet and pour into pan</Action>
        <Action>Add herb packet contents to sauce</Action>
        <Action>Stir gently and begin heating</Action>
        
        <!-- Safe to yield when sauce is heating but not yet bubbling -->
        <YieldSafePoint name="sauce_heating_safely">
          <StateVector>
            <State key="sauce_in_pan" value="true" />
            <State key="herbs_added" value="true" />
            <State key="heat_setting" value="medium_low" />
            <State key="bubbling_state" value="not_bubbling" />
          </StateVector>
          <WaitCondition duration="2-3m" reason="Sauce warming up but not actively bubbling - safe to leave briefly" />
          <ResumeCondition>
            <Check state="sauce_bubbling" target="gentle_simmer" />
          </ResumeCondition>
        </YieldSafePoint>
        
        <Action>Return attention when sauce begins to simmer</Action>
        <Action>Stir and continue heating until fully warmed</Action>
        <Action>Move sauce pot to cold area of stove to prevent overheating</Action>
        
        <Output>
          <Artifact name="sauce_ready_and_waiting">
            <Type>food_item</Type>
            <Description>Sauce prepared and keeping warm off heat</Description>
          </Artifact>
        </Output>
        
        <!-- Background sauce monitoring during safe yield period -->
        <Vigil name="CheckSauceStatus" 
               frequency="every_60s" 
               during="sauce_heating_safely">
          <Description>Check sauce occasionally while it's safe to leave alone</Description>
          <Action>Listen for bubbling sounds starting</Action>
          <Action>Quick visual check for simmering</Action>
          <Condition>Only brief attention needed while sauce is not bubbling</Condition>
        </Vigil>
      </Precept>
      
      <Precept name="CookPastaWhenWaterBoils">
        <Provides>
          <Capability name="pasta_cooking" domain="cooking" />
          <Capability name="timing_coordination" domain="cooking_logistics" />
        </Provides>
        <MLPTrigger ref="cooking water at rolling_boil" />
        <RequiredInstrument instrumentName="sauce_ready_and_waiting" />
        <RequiredInstrument instrumentName="boiling_water" />
        
        <!-- Water should be boiling by now -->
        <Action>Verify water is at rolling boil</Action>
        <Action>Add pasta to boiling water</Action>
        <Action>Stir gently to prevent sticking</Action>
        <Action>Cook according to package time</Action>
        
        <!-- Short cooking period since sauce is already done -->
        <YieldSafePoint name="pasta_cooking_final">
          <StateVector>
            <State key="pasta_in_water" value="true" />
            <State key="sauce_waiting" value="true" />
            <State key="cook_start_time" value="timestamp" />
          </StateVector>
          <WaitCondition duration="8-12m" reason="Pasta cooking while sauce stays warm" />
        </YieldSafePoint>
        
        <R:Precept providing="capability:test_pasta_doneness AND domain:food_preparation"
            allocateOutput="pasta_is_aldente as pasta_is_aldente"
            onStall="ignore"/>
        <R:Precept providing="capability:drain_pasta AND domain:food_preparation"
            allocateOutput="pasta_drained as pasta_drained"/>
        
        <!-- Minimal pasta monitoring since sauce is done -->
        <Vigil name="CheckPastaProgress" 
               frequency="every_90s" 
               during="pasta_cooking_final">
          <Description>Monitor pasta cooking - main focus now</Description>
          <Action>Stir pasta occasionally</Action>
          <Action>Test doneness near end time</Action>
          <Condition>Primary attention during pasta cooking</Condition>
        </Vigil>
        
        <Output>
          <Artifact name="pasta_cooked_perfectly_timed">
            <Type>food_item</Type>
            <Description>Pasta ready just as sauce finishes staying warm</Description>
          </Artifact>
        </Output>
      </Precept>
      
      <Output>
        <Artifact name="both_components_ready">
          <Type>state_vector</Type>
          <Description>Pasta just cooked and sauce perfectly warmed and waiting</Description>
        </Artifact>
      </Output>
    </StagingPhase>

    <!-- Assembly phase: Combine and serve -->
    <StagingPhase type="execution" name="assembly">
      <Description>Combine pasta and sauce, add cheese, and serve</Description>
      <RequiredInstrument instrumentName="both_components_ready" />
      
      <Precept name="CombineAndServe">
        <Provides>
          <Capability name="dish_assembly" domain="food_presentation" />
          <Capability name="portioning" domain="serving" />
        </Provides>
        
        <RequiredInstrument instrumentName="pasta_cooked_perfectly_timed" />
        <RequiredInstrument instrumentName="sauce_ready_and_waiting" />
        
        <Action>Return drained pasta to pasta pot or serving bowl</Action>
        <Action>Retrieve warmed sauce from cold burner area</Action>
        <Action>Pour sauce over pasta</Action>
        <Action>Toss gently to combine</Action>
        <Action>Open parmesan packet and sprinkle over pasta</Action>
        <Action>Serve immediately while hot</Action>
        
        <Output>
          <Artifact name="finished_spaghetti">
            <Type>food_item</Type>
            <Description>Complete spaghetti dish ready to eat</Description>
          </Artifact>
        </Output>
      </Precept>
      
      <Output>
        <Artifact name="meal_complete">
          <Type>state_vector</Type>
          <Description>Spaghetti kit meal prepared and served</Description>
        </Artifact>
      </Output>
    </StagingPhase>
        
  </Precept>
</IntentDOM>
```