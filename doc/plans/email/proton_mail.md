# Plan: Proton Mail actions

Implementation brief for a later change. Replace this file with the integration. Do not merge the brief by itself.

Checked 10 October 2026.

## Actions

- Open app (`ProtonMail.open`)

Do not add `ProtonMail.compose`. Proton's iOS project registers the `protonmail` scheme and `mailto`, and it does not publish compose query parameters.

## API

```dart
ProtonMail.open({bool fallbackToStore = false})
```

## Identifiers

- Android package: `ch.protonmail.android`
- Play listing: <https://play.google.com/store/apps/details?id=ch.protonmail.android>
- iOS App Store id `979659905`, slug `proton-mail-encrypted-email`: <https://apps.apple.com/us/app/proton-mail-encrypted-email/id979659905>
- iOS bundle id, from Proton's repository: `ch.protonmail.protonmail`
- Custom scheme: `protonmail`
- Platforms: iOS and Android. Do not copy the iOS bundle id into `macosBundleIdentifier`. Add macOS only after a Mac listing supplies that id.
- Website: `https://proton.me/mail` (linked from the Play listing)
- Store actions: Play and the iOS App Store.

## URLs

Open:

- iOS: `protonmail://`
- Android: launch package `ch.protonmail.android`

The scheme evidence is the URL type in Proton's iOS project:

```text
CFBundleURLSchemes: mailto, protonmail
CFBundleURLName: ch.protonmail.protonmail
```

`mailto` on that list means Proton can register as a default mail handler. It is not a Proton-specific compose API. Do not build `protonmail://mailto:...` or any other compose path that is not in that file.

Web fallback for open: `https://proton.me/mail`. It does not open a prefilled draft.

## Sources

- Play and App Store listings above, checked 10 October 2026.
- Proton iOS URL types: <https://github.com/ProtonMail/ios-mail/blob/main/project.yml>

## Limits

Open only. No compose action until Proton publishes a query format. No attachments.

## Files a later implementation must touch

Follow the new-app checklist in `AGENTS.md`. This branch does not add the Dart API.

- `lib/src/apps/downloadable_apps/proton_mail.dart`
- Export it from `lib/src/apps/downloadable_apps/downloadable_apps.dart`.
- `doc/apps/proton_mail.md` for usage, schemes, store identifiers, and platform configuration.
- `README.md`: feature counts, the supported-app list, and the documentation list. Compose-capable apps also join the `launchMailComposeAction` provider list when that launcher exists.
- Example catalog: add `CatalogCategory.email` in `example/lib/catalog/models.dart`, add `example/lib/catalog/email_apps.dart`, include it from `example/lib/catalog/catalog.dart`, add `example/assets/proton_mail.png`, and update the counts in `example/test/catalog_test.dart`.
- `example/ios/Runner/Info.plist`: add the custom scheme under `LSApplicationQueriesSchemes` only when a scheme is listed below.
- `example/android/app/src/main/AndroidManifest.xml`: add a `<package android:name="..."/>` query only when an Android package is listed below.
- `test/src/apps/proton_mail_test.dart` covering store actions, app links, and fallbacks.
- `test/deeplink_x_test.dart` exposed-API list.
- This app does not implement `MailComposeAction` and stays out of the mail selector.
- Run `dart format`, `flutter analyze`, and `flutter test` (via FVM if this checkout requires it). Bump `pubspec.yaml` and update `CHANGELOG.md` when the feature is released, not in this brief.

## Release limit

Device-check every native URL before release. An unpublished draft stays out of the version bump until that check passes, the same standard already used for TomTom GO Expert.
