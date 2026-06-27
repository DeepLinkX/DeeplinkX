# OsmAnd Deeplinks

DeeplinkX supports the OsmAnd custom URI scheme on iOS and Android package intents for opening the app, showing a coordinate, and starting coordinate navigation.

## References

- OsmAnd intents documentation: <https://osmand.net/docs/technical/algorithms/osmand-intents/>
- Map Launcher marker implementation: <https://github.com/mattermoran/map_launcher/blob/master/lib/src/marker_url.dart>
- Map Launcher directions implementation: <https://github.com/mattermoran/map_launcher/blob/master/lib/src/directions_url.dart>

## Available Actions

### Launch OsmAnd

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(OsmAnd.open());
```

### View Map

```dart
await deeplinkX.launchAction(
  OsmAnd.view(
    coordinate: const Coordinate(latitude: 52.516275, longitude: 13.377704),
    zoom: 12,
  ),
);
```

### Directions With Coordinates

```dart
await deeplinkX.launchAction(
  OsmAnd.directionsWithCoords(
    destination: const Coordinate(latitude: 52.516275, longitude: 13.377704),
  ),
);
```

OsmAnd route URLs start from the current location, so DeeplinkX does not expose an origin, travel mode, waypoints, or text-only `directions` action for this app.

## Platform Configuration

### iOS

Add the OsmAnd scheme to the `LSApplicationQueriesSchemes` array in `ios/Runner/Info.plist`:

```xml
<string>osmandmaps</string>
```

### Android

Allow querying the package in `android/app/src/main/AndroidManifest.xml`:

```xml
<queries>
  <package android:name="net.osmand" />
</queries>
```

## URI Formats

- iOS view map: `osmandmaps://?lat={latitude}&lon={longitude}&z={zoom}`
- Android view map intent data: `http://osmand.net/go?lat={latitude}&lon={longitude}&z={zoom}`
- iOS directions with coordinates: `osmandmaps://navigate?lat={latitude}&lon={longitude}`
- Android directions intent data: `osmand.navigation:q={latitude},{longitude}`

## Fallback Behavior

1. DeeplinkX opens the native app when installed.
2. If the app is missing and `fallbackToStore` is `true`, we redirect to the appropriate store listing.
3. Otherwise the action falls back to `https://osmand.net/map/` with the same coordinate.
4. Set `disableFallback: true` when calling `launchAction` to skip both store and web fallbacks.

### Fallback Support Matrix

| Action                       | Store Fallback | Web Fallback |
| ---------------------------- | -------------- | ------------ |
| Open app                     | ✔️              | ✔️ (website) |
| View map                     | ✔️              | ✔️           |
| Directions with coordinates  | ✔️              | ✔️           |
