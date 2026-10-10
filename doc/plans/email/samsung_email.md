# Plan: Samsung Email actions

Implementation brief for a later change. Replace this file with the integration. Do not merge the brief by itself.

Checked 10 October 2026.

## Actions

- Open app (`SamsungEmail.open`)
- Compose (`SamsungEmail.compose`), implementing `MailComposeAction`

## API

```dart
SamsungEmail.open({bool fallbackToStore = false})

SamsungEmail.compose({
  List<String> to = const [],
  List<String> cc = const [],
  List<String> bcc = const [],
  String? subject,
  String? body,
  bool fallbackToStore = false,
})
```

## Identifiers

- Android package: `com.samsung.android.email.provider`
- Play listing: <https://play.google.com/store/apps/details?id=com.samsung.android.email.provider>
- Custom scheme: none. Leave `customScheme` unset. Do not add an iOS scheme.
- Platforms: Android only. Samsung Email is a Samsung system app. There is no iOS listing.
- `macosBundleIdentifier`: unset.
- Website: the Play listing URL above. The listing's privacy policy is not a product home. There is no Samsung webmail composer.
- Store actions: Play only.

## URLs

Open: Android package launch of `com.samsung.android.email.provider`. `launchApp` already uses the package name on Android.

Compose implements `IntentAppLinkAction` and `MailComposeAction`. `appLink` is null, matching other package-targeted intents such as TomTom GO Fleet.

`androidIntentOptions` uses `AndroidIntentOption` from `deeplink_x_platform_interface`:

- action: `android.intent.action.SENDTO`
- data: a `mailto:` URI
- package: `com.samsung.android.email.provider`

Build the `mailto:` URI with RFC 6068 fields: the path or `to` addresses, plus `cc`, `subject`, and `body`. Percent-encode values. Put several addresses in one field as a comma-separated list.

```text
mailto:one@example.com,two@example.com?cc=copy@example.com&subject=Hello&body=Note
```

Apple's archived mailto note shows the same query names: <https://developer.apple.com/library/archive/featuredarticles/iPhoneURLScheme_Reference/MailLinks/MailLinks.html>

Do not set an activity class name. Do not use `ACTION_SEND` with a wildcard type, which invites non-mail targets. `ACTION_SENDTO` plus `mailto:` keeps the target in email handlers, and the package restricts it to Samsung Email.

`fallbackLink` is the Play listing, not `mailto:`. A bare `mailto:` fallback would open whichever app is the default handler and skip the rest of a compose priority list. The doc page says this fallback does not prefill a message.

Put Samsung Email last in the mail selector because it is Android-only. On iOS the native attempt fails and the launcher continues.

## Sources

- Play listing above, checked 10 October 2026.
- `mailto` query names: the Apple archive page above, and RFC 6068.

## Limits

Android only. No attachments. No custom scheme. The Play listing is not a web composer.

## Files a later implementation must touch

Follow the new-app checklist in `AGENTS.md`. This branch does not add the Dart API.

- `lib/src/apps/downloadable_apps/samsung_email.dart`
- Export it from `lib/src/apps/downloadable_apps/downloadable_apps.dart`.
- `doc/apps/samsung_email.md` for usage, schemes, store identifiers, and platform configuration.
- `README.md`: feature counts, the supported-app list, and the documentation list. Compose-capable apps also join the `launchMailComposeAction` provider list when that launcher exists.
- Example catalog: add `CatalogCategory.email` in `example/lib/catalog/models.dart`, add `example/lib/catalog/email_apps.dart`, include it from `example/lib/catalog/catalog.dart`, add `example/assets/samsung_email.png`, and update the counts in `example/test/catalog_test.dart`.
- `example/ios/Runner/Info.plist`: add the custom scheme under `LSApplicationQueriesSchemes` only when a scheme is listed below.
- `example/android/app/src/main/AndroidManifest.xml`: add a `<package android:name="..."/>` query only when an Android package is listed below.
- `test/src/apps/samsung_email_test.dart` covering store actions, app links, and fallbacks.
- `test/deeplink_x_test.dart` exposed-API list.
- The compose action implements `MailComposeAction` and is added to the option list in `example/lib/use_cases/mail_selector_page.dart`.
- Run `dart format`, `flutter analyze`, and `flutter test` (via FVM if this checkout requires it). Bump `pubspec.yaml` and update `CHANGELOG.md` when the feature is released, not in this brief.

## Release limit

Device-check every native URL before release. An unpublished draft stays out of the version bump until that check passes, the same standard already used for TomTom GO Expert.
