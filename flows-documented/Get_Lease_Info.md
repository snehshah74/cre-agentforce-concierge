# Flow: Get_Lease_Info (Autolaunched, No Trigger)

**Purpose:** Look up a tenant Account's lease and financial details by company name.

## Elements
1. **Get Records** — Object: Account. Filter: `Name` Equals `TenantNameIn` (Text, input). Only the first record. Field storage: "In separate variables."
2. Field mappings: `Lease_End_Date_c__c` → `LeaseEnd`, `Lease_Start_Date_c__c` → `LeaseStartDate`, `Monthly_Rent_c__c` → `LeaseRent`, `NumberOfEmployees` → `LeaseEmployees`, `Square_Footage_Leased_c__c` → `LeaseSqFt`.

Live-tested and confirmed working across multiple tenants (e.g. Blue Harbor Partners' rent, Crestwood Insurance Group's full lease term).
