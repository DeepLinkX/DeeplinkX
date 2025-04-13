# DeeplinkX

A lightweight Flutter plugin for type-safe handling of external deeplinks with built-in support for popular apps. Features smart fallback to app stores and web URLs across all major platforms.

> **Naming Note**: 'X' in DeeplinkX stands for external.

## Features

- Easy to use
- Type-safe API for external deeplinks
- Multi-platform support
- Smart fallback system
- No native platform codes

## Usage

```dart
import 'package:deeplink_x/deeplink_x.dart';

void main() {
  final deeplinkX = DeeplinkX();

  // Launch App Actions
  final isActionLaunched = await deeplinkX.launchAction(Telegram.openProfile('username'));
  deeplinkX.launchAction(Telegram.openProfile('username', fallBackToStore: true));
  deeplinkX.launchAction(Telegram.openProfile('username'), disableFallback: true);

  // Launch Apps
  final isLaunched = await deeplinkX.launchApp(Instagram.open());
  deeplinkX.launchApp(Instagram.open(fallBackToStore: true));
  deeplinkX.launchApp(Instagram.open(), disableFallback: true);

  // Check App Is Installed
  final isInstalled = await deeplinkX.isAppInstalled(LinkedIn());

  // Redirect to store (Update app use case)
  // Redirect to appropriate store based on platform
  final isRedirected = await deeplinkX.redirectToStore(
    storeActions: [
      AppStore.openAppPage(appId: '389801252'),  // iOS App Store
      PlayStore.openAppPage(packageName: 'com.instagram.android'),  // Google Play Store
      HuaweiAppGalleryStore.openAppPage(appId: 'C101162369'),  // Huawei AppGallery Store
    ],
  );
}
```

## Supported Apps And Actions

| Category    | App                     | Supported Actions                                                  |
| ----------- | ----------------------- | ------------------------------------------------------------------ |
| Stores      | iOS App Store           | • Launch app<br>• Open app page<br>• Rate app                      |
| Stores      | Mac App Store           | • Launch app<br>• Open app page<br>• Rate app                      |
| Stores      | Microsoft Store         | • Launch app<br>• Open app page<br>• Rate app                      |
| Stores      | Google Play Store       | • Launch app<br>• Open app page                                    |
| Stores      | Huawei AppGallery Store | • Launch app<br>• Open app page                                    |
| Stores      | Cafe Bazaar Store       | • Launch app<br>• Open app page                                    |
| Stores      | Myket Store             | • Launch app<br>• Open app page<br>• Rate app                      |
| Social Apps | Telegram                | • Launch app<br>• Open profile by username/phone<br>• Send message |
| Social Apps | Instagram               | • Launch app<br>• Open profile by username                         |
| Social Apps | WhatsApp                | • Launch app<br>• Chat with phone number<br>• Share text content   |
| Business    | LinkedIn                | • Launch app<br>• Open profile page<br>• Open company page         |

## Documentation

Detailed documentation available in [doc/apps](https://github.com/ParhamHatan/DeeplinkX/tree/master/doc/apps):

- [iOS App Store](https://github.com/ParhamHatan/DeeplinkX/blob/master/doc/apps/stores/ios_app_store.md)
- [Mac App Store](https://github.com/ParhamHatan/DeeplinkX/blob/master/doc/apps/stores/mac_app_store.md)
- [Microsoft Store](https://github.com/ParhamHatan/DeeplinkX/blob/master/doc/apps/stores/microsoft_store.md)
- [Play Store](https://github.com/ParhamHatan/DeeplinkX/blob/master/doc/apps/stores/play_store.md)
- [Huawei AppGalley Store](https://github.com/ParhamHatan/DeeplinkX/blob/master/doc/apps/stores/huawei_app_gallery_store.md)
- [Cafe Bazaar Store](https://github.com/ParhamHatan/DeeplinkX/blob/master/doc/apps/stores/cafe_bazaar_store.md)
- [Myket Store](https://github.com/ParhamHatan/DeeplinkX/blob/master/doc/apps/stores/myket_store.md)
- [Instagram](https://github.com/ParhamHatan/DeeplinkX/blob/master/doc/apps/instagram.md)
- [Telegram](https://github.com/ParhamHatan/DeeplinkX/blob/master/doc/apps/telegram.md)
- [WhatsApp](https://github.com/ParhamHatan/DeeplinkX/blob/master/doc/apps/whatsapp.md)
- [LinkedIn](https://github.com/ParhamHatan/DeeplinkX/blob/master/doc/apps/linkedin.md)

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

This project is licensed under the MIT License - see the [LICENSE](https://github.com/ParhamHatan/DeeplinkX/blob/master/LICENSE) file for details.

## Issues and Feature Requests

Have a bug or feature request? [Please open a new issue](https://github.com/ParhamHatan/DeeplinkX/issues) after checking existing ones.