# Plan: Apple Mail actions

Implementation brief for a later change. Replace this file with the integration. Do not merge the brief by itself.

Checked 10 October 2026.

## Actions

- Open app (`AppleMail.open`)

Do not add `AppleMail.compose`. Apple's documented `mailto:` URL opens the user's default mail app. Since iOS 14 that default can be an app other than Mail.

## API

```dart
AppleMail.open({bool fallbackToStore = false})
```

Force `fallbackToStore` to stay false. `storeActions` is an empty list. Mail has no App Store page.

## Identifiers

- Custom scheme: `message`
- Android package: none
- `macosBundleIdentifier`: `com.apple.mail` is the historical Mac bundle id. Confirm it on a current macOS before adding `PlatformType.macos`. Do not ship macOS on an unverified id.
- Platforms: iOS. Add macOS only after the bundle id check above, because `isAppInstalled` on macOS requires `macosBundleIdentifier`. `launchApp` on macOS still uses the custom scheme.
- Website: there is no Mail website. Use `https://support.apple.com/mail` only if that support page still exists on the implementation date. Document that it is a support page, not a web client.

## URLs

Open: `message://`

Public iOS reports say `message://` opens Mail without the compose sheet. Apple's archived URL-scheme article documents `mailto:` for the compose sheet and does not document `message://`. Cite both facts in the doc page.

Add `message` to `LSApplicationQueriesSchemes`.

Do not implement compose with `mailto:`. That URL is not Mail-specific.

## Sources

- `message://` opens Mail without compose: <https://stackoverflow.com/questions/8821934/launch-apple-mail-app-from-within-my-own-app>
- Apple's archived `mailto` documentation: <https://developer.apple.com/library/archive/featuredarticles/iPhoneURLScheme_Reference/MailLinks/MailLinks.html>

## Limits

No store fallback. No compose action. No Android app. macOS waits on a confirmed bundle id.

## Files a later implementation must touch

Follow the new-app checklist in `AGENTS.md`. This branch does not add the Dart API.

- `lib/src/apps/downloadable_apps/apple_mail.dart`
- Export it from `lib/src/apps/downloadable_apps/downloadable_apps.dart`.
- `doc/apps/apple_mail.md` for usage, schemes, store identifiers, and platform configuration.
- `README.md`: feature counts, the supported-app list, and the documentation list. Compose-capable apps also join the `launchMailComposeAction` provider list when that launcher exists.
- Example catalog: add `CatalogCategory.email` in `example/lib/catalog/models.dart`, add `example/lib/catalog/email_apps.dart`, include it from `example/lib/catalog/catalog.dart`, add `example/assets/apple_mail.png`, and update the counts in `example/test/catalog_test.dart`.
- `example/ios/Runner/Info.plist`: add the custom scheme under `LSApplicationQueriesSchemes` only when a scheme is listed below.
- `example/android/app/src/main/AndroidManifest.xml`: add a `<package android:name="..."/>` query only when an Android package is listed below.
- `test/src/apps/apple_mail_test.dart` covering store actions, app links, and fallbacks.
- `test/deeplink_x_test.dart` exposed-API list.
- This app does not implement `MailComposeAction` and stays out of the mail selector.
- Run `dart format`, `flutter analyze`, and `flutter test` (via FVM if this checkout requires it). Bump `pubspec.yaml` and update `CHANGELOG.md` when the feature is released, not in this brief.

## Release limit

Device-check every native URL before release. An unpublished draft stays out of the version bump until that check passes, the same standard already used for TomTom GO Expert.
