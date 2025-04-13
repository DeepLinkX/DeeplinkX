# WhatsApp Deeplinks

## Overview
DeeplinkX provides support for WhatsApp deeplinks, allowing you to open the WhatsApp app, start chats with specific phone numbers, and share content.

## Available Actions

### Launch WhatsApp App
```dart
final deeplinkX = DeeplinkX();

// Simple launch
await deeplinkX.launchApp(WhatsApp.open());

// Launch with store fallback if not installed
await deeplinkX.launchApp(WhatsApp.open(fallBackToStore: true));

// Launch with fallback disabled
await deeplinkX.launchApp(WhatsApp.open(), disableFallback: true);
```

### Launch Chat with Phone Number Action
```dart
final deeplinkX = DeeplinkX();

// Simple action
await deeplinkX.launchAction(WhatsApp.chat(
  phoneNumber: '1234567890',
  message: 'Hello!', // Optional
));

// Action with store fallback if not installed
await deeplinkX.launchAction(
  WhatsApp.chat(
    phoneNumber: '1234567890',
    message: 'Hello!', // Optional
    fallBackToStore: true,
  ),
);

// Action with fallback disabled
await deeplinkX.launchAction(
  WhatsApp.chat(
    phoneNumber: '1234567890',
    message: 'Hello!', // Optional
  ),
  disableFallback: true,
);
```

### Launch Share Text Action
```dart
final deeplinkX = DeeplinkX();

// Simple action
await deeplinkX.launchAction(WhatsApp.share(
  text: 'Check out this cool Flutter package: https://pub.dev/packages/deeplink_x',
));

// Action with store fallback if not installed
await deeplinkX.launchAction(
  WhatsApp.share(
    text: 'Check out this cool Flutter package: https://pub.dev/packages/deeplink_x',
    fallBackToStore: true,
  ),
);

// Action with fallback disabled
await deeplinkX.launchAction(
  WhatsApp.share(
    text: 'Check out this cool Flutter package: https://pub.dev/packages/deeplink_x',
  ),
  disableFallback: true,
);
```

## Platform-Specific Configuration

### iOS
Add the following to your `ios/Runner/Info.plist`:
```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>whatsapp</string>
    <string>itms-apps</string>
</array>
```

### Android
Add the following to your `android/app/src/main/AndroidManifest.xml` inside the `<queries>` tag:
```xml
<queries>
    <!-- For WhatsApp app -->
    <package android:name="com.whatsapp" />
    
    <!-- For Play Store fallback (if using fallbackToStore) -->
    <package android:name="com.android.vending" />
    
    <!-- For web fallback (required) -->
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="https" />
    </intent>
</queries>
```

### macOS
Add the following to your `macos/Runner/Info.plist`:
```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>whatsapp</string>
    <string>macappstore</string>
</array>
```

## URL Schemes

### Native App URI
WhatsApp uses the following URI scheme for native app deeplinks:

- `whatsapp://` - Base URI for WhatsApp app

Examples:
- `whatsapp://` - Opens the WhatsApp app
- `whatsapp://send?phone=1234567890&text=Hello%20World` - Opens a chat with the specified phone number
- `whatsapp://send?text=Hello%20World` - Opens WhatsApp with pre-filled text to share

### Web Fallback URI
When the WhatsApp app is not installed, DeeplinkX will fall back to these web URLs:

- `https://wa.me` - Base URI for WhatsApp web

Examples:
- `https://wa.me` - Opens WhatsApp web
- `https://wa.me/1234567890` - Opens a chat with the specified phone number on WhatsApp web
- `https://wa.me?text=Hello%20World` - Opens WhatsApp web with pre-filled text

## Supported Fallback Stores
When the WhatsApp app is not installed, DeeplinkX can redirect users to download WhatsApp from the following app stores:

- iOS App Store
- Google Play Store
- Microsoft Store
- Mac App Store

To enable fallback to app stores, use the `fallBackToStore` parameter:

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(WhatsApp.open(fallBackToStore: true));
```

## Fallback Behavior
DeeplinkX follows this sequence when handling WhatsApp deeplinks:

1. First, it attempts to launch the WhatsApp app if it's installed on the device using the `whatsapp://` URL scheme.
2. If the WhatsApp app is not installed and `fallBackToStore` is set to `true`, it will redirect to the appropriate app store based on the user's platform (iOS App Store or Google Play Store).
3. If no supported store is available for the current platform or the store app cannot be launched, it will fall back to opening the WhatsApp web interface in the default browser.
4. You can disable all fallbacks by setting `disableFallback: true` in the launch methods.

## Fallback Support for Actions

| Action | Store Fallback | Web Fallback |
| ------ | -------------- | ------------ |
| open   | ✅              | ✅            |
| chat   | ✅              | ✅            |
| share  | ✅              | ✅            |

## Check If WhatsApp Is Installed

```dart
final deeplinkX = DeeplinkX();
final isInstalled = await deeplinkX.isAppInstalled(WhatsApp());
```