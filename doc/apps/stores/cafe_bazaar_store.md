# Cafe Bazaar Store Deeplinks

DeeplinkX provides support for opening the Cafe Bazaar app store and specific app pages.

## Available Actions

### Launch Cafe Bazaar Store
```dart
final deeplinkX = DeeplinkX();

// Simple launch
await deeplinkX.launchApp(CafeBazaarStore.open());

// Launch with fallback disabled
await deeplinkX.launchApp(CafeBazaarStore.open(), disableFallback: true);
```

### Launch Cafe Bazaar App Page Action
```dart
final deeplinkX = DeeplinkX();

// Simple action
await deeplinkX.launchAction(CafeBazaarStore.openAppPage(
  packageName: 'com.example.app',
  referrer: 'utm_source=deeplink_x',  // Optional
));

// Action with fallback disabled
await deeplinkX.launchAction(
  CafeBazaarStore.openAppPage(
    packageName: 'com.example.app',
  ),
  disableFallback: true,
);
```

## Parameters

- `packageName` (required): The package name of the app to open (e.g., 'com.example.app')
- `referrer` (optional): A parameter for tracking the source of the install

## Platform-Specific Configuration

### Android
Add the following to your `android/app/src/main/AndroidManifest.xml` inside the `<queries>` tag:
```xml
<queries>
    <package android:name="com.farsitel.bazaar" />
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="https" />
    </intent>
</queries>
```

## URL Schemes

### Native App URIs

- Open App Page: `bazaar://details?id=com.example.app`

### Web Fallback URIs

- Open App Page: `https://cafebazaar.ir/app/com.example.app`

## Fallback Behavior

DeeplinkX follows this sequence when handling Cafe Bazaar deeplinks:

1. First, it attempts to launch the Cafe Bazaar app if it's installed on the device.
2. If the Cafe Bazaar app is not installed or the device is not running Android, it will automatically fall back to opening the Cafe Bazaar web interface in the default browser.
3. You can disable fallbacks by setting `disableFallback: true` in the launch methods.

## Fallback Support for Actions

| Action      | Web Fallback |
| ----------- | ------------ |
| open        | ✅            |
| openAppPage | ✅            |

## Check If Cafe Bazaar Store Is Installed

```dart
final deeplinkX = DeeplinkX();
final isInstalled = await deeplinkX.isAppInstalled(CafeBazaarStore());
```
