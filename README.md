# CRE Agentforce Operations Concierge

A multi-agent Salesforce Agentforce system that lets tenants in a commercial real estate portfolio report equipment issues, check on existing maintenance cases, and look up their own lease details — all through natural conversation, grounded entirely in live Salesforce data.

## Why this was built

Commercial real estate operations teams handle a constant stream of tenant requests that vary wildly in urgency and type: a flickering light, a flooding mechanical room, and "what's my monthly rent" often arrive through the same channel with no automatic triage. Today that triage is manual — a person reads each message, decides what it is, checks whether it's already been reported, decides how urgent it is, and creates or updates a record by hand. That's slow, inconsistent across staff, and produces real waste: duplicate tickets on issues someone already logged, and priority levels that depend more on who triaged the message than on the actual equipment data.

This project builds a working agent that does that triage automatically and correctly:
- It investigates before it acts, using real Salesforce records rather than guessing
- It checks for existing open cases before creating a new one, so the same broken AC unit doesn't generate five duplicate tickets
- It calculates priority from actual equipment sensor data rather than treating every report the same
- It escalates genuine emergencies immediately, bypassing routine triage entirely
- It answers routine tenant questions (lease terms, rent, employee count) without pulling a person off active work

It was built as a live, from-scratch technical demo for a Salesforce Deployment Strategist interview, specifically to prove out the pattern end-to-end in a single session — real data model, real Apex, real Flows, a real multi-agent Agentforce configuration, and real conversational testing — rather than a mockup or slide deck.

## How to use this repo

This repo is a **source-of-truth reference**, not a one-click deployable package (see the note on metadata retrieval limitations below for why). To actually stand this up in your own Salesforce org:

1. **Data model** — recreate the custom fields documented under `force-app/main/default/objects/` on Account, Asset, and Case (or deploy that metadata directly, since it was retrieved live via CLI and is deployment-ready)
2. **Apex** — create an Apex class named `DeterminePriorityAction` and paste in the source from `classes/DeterminePriorityAction.cls`
3. **Flows** — for each file under `flows-documented/`, build the corresponding Autolaunched Flow in Flow Builder following that file's element-by-element configuration
4. **Agent** — in Agentforce Studio, create an agent with a Router and five subagents, and paste each subagent's Reasoning Instructions directly from the corresponding file under `agent-config/`
5. **Permissions** — create a permission set granting the agent's service user Read on Asset and Read/Create/Edit on Case (see `agent-config/Agent_Definition_and_Access.md` for the full permission-set breakdown)
6. **Sample data** — seed buildings, tenants, equipment, and cases following the naming conventions documented in `agent-config/Maintenance_Request.md` (asset code patterns) so the agent's location-to-asset-code translation works correctly

## Use cases this demonstrates

- **Tenant self-service maintenance reporting** — "The AC on Floor 18 isn't working" → investigated, checked for duplicates, prioritized, and logged, all in one conversational turn
- **Duplicate prevention** — reporting the same issue twice returns the existing case instead of creating a second one
- **Data-driven priority** — priority is calculated from the equipment's actual sensor reading against its normal operating range, not guessed
- **Graceful handling of non-instrumented equipment** — elevators, generators, and other equipment with no numeric reading still get a sensible default priority, escalated to High when the tenant's language suggests a safety issue
- **Case lifecycle management** — priority changes, team reassignment, and status lookups by case number, all handled conversationally as follow-ups in the same conversation
- **Emergency routing** — flooding, gas smell, fire, and similar language is detected and routed to escalation immediately, ahead of any routine maintenance logic, even if the same message also contains maintenance-sounding language
- **Multi-topic conversations** — a tenant can ask about their lease mid-conversation about a maintenance issue and the agent correctly hands off between subagents and back
- **Prompt-injection resistance** — the Off Topic and Ambiguous Question subagents include explicit rules against revealing system configuration or being redirected by embedded instructions in user input

## What this is not

This is a demo built to prove a pattern, not a production system. It does not include: real IoT/BMS sensor integration (equipment readings are static seeded data, not live feeds), a tenant-facing UI beyond Agentforce's native chat interface, real production deployment (see the deployment retrospective in `docs/`), or Apex test coverage (a real blocker for any production deploy, documented honestly rather than skipped over).

## Repository structure

```
force-app/main/default/objects/     Retrieved via Salesforce CLI — real Account, Asset, and Case
                                     schema (standard + custom fields) from the live org
classes/                            DeterminePriorityAction.cls — Apex source, matches the live
                                     org exactly (added manually — see note below)
flows-documented/                   Full configuration writeups for each of the 7 live Flows,
                                     verified field-by-field against the org (added manually)
agent-config/                       The Agent Router and all 5 subagents' Reasoning Instructions,
                                     verbatim from the live org, plus agent access/permissions
docs/                                Architecture, technical design, PRD, and deployment
                                     playbook documents
```

## A note on why Flows and Apex aren't retrieved as native metadata

This org's Metadata API, Tooling API, REST API, and Workbench's metadata browser all independently confirmed the same restriction: Apex Class and Flow metadata are not retrievable through any client tool in this specific Developer Edition org (OrgFarm-provisioned), while CustomObject/CustomField metadata and managed-package Flow metadata retrieve normally. This was diagnosed methodically across five separate tools before concluding it is a genuine org-level API restriction, not a permission or naming issue.

Rather than leave this undocumented, the Apex class source and each Flow's and subagent's full configuration are included here as accurate, manually authored source/documentation, verified line-by-line against the live org the night before the interview — a process that also caught and fixed a real logic bug in duplicate-case detection (see `flows-documented/Check_Existing_Case.md`).

## Data model

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

See `docs/` for full architecture, technical design, PRD, and the deployment retrospective, including real debugging incidents encountered during the build and what would be done differently in a real customer engagement.
