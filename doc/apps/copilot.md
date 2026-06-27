# CoPilot Deeplinks

DeeplinkX supports CoPilot GPS Navigation on iOS and Android for opening the app, showing a coordinate, and starting coordinate navigation.

## References

- Map Launcher marker implementation: <https://github.com/mattermoran/map_launcher/blob/master/lib/src/marker_url.dart>
- Map Launcher directions implementation: <https://github.com/mattermoran/map_launcher/blob/master/lib/src/directions_url.dart>
- CoPilot URL launch documentation: <https://developer.trimblemaps.com/copilot-navigation/v10-19/feature-guide/advanced-features/url-launch/>

## Available Actions

### Launch CoPilot

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(Copilot.open());
```

### View Map

```dart
await deeplinkX.launchAction(
  Copilot.view(
    coordinate: const Coordinate(latitude: 52.5163, longitude: 13.3777),
    title: 'Fleet Yard',
  ),
);
```

### Directions With Coordinates

```dart
await deeplinkX.launchAction(
  Copilot.directionsWithCoords(
    destination: const Coordinate(latitude: 52.5163, longitude: 13.3777),
    destinationTitle: 'Warehouse',
  ),
);
```

CoPilot route links are coordinate based, so DeeplinkX does not expose a text-only `directions` action for this app.

## Platform Configuration

### iOS

Add the CoPilot scheme to the `LSApplicationQueriesSchemes` array in `ios/Runner/Info.plist`:

```xml
<string>copilot</string>
```

### Android

Allow querying the package in `android/app/src/main/AndroidManifest.xml`:

```xml
<queries>
  <package android:name="com.alk.copilot.mapviewer" />
</queries>
```

## URI Formats

- View: `copilot://mydestination?type=LOCATION&action=VIEW&marker={latitude},{longitude}&name={title}`
- Directions with coordinates: `copilot://mydestination?type=LOCATION&action=GOTO&name={destinationTitle}&lat={latitude}&long={longitude}`

## Fallback Behavior

1. DeeplinkX opens the native app when installed.
2. If the app is missing and `fallbackToStore` is `true`, we redirect to the appropriate store listing.
3. Otherwise each action falls back to the CoPilot website.
4. Set `disableFallback: true` when calling `launchAction` to skip both store and web fallbacks.

### Fallback Support Matrix

| Action                        | Store Fallback | Web Fallback |
| ----------------------------- | -------------- | ------------ |
| Open app                      | Yes            | Yes          |
| View map                      | Yes            | Yes          |
| Directions with coordinates   | Yes            | Yes          |
