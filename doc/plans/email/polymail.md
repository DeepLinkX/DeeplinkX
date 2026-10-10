# Plan: Polymail actions

Implementation brief for a later change. Replace this file with the integration. Do not merge the brief by itself.

Checked 10 October 2026.

## Actions

- Open app (`Polymail.open`)

## API

```dart
Polymail.open({bool fallbackToStore = false})
```

## Identifiers

- iOS App Store id `1082058386`, slug `polymail-email-inbox`: <https://apps.apple.com/us/app/polymail-email-inbox/id1082058386>
- The iOS listing also runs on Macs with Apple silicon. That is not a separate bundle id.
- Android package: no Play listing was found on 10 October 2026. Do not invent one.
- Custom scheme: unverified. Leave `customScheme` unset.
- Website: copy the developer website from the App Store listing. Do not guess a host.

## URLs

There is no confirmed way to open Polymail. `launchApp` needs an Android package or a custom scheme, and neither was found.

Do not add the class to the public API until one of those identifiers is copied from a Polymail page, the App Store metadata, or the app's published URL types. Keep this brief as the record of the App Store id and the gap.

If a scheme is confirmed, platforms start at iOS. Add the scheme to `Info.plist`. Add `compose` and the mail selector only when that same kind of source documents a compose URL.

## Sources

- App Store listing above, checked 10 October 2026.

## Limits

Blocked on a published scheme or package. No compose action in this brief.

## Files a later implementation must touch

Follow the new-app checklist in `AGENTS.md`. This branch does not add the Dart API.

- `lib/src/apps/downloadable_apps/polymail.dart`
- Export it from `lib/src/apps/downloadable_apps/downloadable_apps.dart`.
- `doc/apps/polymail.md` for usage, schemes, store identifiers, and platform configuration.
- `README.md`: feature counts, the supported-app list, and the documentation list. Compose-capable apps also join the `launchMailComposeAction` provider list when that launcher exists.
- Example catalog: add `CatalogCategory.email` in `example/lib/catalog/models.dart`, add `example/lib/catalog/email_apps.dart`, include it from `example/lib/catalog/catalog.dart`, add `example/assets/polymail.png`, and update the counts in `example/test/catalog_test.dart`.
- `example/ios/Runner/Info.plist`: add the custom scheme under `LSApplicationQueriesSchemes` only when a scheme is listed below.
- `example/android/app/src/main/AndroidManifest.xml`: add a `<package android:name="..."/>` query only when an Android package is listed below.
- `test/src/apps/polymail_test.dart` covering store actions, app links, and fallbacks.
- `test/deeplink_x_test.dart` exposed-API list.
- This app does not implement `MailComposeAction` and stays out of the mail selector.
- Run `dart format`, `flutter analyze`, and `flutter test` (via FVM if this checkout requires it). Bump `pubspec.yaml` and update `CHANGELOG.md` when the feature is released, not in this brief.

## Release limit

Device-check every native URL before release. An unpublished draft stays out of the version bump until that check passes, the same standard already used for TomTom GO Expert.
