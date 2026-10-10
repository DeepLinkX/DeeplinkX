# Plan: Spark actions

Implementation brief for a later change. Replace this file with the integration. Do not merge the brief by itself.

Checked 10 October 2026.

## Actions

- Open app (`Spark.open`)
- Compose (`Spark.compose`), implementing `MailComposeAction`

## API

```dart
Spark.open({bool fallbackToStore = false})

Spark.compose({
  List<String> to = const [],
  List<String> cc = const [],
  List<String> bcc = const [],
  String? subject,
  String? body,
  bool fallbackToStore = false,
})
```

The Dart parameter is `to`. The Spark URL query name is `recipient`. Map `body` to `body`.

## Identifiers

- Android package: `com.readdle.spark`
- Play listing: <https://play.google.com/store/apps/details?id=com.readdle.spark>
- iOS App Store id `997102246`, slug `spark-mail-ai-email-assistant`: <https://apps.apple.com/us/app/spark-mail-ai-email-assistant/id997102246>
- Custom scheme: `readdle-spark`
- Platforms: iOS and Android. The iOS listing also offers a Mac app. Add macOS only after `macosBundleIdentifier` is read from the Mac App Store metadata or the installed app. Do not guess the bundle id.
- Website: `https://sparkmailapp.com` (linked from the App Store terms URL `https://sparkmailapp.com/legal/terms`)
- Store actions: Play and the iOS App Store. Add the Mac App Store action only with the id taken from that Mac listing.

## URLs

Open: `readdle-spark://`

Compose, copied from Readdle's former knowledge-base article. The original page `https://helpspot.readdle.com/spark/index.php?pg=kb.page&id=791` no longer resolves. The current Spark help page on composing mail does not document the scheme.

```text
readdle-spark://compose?recipient=<address>&subject=<subject>&body=<body>&cc=<address>&bcc=<address>
```

Percent-encode values. This is not an x-callback URL. Do not add `x-success`, `x-error`, or `x-cancel`.

The archived article shows one recipient. Confirm a separator before sending several addresses in one `recipient`, `cc`, or `bcc` value.

Android: use the same scheme when it opens Spark. Otherwise use `ACTION_SENDTO` `mailto:` targeted at `com.readdle.spark`.

Web fallback: `https://sparkmailapp.com`. No prefilled web composer was found, so the doc page says the fallback does not start a draft.

## Sources

- Play and App Store listings above, checked 10 October 2026.
- Archived Readdle scheme, quoted at <https://talk.automators.fm/t/which-ios-email-apps-support-automation-shortcuts-url-schemes-x-callback-url/3552>
- Current help page, which does not document the scheme: <https://sparkmailapp.com/help/sending-emails/compose-an-email>

## Limits

No attachments. The scheme source is an archived vendor article, so a device check is required on current Spark.

## Files a later implementation must touch

Follow the new-app checklist in `AGENTS.md`. This branch does not add the Dart API.

- `lib/src/apps/downloadable_apps/spark.dart`
- Export it from `lib/src/apps/downloadable_apps/downloadable_apps.dart`.
- `doc/apps/spark.md` for usage, schemes, store identifiers, and platform configuration.
- `README.md`: feature counts, the supported-app list, and the documentation list. Compose-capable apps also join the `launchMailComposeAction` provider list when that launcher exists.
- Example catalog: add `CatalogCategory.email` in `example/lib/catalog/models.dart`, add `example/lib/catalog/email_apps.dart`, include it from `example/lib/catalog/catalog.dart`, add `example/assets/spark.png`, and update the counts in `example/test/catalog_test.dart`.
- `example/ios/Runner/Info.plist`: add the custom scheme under `LSApplicationQueriesSchemes` only when a scheme is listed below.
- `example/android/app/src/main/AndroidManifest.xml`: add a `<package android:name="..."/>` query only when an Android package is listed below.
- `test/src/apps/spark_test.dart` covering store actions, app links, and fallbacks.
- `test/deeplink_x_test.dart` exposed-API list.
- The compose action implements `MailComposeAction` and is added to the option list in `example/lib/use_cases/mail_selector_page.dart`.
- Run `dart format`, `flutter analyze`, and `flutter test` (via FVM if this checkout requires it). Bump `pubspec.yaml` and update `CHANGELOG.md` when the feature is released, not in this brief.

## Release limit

Device-check every native URL before release. An unpublished draft stays out of the version bump until that check passes, the same standard already used for TomTom GO Expert.
