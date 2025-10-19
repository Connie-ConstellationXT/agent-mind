# INFER Finger Delta Simulator

This example shows an INFER simulator that runs lightweight predictive simulations over candidate finger-delta precepts and publishes a resolver cache artifact for RESOLVE consumers.

```xml
<!-- INFER Simulator: Finger Delta Resolver Cache Provider -->
<IntentDOM root="InferFingerDeltaSimulator">

  <Precept name="InferFingerDeltaSimulator">
    <Description>Continuously runs lightweight predictive simulations over candidate finger-delta precepts and publishes a resolver cache artifact for RESOLVE consumers.</Description>
    <Provides>
      <Capability name="inference_simulation" domain="typing" />
    </Provides>

    <!-- Output: resolver cache map used by RESOLVE. Keep the artifact name stable so consumers can reference it. -->
    <Output>
      <Artifact name="finger_delta_cache" type="resolver_cache_map">
        <Description>Map of candidate precept name → {score, confidence, latency_ms, verbosity_level, health_status, last_updated}.
          This artifact is updated continuously by the INFER loop and is intended as a soft, high-frequency guide for the RESOLVE subsystem.</Description>
        <SystemOffering />
      </Artifact>
    </Output>

    <!-- Notes for runtime implementers: 
         - freshness: include timestamps and TTL entries per-candidate
         - verbosity_level: qualitative indicator (quiet|normal|chatty|shouting)
         - health_status: ok|degraded|alert (used to trigger DISRUPT-level handlers)
         - keep per-key/finger focus to limit compute cost
    -->

  </Precept>

</IntentDOM>
```