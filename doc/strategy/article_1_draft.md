# Draft Article 1

## Title
How to Build a Multi-Feature Outbound Deep Link Menu in Flutter

## Subtitle
Implement separate deeplink actions for update app, contact support, social profile, and navigation with predictable fallback behavior.

## Intro
Most Flutter apps do not have only one outbound action. A real app usually needs multiple separate features such as:
- update app from settings,
- contact support,
- open social profiles,
- open map directions.

This article shows a practical pattern using DeeplinkX where each product feature owns its own deeplink handler. This is not one combined mega-call; each action remains independent and testable.

## Why this pattern
1. Feature ownership stays clear.
2. Fallback behavior is consistent.
3. Adding one more outbound feature is low effort.

## Setup

```dart
import 'package:deeplink_x/deeplink_x.dart';

final deeplinkX = DeeplinkX();
```

## Feature 1: Update App

```dart
Future<void> onUpdateTap() async {
  await deeplinkX.redirectToStore(
    storeActions: [
      IOSAppStore.openAppPage(appId: '123456789', appName: 'my-flutter-app'),
      PlayStore.openAppPage(packageName: 'com.example.my_flutter_app'),
    ],
  );
}
```

## Feature 2: Contact Support

```dart
Future<void> onSupportTap() async {
  await deeplinkX.launchAction(
    WhatsApp.chat(
      phoneNumber: '989120000000',
      message: 'Hi support team, I need help.',
      fallbackToStore: true,
    ),
  );
}
```

## Feature 3: Open Community Channel

```dart
Future<void> onCommunityTap() async {
  await deeplinkX.launchAction(
    Telegram.openProfile(username: 'deeplinkx', fallbackToStore: true),
  );
}
```

## Feature 4: Open Directions

```dart
Future<void> onDirectionsTap() async {
  await deeplinkX.launchAction(
    GoogleMaps.directionsWithCoords(
      destination: const Coordinate(latitude: 35.7219, longitude: 51.3347),
      mode: GoogleMapsTravelMode.driving,
      fallbackToStore: true,
    ),
  );
}
```

## Fallback Strategy Notes
- Keep `fallbackToStore: true` for user-facing flows where conversion matters.
- Use `disableFallback: true` only for strict flows where you need full control.
- Keep one fallback policy style across the app for predictable UX.

## Testing Checklist
1. Verify behavior when target app is installed.
2. Verify store fallback when app is missing.
3. Verify web fallback when store cannot open.
4. Verify strict mode with `disableFallback: true`.

## Sources
- Multi-feature recipe: https://github.com/DeepLinkX/DeeplinkX/blob/master/doc/recipes/multi_feature_app_menu.md
- Fallback recipe: https://github.com/DeepLinkX/DeeplinkX/blob/master/doc/recipes/fallback_strategy_examples.md
- Core launch/fallback flow: https://github.com/DeepLinkX/DeeplinkX/blob/master/lib/src/core/deeplink_x.dart
