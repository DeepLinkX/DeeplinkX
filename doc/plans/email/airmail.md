# Plan: Airmail actions

Implementation brief for a later change. Replace this file with the integration. Do not merge the brief by itself.

Checked 10 October 2026.

## Actions

- Open app (`Airmail.open`)
- Compose (`Airmail.compose`), implementing `MailComposeAction`

## API

```dart
Airmail.open({bool fallbackToStore = false})

Airmail.compose({
  List<String> to = const [],
  List<String> cc = const [],
  List<String> bcc = const [],
  String? subject,
  String? body,
  bool fallbackToStore = false,
})
```

Map `body` to the query name `plainBody`. Do not expose `htmlBody` or `from`. Do not add the x-callback `send` action.

## Identifiers

- Custom scheme: `airmail`
- iOS App Store id `993160329`, slug `airmail-for-gmail-outlook-mail`: <https://apps.apple.com/us/app/airmail-for-gmail-outlook-mail/id993160329>
- Mac App Store id `918858936`, slug `airmail-lightning-fast-email`: <https://apps.apple.com/us/app/airmail-lightning-fast-email/id918858936>
- Android package: none found on 10 October 2026. Do not invent one. Leave `androidPackageName` unset and omit Play.
- Platforms: iOS and macOS. macOS install checks need `macosBundleIdentifier`. Read it from the Mac listing metadata or the installed app before adding `PlatformType.macos`. Until that id is known, ship iOS only and keep the Mac App Store id in the doc page as a follow-up.
- Website: `https://airmailapp.com`
- Store actions: iOS App Store, plus Mac App Store once macOS is enabled.

## URLs

Open: `airmail://`

Compose, from Airmail's help article updated 28 March 2026:

```text
airmail://compose?subject=<subject>&to=<address>&cc=<address>&bcc=<address>&plainBody=<body>
```

The official template also allows `from` and `htmlBody`. Omit both. Percent-encode values.

The help example writes a second address as `&ann%40example.com` without a key. Treat that as a broken example, not as a second query format. Use a repeated or comma-separated `to` only after a device check.

Do not implement `airmail://x-callback-url/send`.

Web fallback: `https://airmailapp.com`. Airmail has no web composer in the sources below, so `fallbackLink` does not prefill a message.

## Sources

- Airmail iOS URL scheme, updated 28 March 2026: <https://help.airmailapp.com/en-us/article/airmail-ios-url-scheme-1q060gy/>
- iOS and Mac App Store listings above, checked 10 October 2026.

## Limits

No Android package. No HTML body, sender override, attachments, or x-callback send.

## Files a later implementation must touch

Follow the new-app checklist in `AGENTS.md`. This branch does not add the Dart API.

- `lib/src/apps/downloadable_apps/airmail.dart`
- Export it from `lib/src/apps/downloadable_apps/downloadable_apps.dart`.
- `doc/apps/airmail.md` for usage, schemes, store identifiers, and platform configuration.
- `README.md`: feature counts, the supported-app list, and the documentation list. Compose-capable apps also join the `launchMailComposeAction` provider list when that launcher exists.
- Example catalog: add `CatalogCategory.email` in `example/lib/catalog/models.dart`, add `example/lib/catalog/email_apps.dart`, include it from `example/lib/catalog/catalog.dart`, add `example/assets/airmail.png`, and update the counts in `example/test/catalog_test.dart`.
- `example/ios/Runner/Info.plist`: add the custom scheme under `LSApplicationQueriesSchemes` only when a scheme is listed below.
- `example/android/app/src/main/AndroidManifest.xml`: add a `<package android:name="..."/>` query only when an Android package is listed below.
- `test/src/apps/airmail_test.dart` covering store actions, app links, and fallbacks.
- `test/deeplink_x_test.dart` exposed-API list.
- The compose action implements `MailComposeAction` and is added to the option list in `example/lib/use_cases/mail_selector_page.dart`.
- Run `dart format`, `flutter analyze`, and `flutter test` (via FVM if this checkout requires it). Bump `pubspec.yaml` and update `CHANGELOG.md` when the feature is released, not in this brief.

## Release limit

Device-check every native URL before release. An unpublished draft stays out of the version bump until that check passes, the same standard already used for TomTom GO Expert.
