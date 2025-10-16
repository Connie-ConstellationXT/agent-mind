# STOP CODE: INTENT_REALTIME_PROMISE_NOT_DISJOINT

When the intent scaffolding runtime detects two or more non-parallelizable intents with mutually exclusive, high-priority real-time requirements, it cannot satisfy both promises. In this case, the system triggers a STOP CODE event, halting execution and surfacing a diagnostic message inspired by Windows NT/BSOD aesthetics:

```
*** STOP: 0x000000E2 (INTENT_REALTIME_PROMISE_NOT_DISJOINT)

A fatal scheduling conflict has occurred.

Multiple active intents require exclusive, real-time execution and their realtime_promise properties are not disjoint:

  - DriveToStore (realtime_promise = exclusive, priority = 10)
  - AttendMeeting (realtime_promise = exclusive, priority = 10)

The system cannot resolve this conflict. All affected intents have been pruned.

If this is the first time you've seen this STOP CODE, review your intent declarations for mutually exclusive, high-priority tasks.

If problems continue, consult the intent scaffolding language reference or contact your system administrator.
```

This STOP CODE is one of many possible intent runtime errors. Each STOP CODE is designed to be precise and actionable for developers and system integrators.
