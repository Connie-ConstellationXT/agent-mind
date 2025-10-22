# IntentDOM: Install and Test VR Class JK3 Mod for Derail Valley

This document models the process of installing and testing the "VR Class JK3" mod for Derail Valley using intent scaffolding principles. The intent tree includes acquiring dependencies, installing the mod, and verifying its functionality in-game.

---

```xml
<IntentDOM root="InstallAndTestVRClassJK3">

  <!-- Root Precept: Install and Test the Mod -->
  <Precept name="InstallAndTestVRClassJK3">
    <Description>Install the VR Class JK3 mod and verify its functionality in Derail Valley.</Description>

    <!-- Acquire Dependencies (download/prep) -->
    <Precept name="AcquireDependencies">
      <Description>Download and prepare the required dependency mod packages (local files).</Description>

      <RequiredInstrument instrumentName="CustomCarLoader" alias="custom_car_loader" />
      <RequiredInstrument instrumentName="CustomLicensesMod" alias="custom_licenses_mod" />

      <Action>Locate and download the two required mods from their respective sources (or verify local copies).</Action>
      <Action>Validate package integrity and compatibility with the current Derail Valley version.</Action>

      <Output>
        <Artifact name="DependenciesReady">
          <Type>mod_dependencies</Type>
          <Description>All required dependency packages are downloaded and validated, ready for installation.</Description>
        </Artifact>
      </Output>
    </Precept>

    <!-- Install dependency mods using Unity Mod Manager (separate precept) -->
    <Precept name="InstallDependencies">
      <Description>Install dependency mods (Custom Car Loader, Custom Licenses Mod) into Derail Valley via Unity Mod Manager.</Description>

      <RequiredInstrument instrumentName="UnityModManager" alias="UMM" />
      <RequiredInstrument instrumentName="DependenciesReady" />

      <Action>Launch Unity Mod Manager via Proton (UMM).</Action>
      <Action>Load the dependency packages and install Custom Car Loader.</Action>
      <Action>Load the dependency packages and install Custom Licenses Mod.</Action>
      <Action>Verify installation and enable the mods in UMM if necessary.</Action>

      <Output>
        <Artifact name="DependencyModsInstalled">
          <Type>installed_dependencies</Type>
          <Description>Dependency mods (Custom Car Loader and Custom Licenses Mod) are installed and enabled.</Description>
        </Artifact>
      </Output>
    </Precept>

    <!-- Install the main VR Class JK3 mod; depends on dependency installation -->
    <Precept name="InstallJK3">
      <Description>Install the VR Class JK3 mod after dependencies are present.</Description>

      <RequiredInstrument instrumentName="UnityModManager" alias="UMM" />
      <RequiredInstrument instrumentName="DependencyModsInstalled" />

      <Action>Acquire the VR Class JK3 mod package (download or verify local copy).</Action>
      <Action>Use UMM to install the VR Class JK3 package into Derail Valley.</Action>
      <Action>Resolve any conflicts reported by UMM (dependency ordering, load order).</Action>

      <Output>
        <Artifact name="ModsInstalled">
          <Type>installed_mods</Type>
          <Description>All mods, including VR Class JK3, are installed and ready for testing.</Description>
        </Artifact>
      </Output>
    </Precept>

    <!-- Test the Mod In-Game -->
    <Precept name="TestModInGame">
      <Description>Verify the functionality of the VR Class JK3 mod in Derail Valley.</Description>

      <RequiredInstrument instrumentName="ModsInstalled" />
      <RequiredInstrument instrumentName="DerailValley" alias="Game" />

      <Action>Launch Derail Valley.</Action>
      <Action>Enter sandbox mode.</Action>
      <Action>Use the in-game remote item to spawn the VR Class JK3 engine and its tender.</Action>
      <Action>Test the engine's functionality, including refueling, coupling to tender, and operational behavior.</Action>

      <Output>
        <Artifact name="ModTested">
          <Type>test_results</Type>
          <Description>VR Class JK3 mod functionality verified in-game.</Description>
        </Artifact>
      </Output>
    </Precept>

  </Precept>

</IntentDOM>
```