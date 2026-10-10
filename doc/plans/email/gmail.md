# Plan: Gmail actions

Implementation brief for a later change. Replace this file with the integration. Do not merge the brief by itself.

Checked 10 October 2026.

## Actions

- Open app (`Gmail.open`)
- Compose (`Gmail.compose`), implementing `MailComposeAction`

## API

```dart
Gmail.open({bool fallbackToStore = false})

Gmail.compose({
  List<String> to = const [],
  List<String> cc = const [],
  List<String> bcc = const [],
  String? subject,
  String? body,
  bool fallbackToStore = false,
})
```

`compose` returns an action that implements `MailComposeAction`, `AppLinkAppAction`, and `Fallbackable`. Map `body` to the query name the native URL actually uses. Do not add an attachment parameter.

## Identifiers

- Android package: `com.google.android.gm`
- Play listing: <https://play.google.com/store/apps/details?id=com.google.android.gm>
- iOS App Store id `422689480`, slug `gmail-email-by-google`: <https://apps.apple.com/us/app/gmail-email-by-google/id422689480>
- Custom scheme: `googlegmail`
- Platforms: iOS and Android. No Mac app listing was found, so leave `macosBundleIdentifier` unset and do not add macOS.
- Website: `https://mail.google.com`
- Store actions: Play and the iOS App Store. Do not add Huawei, Cafe Bazaar, Myket, Mac App Store, or Microsoft Store actions unless a listing is found while implementing.

## URLs

Open:

- iOS: `googlegmail://`
- Android: launch package `com.google.android.gm`

Compose on iOS, from public write-ups of the Gmail app rather than a Google developer document:

```text
googlegmail:///co?to=<address>&subject=<subject>&body=<body>
```

The path is `co`, with three slashes before it. Percent-encode query values. Public examples show `to`, `subject`, and `body`. Pass `cc` and `bcc` only after a device check shows Gmail accepts them. One public Swift example joins several recipients with semicolons; confirm that separator on a device before encoding more than one address.

Web fallback for compose:

```text
https://mail.google.com/mail/?view=cm&fs=1&to=<address>&su=<subject>&body=<body>&cc=<address>&bcc=<address>
```

The web composer uses `su` for the subject. The native scheme uses `subject`. Keep those names separate.

Android compose should target `com.google.android.gm` with an `ACTION_SENDTO` `mailto:` intent (`AndroidIntentOption` from `deeplink_x_platform_interface`) when the `googlegmail` scheme is not a reliable Android link. `appLink` remains the iOS URL. Do not hard-code an activity class name such as `ComposeActivityGmail`; those class names change.

## Sources

- App Store listing above, checked 10 October 2026.
- Play listing id `com.google.android.gm`, also used by public Android intent examples: <https://stackoverflow.com/questions/3470042/intent-uri-to-launch-gmail-app>
- Tom Scogland, “Finding the GMail URL scheme for iOS”, 29 January 2013: <https://tom.scogland.com/blog/2013/01/29/gmail-url-scheme/>
- MacStories summary of that scheme, including `to`: <https://www.macstories.net/links/gmail-for-ios-url-scheme/>
- Web compose parameters: <https://stackoverflow.com/questions/6548570/url-to-compose-a-message-in-gmail-with-full-gmail-interface-and-specified-to-bcc-subject-etc>

Google does not publish this custom scheme. Treat the native compose URL as community-documented and require a device check.

## Limits

No file attachments. No inbox search, thread, or label actions. `from` is not part of the API.


## Files a later implementation must touch

Follow the new-app checklist in `AGENTS.md`. This branch does not add the Dart API.

- `lib/src/apps/downloadable_apps/gmail.dart`
- Export it from `lib/src/apps/downloadable_apps/downloadable_apps.dart`.
- `doc/apps/gmail.md` for usage, schemes, store identifiers, and platform configuration.
- `README.md`: feature counts, the supported-app list, and the documentation list. Compose-capable apps also join the `launchMailComposeAction` provider list when that launcher exists.
- Example catalog: add `CatalogCategory.email` in `example/lib/catalog/models.dart`, add `example/lib/catalog/email_apps.dart`, include it from `example/lib/catalog/catalog.dart`, add `example/assets/gmail.png`, and update the counts in `example/test/catalog_test.dart`.
- `example/ios/Runner/Info.plist`: add the custom scheme under `LSApplicationQueriesSchemes` only when a scheme is listed below.
- `example/android/app/src/main/AndroidManifest.xml`: add a `<package android:name="..."/>` query only when an Android package is listed below.
- `test/src/apps/gmail_test.dart` covering store actions, app links, and fallbacks.
- `test/deeplink_x_test.dart` exposed-API list.
- The compose action implements `MailComposeAction` and is added to the option list in `example/lib/use_cases/mail_selector_page.dart`.
- Run `dart format`, `flutter analyze`, and `flutter test` (via FVM if this checkout requires it). Bump `pubspec.yaml` and update `CHANGELOG.md` when the feature is released, not in this brief.

## Release limit

Device-check every native URL before release. An unpublished draft stays out of the version bump until that check passes, the same standard already used for TomTom GO Expert.
