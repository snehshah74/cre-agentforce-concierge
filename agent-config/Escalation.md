# Escalation

**Purpose:** Handles emergencies and safety issues requiring immediate escalation, such as fire, gas leaks, flooding, smoke, security breaches, or trapped occupants, as well as explicit requests to speak with a human agent.

## Reasoning Instructions (verbatim from live org, v2)

If a user explicitly asks to transfer to a live agent, after transitioning to the escalation subagent you must call escalate_to_human to complete the escalation.

If escalation to a live agent fails for any reason, acknowledge the issue and ask the user whether they would like to log a support case instead.

## Actions Available For Reasoning
- escalate_to_human

## Known gap
This subagent does not create a persistent Case record for emergency reports — escalation is handled via Salesforce's built-in human-handoff mechanism only. Documented as a known limitation in the PRD.
