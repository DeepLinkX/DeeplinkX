# Sygic Deeplinks

DeeplinkX supports the custom URI scheme used by [Sygic GPS Navigation](https://www.sygic.com/gps-navigation) so you can open map previews or launch turn-by-turn guidance directly from your Flutter app.

## References

- Sygic developer program overview: <https://www.sygic.com/developers/professional-navigation-sdk/introduction>
- Map Launcher open-source implementation of the same URI scheme: <https://github.com/mattermoran/map_launcher/blob/master/lib/src/marker_url.dart>

## Available Actions

### Launch Sygic

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(Sygic.open());
```

### View Map

```dart
await deeplinkX.launchAction(
  Sygic.view(
    coordinate: const Coordinate(latitude: 48.1486, longitude: 17.1077),
  ),
);
```

### Directions With Coordinates

```dart
await deeplinkX.launchAction(
  Sygic.directionsWithCoords(
    destination: const Coordinate(latitude: 48.1486, longitude: 17.1077),
    mode: SygicTransportMode.drive, // or .walk
  ),
);
```

## Platform Configuration

### iOS

Add the Sygic scheme to the `LSApplicationQueriesSchemes` array in `ios/Runner/Info.plist`:

```xml
<string>com.sygic.aura</string>
```

### Android

Allow querying the package in `android/app/src/main/AndroidManifest.xml`:

```xml
<queries>
  <package android:name="com.sygic.aura" />
</queries>
```

## URI Formats

- View map: `com.sygic.aura://coordinate|{longitude}|{latitude}|show`
- Directions (driving/walking): `com.sygic.aura://coordinate|{longitude}|{latitude}|{drive|walk}`

## Fallback Behavior

1. DeeplinkX opens the native app when installed.
2. If the app is missing and `fallbackToStore` is `true`, we redirect to the appropriate store listing.
3. Otherwise the action falls back to `https://www.sygic.com/gps-navigation`.
4. Set `disableFallback: true` when calling `launchAction` to skip both store and web fallbacks.

### Fallback Support Matrix

| Action              | Store Fallback | Web Fallback |
| ------------------- | -------------- | ------------ |
| Open app            | ✔️              | ✔️ (website) |
| View map            | ✔️              | ✔️           |
| Directions with coordinates | ✔️              | ✔️           |
