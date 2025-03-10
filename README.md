# DeeplinkX

A lightweight Flutter plugin that provides type-safe handling of external deep links, with built-in support for popular apps like Telegram and Instagram. Seamlessly handles fallback to web URLs when apps aren't installed, working across all major platforms.

## Features

- Support for multiple platforms (iOS, Android, Web, macOS, Windows, Linux)
- Fallback to web URLs when apps are not installed
- Type-safe API for creating deep links
- Support Instagram, Telegram deeplinks and more coming soon

## Supported Apps

### Telegram

DeeplinkX supports various Telegram deep linking actions:

```dart
final deeplinkX = DeeplinkX();

// Open Telegram app
await deeplinkX.launchAction(Telegram.open);

// Open a specific profile by username
await deeplinkX.launchAction(Telegram.openProfile('username'));

// Open a profile by phone number (include country code)
await deeplinkX.launchAction(Telegram.openProfilePhoneNumber('1234567890'));

// Send a message to a user by username
await deeplinkX.launchAction(
  Telegram.sendMessage('username', 'Hello!'),
);

// Send a message to a user by phone number
await deeplinkX.launchAction(
  Telegram.sendMessagePhoneNumber('1234567890', 'Hello!'),
);
```

#### Phone Number Format
When using phone number-based actions:
- Include the country code (e.g., '1234567890' for US number)
- Do not include '+' or spaces
- Example formats:
  - US: '1234567890'
  - UK: '447911123456'
  - International: '861234567890'

#### Message Formatting
- Messages starting with '@' are automatically prefixed with a space to avoid triggering inline queries
- Messages are automatically URL-encoded

### Instagram

```dart
final deeplinkX = DeeplinkX();

// Open Instagram app
await deeplinkX.launchAction(Instagram.open);

// Open a specific profile
await deeplinkX.launchAction(Instagram.openProfile('username'));
```

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  deeplink_x: ^0.0.2
```

## Usage

1. Import the package:

```dart
import 'package:deeplink_x/deeplink_x.dart';
```

2. Create a DeeplinkX instance:

```dart
final deeplinkX = DeeplinkX();
```

3. Launch deep links:

```dart
// Example: Open a Telegram profile
await deeplinkX.launchAction(Telegram.openProfile('username'));
```

## Platform-Specific Configuration

### iOS
Add required schemes to your `ios/Runner/Info.plist`:
```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>instagram</string>
    <string>tg</string>
</array>
```

### Android
Add required schemes to your `android/app/src/main/AndroidManifest.xml` inside the `<queries>` tag:
```xml
<queries>
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="instagram" />
    </intent>
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="tg" />
    </intent>
</queries>
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Issues and Feature Requests

Have a bug or a feature request? Please first search for existing and closed issues. If your problem or idea is not addressed yet, [please open a new issue](https://github.com/ParhamHatan/DeeplinkX/issues).