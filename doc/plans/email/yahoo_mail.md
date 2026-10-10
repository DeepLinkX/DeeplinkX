# Plan: Yahoo Mail actions

Implementation brief for a later change. Replace this file with the integration. Do not merge the brief by itself.

Checked 10 October 2026.

## Actions

- Open app (`YahooMail.open`)
- Compose (`YahooMail.compose`), implementing `MailComposeAction`

## API

```dart
YahooMail.open({bool fallbackToStore = false})

YahooMail.compose({
  List<String> to = const [],
  List<String> cc = const [],
  List<String> bcc = const [],
  String? subject,
  String? body,
  bool fallbackToStore = false,
})
```

The public compose URL uses `to`, `subject`, and `body`. Keep `cc` and `bcc` on the Dart API for `MailComposeAction`, and omit them from the URL until a device check shows Yahoo Mail accepts them.

## Identifiers

- Android package: `com.yahoo.mobile.client.android.mail`
- Play listing: <https://play.google.com/store/apps/details?id=com.yahoo.mobile.client.android.mail>
- iOS App Store id `577586159`, slug `yahoo-mail-your-email-inbox`: <https://apps.apple.com/us/app/yahoo-mail-your-email-inbox/id577586159>
- Custom scheme: `ymail`
- Platforms: iOS and Android. No Mac bundle id was found, so leave `macosBundleIdentifier` unset.
- Website: `https://mail.yahoo.com`
- Store actions: Play and the iOS App Store only, unless another store listing is found while implementing.

## URLs

Open: `ymail://` on iOS, and the Android package launch on Android.

Compose, from a public iOS report:

```text
ymail://mail/compose?to=<address>&subject=<subject>&body=<body>
```

Percent-encode query values. The path includes `mail/compose`.

Android compose: target package `com.yahoo.mobile.client.android.mail` with `ACTION_SENDTO` and a `mailto:` URI when `ymail` does not compose on Android. Do not hard-code an activity class name. A 2014 note names `com.yahoo.mobile.client.android.mail.activity.MainActivity`; that class is not a stable contract.

Web fallback: `https://mail.yahoo.com`. A prefilled Yahoo web composer was not confirmed in the sources below, so `fallbackLink` opens the site and the doc page says it does not prefill the draft.

## Sources

- Play and App Store listings above, checked 10 October 2026.
- Compose URL: <https://stackoverflow.com/questions/43453852/using-openurl-to-send-an-email-from-yahoo-mail-client>
- Package launch: <https://stackoverflow.com/questions/24073982/launch-yahoo-mail-from-another-app>

## Limits

No attachments. `cc` and `bcc` stay off the native URL until verified.

## Files a later implementation must touch

Follow the new-app checklist in `AGENTS.md`. This branch does not add the Dart API.

- `lib/src/apps/downloadable_apps/yahoo_mail.dart`
- Export it from `lib/src/apps/downloadable_apps/downloadable_apps.dart`.
- `doc/apps/yahoo_mail.md` for usage, schemes, store identifiers, and platform configuration.
- `README.md`: feature counts, the supported-app list, and the documentation list. Compose-capable apps also join the `launchMailComposeAction` provider list when that launcher exists.
- Example catalog: add `CatalogCategory.email` in `example/lib/catalog/models.dart`, add `example/lib/catalog/email_apps.dart`, include it from `example/lib/catalog/catalog.dart`, add `example/assets/yahoo_mail.png`, and update the counts in `example/test/catalog_test.dart`.
- `example/ios/Runner/Info.plist`: add the custom scheme under `LSApplicationQueriesSchemes` only when a scheme is listed below.
- `example/android/app/src/main/AndroidManifest.xml`: add a `<package android:name="..."/>` query only when an Android package is listed below.
- `test/src/apps/yahoo_mail_test.dart` covering store actions, app links, and fallbacks.
- `test/deeplink_x_test.dart` exposed-API list.
- The compose action implements `MailComposeAction` and is added to the option list in `example/lib/use_cases/mail_selector_page.dart`.
- Run `dart format`, `flutter analyze`, and `flutter test` (via FVM if this checkout requires it). Bump `pubspec.yaml` and update `CHANGELOG.md` when the feature is released, not in this brief.

## Release limit

Device-check every native URL before release. An unpublished draft stays out of the version bump until that check passes, the same standard already used for TomTom GO Expert.
