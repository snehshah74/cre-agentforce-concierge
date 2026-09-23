# Flow: Create_Maintenance_Case (Autolaunched, No Trigger)

**Purpose:** Create a new maintenance Case for a piece of equipment at a given priority.

## Elements
1. **Create Records** — Object: Case. Field values (manual):
   - AccountId = `AccountIdInput` (Text, input)
   - AssetId = `AssetIdForCase` (Text, input)
   - Description = literal descriptive text
   - Priority = `PriorityInput` (Text, input)
   - Subject = literal ("Equipment issue reported")
   - Status = literal ("New")
2. **Assignment** — `CreatedCaseId` (Text, output) = `Case from Create Maintenance Case > Case ID`.
