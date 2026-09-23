# Agent Definition, Access, and Security

**Agent name:** Building Operations Concierge
**Version:** 2 (Active), last saved 9/21/2026, 11:30 PM

## Agent Access
**Agent's User Record:** EinsteinServiceAgent User (building_operations_concierge@00djv000003ufef495933093.ext)

## Permission Sets assigned to the agent's user record
- **Agentforce Agent Building_Operations_Concierge Permissions** — custom permissions for this specific Agentforce Agent
- **Agentforce Asset Access** — the custom permission set built during this project specifically to grant Read on Asset and Read/Create/Edit on Case, fixing the original UNKNOWN_EXCEPTION root cause
- **Agentforce Service Agent Secure Base** — Salesforce's own base permission set for Agentforce Service Agent actions with enhanced data security
- **Building_Operations_Concierge1639990200 Permissions** — auto-generated custom permissions tied to this agent's specific user

## Correction to earlier documentation
Earlier project documentation referred to a single custom permission set ("Agentforce Asset Access") as the sole fix for the agent's data access. The live org actually shows FOUR permission sets assigned to the agent's user record, three of which (the "Permissions" sets and the Secure Base set) are Salesforce/Agentforce-generated defaults that exist automatically when an agent is created, not manually built. "Agentforce Asset Access" is the one genuinely custom permission set built to solve the Asset/Case access gap; the others were already present and are not part of the manual fix.
