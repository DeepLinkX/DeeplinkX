# Play Store Deeplinks

DeeplinkX provides support for opening the Google Play Store and specific app pages.

## Available Actions

### Launch Play Store App
```dart
final deeplinkX = DeeplinkX();

// Simple launch
await deeplinkX.launchApp(PlayStore.open());

// Launch with fallback disabled
await deeplinkX.launchApp(PlayStore.open(), disableFallback: true);
```

### Launch App Page Action
```dart
final deeplinkX = DeeplinkX();

// Simple action
await deeplinkX.launchAction(PlayStore.openAppPage(
  packageName: 'com.example.app',
  referrer: 'utm_source=deeplink_x&utm_medium=example',  // Optional
  language: 'en',  // Optional
));

// Action with fallback disabled
await deeplinkX.launchAction(
  PlayStore.openAppPage(
    packageName: 'com.example.app',
  ),
  disableFallback: true,
);
```

## Parameters

### Package Name

The package name is the unique identifier for an Android app in the Play Store. It typically follows a reverse domain name pattern (e.g., `com.example.app`).

### Referrer

The referrer parameter is used for tracking the source of an app installation. It's commonly used for attribution and analytics purposes.

### Language (hl)

The `hl` parameter specifies the language to display the Play Store content in. It uses ISO 639-1 language codes (e.g., 'en' for English, 'fr' for French, 'de' for German, 'ja' for Japanese, etc.).

## Platform-Specific Configuration

### Android
Add the following to your `android/app/src/main/AndroidManifest.xml` inside the `<queries>` tag:
```xml
<queries>
    <package android:name="com.android.vending" />
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="https" />
    </intent>
</queries>
```

### iOS

Play Store deeplinks on iOS will always use the web fallback URLs, as the Play Store app is not available on iOS devices.

## URL Schemes

DeeplinkX uses the following URL schemes for Play Store actions:

### Native App URIs

- Base URI: `market://`
- App Page: `market://details?id=<package_name>&referrer=<referrer>&hl=<language_code>`

### Web Fallback URIs

- Base URI: `https://play.google.com`
- App Page: `https://play.google.com/store/apps/details?id=<package_name>&referrer=<referrer>&hl=<language_code>`

## Fallback Behavior

DeeplinkX follows this sequence when handling Play Store deeplinks:

1. First, it attempts to launch the Play Store app if it's installed on the device.
2. If the Play Store app is not installed or the device is not running Android, it will automatically fall back to opening the Play Store web interface in the default browser.
3. You can disable fallbacks by setting `disableFallback: true` in the launch methods.

## Fallback Support for Actions

| Action      | Web Fallback |
| ----------- | ------------ |
| open        | ✅            |
| openAppPage | ✅            |

## Check If Play Store Is Installed

```dart
final deeplinkX = DeeplinkX();
final isInstalled = await deeplinkX.isAppInstalled(PlayStore());
```
