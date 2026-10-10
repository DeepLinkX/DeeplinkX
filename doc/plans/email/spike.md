# Plan: Spike actions

Implementation brief for a later change. Replace this file with the integration. Do not merge the brief by itself.

Checked 10 October 2026.

## Actions

- Open app (`Spike.open`)

## API

```dart
Spike.open({bool fallbackToStore = false})
```

## Identifiers

- Android package: `com.pingapp.app`
- Play listing: <https://play.google.com/store/apps/details?id=com.pingapp.app>
- iOS App Store id `707452888`, slug `spike-ai-email-team-chat`: <https://apps.apple.com/us/app/spike-ai-email-team-chat/id707452888>
- Custom scheme: unverified. Leave `customScheme` unset.
- Platforms: Android until an iOS scheme is verified. The iOS listing also offers a Mac app. Do not add macOS without a published bundle id.
- Website: use the developer website linked from the Play listing. The Play support address is `chat@spikenow.com`. Do not assume a host beyond that until the listing link is copied.
- Store actions: Play now. Add the iOS App Store action when iOS support is enabled.

## URLs

Open on Android by package name `com.pingapp.app`.


No published custom scheme was found on 10 October 2026. Do not invent one, and do not add a scheme to `Info.plist`.

`launchApp` on iOS reads `customScheme`. Leave iOS out of `supportedPlatforms` until a vendor page, the app's published URL types, or another independent public document names the scheme. Android open uses the package name.

If a compose URL is found in a source of that kind while implementing, add `compose` implementing `MailComposeAction` and then add the app to the mail selector. Otherwise ship open only.


## Sources

- Play and App Store listings above, checked 10 October 2026.

## Limits

Open on Android only until a scheme is published. No compose action in this brief.

## Files a later implementation must touch

Follow the new-app checklist in `AGENTS.md`. This branch does not add the Dart API.

- `lib/src/apps/downloadable_apps/spike.dart`
- Export it from `lib/src/apps/downloadable_apps/downloadable_apps.dart`.
- `doc/apps/spike.md` for usage, schemes, store identifiers, and platform configuration.
- `README.md`: feature counts, the supported-app list, and the documentation list. Compose-capable apps also join the `launchMailComposeAction` provider list when that launcher exists.
- Example catalog: add `CatalogCategory.email` in `example/lib/catalog/models.dart`, add `example/lib/catalog/email_apps.dart`, include it from `example/lib/catalog/catalog.dart`, add `example/assets/spike.png`, and update the counts in `example/test/catalog_test.dart`.
- `example/ios/Runner/Info.plist`: add the custom scheme under `LSApplicationQueriesSchemes` only when a scheme is listed below.
- `example/android/app/src/main/AndroidManifest.xml`: add a `<package android:name="..."/>` query only when an Android package is listed below.
- `test/src/apps/spike_test.dart` covering store actions, app links, and fallbacks.
- `test/deeplink_x_test.dart` exposed-API list.
- This app does not implement `MailComposeAction` and stays out of the mail selector.
- Run `dart format`, `flutter analyze`, and `flutter test` (via FVM if this checkout requires it). Bump `pubspec.yaml` and update `CHANGELOG.md` when the feature is released, not in this brief.

## Release limit

Device-check every native URL before release. An unpublished draft stays out of the version bump until that check passes, the same standard already used for TomTom GO Expert.
