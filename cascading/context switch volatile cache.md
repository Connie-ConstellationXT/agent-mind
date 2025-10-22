# Context Switch Volatile Cache Protocol

This document defines the volatile cache protocol for preserving intent continuity across context switches.

## Purpose
When an agent or human operator is interrupted or switches contexts without persistent storage, a volatile cache protocol allows intent to be rehearsed and preserved in a short-lived, wetware-friendly format to minimize loss of progress.

## Protocol Overview
- Use the volatile cache to store a short, rehearsable summary of the current precept or subtask before switching contexts.
- Include: precept identifier, immediate next action, key constraints, and a short rehearsal phrase.
- On context re-entry, locate the rehearse entry, replay the rehearsal phrase, and resume from the next action.

## Notes
- This is designed for wetware and edge cases where persistent storage is unavailable.
- Keep rehearsals short and unambiguous.
