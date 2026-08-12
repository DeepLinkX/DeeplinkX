# Citymapper Deeplinks

DeeplinkX supports the Citymapper custom URI scheme on iOS and Android for opening the app and building route requests.

## References

- Citymapper deep linking overview: <https://citymapper.com/news/2386/deeplinking-with-citymapper>
- Citymapper deep linking parameters: <https://citymapper.com/news/2546/deep-linking>
- Map Launcher marker implementation: <https://github.com/mattermoran/map_launcher/blob/master/lib/src/marker_url.dart>
- Map Launcher directions implementation: <https://github.com/mattermoran/map_launcher/blob/master/lib/src/directions_url.dart>

## Available Actions

### Launch Citymapper

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(Citymapper.open());
```

### View Map

Citymapper does not expose a true marker URL. `Citymapper.view` opens the supported directions flow with the coordinate as the destination.

```dart
await deeplinkX.launchAction(
  Citymapper.view(
    coordinate: const Coordinate(latitude: 51.503399, longitude: -0.119519),
    title: 'London Eye',
  ),
);
```

### Directions With Coordinates

```dart
await deeplinkX.launchAction(
  Citymapper.directionsWithCoords(
    origin: const Coordinate(latitude: 51.500729, longitude: -0.124625),
    destination: const Coordinate(latitude: 51.503399, longitude: -0.119519),
    originTitle: 'Westminster',
    destinationTitle: 'London Eye',
    arriveBy: DateTime.utc(2026, 1, 2, 3, 4, 5),
  ),
);
```

Citymapper route URLs are coordinate based, so DeeplinkX does not expose a text-only `directions` action for this app.

## Platform Configuration

### iOS

Add the Citymapper scheme to the `LSApplicationQueriesSchemes` array in `ios/Runner/Info.plist`:

```xml
<string>citymapper</string>
```

### Android

Allow querying the package in `android/app/src/main/AndroidManifest.xml`:

```xml
<queries>
  <package android:name="com.citymapper.app.release" />
</queries>
```

## URI Formats

- Directions destination: `citymapper://directions?endcoord={latitude},{longitude}&endname={title?}`
- Directions with origin: `citymapper://directions?startcoord={originLatitude},{originLongitude}&startname={originTitle?}&endcoord={destinationLatitude},{destinationLongitude}&endname={destinationTitle?}&arriveby={iso8601?}`
- Web fallback: `https://citymapper.com/directions?...`

## Fallback Behavior

1. DeeplinkX opens the native app when installed.
2. If the app is missing and `fallbackToStore` is `true`, we redirect to the appropriate store listing.
3. Otherwise the action falls back to `https://citymapper.com/directions` with the same route parameters.
4. Set `disableFallback: true` when calling `launchAction` to skip both store and web fallbacks.

### Fallback Support Matrix

| Action                       | Store Fallback | Web Fallback |
| ---------------------------- | -------------- | ------------ |
| Open app                     | ✔️              | ✔️ (website) |
| View map                     | ✔️              | ✔️           |
| Directions with coordinates  | ✔️              | ✔️           |
