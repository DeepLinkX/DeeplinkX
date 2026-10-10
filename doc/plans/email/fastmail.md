# Plan: Fastmail actions

Implementation brief for a later change. Replace this file with the integration. Do not merge the brief by itself.

Checked 10 October 2026.

## Actions

- Open app (`Fastmail.open`)
- Compose (`Fastmail.compose`), implementing `MailComposeAction`

## API

```dart
Fastmail.open({bool fallbackToStore = false})

Fastmail.compose({
  List<String> to = const [],
  List<String> cc = const [],
  List<String> bcc = const [],
  String? subject,
  String? body,
  bool fallbackToStore = false,
})
```

The only public compose example uses `to`, `subject`, and `body`. Keep `cc` and `bcc` on the Dart API and omit them from the URL until a device check accepts them.

## Identifiers

- Android package: `com.fastmail.app`
- Play listing: <https://play.google.com/store/apps/details?id=com.fastmail.app>
- iOS App Store id `931370077`, slug `fastmail-email-calendar`: <https://apps.apple.com/us/app/fastmail-email-calendar/id931370077>
- Custom scheme: `fastmail`
- Platforms: iOS and Android. The iOS listing checked on 10 October 2026 does not include a Mac app. Leave `macosBundleIdentifier` unset.
- Website: `https://www.fastmail.com`
- Store actions: Play and the iOS App Store.

## URLs

Open: `fastmail://` on iOS, and the Android package launch on Android.

Compose, from a secondary article rather than a Fastmail document:

```text
fastmail://mail/compose?to=<address>&subject=<subject>&body=<body>
```

Mark this URL as unverified in `doc/apps/fastmail.md` until a device check on a current Fastmail build succeeds. If the check fails, ship `Fastmail.open` only and drop `compose` from the roadmap entry rather than guessing another path.

Android compose fallback inside the action: `ACTION_SENDTO` `mailto:` targeted at `com.fastmail.app` if the custom scheme does not compose on Android.

Web fallback: `https://www.fastmail.com` or `https://app.fastmail.com` if that host is the signed-in app. No prefilled web query was confirmed, so `fallbackLink` does not prefill the draft.

## Sources

- Play and App Store listings above, checked 10 October 2026.
- Secondary compose write-up: <https://azorychta.medium.com/composing-email-on-ios-via-custom-url-schemes-7d408ae5b0aa>

## Limits

The compose path is not a Fastmail-published document. No attachments. No `cc` or `bcc` on the native URL until verified.

## Files a later implementation must touch

Follow the new-app checklist in `AGENTS.md`. This branch does not add the Dart API.

- `lib/src/apps/downloadable_apps/fastmail.dart`
- Export it from `lib/src/apps/downloadable_apps/downloadable_apps.dart`.
- `doc/apps/fastmail.md` for usage, schemes, store identifiers, and platform configuration.
- `README.md`: feature counts, the supported-app list, and the documentation list. Compose-capable apps also join the `launchMailComposeAction` provider list when that launcher exists.
- Example catalog: add `CatalogCategory.email` in `example/lib/catalog/models.dart`, add `example/lib/catalog/email_apps.dart`, include it from `example/lib/catalog/catalog.dart`, add `example/assets/fastmail.png`, and update the counts in `example/test/catalog_test.dart`.
- `example/ios/Runner/Info.plist`: add the custom scheme under `LSApplicationQueriesSchemes` only when a scheme is listed below.
- `example/android/app/src/main/AndroidManifest.xml`: add a `<package android:name="..."/>` query only when an Android package is listed below.
- `test/src/apps/fastmail_test.dart` covering store actions, app links, and fallbacks.
- `test/deeplink_x_test.dart` exposed-API list.
- The compose action implements `MailComposeAction` and is added to the option list in `example/lib/use_cases/mail_selector_page.dart`.
- Run `dart format`, `flutter analyze`, and `flutter test` (via FVM if this checkout requires it). Bump `pubspec.yaml` and update `CHANGELOG.md` when the feature is released, not in this brief.

## Release limit

Device-check every native URL before release. An unpublished draft stays out of the version bump until that check passes, the same standard already used for TomTom GO Expert.
