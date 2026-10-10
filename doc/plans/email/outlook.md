# Plan: Outlook actions

Implementation brief for a later change. Replace this file with the integration. Do not merge the brief by itself.

Checked 10 October 2026.

## Actions

- Open app (`Outlook.open`)
- Compose (`Outlook.compose`), implementing `MailComposeAction`

## API

```dart
Outlook.open({bool fallbackToStore = false})

Outlook.compose({
  List<String> to = const [],
  List<String> cc = const [],
  List<String> bcc = const [],
  String? subject,
  String? body,
  bool fallbackToStore = false,
})
```

`compose` implements `MailComposeAction`, `AppLinkAppAction` or `IntentAppLinkAction`, and `Fallbackable`. Do not add attachments. A Microsoft Q&A reply says the Outlook scheme cannot attach files.

## Identifiers

- Android package: `com.microsoft.office.outlook`
- Play listing: <https://play.google.com/store/apps/details?id=com.microsoft.office.outlook>
- iOS App Store id `951937596`, slug `microsoft-outlook`: <https://apps.apple.com/us/app/microsoft-outlook/id951937596>
- Custom scheme: `ms-outlook`
- Platforms: iOS and Android. Outlook also has Mac and Windows apps; do not add those platforms until a published macOS bundle id or a documented desktop URI is confirmed. Leave `macosBundleIdentifier` unset.
- Website: `https://outlook.live.com`
- Store actions: Play and the iOS App Store. Add a Microsoft Store action only if a current product id is copied from the Microsoft Store listing during implementation.

## URLs

Open: `ms-outlook://` on iOS, and the Android package launch on Android.

Compose is not settled in public sources. Record both forms and pick one only after a device check on current Outlook builds:

- iOS reports, including a Microsoft Q&A question: `ms-outlook://compose?to=<address>&subject=<subject>&body=<body>`
- A January 2024 report says `compose` stopped working and the replacement is `ms-outlook://emails/new?to=<address>&subject=<subject>&body=<body>`
- Android reports use `ms-outlook://emails/new?to=<address>` for a draft. A 2022 decompile of Outlook 4.2212.2 lists `emails/new` with `to`, `name`, `body`, and `type`. That decompile is not a Microsoft document, and its notes confuse the mail composer with a calendar event. Do not treat the extra hosts (`emails/inbox`, `events/new`, `events/view`, `search`) as supported actions.

Multiple recipients in the iOS `compose` examples are joined with semicolons. `cc` and `bcc` are not in those examples; add them only if a device check accepts them.

Until the device check, implement the action so the chosen host is one constant that tests can assert. Do not encode both hosts.

Web fallback: confirm the current Outlook on the web compose URL before setting `fallbackLink`. Do not invent query names. If no stable prefilled web URL is confirmed, `fallbackLink` is `https://outlook.live.com` and the doc page says it does not prefill the message.

Android may also compose with `ACTION_SENDTO` and a `mailto:` URI targeted at `com.microsoft.office.outlook`. A 2019 report says that intent crashed when the package was set on `ACTION_SEND`. Prefer the verified `ms-outlook` URL, and use the intent only if the URL fails on a current Android build.

## Sources

- Play and App Store listings above, checked 10 October 2026.
- iOS compose examples: <https://stackoverflow.com/questions/33190891/ios-url-scheme-microsoft-outlook-app>
- Microsoft Q&A, using `ms-outlook://compose` and `ms-outlook://events/open`: <https://learn.microsoft.com/en-us/answers/questions/4556024/ios-outlook-mobile-app-fails-to-fully-open-links>
- January 2024 report of `emails/new`: <https://stackoverflow.com/questions/32369198/i-just-want-to-open-ms-outlook-app-and-see-mailto-screen-using-url-scheme-at-ios>
- Android `emails/new` and a failed `mailto` intent: <https://stackoverflow.com/questions/57205554/ms-outlook-uri-scheme-no-longer-working-for-xamarin-android>
- Decompile notes for Outlook 4.2212.2: <https://gist.github.com/wilkinvr/c3b77938f45b01a33cbb6df1e146a0e7>
- Attachments are not supported on the scheme: <https://learn.microsoft.com/en-us/answers/questions/869774/url-scheme-microsoft-outlook-app-with-attachment>

## Limits

No attachments, calendar events, or search. The compose host stays unresolved until a device check.

## Files a later implementation must touch

Follow the new-app checklist in `AGENTS.md`. This branch does not add the Dart API.

- `lib/src/apps/downloadable_apps/outlook.dart`
- Export it from `lib/src/apps/downloadable_apps/downloadable_apps.dart`.
- `doc/apps/outlook.md` for usage, schemes, store identifiers, and platform configuration.
- `README.md`: feature counts, the supported-app list, and the documentation list. Compose-capable apps also join the `launchMailComposeAction` provider list when that launcher exists.
- Example catalog: add `CatalogCategory.email` in `example/lib/catalog/models.dart`, add `example/lib/catalog/email_apps.dart`, include it from `example/lib/catalog/catalog.dart`, add `example/assets/outlook.png`, and update the counts in `example/test/catalog_test.dart`.
- `example/ios/Runner/Info.plist`: add the custom scheme under `LSApplicationQueriesSchemes` only when a scheme is listed below.
- `example/android/app/src/main/AndroidManifest.xml`: add a `<package android:name="..."/>` query only when an Android package is listed below.
- `test/src/apps/outlook_test.dart` covering store actions, app links, and fallbacks.
- `test/deeplink_x_test.dart` exposed-API list.
- The compose action implements `MailComposeAction` and is added to the option list in `example/lib/use_cases/mail_selector_page.dart`.
- Run `dart format`, `flutter analyze`, and `flutter test` (via FVM if this checkout requires it). Bump `pubspec.yaml` and update `CHANGELOG.md` when the feature is released, not in this brief.

## Release limit

Device-check every native URL before release. An unpublished draft stays out of the version bump until that check passes, the same standard already used for TomTom GO Expert.
