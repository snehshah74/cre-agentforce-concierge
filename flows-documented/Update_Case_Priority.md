# Flow: Update_Case_Priority (Autolaunched, No Trigger)

**Purpose:** Update the Priority field on an existing Case.

## Elements
1. **Update Records** — "Specify conditions to identify records, and set fields individually." Object: Case. Filter: `Id` Equals `CaseIdInput` (Text, input). Set field: `Priority` = `NewPriorityInput` (Text, input).
2. **Assignment** — `UpdateSuccess` (Text, output) = literal confirmation value.

**Design note:** the confirmation output was added specifically because Agentforce requires at least one output per Flow-backed Action, even for a pure-mutation Flow with nothing natural to return. Live-tested and confirmed working: the agent correctly updates priority and confirms the change conversationally.
