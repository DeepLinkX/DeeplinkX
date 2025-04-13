# Myket Store Deeplinks

DeeplinkX provides support for opening the Myket app store and specific app pages, including app details and reviews.

## Available Actions

### Launch Myket Store
```dart
final deeplinkX = DeeplinkX();

// Simple launch
await deeplinkX.launchApp(MyketStore.open());

// Launch with fallback disabled
await deeplinkX.launchApp(MyketStore.open(), disableFallback: true);
```

### Launch Myket App Page Action
```dart
final deeplinkX = DeeplinkX();

// Simple action
await deeplinkX.launchAction(MyketStore.openAppPage(
  packageName: 'com.example.app',
  referrer: 'utm_source=deeplink_x',  // Optional
));

// Action with fallback disabled
await deeplinkX.launchAction(
  MyketStore.openAppPage(
    packageName: 'com.example.app',
  ),
  disableFallback: true,
);
```

### Launch App Review Page Action
```dart
final deeplinkX = DeeplinkX();

// Simple action
await deeplinkX.launchAction(MyketStore.rateApp(
  packageName: 'com.example.app',
));

// Action with fallback disabled
await deeplinkX.launchAction(
  MyketStore.rateApp(
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
    <package android:name="ir.mservices.market" />
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="https" />
    </intent>
</queries>
```

## URL Schemes

### Native App URIs

- Open App Page: `myket://details?id=com.example.app`
- Rate App: `myket://comment?id=com.example.app`

### Web Fallback URIs

- Open App Page: `https://myket.ir/app/com.example.app`

## Fallback Behavior

DeeplinkX follows this sequence when handling Myket deeplinks:

1. First, it attempts to launch the Myket app if it's installed on the device.
2. If the Myket app is not installed or the device is not running Android, it will automatically fall back to opening the Myket web interface in the default browser.
3. You can disable fallbacks by setting `disableFallback: true` in the launch methods.

## Fallback Support for Actions

| Action      | Web Fallback |
| ----------- | ------------ |
| open        | ✅            |
| openAppPage | ✅            |
| rateApp     | ❌            |

## Check If Myket Store Is Installed

```dart
final deeplinkX = DeeplinkX();
final isInstalled = await deeplinkX.isAppInstalled(MyketStore());
```