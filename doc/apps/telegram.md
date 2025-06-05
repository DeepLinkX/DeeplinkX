# Telegram Deeplinks

DeeplinkX provides comprehensive support for Telegram deep linking actions.

## Available Actions

### Launch Telegram App
```dart
final deeplinkX = DeeplinkX();

// Simple launch
await deeplinkX.launchApp(Telegram.open());

// Launch with store fallback if not installed
await deeplinkX.launchApp(Telegram.open(fallbackToStore: true));

// Launch with fallback disabled
await deeplinkX.launchApp(Telegram.open(), disableFallback: true);
```

### Launch Profile Action
```dart
final deeplinkX = DeeplinkX();

// Simple action
await deeplinkX.launchAction(Telegram.openProfile('username'));

// Action with store fallback if not installed
await deeplinkX.launchAction(Telegram.openProfile('username', fallbackToStore: true));

// Action with fallback disabled
await deeplinkX.launchAction(Telegram.openProfile('username'), disableFallback: true);
```

### Launch Profile by Phone Number Action
```dart
final deeplinkX = DeeplinkX();

// Simple action
await deeplinkX.launchAction(Telegram.openProfileByPhone('1234567890'));

// Action with store fallback if not installed
await deeplinkX.launchAction(Telegram.openProfileByPhone('1234567890', fallbackToStore: true));

// Action with fallback disabled
await deeplinkX.launchAction(Telegram.openProfileByPhone('1234567890'), disableFallback: true);
```

### Launch Send Message Action
```dart
final deeplinkX = DeeplinkX();

// Simple action
await deeplinkX.launchAction(Telegram.sendMessage(
  username: 'username',
  message: 'Hello!',
));

// Action with store fallback if not installed
await deeplinkX.launchAction(
  Telegram.sendMessage(
    username: 'username',
    message: 'Hello!',
    fallbackToStore: true,
  ),
);

// Action with fallback disabled
await deeplinkX.launchAction(
  Telegram.sendMessage(
    username: 'username',
    message: 'Hello!',
  ),
  disableFallback: true,
);
```

## Parameter Validations

### Username Validation
Telegram usernames must follow these rules:
- Length: 5-32 characters
- Can contain letters, numbers, and underscores
- Must be lowercase
- Cannot contain spaces or special characters
- Cannot start with a number
- Cannot be a reserved word

Example valid usernames:
- `johndoe`
- `john_doe`
- `john_doe123`
- `john_doe_123`

Example invalid usernames:
- `123johndoe` (starts with number)
- `john doe` (contains space)
- `john@doe` (contains special character)
- `JOHNDOE` (contains uppercase)
- `admin` (reserved word)

### Phone Number Validation
Phone numbers must follow these rules:
- Must include country code
- Must contain only digits
- Must not include '+' or spaces
- Length: 6-15 digits (including country code)

Example valid phone numbers:
- US: `1234567890`
- UK: `447911123456`
- International: `861234567890`

Example invalid phone numbers:
- `+1234567890` (contains '+')
- `123 456 7890` (contains spaces)
- `123abc` (contains non-digits)
- `12345` (too short)
- `1234567890123456` (too long)

### Message Validation
Messages must follow these rules:
- Cannot be empty
- Maximum length: 4096 characters
- Special handling for messages starting with '@':
  - Automatically prefixed with a space to avoid triggering inline queries
  - Example: `@mention` becomes ` @mention`

## Platform-Specific Configuration

### iOS
Add the following to your `ios/Runner/Info.plist`:
```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>tg</string>
    <string>itms-apps</string>
</array>
```

### Android
Add the following to your `android/app/src/main/AndroidManifest.xml` inside the `<queries>` tag:
```xml
<queries>
    <!-- For Telegram app -->
    <package android:name="org.telegram.messenger" />
    
    <!-- For store fallbacks (if using fallbackToStore) -->
    <package android:name="com.android.vending" /> <!-- Google Play Store -->
    <package android:name="com.huawei.appmarket" /> <!-- Huawei AppGallery -->
    
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
    <string>tg</string>
    <string>macappstore</string>
</array>
```

## URL Schemes

DeeplinkX uses the following URL schemes for Telegram:

### Native App Deep Links
When Telegram is installed, the following scheme is used:
- `tg://` - Native Telegram URL scheme
- For profiles: `tg://resolve?domain={username}&profile`
- For profiles by phone: `tg://resolve?phone={phoneNumber}&profile`
- For messages: `tg://resolve?domain={username}&text={encodedMessage}`

### Web Fallback URLs
When Telegram is not installed, DeeplinkX automatically falls back to:
- `https://t.me` - Official Telegram web URL
- For profiles: `https://t.me/{username}?profile`
- For profiles by phone: `https://t.me/+{phoneNumber}?profile`
- For messages: `https://t.me/{username}?text={encodedMessage}`

## Supported Fallback Stores
When the Telegram app is not installed, DeeplinkX can redirect users to download Telegram from the following app stores:

- iOS App Store
- Google Play Store
- Huawei AppGallery Store
- Mac App Store
- Microsoft Store

To enable fallback to app stores, use the `fallbackToStore` parameter:

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(Telegram.open(fallbackToStore: true));
```

## Fallback Behavior
DeeplinkX follows this sequence when handling Telegram deeplinks:

1. First, it attempts to launch the Telegram app if it's installed on the device.
2. If the Telegram app is not installed and `fallbackToStore` is set to `true`, it will redirect to the appropriate app store based on the user's platform (iOS App Store, Google Play Store, Mac App Store, or Microsoft Store).
3. If no supported store is available for the current platform or the store app cannot be launched, it will fall back to opening the Telegram web interface in the default browser.
4. You can disable all fallbacks by setting `disableFallback: true` in the launch methods.

## Fallback Support for Actions

| Action             | Store Fallback | Web Fallback |
| ------------------ | -------------- | ------------ |
| open               | ✅              | ✅            |
| openProfile        | ✅              | ✅            |
| openProfileByPhone | ✅              | ✅            |
| sendMessage        | ✅              | ✅            |
| sendMessageByPhone | ✅              | ✅            |

## Check If Telegram Is Installed

```dart
final deeplinkX = DeeplinkX();
final isInstalled = await deeplinkX.isAppInstalled(Telegram());
```
