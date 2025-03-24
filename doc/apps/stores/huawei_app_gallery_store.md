# Huawei AppGallery Deeplinks

DeeplinkX provides support for opening the Huawei AppGallery specific app pages.

## Available Actions

### Open App Page

Opens a specific app page in the Huawei AppGallery.

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchAction(
  HuaweiAppGallery.openAppPage(
    appId: 'C100000000',
    packageName: 'com.example.app',
    referrer: 'utm_source=your_app', // optional
    locale: 'en_US', // optional - language and region code
  ),
);
```

## Platform-Specific Configuration

### Android
Add the following to your `android/app/src/main/AndroidManifest.xml` inside the `<queries>` tag:
```xml
<queries>
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="appmarket" android:host="details" />
    </intent>
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="https" />
    </intent>
</queries>
```

## URL Schemes

### Native App URIs

- Open App Page: `appmarket://details?id=com.example.app`

### Web Fallback URIs

- Open App Page: `https://appgallery.huawei.com/app/C100000000`