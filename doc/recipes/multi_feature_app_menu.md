# Multi-Feature App Menu (Several Separate Actions)

This recipe is for apps that have multiple independent outbound deeplink features in different UI sections.

Example feature menu:
- Update app
- Contact support
- Open community channel
- Open social profile
- Open navigation route

Each feature uses a separate DeeplinkX action. This is not one combined API call.

## Setup

```dart
import 'package:deeplink_x/deeplink_x.dart';

final deeplinkX = DeeplinkX();
```

## 1) Update App Feature (Store Redirect)

```dart
Future<void> onUpdateAppTap() async {
  await deeplinkX.redirectToStore(
    storeActions: [
      IOSAppStore.openAppPage(appId: '123456789', appName: 'my-flutter-app'),
      PlayStore.openAppPage(packageName: 'com.example.my_flutter_app'),
      HuaweiAppGalleryStore.openAppPage(appId: 'C123456789'),
      MicrosoftStore.openAppPage(productId: '9NBLGGH00000'),
      MacAppStore.openAppPage(appId: '123456789', appName: 'my-flutter-app'),
    ],
  );
}
```

## 2) Contact Support Feature (WhatsApp)

```dart
Future<void> onContactSupportTap() async {
  await deeplinkX.launchAction(
    WhatsApp.chat(
      phoneNumber: '989120000000',
      message: 'Hi support team, I need help with my account.',
      fallbackToStore: true,
    ),
  );
}
```

## 3) Community Feature (Telegram)

```dart
Future<void> onCommunityTap() async {
  await deeplinkX.launchAction(
    Telegram.openProfile(
      username: 'deeplinkx',
      fallbackToStore: true,
    ),
  );
}
```

## 4) Social Feature (Instagram)

```dart
Future<void> onInstagramTap() async {
  await deeplinkX.launchAction(
    Instagram.openProfile(
      username: 'deeplinkx',
      fallbackToStore: true,
    ),
  );
}
```

## 5) Navigation Feature (Google Maps)

```dart
Future<void> onNavigateToOfficeTap() async {
  await deeplinkX.launchAction(
    GoogleMaps.directionsWithCoords(
      destination: const Coordinate(latitude: 35.7219, longitude: 51.3347),
      mode: GoogleMapsTravelMode.driving,
      fallbackToStore: true,
    ),
  );
}
```

## Why This Pattern Works
1. Each product feature keeps its own deeplink action and parameters.
2. Fallback behavior is consistent across features.
3. Adding a new menu action is usually one new handler function.

## Enterprise Scaling Notes
1. Keep one outbound service layer in your app (for example `ExternalActionsService`) and call it from multiple features.
2. Keep each business feature mapped to one explicit DeeplinkX action method for easier testing and analytics.
3. Centralize constants (usernames, support numbers, package IDs, store IDs) to avoid duplication across modules.
4. Add per-feature telemetry around action success/failure so product teams can monitor user flow health.
