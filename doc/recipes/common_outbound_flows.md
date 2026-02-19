# Common Outbound Flows

This page collects practical outbound deeplink flows used in production apps.

## Flow 1: Contact Support

```dart
await deeplinkX.launchAction(
  WhatsApp.chat(
    phoneNumber: '989120000000',
    message: 'I need help with order #12345',
    fallbackToStore: true,
  ),
);
```

## Flow 2: Open Community or Brand Channel

```dart
await deeplinkX.launchAction(
  Telegram.sendMessage(
    username: 'deeplinkx',
    message: 'Hi team!',
    fallbackToStore: true,
  ),
);
```

## Flow 3: Open Marketing Profile

```dart
await deeplinkX.launchAction(
  Instagram.openProfile(
    username: 'deeplinkx',
    fallbackToStore: true,
  ),
);
```

## Flow 4: Navigate to Branch or Event Location

```dart
await deeplinkX.launchAction(
  GoogleMaps.directions(
    destination: 'Tehran Grand Bazaar',
    mode: GoogleMapsTravelMode.driving,
    fallbackToStore: true,
  ),
);
```

## Flow 5: Prompt User to Update App

```dart
await deeplinkX.redirectToStore(
  storeActions: [
    IOSAppStore.openAppPage(appId: '123456789', appName: 'my-flutter-app'),
    PlayStore.openAppPage(packageName: 'com.example.my_flutter_app'),
  ],
);
```

## Implementation Notes
1. Keep each feature as a separate method in your presentation layer.
2. Use the same fallback policy style across features for predictable UX.
3. Add analytics around each action to measure usage and success.
