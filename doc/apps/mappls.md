# Mappls Deeplinks

DeeplinkX supports Mappls MapmyIndia links so Flutter apps can open map locations or launch coordinate-based directions in the native app on iOS and Android.

## References

- Map Launcher open-source implementation of the same URL pattern: <https://github.com/mattermoran/map_launcher/blob/master/lib/src/marker_url.dart>
- Mappls App Store listing: <https://apps.apple.com/us/app/mappls-mapmyindia-maps/id723492531>

## Available Actions

### Launch Mappls

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(Mappls.open());
```

### View Map

```dart
await deeplinkX.launchAction(
  Mappls.view(
    coordinate: const Coordinate(latitude: 28.6139, longitude: 77.2090),
  ),
);
```

### Directions With Coordinates

```dart
await deeplinkX.launchAction(
  Mappls.directionsWithCoords(
    destination: const Coordinate(latitude: 28.6129, longitude: 77.2295),
    destinationTitle: 'India Gate',
    mode: MapplsTravelMode.driving,
  ),
);
```

Supported modes are `driving`, `walking`, `bicycling`, and `transit`.

## Platform Configuration

### iOS

Add the Mappls scheme to the `LSApplicationQueriesSchemes` array in `ios/Runner/Info.plist`:

```xml
<string>mappls</string>
```

### Android

Allow querying the package in `android/app/src/main/AndroidManifest.xml`:

```xml
<queries>
  <package android:name="com.mmi.maps" />
</queries>
```

## URL Formats

- View map: `https://www.mappls.com/location/{latitude},{longitude}`
- Directions: `https://mappls.com/navigation?places={latitude},{longitude},{destinationTitle}&mode={mode}`

## Fallback Behavior

1. DeeplinkX opens the native app when installed.
2. If the app is missing and `fallbackToStore` is `true`, we redirect to the appropriate store listing.
3. Otherwise the action falls back to the same Mappls web URL.
4. Set `disableFallback: true` when calling `launchAction` to skip both store and web fallbacks.

### Fallback Support Matrix

| Action                       | Store Fallback | Web Fallback |
| ---------------------------- | -------------- | ------------ |
| Open app                     | ✔️              | ✔️ (website) |
| View map                     | ✔️              | ✔️           |
| Directions with coordinates  | ✔️              | ✔️           |
