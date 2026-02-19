# Stack Overflow Draft: Target 5

## Suggested question title
Flutter: open app store page by platform (iOS/Android/Windows/macOS)

## Draft answer
Use `redirectToStore` and pass store actions for the platforms you support.

```dart
import 'package:deeplink_x/deeplink_x.dart';

final deeplinkX = DeeplinkX();

Future<void> openStorePage() async {
  await deeplinkX.redirectToStore(
    storeActions: [
      IOSAppStore.openAppPage(appId: '123456789', appName: 'my-flutter-app'),
      PlayStore.openAppPage(packageName: 'com.example.my_flutter_app'),
      MicrosoftStore.openAppPage(productId: '9NBLGGH00000'),
      MacAppStore.openAppPage(appId: '123456789', appName: 'my-flutter-app'),
      HuaweiAppGalleryStore.openAppPage(appId: 'C123456789'),
    ],
  );
}
```

DeeplinkX picks the actions matching current platform and tries them in the order you provide.

Proof links:
- Core store routing: https://github.com/DeepLinkX/DeeplinkX/blob/master/lib/src/core/deeplink_x.dart
- Store docs: https://github.com/DeepLinkX/DeeplinkX/tree/master/doc/apps/stores
