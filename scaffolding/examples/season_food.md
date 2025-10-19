# Universal Seasoning Precept

This example shows a reusable seasoning precept that can be applied to any food preparation context.

```xml
<!-- Universal Seasoning Precept - Reusable for Any Food Preparation -->
<IntentDOM root="SeasonFood">
  <Precept name="SeasonFood">
    <Description>Add seasonings to food item with appropriate quantity and technique</Description>
    <Domains>
      <Domain ref="food_preparation" />
      <Domain ref="kitchen" />
      <Domain ref="flavor_enhancement" />
    </Domains>
    
    <Provides>
      <Capability name="seasoning_application" context="kitchen" />
      <Capability name="flavor_enhancement" context="food_preparation" />
    </Provides>
    
    <!-- Parameterizable instruments -->
    <RequiredInstrument instrumentName="food_item" description="The food to be seasoned" />
    <RequiredInstrument instrumentName="seasonings" description="Salt, pepper, herbs, or spices to apply" />
    <RequiredInstrument instrumentName="quantity" description="Amount of seasoning (e.g., 'to_taste', 'pinch', 'light_dusting')" default="to_taste" />
    
    <Precept name="ApplySeasonings">
      <Action>Add specified seasonings to food item</Action>
      <Action>Distribute evenly across surface</Action>
      <Constraint type="technique">Start with less, taste and adjust as needed</Constraint>
      <Constraint type="safety">Avoid over-seasoning - easier to add than remove</Constraint>
    </Precept>
    
    <Output>
      <Artifact name="seasoned_food">
        <Type>instrument</Type>
        <Description>Food item properly seasoned and ready for next step</Description>
      </Artifact>
    </Output>
    
  </Precept>
</IntentDOM>
```