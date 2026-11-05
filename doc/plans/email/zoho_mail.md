# Implementation instructions: Zoho Mail

Draft planning brief for a future implementation. Documentation-only revision, checked **2026-10-11**. No API implemented, native route launched, message sent or store action added.

## Decision and blockers

Desktop downloads cover macOS/Windows/Linux and mobile page Android/iOS. Distinguish Mail from Admin/Streams; tenant/data-center hosts and web compose query contracts need verification.

Proposed class spelling: `ZohoMail`. `ZohoMail.open` is a candidate only where the table establishes a named route. `ZohoMail.compose` may implement the proposed [MailComposeAction](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fmail-compose-launcher/doc/plans/email/mail_compose_launcher.md) only after field-preservation and platform prerequisites pass. No public inbox/search/message method is promised by a blocked cell.

## Proposed API and action gates

```dart
ZohoMail.open({bool fallbackToStore = false})

// Enable only on platforms that pass the compose-field gate below.
ZohoMail.compose({
  List<String> to = const [],
  List<String> cc = const [],
  List<String> bcc = const [],
  String? subject,
  String? body,
  bool fallbackToStore = false,
})
```

These signatures are proposals. A blocked or unavailable-evidence cell is a research task, not permission to export that action or add a platform. Open follows the existing `App` / `DownloadableApp` pattern; a compatible text-compose action extends `ZohoMail` and implements `MailComposeAction` plus the appropriate `IntentAppLinkAction` or `AppLinkAppAction` and `Fallbackable`. Explicit desktop invocation needs the separate adapter before it can use this pattern. `supportedPlatforms` describes verified invocation, not downloaded app availability.

Inbox, Search and Message remain separate future action research. Do not add their constructors until the table's external route and account/message identity are established. Thunderbird's message-ID and Evolution's folder candidates require targeted adapters; no provider-specific sending, attachment or mailbox API is included here.

Keep default-handler compose and installed-app discovery separate from selecting this named provider. Apple Mail must not acquire a named `compose` action through generic `mailto:` alone. Attachments remain outside this five-field interface.

## Actions by platform

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | C | B | B | B | B | W |
| Compose | C | B | B | B | B | B |
| Inbox | B | B | B | B | B | B |
| Search | B | B | B | B | B | B |
| Message | B | B | B | B | B | B |

Status legend (self-contained):

- **D:** provider-documented invocation candidate; runtime not tested.
- **S:** first-party source candidate; release/manifest/handler verification still required.
- **C:** OS-contract candidate (Android package open or package-targeted SENDTO); app behavior/fields unverified.
- **E:** experimental, undocumented/community/historical route; never enable as stable support without evidence.
- **A:** adapter prerequisite; current DeeplinkX path cannot perform the proposed explicit CLI/application invocation.
- **B:** availability established but action route, identity or required fields remain blocked/unresolved.
- **U:** platform distribution/action not established in inspected evidence; does not mean unsupported.
- **W:** a website/store/product route can open; no particular inbox, draft, search or message is promised.

Every cell is research status, not implemented support. All runtime statuses are **not tested**. Open means launch the named app; Inbox is a separately addressed folder; Message is an existing message, not sending. Web Open is explicitly the exception: it can be a product/store page.

 In-app menu items, search features, or compose screenshots are not proof of external invocation.

## Platform evidence and prerequisites

