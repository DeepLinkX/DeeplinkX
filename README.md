# DeeplinkX

Easy to use Flutter plugin for type-safe handling of external deeplinks with built-in support for popular apps. Features smart fallback to app stores and web URLs across all major platforms.

> **Naming Note**: 'X' in DeeplinkX stands for external.

## Features

- Launch deeplink actions within apps
- Launch apps without specific actions
- Redirect to app stores to update apps
- Check if external app is installed on the device
- Smart fallback system
- Support popular stores and apps including Facebook, Instagram, LinkedIn, WhatsApp, and Telegram

## Usage

First, import the package and create an instance:

```dart
import 'package:deeplink_x/deeplink_x.dart';

void main() {
  final deeplinkX = DeeplinkX();
  
  // Use the methods below
}
```

### Launch App Actions

Execute specific actions within apps:

```dart
// Basic usage
final isActionLaunched = await deeplinkX.launchAction(Telegram.openProfile('username'));

// With store fallback (redirects to store if app not installed)
deeplinkX.launchAction(Telegram.openProfile('username', fallBackToStore: true));

// Disable all fallbacks
deeplinkX.launchAction(Telegram.openProfile('username'), disableFallback: true);
```

### Launch Apps

Simply open apps without specific actions:

```dart
// Basic usage
final isLaunched = await deeplinkX.launchApp(Instagram.open());

// With store fallback
deeplinkX.launchApp(Instagram.open(fallBackToStore: true));

// Disable all fallbacks
deeplinkX.launchApp(Instagram.open(), disableFallback: true);
```

### Check If App Is Installed

Verify if a specific app is installed on the device:

```dart
final isInstalled = await deeplinkX.isAppInstalled(LinkedIn());
```

### Redirect To Store

Redirect users to appropriate app stores based on their platform:

```dart
// Redirect to appropriate store based on current platform
final isRedirected = await deeplinkX.redirectToStore(
  storeActions: [
    AppStore.openAppPage(appId: '389801252'),  // iOS App Store
    PlayStore.openAppPage(packageName: 'com.instagram.android'),  // Google Play Store
    HuaweiAppGalleryStore.openAppPage(appId: 'C101162369'),  // Huawei AppGallery Store
  ],
);
```

## Supported Apps And Actions

| Category    | App                     | Supported Actions                                  |
| ----------- | ----------------------- | -------------------------------------------------- |
| Stores      | iOS App Store           | • Open app page<br>• Rate app                      |
| Stores      | Mac App Store           | • Open app page<br>• Rate app                      |
| Stores      | Microsoft Store         | • Open app page<br>• Rate app                      |
| Stores      | Google Play Store       | • Open app page                                    |
| Stores      | Huawei AppGallery Store | • Open app page                                    |
| Stores      | Cafe Bazaar Store       | • Open app page                                    |
| Stores      | Myket Store             | • Open app page<br>• Rate app                      |
| Social Apps | Telegram                | • Open profile by username/phone<br>• Send message |
| Social Apps | Instagram               | • Open profile by username                         |
| Social Apps | WhatsApp                | • Chat with phone number<br>• Share text content   |
| Business    | LinkedIn                | • Open profile page<br>• Open company page         |

## Documentation

Detailed documentation available in [doc/apps](https://github.com/DeeplinkX/DeeplinkX/tree/master/doc/apps):

- [iOS App Store](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/stores/ios_app_store.md)
- [Mac App Store](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/stores/mac_app_store.md)
- [Microsoft Store](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/stores/microsoft_store.md)
- [Play Store](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/stores/play_store.md)
- [Huawei AppGalley Store](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/stores/huawei_app_gallery_store.md)
- [Cafe Bazaar Store](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/stores/cafe_bazaar_store.md)
- [Myket Store](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/stores/myket_store.md)
- [Instagram](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/instagram.md)
- [Telegram](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/telegram.md)
- [WhatsApp](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/whatsapp.md)
- [LinkedIn](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/linkedin.md)

## URL Scheme Handling

DeeplinkX uses a three-tier approach for compatibility:

1. **Native App Deep Links**: Direct app launch when installed
2. **Store Fallback**: Redirects to app stores when apps aren't installed (with `fallBackToStore: true`)
3. **Web Fallback**: Redirects to web URLs when neither app nor store is available

Most app actions (like opening profiles, sending messages) support all three fallback levels:

```dart
// With store fallback enabled
await deeplinkX.launchAction(Instagram.open(fallBackToStore: true));

// With fallback disabled
await deeplinkX.launchAction(Instagram.open(), disableFallback: true);
```

For detailed URL schemes and fallback behavior, see each app's documentation.

## Platform-Specific Configuration
See respective app documentation for platform-specific configuration.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/DeeplinkX/DeeplinkX/blob/master/LICENSE) file for details.

## Issues and Feature Requests

Have a bug or feature request? [Please open a new issue](https://github.com/DeeplinkX/DeeplinkX/issues) after checking existing ones.