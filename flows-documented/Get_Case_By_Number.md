# Flow: Get_Case_By_Number (Autolaunched, No Trigger)

**Purpose:** Look up a Case by its human-readable Case Number (distinct from its internal Case Id).

## Elements
1. **Get Records** — Object: Case. Filter: `CaseNumber` Equals `CaseNumberInput` (Text, input). Only the first record. Field storage: "In separate variables."
2. Field mappings: `Priority` → `LookedUpPriority`, `Status` → `LookedUpStatus`, `Subject` → `LookedUpSubject` (all Text, output).

**Design note:** Case Number and Case Id are explicitly distinguished in the agent's Reasoning Instructions after an early failure where the agent passed a Case Id into this Flow, which expects a Case Number and returned no result. Live-tested and confirmed working.