| Platform | App availability | Identifiers | Native route research | Adapter / configuration prerequisite | Store / download route | Evidence |
| --- | --- | --- | --- | --- | --- | --- |
| Android | Listed; runtime not tested | Package `com.zoho.mail` | Package open candidate; SENDTO + mailto targeted to package for compose research | Package visibility query; resolve exact intent; verify all supplied fields | [Play listing](https://play.google.com/store/apps/details?id=com.zoho.mail) | [zoho_mail-vendor](https://www.zoho.com/mail/desktop/), [zoho_mail-additional](https://www.zoho.com/mail/mobile/), [zoho_mail-android](https://play.google.com/store/apps/details?id=com.zoho.mail), [android](https://developer.android.com/guide/components/intents-common#Email), [android-open](https://developer.android.com/reference/android/content/pm/PackageManager#getLaunchIntentForPackage(java.lang.String)), [android-visibility](https://developer.android.com/training/package-visibility/declaring) |
| iOS | Listed; runtime not tested | Store ID/bundle ID unverified | No named route established | Verify provider identity/handler before enabling | Not established; follow verified vendor downloads | [zoho_mail-vendor](https://www.zoho.com/mail/desktop/), [zoho_mail-additional](https://www.zoho.com/mail/mobile/), [ios-query](https://developer.apple.com/documentation/uikit/uiapplication/canopenurl(_:)) |
| macOS | Listed; runtime not tested | Bundle ID unverified | No named route established | Current install gate requires bundle ID; launchApp still needs a scheme. Explicit bundle URL/CLI launch needs adapter | Not established; follow verified vendor downloads | [zoho_mail-vendor](https://www.zoho.com/mail/desktop/), [zoho_mail-additional](https://www.zoho.com/mail/mobile/) |
| Windows | Listed; runtime not tested | Product/AppUserModelID/executable identity unverified | No named route established | Current scheme check identifies a handler, not necessarily this provider. Explicit executable/desktop launch needs adapter | Not established; follow verified vendor downloads | [zoho_mail-vendor](https://www.zoho.com/mail/desktop/), [zoho_mail-additional](https://www.zoho.com/mail/mobile/) |
| Linux | Listed; runtime not tested | Desktop-file ID/executable identity unverified | No named route established | Current scheme check identifies a handler, not necessarily this provider. Explicit executable/desktop launch needs adapter | Not established; follow verified vendor downloads | [zoho_mail-vendor](https://www.zoho.com/mail/desktop/), [zoho_mail-additional](https://www.zoho.com/mail/mobile/), [desktop-entry](https://specifications.freedesktop.org/desktop-entry-spec/latest/) |
| Web | Website/store route; client availability only where vendor confirms | Host from referenced product/store entry; tenant/account selection unverified | No native web route; browser URL only | Browser URL adapter; do not claim composer or named native handler | Not applicable | [zoho_mail-vendor](https://www.zoho.com/mail/desktop/), [zoho_mail-additional](https://www.zoho.com/mail/mobile/) |

All rows have runtime status **not tested**. A download/store entry does not establish handler registration. Missing store/desktop IDs remain explicit blockers; implementation must copy verified identifiers, not derive them from brand names.

## Text-compose fields and fallback

| Platform | Status | to / cc / bcc / subject / body | Fallback semantics |
| --- | --- | --- | --- |
| Android | C | OS proposal: to/cc/bcc arrays plus subject/body strings, or RFC 6068 URI. Provider handling and URI/extras precedence unverified; test before enabling. | Product / download page; no prefilled contract established |
| iOS | B | No verified named text-compose contract; all five fields unresolved. | Product / download page; no prefilled contract established |
| macOS | B | No verified named text-compose contract; all five fields unresolved. | Product / download page; no prefilled contract established |
| Windows | B | No verified named text-compose contract; all five fields unresolved. | Product / download page; no prefilled contract established |
| Linux | B | No verified named text-compose contract; all five fields unresolved. | Product / download page; no prefilled contract established |
| Web | B | No verified named text-compose contract; all five fields unresolved. | Product / download page; no prefilled contract established |


Never silently discard supplied recipients, subject or body. A future route must preserve every nonempty field or be rejected/skipped before launch; unverified cc/bcc is a blocker, not permission to omit it. A normal store/product fallback may open without prefilling anything, and `true` then means only a route opened. No generic default-mail action is inserted into a named-provider list.

Fallback entry candidate: [https://www.zoho.com/mail/](https://www.zoho.com/mail/) — **Product / download page**. No complete five-field prefilled compose contract is established here. Use [default-mail compose](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fmail-compose-launcher/doc/plans/email/default_mail_compose.md) separately. Attachments remain outside text compose; see [attachment research](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fmail-compose-launcher/doc/plans/email/attachments.md).

## Implementation gate and future verification

1. Match first-party route/parser and identifiers to the installed release, including exported Android activities, iOS queries, and desktop handler/application identity. Pin moving source links before implementing.
2. Verify all supplied fields, multiple recipients, Unicode, percent encoding and body newlines; skip incompatible routes without losing recipients.
3. Verify open separately from addressed Inbox, Search and Message. Message lookup needs account/folder identity and unavailable-message behavior; do not assume web roots or root schemes select Inbox.
4. Test handler missing, app logged out, multi-account selection, cold/warm start, unavailable store, native priority and normal fallback order. Add this provider to the selector only after a compose action exists and passes its gate.
5. Future integration must update exports, dedicated app docs, example catalog/logo/configuration and meaningful action tests; follow [test scenarios](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fmail-compose-launcher/doc/plans/email/test_scenarios.md). No release metadata changes in this research phase.

Evidence: [zoho_mail-android](https://play.google.com/store/apps/details?id=com.zoho.mail), [zoho_mail-vendor](https://www.zoho.com/mail/desktop/), [zoho_mail-additional](https://www.zoho.com/mail/mobile/), [android](https://developer.android.com/guide/components/intents-common#Email), [mailto](https://www.rfc-editor.org/rfc/rfc6068). Dates and evidence tiers are in the [source register](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fmail-compose-launcher/doc/plans/email/sources.md); secondary leads retain their original 2026-10-10 observation. Missing evidence is not confirmed lack of support.

## Required integration files for a later implementation

- `lib/src/apps/downloadable_apps/zoho_mail.dart`: app identity, verified platform/store metadata and only eligible action classes; export via `lib/src/apps/downloadable_apps/downloadable_apps.dart`.
- `lib/src/core/interfaces/mail_app_action_interface.dart` and `lib/src/core/interfaces/interfaces.dart`: consume the shared proposed interface when implemented; do not duplicate it per provider.
- `doc/apps/zoho_mail.md`: document callable actions, exact field mappings, platform configuration, evidence date and runtime limitations. Update `README.md` provider/action tables and counts only when this integration actually lands.
- `example/lib/catalog/models.dart`, `email_apps.dart`, `catalog.dart`: add the email category once, then this provider's verified actions; add `example/assets/zoho_mail.png` and update `example/test/catalog_test.dart` counts.
- `example/android/app/src/main/AndroidManifest.xml`: bounded package queries for verified Android IDs and SENDTO/mailto intent visibility where needed. Use the package from the table, never a guessed activity class. Resolve the installed app's exported handler before enabling compose.
- `example/ios/Runner/Info.plist`: exact verified scheme under `LSApplicationQueriesSchemes`; store ID alone does not justify a scheme or native iOS support. Do not add experimental schemes as stable routes without a recorded validation decision.
- `test/src/apps/zoho_mail_test.dart`, `test/deeplink_x_test.dart`: metadata, action interfaces, generated URI/intent fields, unsupported-platform handling and fallback cases. Desktop adapter changes need their own native tests and identity evidence.
- `example/lib/use_cases/mail_selector_page.dart`, `example/lib/home.dart`, `example/test/use_cases_test.dart`: include only implemented, compatible compose actions. Label store, product/support page and web-client fallback destinations accurately.

For apps with a verified Android package, future Android compose uses `android.intent.action.SENDTO`, `mailto:` data and the verified package. Determine whether URI headers or standard extras (`EXTRA_EMAIL`, `EXTRA_CC`, `EXTRA_BCC`, `EXTRA_SUBJECT`, `EXTRA_TEXT`) are actually parsed by this app, and verify bridge types and precedence. OS documentation alone does not prove app acceptance. Do not substitute wildcard ACTION_SEND for text compose.

Match `launchMailComposeAction(actions:, disableFallback:)` to the existing map launcher: all actions in priority order with fallback disabled, stop on success; if permitted, repeat in order with normal `launchAction`, which retries native then requested stores then the fallback URL. Empty/all-failed returns false. `true` means a route opened, including a store or website; it does not validate a draft or sending. Never automatically insert generic default-mail compose.

## Acceptance tests before exposing actions

1. Every supplied to/cc/bcc recipient, subject and body survives exactly; unverified or incompatible fields cause the native/prefilled route to be skipped/rejected before launch. Cover multiple recipients, cc-only, bcc-only and empty drafts.
2. Persian/Unicode, emoji, plus addresses, reserved characters, percent signs and body newlines survive one encoding/decoding pass. Assert provider-specific query names and delimiters from evidence.
3. All native attempts precede normal fallbacks; cover first/later native success, second-pass native retry, store/site failures, disabled fallback, empty lists and missing handlers.
4. Verify named-provider identity with another app set as default, invisible packages, cold/warm start, logged-out and multiple-account states. Root Open does not prove Inbox/Search/Message.
5. Runtime records include OS/app version, pinned source, route, input and observed draft/destination. Attachments require separate file/URI-grant tests and must not be silently dropped through this contract.

Run the pinned FVM SDK's formatter, analysis, root tests and relevant example/native tests when implementing. This draft only changes documentation; version, changelog, lockfiles and feature counts await a separately authorized implementation/release.

## Direct evidence and dates

- [Android email intents](https://developer.android.com/guide/components/intents-common#Email) — Primary; checked/observed **2026-10-11**. SENDTO/mailto and standard recipient arrays/subject/text; each app must resolve and preserve fields.
- [Android package root launch](https://developer.android.com/reference/android/content/pm/PackageManager#getLaunchIntentForPackage(java.lang.String)) — Primary; checked/observed **2026-10-11**. Package root launch intent; does not select Inbox or Compose.
- [Android package visibility](https://developer.android.com/training/package-visibility/declaring) — Primary; checked/observed **2026-10-11**. Bounded package/intent queries; querying visibility is separate from launch success.
- [freedesktop desktop entry specification](https://specifications.freedesktop.org/desktop-entry-spec/latest/) — Primary; checked/observed **2026-10-11**. Linux desktop entries/Exec identity research; not proof of installed provider or compose handling.
- [Apple URL handler queries](https://developer.apple.com/documentation/uikit/uiapplication/canopenurl(_:)) — Primary; checked/observed **2026-10-11**. canOpenURL and scheme query configuration; does not enumerate installed mail apps.
- [RFC 6068](https://www.rfc-editor.org/rfc/rfc6068) — Primary; checked/observed **2026-10-11**. URI encoding and text compose; no portable attachment parameter.
- [zoho_mail additional platform evidence](https://www.zoho.com/mail/mobile/) — Primary; checked/observed **2026-10-11**. Additional vendor app/platform availability, not an external action contract.
- [Zoho Mail Android listing](https://play.google.com/store/apps/details?id=com.zoho.mail) — Primary; checked/observed **2026-10-11**. Verified package ID and Android availability only.
- [Zoho Mail official platform/download evidence](https://www.zoho.com/mail/desktop/) — Primary; checked/observed **2026-10-11**. Listed app availability and official download entry points; actions require separate evidence.

Internet/community and historical references are experimental leads only. Pin moving first-party source to the installed release before implementation. Research dates are retained; publication does not imply a new provider or device check.
