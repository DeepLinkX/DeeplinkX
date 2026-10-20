# WhatsApp Deeplinks

## Overview
DeeplinkX provides support for WhatsApp deeplinks, allowing you to open the WhatsApp app, start chats with phone numbers or usernames, and share content.

## Available Actions

### Launch WhatsApp App
```dart
final deeplinkX = DeeplinkX();

// Simple launch
await deeplinkX.launchApp(WhatsApp.open());

// Launch with store fallback if not installed
await deeplinkX.launchApp(WhatsApp.open(fallbackToStore: true));

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
    fallbackToStore: true,
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

### Launch Chat with Username Action

```dart
final deeplinkX = DeeplinkX();

// Replace this illustrative username with the recipient's exact username.
await deeplinkX.launchAction(WhatsApp.chatByUsername(
  username: 'example_user', // Without the leading @
  message: 'Hello!', // Optional; prefills the composer without sending
));

// Use the existing platform-specific store fallback.
await deeplinkX.launchAction(WhatsApp.chatByUsername(
  username: 'example_user',
  fallbackToStore: true,
));

// Attempt only the native link, without store or web fallback.
await deeplinkX.launchAction(
  WhatsApp.chatByUsername(username: 'example_user'),
  disableFallback: true,
);
```

Supply a bare username without `@`. DeeplinkX preserves it as supplied without normalization or username validation. WhatsApp determines whether the username exists and is available to contact. A null message omits the `text` query parameter; an explicitly empty message retains `text=`.

This action inherits WhatsApp's existing Android, iOS, macOS, and Windows support and uses the same platform configuration and fallback flow as phone chats. Usernames are rolling out gradually, so the recipient's reserved username may not be active yet. WhatsApp may ask for the recipient's username key; obtain that key from the recipient and enter it inside WhatsApp. DeeplinkX does not accept or append a username-key parameter.

See [username link evidence and limitations](#username-link-evidence-and-limitations) for the runtime checks behind this action.

### Launch Share Text Action
```dart
final deeplinkX = DeeplinkX();

// Simple action
await deeplinkX.launchAction(WhatsApp.shareText(
  text: 'Check out this cool Flutter package: https://pub.dev/packages/deeplink_x',
));

// Action with store fallback if not installed
await deeplinkX.launchAction(
  WhatsApp.shareText(
    text: 'Check out this cool Flutter package: https://pub.dev/packages/deeplink_x',
    fallbackToStore: true,
  ),
);

// Action with fallback disabled
await deeplinkX.launchAction(
  WhatsApp.shareText(
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
- `whatsapp://send?username=example_user` - Targets a chat by username
- `whatsapp://send?username=example_user&text=Hello+World` - Targets a username chat with pre-filled text
- `whatsapp://send?text=Hello%20World` - Opens WhatsApp with pre-filled text to share

### Web Fallback URI
When the WhatsApp app is not installed, DeeplinkX will fall back to these web URLs:

- `https://wa.me` - Base URI for WhatsApp web

Examples:
- `https://wa.me` - Opens WhatsApp web
- `https://wa.me/1234567890` - Opens a chat with the specified phone number on WhatsApp web
- `https://wa.me/example_user` - Opens the username click-to-chat link
- `https://wa.me/example_user?text=Hello+World` - Username web fallback with a pre-filled message parameter; runtime prefill behavior is unverified
- `https://wa.me?text=Hello%20World` - Opens WhatsApp web with pre-filled text

### Username Link Evidence and Limitations

Sources checked on **2026-10-20**:

- [WhatsApp Help Center: How to contact someone by username](https://faq.whatsapp.com/1561101675623754/?cms_platform=web&helpref=faq_content) documents `wa.me/YourUsername`, the gradual rollout, and username-key prompts.
- [WhatsApp Help Center: How to use click to chat](https://faq.whatsapp.com/5913398998672934) documents `text` for phone-number and text-sharing links. It does not establish prefilled-message support for username web links.
- The maintainer reported a successful macOS test of `whatsapp://send?username=<username>&text=hello`. The native username scheme is based on that runtime report; no first-party documentation for it was found in this research. The tested WhatsApp and macOS versions were not recorded.

Native username and message-prefill behavior on Android, iOS, and Windows, and username web-message prefill, have not been independently verified. The same native format is used across the existing supported platforms as requested by the maintainer. URI unit tests and mocked launch tests verify URL construction and fallback routing, not WhatsApp's handling of a recipient or message. A successful launch result does not guarantee that WhatsApp resolved the username or prefilled the composer.

## Supported Fallback Stores
When the WhatsApp app is not installed, DeeplinkX can redirect users to download WhatsApp from the following app stores:

- iOS App Store
- Google Play Store
- Microsoft Store
- Mac App Store

To enable fallback to app stores, use the `fallbackToStore` parameter:

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(WhatsApp.open(fallbackToStore: true));
```

## Fallback Behavior
DeeplinkX follows this sequence when handling WhatsApp deeplinks:

1. First, it attempts to launch the WhatsApp app if it's installed on the device using the `whatsapp://` URL scheme.
2. If the app is not installed or its native link cannot be launched and `fallbackToStore` is set to `true`, it attempts the matching iOS App Store, Google Play Store, Mac App Store, or Microsoft Store listing.
3. If store fallback is disabled or cannot launch, it opens the action's web fallback in the default browser. Username chats use `https://wa.me/<username>` with `text` included when a message is supplied.
4. You can disable all fallbacks by setting `disableFallback: true` in the launch methods.

## Fallback Support for Actions

| Action         | Store Fallback | Web Fallback |
| -------------- | -------------- | ------------ |
| open           | ✅              | ✅            |
| chat           | ✅              | ✅            |
| chatByUsername | ✅              | ✅            |
| shareText      | ✅              | ✅            |

## Check If WhatsApp Is Installed

```dart
final deeplinkX = DeeplinkX();
final isInstalled = await deeplinkX.isAppInstalled(WhatsApp());
```
