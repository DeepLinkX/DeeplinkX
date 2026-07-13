# 2GIS Deeplinks

DeeplinkX supports the 2GIS custom URI scheme on iOS and Android for opening the app, showing a coordinate, and building coordinate routes.

## References

- 2GIS navigation deeplink documentation: <https://help.2gis.com/question/developers-launching-2gis-navigation-using-deeplink>

## Available Actions

### Launch 2GIS

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(TwoGis.open());
```

### View Map

Android 2GIS does not expose a marker-by-coordinate URI, so the Android intent opens the supported route flow to the coordinate.

```dart
await deeplinkX.launchAction(
  TwoGis.view(
    coordinate: const Coordinate(latitude: 55.76009, longitude: 37.648801),
  ),
);
```

### Directions With Coordinates

```dart
await deeplinkX.launchAction(
  TwoGis.directionsWithCoords(
    origin: const Coordinate(latitude: 55.751244, longitude: 37.618423),
    destination: const Coordinate(latitude: 55.76009, longitude: 37.648801),
    mode: TwoGisTravelMode.transit,
  ),
);
```

2GIS route URLs are coordinate based, so DeeplinkX does not expose a text-only `directions` action for this app.

## Platform Configuration

### iOS

Add the 2GIS scheme to the `LSApplicationQueriesSchemes` array in `ios/Runner/Info.plist`:

```xml
<string>dgis</string>
```

### Android

Allow querying the package in `android/app/src/main/AndroidManifest.xml`:

```xml
<queries>
  <package android:name="ru.dublgis.dgismobile" />
</queries>
```

## URI Formats

- iOS view map: `dgis://2gis.ru/geo/{longitude},{latitude}`
- Android view map intent data: `dgis://2gis.ru/routeSearch/rsType/car/to/{longitude},{latitude}`
- Directions with coordinates: `dgis://2gis.ru/routeSearch/rsType/{car|ctx|pedestrian}/from/{originLongitude},{originLatitude}/to/{destinationLongitude},{destinationLatitude}`
- Destination-only directions: `dgis://2gis.ru/routeSearch/rsType/{car|ctx|pedestrian}/to/{destinationLongitude},{destinationLatitude}`

`TwoGisTravelMode.auto` remains as a deprecated source-compatible alias but
emits the supported `car` value. Transit custom links and web fallbacks emit
the provider-documented `ctx`. The package-targeted Android intent uses `bus`,
which is the value accepted by the current Android app for selecting public
transport.
Longitude-latitude ordering and Android's marker-to-route behavior remain
compatible with existing integrations.

## Fallback Behavior

1. DeeplinkX opens the native app when installed.
2. If the app is missing and `fallbackToStore` is `true`, we redirect to the appropriate store listing.
3. Otherwise the action falls back to `https://2gis.ru` with the same path.
4. Set `disableFallback: true` when calling `launchAction` to skip both store and web fallbacks.

### Fallback Support Matrix

| Action                       | Store Fallback | Web Fallback |
| ---------------------------- | -------------- | ------------ |
| Open app                     | Yes            | Yes (website) |
| View map                     | Yes            | Yes           |
| Directions with coordinates  | Yes            | Yes           |
