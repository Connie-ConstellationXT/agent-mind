# Intent Cascading Tree: ExistWhileEmployed

This example models the intent of "existing while employed" as a long-lived precept with two nested sub-precepts: one for handling any work-related task (with a vigil and yieldsafepoint), and one dynlinked precept for handling personal tasks. The only possible outputs are `unemployed` or `pensioned` state vectors, representing the only valid terminations.

```xml
<IntentDOM root="ExistWhileEmployed">

  <Precept name="ExistWhileEmployed">
    <Description>Maintain existence and respond to all work and personal tasks while employed. Terminates only on unemployment or pensioning.</Description>
    <Provides>
      <Capability name="life_maintenance" domain="employment" />
    </Provides>

    <StagingPhase type="execution" name="employment_lifecycle">
      <!-- 1. Work-related task handler -->
      <Precept name="HandleWorkTasks">
        <Description>Find and respond to any work-related task as they appear.</Description>
        <Provides>
          <Capability name="work_task_handling" domain="employment" />
        </Provides>
        <!-- No direct actions: just a vigil and a yieldsafepoint -->
        <Vigil name="WorkTaskVigil" frequency="continuous">
          <Description>Monitor for new work-related tasks and trigger appropriate sub-precepts.</Description>
          <Trigger>work_task_appeared</Trigger>
          <Action>Dynlink and invoke precept to handle the new work task</Action>
        </Vigil>
        <YieldSafePoint name="AwaitingWorkTask">
          <StateVector>
            <State key="awaiting_task" value="true" />
          </StateVector>
          <WaitCondition duration="indefinite" reason="No work tasks currently present" />
        </YieldSafePoint>
      </Precept>

      <!-- 2. Personal task handler (dynlinked for independence) -->
      <R:Precept name="HandlePersonalTasks"
                providing="capability:personal_task_handling AND domain=personal_life"
                dynlink="true"
                description="Dynlinked precept for handling all personal tasks, independent of employment status" />

      <!-- Termination outputs -->
      <Output>
        <Artifact name="employment_status">
          <Type>state_vector</Type>
          <Description>Employment lifecycle terminated: either unemployed or pensioned</Description>
          <ExclusiveAny>
            <From ref="ExistWhileEmployed" artifact="unemployed" />
            <From ref="ExistWhileEmployed" artifact="pensioned" />
          </ExclusiveAny>
        </Artifact>
      </Output>
    </StagingPhase>
  </Precept>

</IntentDOM>
```

---

## Key Features Illustrated

- **Long-lived intent**: The root precept persists, only terminating on unemployment or pensioning.
- **Work task handler**: Watches for new work tasks, dynlinks sub-precepts as needed, and yields when idle.
- **Personal task handler**: Dynlinked for independence, so personal tasks can be handled even if employment ends.
- **Termination**: Only possible outputs are `unemployed` or `pensioned` state vectors.
- **Event-driven, compositional, and open-ended**: The tree can handle any number of tasks, and is structured for continuous operation.
- **Emergent robustness via system rules**: The runtime enforces task admission limits and prunes low-priority tasks when quotas are exceeded. This behavior emerges from system-wide rules, such as:
  - **Alarm 1201**: Prevents admission of new runtime-mutable tasks when VAC areas are full.
  - **Alarm 1202**: Halts admission of all tasks when CPU cycles are exhausted.
  - **Task pruning**: Low-priority tasks are pruned automatically to free resources for higher-priority intents.
