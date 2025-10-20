``` xml
<IntentDom root="UnnamedDesignPattern">

    <Precept name="DesignPatternExample">
        <Description>
        This design pattern illustrates a reusable structure for defining precepts that can be dynamically resolved and coordinated.
        </Description>
    
        <!-- Define capabilities provided by this precept -->
        <Provides>
        <Capability name="example_capability" domain="example_domain" />
        </Provides>
    
        <!-- Define required instruments for this precept -->
        <RequiredInstrument instrumentName="input_instrument" description="Input required for the precept" />
        
        <H:Precept name="NestedPrecept1"
                  id="0xABCDEF01"
                  allocateOutput="output_artifact as output_artifact"
                  onStall="prune"/>

        <H:Precept name="NestedPrecept2"
                  id="0xDEFABC07"
                  allocateOutput="output_artifact as output_artifact"
                  onStall="prune"/>

        <H:Precept name="NestedPrecept3"
                  id="0x12345678"
                  allocateOutput="output_artifact as output_artifact"
                  onStall="prune"/>

    <Vigil name="ExampleVigil" during="DesignPatternExample">
      <Description>Monitor for specific conditions to trigger actions</Description>
      <MLPTrigger model="example_model"
                  symbol="output_artifact_instantiation"
                  confidence_threshold="0.9" />
      <Action>jump to return (Output) </Action>
    </Vigil>

    <Output>
      <Artifact name="final_output_artifact">
        <Type>example_type</Type>
        <Description>Final output artifact produced by the design pattern precept</Description>
        </Artifact>
    </Output>
    </Precept>
</IntentDom>
```