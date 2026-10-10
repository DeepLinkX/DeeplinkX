# Plan: mail compose launcher

Implementation brief for a later change. Replace this file with the integration. Do not merge the brief by itself.

Checked 10 October 2026.

## Feature

`Launch mail compose` is a shared launcher, in the same role as `launchMapDirectionsWithCoordsAction`. Callers pass compose actions in priority order. DeeplinkX opens the first installed mail app, then uses a web fallback only if none of the native launches succeed.

## API

Add `lib/src/core/interfaces/mail_app_action_interface.dart` beside `lib/src/core/interfaces/map_app_action_interface.dart`, and export it from `lib/src/core/interfaces/interfaces.dart`.

```dart
abstract class MailAppAction extends DownloadableApp implements AppAction {}

abstract class MailComposeAction extends MailAppAction {
  List<String> get to;
  List<String> get cc;
  List<String> get bcc;
  String? get subject;
  String? get body;
}
```

Add this method on `DeeplinkX` in `lib/src/core/deeplink_x.dart`, next to the `launchMap*Action` methods:

```dart
Future<bool> launchMailComposeAction({
  required List<MailComposeAction> actions,
  bool disableFallback = false,
})
```

Behavior matches `_launchMapActions`:

1. Try each action with `launchAction(action, disableFallback: true)`.
2. Return true on the first success.
3. If `disableFallback` is true, return false after the native pass.
4. Otherwise try each action with normal fallback and return true on the first success.
5. Return false when every attempt fails, including an empty list.

Keep the map methods' behavior unchanged. A private helper shared with `_launchMapActions` is fine when the existing map tests still pass. Duplicating the loop as `_launchMailActions` is also fine.

Only compose actions implement `MailComposeAction`. Open-only mail apps stay out of this list.

Apps that implement it, once their own integrations land:

- Gmail
- Outlook
- Yahoo Mail
- Spark
- Airmail
- Fastmail
- Samsung Email

Each app's compose action maps the shared fields onto that app's real query names. Spark uses `recipient` for `to`. Airmail uses `plainBody` for `body`. Samsung Email uses a package-targeted `mailto:` intent and has no web composer.

## README

Add a section in the same place and shape as "Open a map, search a place, or get directions":

- Short explanation: pass the mail apps in priority order; DeeplinkX opens the first installed one, then the first fallback.
- A `launchMailComposeAction` example that lists the compose-capable apps.
- A provider table with one row, `launchMailComposeAction`, and those apps.
- Note Samsung Email is Android-only and its fallback does not prefill a message.
- Note Fastmail's compose URL is unverified until a device check.
- Note Outlook's compose host (`compose` versus `emails/new`) is chosen only after a device check.
- Extend the result table: `launchMailComposeAction` returns true when any listed provider or its fallback launches.

Do not add open-only apps to that table.

## Tests

Mirror the `launchMap*Action` cases:

- `test/src/core/deeplink_x_test.dart`: later native actions run before any fallback; fallback runs only after every native attempt fails; `disableFallback` skips the fallback pass; an empty list returns false.
- `test/deeplink_x_test.dart`: exposed-API check for `launchMailComposeAction`, plus a `MockMailComposeAction` next to the map mocks.

## Example

Follow `example/lib/use_cases/map_selector_page.dart`.

- Add `example/lib/use_cases/mail_selector_page.dart`.
- Fields: to, cc, bcc, subject, and body. To is required before launch. Cc, bcc, subject, and body are optional.
- Build one `LaunchOption<MailComposeAction>` per compose-capable app, with the logo asset, a web-fallback label, and that app's `compose` action.
- Order: Gmail, Outlook, Yahoo Mail, Spark, Airmail, Fastmail, Samsung Email. Samsung Email stays last because it is Android-only.
- Call `showLaunchSelector<MailComposeAction>` from `example/lib/use_cases/use_case_support.dart`.
- Automatic action: `deeplinkX.launchMailComposeAction(actions: options.map((option) => option.app).toList())`.
- Manual action: `deeplinkX.launchAction`.
- Subtitle: try installed providers in order, then use the first provider's web fallback.
- Add a home tile in `example/lib/home.dart` next to Map Selector. Title: Mail Selector. Description: compose across installed mail apps.
- In `example/test/use_cases_test.dart`, extend `_FakeDeeplinkX` with `launchMailComposeAction`, recording the action list the way `launchMapDirectionsWithCoordsAction` records map actions. Cover the selector opening and the automatic launch.

Logos and catalog entries come from each app's own integration. This launcher page lists an app only after that app's compose action exists. Until then, the page can be added with the apps that have already landed, in the order above.

## Files

- `lib/src/core/interfaces/mail_app_action_interface.dart`
- `lib/src/core/interfaces/interfaces.dart`
- `lib/src/core/deeplink_x.dart`
- `README.md`
- `test/src/core/deeplink_x_test.dart`
- `test/deeplink_x_test.dart`
- `example/lib/use_cases/mail_selector_page.dart`
- `example/lib/home.dart`
- `example/test/use_cases_test.dart`
- Each compose action class from the app briefs

## Checks

Run `dart format`, `flutter analyze`, and `flutter test` (via FVM if this checkout requires it), including `example/test`. Bump `pubspec.yaml` and update `CHANGELOG.md` when the feature is released, not in this brief.

## Limits

No attachment parameter. No shared "open any mail app" method. No generic default-mail picker. Open-only apps are not in the selector.
