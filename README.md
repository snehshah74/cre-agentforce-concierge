# CRE Agentforce Operations Concierge

A multi-agent Salesforce Agentforce system for commercial real estate building operations: tenant equipment issue triage, duplicate case prevention, priority calculation from live equipment data, case lifecycle actions, and tenant lease/financial data lookup.

Built as a live technical demo in a Salesforce Developer Edition org for a Deployment Strategist interview.

## Repository structure

```
force-app/main/default/objects/     Retrieved via Salesforce CLI — real Account, Asset, and Case
                                     schema (standard + custom fields) from the live org
classes/                            DeterminePriorityAction.cls — Apex source, matches the live
                                     org exactly (added manually — see note below)
flows-documented/                   Full configuration writeups for each of the 7 live Flows,
                                     verified field-by-field against the org (added manually —
                                     see note below)
docs/                                Architecture, technical design, PRD, and deployment
                                     playbook documents
```

## A note on why Flows and Apex aren't retrieved as native metadata

This org's Metadata API, Tooling API, REST API, and Workbench's metadata browser all independently confirmed the same restriction: Apex Class and Flow metadata are not retrievable through any client tool in this specific Developer Edition org (OrgFarm-provisioned), while CustomObject/CustomField metadata and managed-package Flow metadata retrieve normally. This was diagnosed methodically across five separate tools before concluding it is a genuine org-level API restriction, not a permission or naming issue.

Rather than leave this undocumented, the Apex class source and each Flow's full configuration are included here as accurate, manually authored source/documentation, verified field-by-field against the live org the night before the interview — a process that also caught and fixed a real logic bug (see Check_Existing_Case.md).

## Actual data model (retrieved live)

- **Account** — extended with `Building_Code__c` (buildings) and `Lease_Start_Date_c__c`, `Lease_End_Date_c__c`, `Monthly_Rent_c__c`, `Square_Footage_Leased_c__c` (tenants)
- **Asset** — extended with `Asset_Code__c`, `Current_Reading__c`, `Normal_Range_Low__c`, `Normal_Range_High__c`
- **Case** — extended with `Assigned_Team__c`

## Live-tested capabilities

- Duplicate maintenance case detection (verified correct after fixing a filter bug pre-interview)
- New case creation with Apex-calculated priority from live equipment readings
- Non-HVAC equipment handling (no numeric reading available)
- Case status lookup by case number
- Priority updates and team assignment on existing cases
- Cross-topic conversational context retention
- Tenant lease/rent/employee-count lookups across a second subagent

See `docs/` for full architecture, technical design, PRD, and the deployment retrospective (including real debugging incidents encountered during the build).
