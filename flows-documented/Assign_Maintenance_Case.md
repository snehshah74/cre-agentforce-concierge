# Flow: Assign_Maintenance_Case (Autolaunched, No Trigger)

**Purpose:** Assign an existing Case to a specific facilities team.

## Elements
1. **Update Records** — "Specify conditions to identify records, and set fields individually." Object: Case. Filter: `Id` Equals `CaseIdToAssign` (Text, input). Set field: `Assigned_Team__c` = `AssignmentTeam` (Text, input).
2. **Assignment** — `AssignSuccess` (Text, output) = literal confirmation value. Same rationale as Update_Case_Priority.

Live-tested and confirmed working: the agent correctly assigns and reassigns cases to named teams (e.g. HVAC Team, Electrical) and confirms the change conversationally.
