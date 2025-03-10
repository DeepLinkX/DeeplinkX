# Telegram Deeplinks

DeeplinkX provides comprehensive support for Telegram deep linking actions.

## Available Actions

### Open Telegram App
```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchAction(Telegram.open);
```

### Open Profile by Username
```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchAction(Telegram.openProfile('username'));
```
[Official Documentation](https://core.telegram.org/api/links#public-username-links)

### Open Profile by Phone Number
```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchAction(Telegram.openProfilePhoneNumber('1234567890'));
```
[Official Documentation](https://core.telegram.org/api/links#phone-number-links)

### Send Message by Username
```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchAction(
  Telegram.sendMessage('username', 'Hello!'),
);
```
[Official Documentation](https://core.telegram.org/api/links#public-username-links)

### Send Message by Phone Number
```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchAction(
  Telegram.sendMessagePhoneNumber('1234567890', 'Hello!'),
);
```
[Official Documentation](https://core.telegram.org/api/links#phone-number-links)

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
</array>
```

### Android
Add the following to your `android/app/src/main/AndroidManifest.xml` inside the `<queries>` tag:
```xml
<queries>
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="tg" />
    </intent>
</queries>
```

## URL Schemes

DeeplinkX uses the following URL schemes for Telegram:

### Native App Deep Links
When Telegram is installed, the following scheme is used:
- `tg://` - Native Telegram URL scheme

### Web Fallback URLs
When Telegram is not installed, DeeplinkX automatically falls back to:
- `https://t.me` - Official Telegram web URL 

## Fallback Behavior
If the Telegram app is not installed, DeeplinkX will automatically fall back to opening the Telegram web interface in the default browser.
