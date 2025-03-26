# Myket Store

Myket is a popular Android app store in Iran. This document describes how to use the DeeplinkX plugin to create deeplinks for the Myket store.

## Available Actions

### Open Myket

Opens the Myket app.

```dart
await deeplinkX.launchAction(MyketStore.open);
```

### Open App Page

Opens a specific app page in the Myket store.

```dart
await deeplinkX.launchAction(
  MyketStore.openAppPage(
    packageName: 'com.example.app',
    referrer: 'utm_source=your_app', // Optional
  ),
);
```

### Rate app
Opens the rating page for a specific app in the Myket store.

```dart
await deeplinkX.launchAction(
  MyketStore.rateApp(
    packageName: 'com.example.app',
  ),
);
```

## Parameters

- `packageName`: The package name of the app to open (e.g., 'com.example.app')
- `referrer`: An optional parameter for tracking the source of the install

## Platform-Specific Configuration

### Android
Add the following to your `android/app/src/main/AndroidManifest.xml` inside the `<queries>` tag:
```xml
<queries>
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="myket" android:host="main" />
    </intent>
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="https" />
    </intent>
</queries>
```

## URI Formats

### Native URIs

- Open Myket: `myket://main`
- Open App Page: `myket://details?id=[packageName]&referrer=[referrer]`
- Open App Review Page: `myket://comment?id=[packageName]`

### Fallback URIs

- Open Myket: `https://myket.ir`
- Open App Page: `https://myket.ir/app/[packageName]?referrer=[referrer]`
- Open App Review Page: `https://myket.ir/app/[packageName]?referrer=[referrer]#reviews`