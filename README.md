# DeeplinkX

A lightweight Flutter plugin that provides type-safe handling of external deep links, with built-in support for popular apps like Telegram and Instagram. Seamlessly handles fallback to web URLs when apps aren't installed, working across all major platforms.

## Features

- Support for multiple platforms (iOS, Android, Web, macOS, Windows, Linux)
- Fallback to web URLs when apps are not installed
- Type-safe API for creating deep links
- Support Instagram, Telegram, iOS App Store deeplinks and more coming soon
- Comprehensive test suite ensuring reliability

## Usage

```dart
import 'package:deeplink_x/deeplink_x.dart';

void main() {
  // Create instance
  final deeplinkX = DeeplinkX();

  // Open Instagram app
  deeplinkX.launchAction(Instagram.open);

  // Open Telegram profile
  deeplinkX.launchAction(Telegram.openProfile('username'));

  // Open AppStore app
  deeplinkX.launchAction(AppStore.open);
}
```

## Supported Apps And Actions

### iOS App Store
- Open App Store app
- Open specific app page
- Open specific app review page
- Open specific app iMessage extension page

### Telegram
- Open Telegram app
- Open profile by username
- Open profile by phone number
- Send message to user by username
- Send message to user by phone number

### Instagram
- Open Instagram app
- Open profile by username

For detailed documentation on each app's capabilities, parameter validations, and platform-specific configurations, please refer to the [Documentation](#documentation) section below.

## Documentation

Detailed documentation for each supported app is available in the [doc/apps](doc/apps) directory:

- [App Store Deeplinks](doc/apps/app_store.md)
- [Instagram Deeplinks](doc/apps/instagram.md)
- [Telegram Deeplinks](doc/apps/telegram.md)

## URL Scheme Handling

DeeplinkX uses a dual-URL approach for maximum compatibility across all supported apps:

1. **Native App Deep Links**: Uses custom URL schemes to launch apps directly when installed
2. **Web Fallback URLs**: Automatically redirects to web URLs when apps aren't installed

This ensures your app works seamlessly whether or not the target apps are installed on the user's device. For app-specific URL schemes and web fallbacks, please refer to each app's documentation:
- [App Store URL Schemes](doc/apps/app_store.md#url-schemes)
- [Telegram URL Schemes](doc/apps/telegram.md#url-schemes)
- [Instagram URL Schemes](doc/apps/instagram.md#url-schemes)

## Testing

DeeplinkX maintains a comprehensive test suite to ensure reliability and stability:

- **Unit Tests**: Extensive testing of all core functionality

## Platform-Specific Configuration
For platform-specific configuration instructions (iOS and Android), please refer to the respective app documentation:
- [App Store Platform Configuration](doc/apps/app_store.md#platform-specific-configuration)
- [Telegram Platform Configuration](doc/apps/telegram.md#platform-specific-configuration)
- [Instagram Platform Configuration](doc/apps/instagram.md#platform-specific-configuration)

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