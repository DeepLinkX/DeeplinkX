# Proposal: shared mail compose launcher

Revision of [draft PR #88](https://github.com/DeepLinkX/DeeplinkX/pull/88), checked **2026-10-11**. Documentation only. Preserve shared map launcher behavior; no implementation or API export is added in this phase.

## Proposed interface

Retain the original names and text-only fields:

```dart
abstract class MailAppAction extends DownloadableApp implements AppAction {}

abstract class MailComposeAction extends MailAppAction {
  List<String> get to;
  List<String> get cc;
  List<String> get bcc;
  String? get subject;
  String? get body;
}

Future<bool> launchMailComposeAction({
  required List<MailComposeAction> actions,
  bool disableFallback = false,
});
```

These are proposals, not callable APIs. Future implementation locations remain `lib/src/core/interfaces/mail_app_action_interface.dart`, its interface export, and `lib/src/core/deeplink_x.dart`. App-specific constructors should retain `to`, `cc`, `bcc`, `subject`, `body` and `fallbackToStore` from their original compose proposals. Do not require a nonempty `to` at interface level: an empty draft is a distinct test case; example forms may impose their own validation.

## Exact two-pass contract

Match [_launchMapActions](https://github.com/DeepLinkX/DeeplinkX/blob/f8225e35158d4b69c9ddb7e8128418e9b278d33c/lib/src/core/deeplink_x.dart), including normal `launchAction` retry behavior:

1. In caller order, await `launchAction(action, disableFallback: true)` for each action. Stop at the first `true`.
2. If every native attempt fails and `disableFallback` is `true`, return `false`.
3. Otherwise, in the same caller order, await normal `launchAction(action)` for each action. Stop at the first `true`.
4. Return `false` when all attempts fail, including an empty list.

The second pass retries each action's native path before its normal fallback. It is not a fallback-URL-only loop. Within normal `launchAction`, a requested store fallback precedes the action's `Fallbackable` URL. Stores, product/download/support pages and web clients are possible results. Keep this behavior even when a route does not prefill a message.

**`true` means some route opened**, including a store or website. It does not prove the intended provider opened, a compose sheet appeared, fields survived, or mail was sent. `disableFallback` suppresses stores/websites from this shared loop; it does not guarantee that a provider has a compatible native route.

Native calls remain subject to the existing installation/platform gate and exception handling. An Android intent returning `false` can permit the action's app-link attempt; an exception can jump directly to the action's fallback handling. Do not promise custom-scheme-then-intent retry behavior without checking the implementation. Map behavior stays unchanged; any future shared helper must preserve existing tests.

## Provider readiness and field preservation

The original seven compose proposals (Gmail, Outlook, Yahoo Mail, Spark, Airmail, Fastmail, Samsung Email) are candidates, not an implemented provider list. Proton Android, FairEmail and Thunderbird/K-9 have additional first-party source leads. Desktop clients require the [desktop prerequisites](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fmail-compose-launcher/doc/plans/email/desktop_launch_prerequisites.md) before entering a native priority list. See [matrix](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fmail-compose-launcher/doc/plans/email/matrix.md) for platform-specific readiness.

Every future native or prefilled web compose route must preserve all supplied nonempty fields. If cc/bcc, subject, body or a recipient separator is unverified or unsupported, reject/skip that route before launch; do not silently discard fields. Normal non-compose fallback may still open under the contract above, with clear labeling. A successful URL launch cannot validate recipient preservation; inspect the resulting draft on devices.

Open-only actions do not implement `MailComposeAction`. Do not automatically insert generic `mailto:` as a named provider's native action or fallback: it could select another provider before the rest of the native priority list. [Default-mail compose](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fmail-compose-launcher/doc/plans/email/default_mail_compose.md) is explicitly separate. Attachments, HTML, sender override and sending are outside this text-compose contract.

## Future README, example and tests

- README: describe native attempts in priority order followed by **normal fallbacks**, and the bounded meaning of `true`. Provider tables list only integrations that have landed and passed their field/platform gates.
- Example: retain a proposed Mail Selector alongside Map Selector, with to/cc/bcc/subject/body inputs. Build `LaunchOption<MailComposeAction>` only for implemented compose actions; automatic selection calls the proposed shared launcher, manual selection calls `launchAction`. Label each fallback destination accurately: web client, store, product or support page. Do not say “first provider's web fallback” when normal launchAction may reach a store or a later provider.
- Keep logo/catalog/scheme/package setup with each eventual integration. Update the selector fake and exposed-API tests when an implementation is authorized.
- Verify exact call order, second-pass native retries, early success, disabled fallback, empty list and field integrity using [future test scenarios](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fmail-compose-launcher/doc/plans/email/test_scenarios.md).

No release metadata changes in this brief. Evidence: [local product execution notes](https://github.com/DeepLinkX/DeeplinkX/blob/f8225e35158d4b69c9ddb7e8128418e9b278d33c/lib/src/core/deeplink_x.dart), [Android](https://developer.android.com/guide/components/intents-common#Email), [mailto](https://www.rfc-editor.org/rfc/rfc6068).

## Future integration file checklist

- `lib/src/core/interfaces/mail_app_action_interface.dart`, `lib/src/core/interfaces/interfaces.dart`: shared interfaces and export.
- `lib/src/core/deeplink_x.dart`: public method and exact two-pass loop; preserve map behavior.
- `README.md`: bounded result semantics and implemented-provider table.
- `test/src/core/deeplink_x_test.dart`, `test/deeplink_x_test.dart`: call order, retries, stop-on-success, disabled fallback, empty list and exposed API.
- `example/lib/use_cases/mail_selector_page.dart`, `example/lib/home.dart`, `example/test/use_cases_test.dart`: selector, priority options, accurate fallback labels and fake launcher.

Default-mail, discovery, attachments and desktop briefs define independent adapter design gates; do not expand the text-compose interface to absorb them. Future code requires pinned FVM formatting, analysis, meaningful root/example tests and device validation; release metadata is unchanged in this planning draft.
