# Air Navigation Pro Deeplinks

DeeplinkX supports Air Navigation Pro's iOS `airnavpro` URI scheme and Android package-targeted HTTPS direct-to links so Flutter apps can open a coordinate in Air Navigation Pro on iOS and Android.

Air Navigation Pro does not expose a separate marker URL in the upstream Map Launcher implementation. Its map view action uses the official `direct-to` URL, which is also exposed directly through `AirNavigationPro.directTo`.

## References

- Map Launcher open-source implementation of the same URI patterns: <https://github.com/mattermoran/map_launcher/blob/master/lib/src/directions_url.dart>
- Air Navigation Pro URL manual: <https://airnavigation.aero/manual/en/html/manual/moving-map.html#create-via-url>
- Air Navigation Pro App Store listing: <https://apps.apple.com/us/app/air-navigation-pro/id301046057>

## Available Actions

### Launch Air Navigation Pro

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(AirNavigationPro.open());
```

### View Map

```dart
await deeplinkX.launchAction(
  AirNavigationPro.view(
    coordinate: const Coordinate(latitude: 46.2044, longitude: 6.1432),
  ),
);
```

### Direct To

```dart
await deeplinkX.launchAction(
  AirNavigationPro.directTo(
    destination: const Coordinate(latitude: 46.2381, longitude: 6.1090),
  ),
);
```

### Directions With Coordinates

```dart
await deeplinkX.launchAction(
  AirNavigationPro.directionsWithCoords(
    destination: const Coordinate(latitude: 46.2381, longitude: 6.1090),
  ),
);
```

## Platform Configuration

### iOS

Add the Air Navigation Pro scheme to the `LSApplicationQueriesSchemes` array in `ios/Runner/Info.plist`:

```xml
<string>airnavpro</string>
```

### Android

Allow querying the package in `android/app/src/main/AndroidManifest.xml`:

```xml
<queries>
  <package android:name="com.xample.airnavigation" />
</queries>
```

## URI Formats

- iOS direct-to: `airnavpro://direct-to?coordinates=wgs84-decimal&location={latitude}_{longitude},0.0`
- Android direct-to and web fallback: `https://airnavigation.aero/direct-to?coordinates=wgs84-decimal&location={latitude}_{longitude},0.0`

## Fallback Behavior

1. DeeplinkX opens the native app when installed.
2. If the app is missing and `fallbackToStore` is `true`, we redirect to the appropriate store listing.
3. Otherwise coordinate actions fall back to the matching `https://airnavigation.aero/direct-to` URL.
4. Set `disableFallback: true` when calling `launchAction` to skip both store and web fallbacks.

### Fallback Support Matrix

| Action                       | Store Fallback | Web Fallback |
| ---------------------------- | -------------- | ------------ |
| Open app                     | Yes            | Yes          |
| View map                     | Yes            | Yes          |
| Direct to                    | Yes            | Yes          |
| Directions with coordinates  | Yes            | Yes          |
