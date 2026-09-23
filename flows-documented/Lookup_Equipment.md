# Flow: Lookup_Equipment (Autolaunched, No Trigger)

**Purpose:** Resolve an equipment asset code to its Asset ID and Account ID.

## Elements
1. **Get Records** — Object: Asset. Filter: `Asset_Code__c` Equals `AssetCodeIn` (Text, input). Only the first record. Field storage: "Choose fields and assign variables (advanced) → In separate variables."
2. Field mappings (direct, no downstream Assignment element):
   - `Id` → `EquipAssetId` (Text, output)
   - `AccountId` → `EqAccountId` (Text, output)

**Design note:** an earlier attempt, "Get Equipment," used "Automatically store all fields" plus a separate Assignment element referencing dot-notation (e.g. `Asset from Get Equipment > Asset ID`). That version is still present in the org (Active, V7) but is NOT wired into the live agent — it was replaced by this Flow after repeated Agentforce Action sync failures. The direct "in separate variables" mapping proved reliable; the dot-notation Assignment pattern did not.
