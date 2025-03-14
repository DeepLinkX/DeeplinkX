# Play Store Deeplinks

This document describes the available deeplink actions for the Google Play Store.

## Available Actions

### Open Play Store

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchAction(PlayStore.open);
```

### Open App Page

Opens a specific app page in the Play Store.

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchAction(
  PlayStore.openAppPage(
    packageName: 'com.example.app',
    referrer: 'utm_source=your_app', // optional
    hl: 'en', // optional - language code
  ),
);
```

### Open App Review Page

Opens the review page for a specific app in the Play Store.

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchAction(
  PlayStore.openAppReviewPage(
    packageName: 'com.example.app',
    referrer: 'utm_source=your_app', // optional
    hl: 'en', // optional - language code
  ),
);
```

## Parameters

### Package Name

The package name is the unique identifier for an Android app in the Play Store. It typically follows a reverse domain name pattern (e.g., `com.example.app`).

### Referrer

The referrer parameter is used for tracking the source of an app installation. It's commonly used for attribution and analytics purposes.

### Language (hl)

The `hl` parameter specifies the language to display the Play Store content in. It uses ISO 639-1 language codes (e.g., 'en' for English, 'fr' for French, 'de' for German, 'ja' for Japanese, etc.).

## URL Schemes

DeeplinkX uses the following URL schemes for Play Store actions:

### Native App URIs

- Base URI: `market://`
- App Page: `market://details?id=<package_name>&referrer=<referrer>&hl=<language_code>`
- Review Page: `market://details?id=<package_name>&showAllReviews=true&referrer=<referrer>&hl=<language_code>`

### Web Fallback URIs

- Base URI: `https://play.google.com`
- App Page: `https://play.google.com/store/apps/details?id=<package_name>&referrer=<referrer>&hl=<language_code>`
- Review Page: `https://play.google.com/store/apps/details?id=<package_name>&showAllReviews=true&referrer=<referrer>&hl=<language_code>`

## Platform-Specific Configuration

### Android

No additional configuration is required for Android devices to handle Play Store deeplinks.

### iOS

Play Store deeplinks on iOS will always use the web fallback URLs, as the Play Store app is not available on iOS devices.