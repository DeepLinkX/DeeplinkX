# Review: email research PRs #72–#89

Reviewed **2026-10-11**. All 18 PRs are planning documents: #72–#87 add one app brief each, #88 adds the compose-launcher proposal, and #89 changes the roadmap. None implements email Dart APIs.

## Findings and resolutions

| Finding | Existing PRs | Instruction correction | Remaining gate |
| --- | --- | --- | --- |
| P1: Proposed recipient loss: APIs accept cc/bcc while instructions allow omitting unverified fields | #72 Gmail, #73 Outlook, #74 Yahoo Mail, #77 Fastmail; contract #88 | All briefs require preserving every supplied nonempty field or rejecting/skipping the incompatible route before launch. No silent recipient loss | Current provider field/parser evidence and output-draft device checks |
| P2: Incorrect claim that Apple Mail has no App Store page | #87 Apple Mail; roadmap #89 | iOS store ID 1108187098 recorded; local macOS bundle com.apple.mail and message registration recorded as metadata only | Native root/message invocation untested; default mailto remains separate |
| P2: Desktop research confuses absence of a store/scheme with app absence | Every app draft #72–#87; #89 | Six-platform inventory separates distribution from native route, fields, identity and adapter readiness. Proton, BlueMail, Fastmail, HEY, Spark, Polymail, Canary, Spike, Superhuman and Edison desktop evidence included | Source/release pin, desktop identities and explicit native adapters/runtime checks |
| P2: Blanket compose exclusion overlooks package-targeted Android intents | #78 Proton; open-only Android briefs #79–#82, #84–#85; shared #88 | Revisit all identified Android packages through OS SENDTO research; Proton gets first-party source-backed candidate status rather than a no-compose rule. Added FairEmail and Thunderbird/K-9 source leads | OS contract alone is not provider acceptance; exported activity, parser/fields and installed release must match |
| P2: Launcher says web fallback but algorithm delegates to normal fallback | #88 and roadmap #89 | Preserve exact map two-pass behavior; normal second pass retries native and may open stores or websites. true means a route opened | Future selector labels and call-order tests must match this bounded result |
| Research breadth: original queue misses desktop and Android clients plus shared capabilities | Individual app drafts and #88; roadmap #89 | Add 17 provider briefs and separate default-handler, discovery/open selection, attachment and desktop prerequisite briefs | Blocked cells stay research, not public APIs or supported-platform claims |

These are flaws in proposed implementation instructions, not observed production email failures. Selected first-party evidence supports candidates, not device-tested functionality. Links and source dates are in the [register](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fmail-compose-launcher/doc/plans/email/sources.md); every provider has identifiers/routes/fields/fallback/prerequisite rows and the [matrix](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fmail-compose-launcher/doc/plans/email/matrix.md) covers 990 app/action/platform combinations.


Each provider has its own planning draft; shared capabilities, matrix, source register and tests belong to #88. #89 contains only the roadmap. These are documentation proposals; runtime support is unverified.
