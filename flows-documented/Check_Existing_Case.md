# Flow: Check_Existing_Case (Autolaunched, No Trigger)

**Purpose:** Detect an existing OPEN case for a given asset, to prevent duplicate case creation.

## Elements
1. **Get Records** — Object: Case. Filter (AND): `AssetId` Equals `AssetIdInput3` (Text, input) AND `Status` **Not Equal To** `Closed`. Only the first record.
2. **Assignment** — `ExistingCaseId` (Text, output) = the found Case's Id; `ExistingCaseNumber` (Text, output) = the found Case's CaseNumber.

If no matching open record is found, both outputs remain null, signaling to the calling agent that no open case exists.

## Bug found and fixed during pre-interview review
While manually re-verifying every Flow's live configuration the night before the final-round interview, this filter was found set to `Status Equals Closed` — the inverse of the intended logic. This meant the Flow could only ever match already-closed cases, so true open-case duplicate detection had never actually been exercised correctly, despite appearing to work in earlier live testing (a genuinely closed case was found and reported, and the agent correctly created a new case afterward — a different, narrower behavior that looked identical to correct duplicate prevention in conversation). Corrected to `Not Equal To Closed` and re-verified live before the interview: reporting the same issue twice now correctly finds the open case and creates no duplicate.
