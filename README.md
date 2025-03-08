# DeeplinkX

A cross-platform deeplink plugin that supports various apps and platforms. This plugin provides a simple way to create deeplinks for different apps, with fallback support for web URLs when native apps are not available.

## Features

- Cross-platform support (iOS, Android, macOS, Windows, Linux, Web)
- Automatic fallback to web URLs when native apps are not available
- Type-safe API for creating deeplinks
- Support for multiple apps (Instagram, more coming soon)

## Getting Started

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  deeplink_x: ^0.0.1
```

## Usage

### Instagram Deeplinks

```dart
import 'package:deeplink_x/deeplink_x.dart';

// Create a DeeplinkX instance
final deeplinkX = const DeeplinkX();

// Open Instagram app
await deeplinkX.launchAction(Instagram.open);

// Open a specific profile
await deeplinkX.launchAction(Instagram.openProfile('username'));
```

## Platform Support

| Platform | Support Level |
|----------|--------------|
| Android  | SDK 16+ |
| iOS      | 12.0+ |
| Linux    | Any |
| macOS    | 10.14+ |
| Web      | Any |
| Windows  | 10+ |

### Platform-Specific Notes

- **iOS**: Uses app-specific schemes (e.g., `instagram://`)
  - Requires iOS 12.0 or higher
  - Requires the following keys in your `Info.plist`:
    ```xml
    <key>LSApplicationQueriesSchemes</key>
    <array>
        <string>instagram</string>
    </array>
    ```

- **Android**: Uses `intent://` scheme with fallback to web
  - Requires Android SDK 16 or higher
  - No additional configuration needed

- **Web**: Uses `https://` URLs
  - Works in all modern browsers
  - Some features might be limited by browser security policies

- **Desktop** (Windows, macOS, Linux):
  - Uses web URLs as fallback
  - Windows requires Windows 10 or higher
  - macOS requires 10.14 (Mojave) or higher
  - Linux requires `xdg-utils` installed

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