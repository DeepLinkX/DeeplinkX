# Huawei AppGallery Deeplinks

DeeplinkX provides support for opening the Huawei AppGallery specific app pages.

## Available Actions

### Launch Huawei AppGallery Store
```dart
final deeplinkX = DeeplinkX();

// Simple launch
await deeplinkX.launchApp(HuaweiAppGalleryStore.open());

// Launch with fallback disabled
await deeplinkX.launchApp(HuaweiAppGalleryStore.open(), disableFallback: true);
```

### Launch Huawei AppGallery App Page Action
```dart
final deeplinkX = DeeplinkX();

// Simple action
await deeplinkX.launchAction(HuaweiAppGalleryStore.openAppPage(
  packageName: 'com.example.app',
  appId: 'C123456789',
  referrer: 'utm_source=deeplink_x',  // Optional
  locale: 'en_US',  // Optional - language and region code
));

// Action with fallback disabled
await deeplinkX.launchAction(
  HuaweiAppGalleryStore.openAppPage(
    packageName: 'com.example.app',
    appId: 'C123456789',
  ),
  disableFallback: true,
);
```

### Launch App Review Page Action
```dart
final deeplinkX = DeeplinkX();

// Simple action
await deeplinkX.launchAction(HuaweiAppGalleryStore.rateApp(
  packageName: 'com.example.app',
  appId: 'C123456789',
  referrer: 'utm_source=deeplink_x',  // Optional
  locale: 'en_US',  // Optional - language and region code
));

// Action with fallback disabled
await deeplinkX.launchAction(
  HuaweiAppGalleryStore.rateApp(
    packageName: 'com.example.app',
    appId: 'C123456789',
  ),
  disableFallback: true,
);
```

## Parameters

- `packageName` (required): The Android package name of the app (e.g., 'com.example.app')
- `appId` (required): The unique ID of the app in Huawei AppGallery, usually starting with 'C' (e.g., 'C123456789')
- `referrer` (optional): Parameter for tracking referral sources
- `locale` (optional): Language and region code (e.g., 'en_US')

## Platform-Specific Configuration

### Android
Add the following to your `android/app/src/main/AndroidManifest.xml` inside the `<queries>` tag:
```xml
<queries>
    <package android:name="com.huawei.appmarket" />
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="https" />
    </intent>
</queries>
```

## URL Schemes

### Native App URIs

- Open App Page: `appmarket://details?id=com.example.app`
- Rate App: `appmarket://details?id=com.example.app&downloadButton=comment`

### Web Fallback URIs

- Open App Page: `https://appgallery.huawei.com/app/C123456789`
- Rate App: `https://appgallery.huawei.com/app/C123456789#comment`

## Fallback Behavior

DeeplinkX follows this sequence when handling Huawei AppGallery deeplinks:

1. First, it attempts to launch the Huawei AppGallery app if it's installed on the device.
2. If the Huawei AppGallery app is not installed or the device is not running Android, it will automatically fall back to opening the AppGallery web interface in the default browser.
3. You can disable fallbacks by setting `disableFallback: true` in the launch methods.

## Fallback Support for Actions

| Action      | Web Fallback |
| ----------- | ------------ |
| open        | ✅            |
| openAppPage | ✅            |
| rateApp     | ✅            |

## Check If Huawei AppGallery Store Is Installed

```dart
final deeplinkX = DeeplinkX();
final isInstalled = await deeplinkX.isAppInstalled(HuaweiAppGalleryStore());
```
