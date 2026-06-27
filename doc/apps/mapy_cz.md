# Mapy.cz Deeplinks

DeeplinkX supports Mapy.cz / Mapy.com links so Flutter apps can open map locations or coordinate-based directions in the native app on iOS and Android.

## References

- Map Launcher open-source implementation of the same URL pattern: <https://github.com/mattermoran/map_launcher/blob/master/lib/src/marker_url.dart>
- Mapy.com App Store listing: <https://apps.apple.com/us/app/mapy-com-maps-gps-offline/id411411020>

## Available Actions

### Launch Mapy.cz

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(MapyCz.open());
```

### View Map

```dart
await deeplinkX.launchAction(
  MapyCz.view(
    coordinate: const Coordinate(latitude: 50.0755, longitude: 14.4378),
    zoom: 15,
  ),
);
```

### Directions With Coordinates

```dart
await deeplinkX.launchAction(
  MapyCz.directionsWithCoords(
    destination: const Coordinate(latitude: 50.0755, longitude: 14.4378),
  ),
);
```

## Platform Configuration

### iOS

Add the Mapy.cz scheme to the `LSApplicationQueriesSchemes` array in `ios/Runner/Info.plist`:

```xml
<string>szn-mapy</string>
```

### Android

Allow querying the package in `android/app/src/main/AndroidManifest.xml`:

```xml
<queries>
  <package android:name="cz.seznam.mapy" />
</queries>
```

## URL Formats

- View map: `https://mapy.cz/zakladni?id={longitude},{latitude}&z={zoom}&source=coor`
- Directions/location: `https://mapy.cz/zakladni?id={longitude},{latitude}&source=coor`

## Fallback Behavior

1. DeeplinkX opens the native app when installed.
2. If the app is missing and `fallbackToStore` is `true`, we redirect to the appropriate store listing.
3. Otherwise the action falls back to the same Mapy.cz web URL.
4. Set `disableFallback: true` when calling `launchAction` to skip both store and web fallbacks.

### Fallback Support Matrix

| Action                       | Store Fallback | Web Fallback |
| ---------------------------- | -------------- | ------------ |
| Open app                     | ✔️              | ✔️ (website) |
| View map                     | ✔️              | ✔️           |
| Directions with coordinates  | ✔️              | ✔️           |
