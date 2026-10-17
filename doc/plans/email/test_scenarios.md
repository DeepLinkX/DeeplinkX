# Future email verification scenarios

Checked **2026-10-11**. These are acceptance requirements for future implementation, not tests run in this documentation phase. No Dart test or runtime result is claimed.

| Area | Scenarios | Required observation |
| --- | --- | --- |
| Recipient preservation | Multiple to/cc/bcc, cc-only/bcc-only drafts, all fields together; unverified cc/bcc route | Every supplied recipient survives, or the incompatible native/prefilled route is skipped/rejected before launch |
| Text and encoding | Persian/Unicode, emoji, plus-addresses, spaces, commas, ampersands, percent signs, fragments, body newlines and empty/null fields | Correct draft text after one encoding/decoding pass; no recipient loss, truncation or parameter injection |
| Native priority | Earlier installed app fails, later native succeeds; handler falsely reports availability | All native actions attempted in caller order before any normal fallback; stop on first success |
| Normal fallback | All first-pass attempts fail; second-pass native retry succeeds; stores fail then site succeeds; earlier site fails then later fallback succeeds | Exact existing map call order: A(native), B(native), A(normal), B(normal); normal calls can retry native and then store/website |
| Disabled fallback | Native failures with disableFallback true | False with no stores or websites attempted |
| Empty list | No actions supplied | False and no launch calls |
| Result semantics | Store/product page opens successfully | True means route opened; UI/documentation never says draft created or sent |
| Error handling | Platform exception, false launch return, missing handler, invisible package, unavailable store | Match current launchAction behavior; no promised alternate native retry after exception without implementation evidence |
| Provider identity | Other app set as default; colliding schemes; changed default; selected provider missing | Named-provider routes stay distinct from default handler and bounded discovery |
| Lifecycle/account | Cold/warm app, no configured account, logged out, multiple accounts, canceled picker | Document actual account selection and failure/cancellation; opening alone does not validate fields |
| Action destinations | Root open versus Inbox, Search, Message; missing message-ID; account-local folder | Explicit addressed destination verified; in-app features/root URL do not prove external route |
| Attachments | Single/multiple, URI grants, missing/locked/large files, MIME mismatch, Unicode path, sandbox grants | Files retained in output draft or route rejected; no silent file loss |
| Desktop targeting | macOS bundle lookup and explicit app open; Windows variants; Linux Flatpak/Snap/executable missing | Installation and native invocation both proven; CLI arguments passed without shell interpolation |

Each device record must identify date, OS/build, app version/source pin, launch route, supplied fields/files, expected outcome, observed draft/destination and limitations. Sanitize test recipients/files in reports. Use a test account; sending is outside this launch task. Preserve map-launcher regression checks if a helper is shared later.

Future Dart integrations follow pinned FVM SDK, formatting, package analysis, relevant tests and feasible device checks. Documentation-only link/content/patch checks cannot replace those runtime requirements.
