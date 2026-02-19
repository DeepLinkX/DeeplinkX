# Stack Overflow Draft: Target 3

## Suggested question title
Flutter: how to implement multiple deeplink actions in one app (settings/contact/maps/social)

## Draft answer
A practical pattern is to keep each outbound feature as a separate handler method and call the appropriate DeeplinkX action.

```dart
import 'package:deeplink_x/deeplink_x.dart';

final deeplinkX = DeeplinkX();

Future<void> onUpdateAppTap() async {
  await deeplinkX.redirectToStore(
    storeActions: [
      IOSAppStore.openAppPage(appId: '123456789', appName: 'my-flutter-app'),
      PlayStore.openAppPage(packageName: 'com.example.my_flutter_app'),
    ],
  );
}

Future<void> onContactSupportTap() async {
  await deeplinkX.launchAction(
    WhatsApp.chat(
      phoneNumber: '989120000000',
      message: 'Hi support team',
      fallbackToStore: true,
    ),
  );
}

Future<void> onDirectionsTap() async {
  await deeplinkX.launchAction(
    GoogleMaps.directions(
      destination: 'Tehran Grand Bazaar',
      mode: GoogleMapsTravelMode.driving,
      fallbackToStore: true,
    ),
  );
}
```

This keeps each feature independent and easier to test/track.

Proof links:
- Multi-feature recipe: https://github.com/DeepLinkX/DeeplinkX/blob/master/doc/recipes/multi_feature_app_menu.md
- Common outbound flows: https://github.com/DeepLinkX/DeeplinkX/blob/master/doc/recipes/common_outbound_flows.md
