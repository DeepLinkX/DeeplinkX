# Cafe Bazaar Store

Cafe Bazaar is a popular Android app store in Iran. This module provides deeplink actions for interacting with the Cafe Bazaar app store.

## Available Actions

### Open Cafe Bazaar

Opens the Cafe Bazaar app store.

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchAction(CafeBazaarStore.open);
```

### Open App Page

Opens a specific app page in the Cafe Bazaar app store.

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchAction(
  CafeBazaarStore.openAppPage(
    packageName: 'com.example.app',
    referrer: 'utm_source=deeplink_x',
  ),
);
```

#### Parameters

- `packageName` (required): The package name of the app to open (e.g., 'com.example.app')
- `referrer` (optional): A parameter for tracking the source of the install

## Platform-Specific Configuration

### Android
Add the following to your `android/app/src/main/AndroidManifest.xml` inside the `<queries>` tag:
```xml
<queries>
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="bazaar" android:host="home" />
    </intent>
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="https" />
    </intent>
</queries>
```

## URL Schemes

### Native App URI

- Open Cafe Bazaar: `bazaar://home`
- Open App Page: `bazaar://details/com.example.app`

### Web Fallback URI

- Open Cafe Bazaar: `https://cafebazaar.ir`
- Open App Page: `https://cafebazaar.ir/app/com.example.app`
