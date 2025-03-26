# WhatsApp Deeplinks

## Overview
DeeplinkX provides support for WhatsApp deeplinks, allowing you to open the WhatsApp app, start chats with specific phone numbers, and share content.

## Supported Actions

### Open WhatsApp App
Opens the WhatsApp application if installed.

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchAction(WhatsApp.open());
```

### Chat with Phone Number
Opens a chat with a specific phone number in WhatsApp.

```dart
final deeplinkX = DeeplinkX();

// Open chat with a phone number and optional pre-filled text
// Note: Phone number must include country code without '+' or spaces
await deeplinkX.launchAction(WhatsApp.chat('1234567890', text: 'Hello'));
```

### Share Content
Shares text content via WhatsApp.

```dart
final deeplinkX = DeeplinkX();

// Share text content
await deeplinkX.launchAction(WhatsApp.share('Check out this awesome content!'));
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
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="whatsapp" />
    </intent>
    <!-- Play store fallback -->
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="market" />
    </intent>
    <!-- Web fallback -->
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
await deeplinkX.launchAction(WhatsApp.open(fallBackToStore: true));
```

## Fallback Behavior
DeeplinkX follows this sequence when handling WhatsApp deeplinks:

1. First, it attempts to launch the WhatsApp app if it's installed on the device.
2. If the WhatsApp app is not installed and `fallBackToStore` is set to `true`, it will redirect to the appropriate app store based on the user's platform.
3. If no supported store is available for the current platform or the store app cannot be launched, it will fall back to opening the WhatsApp web interface in the default browser.