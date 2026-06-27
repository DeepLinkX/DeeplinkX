# Sygic Truck Deeplinks

DeeplinkX supports Sygic Truck & RV Navigation on iOS and Android for opening the app, showing a coordinate, and starting coordinate navigation.

## References

- Map Launcher marker implementation: <https://github.com/mattermoran/map_launcher/blob/master/lib/src/marker_url.dart>
- Map Launcher directions implementation: <https://github.com/mattermoran/map_launcher/blob/master/lib/src/directions_url.dart>
- Sygic Professional Navigation SDK documentation: <https://www.sygic.com/developers/professional-navigation-sdk/introduction>

## Available Actions

### Launch Sygic Truck

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(SygicTruck.open());
```

### View Map

```dart
await deeplinkX.launchAction(
  SygicTruck.view(
    coordinate: const Coordinate(latitude: 48.1486, longitude: 17.1077),
  ),
);
```

### Directions With Coordinates

```dart
await deeplinkX.launchAction(
  SygicTruck.directionsWithCoords(
    destination: const Coordinate(latitude: 48.1486, longitude: 17.1077),
  ),
);
```

Sygic Truck route links are coordinate based, so DeeplinkX does not expose a text-only `directions` action for this app.

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
  <package android:name="com.sygic.truck" />
</queries>
```

## URI Formats

- View: `com.sygic.aura://coordinate|{longitude}|{latitude}|show`
- Directions with coordinates: `com.sygic.aura://coordinate|{longitude}|{latitude}|drive`

## Fallback Behavior

1. DeeplinkX opens the native app when installed.
2. If the app is missing and `fallbackToStore` is `true`, we redirect to the appropriate store listing.
3. Otherwise each action falls back to the Sygic Truck website.
4. Set `disableFallback: true` when calling `launchAction` to skip both store and web fallbacks.

### Fallback Support Matrix

| Action                        | Store Fallback | Web Fallback |
| ----------------------------- | -------------- | ------------ |
| Open app                      | Yes            | Yes          |
| View map                      | Yes            | Yes          |
| Directions with coordinates   | Yes            | Yes          |
