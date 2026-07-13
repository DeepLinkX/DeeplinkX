# Amap Deeplinks

DeeplinkX supports Amap (Gaode Maps) deep links on Android and iOS for opening the app, viewing locations, searching places, and planning routes.

## References

- Amap Android URI docs: <https://lbs.amap.com/api/amap-mobile/guide/android/marker>
- Amap iOS URI docs: <https://lbs.amap.com/api/amap-mobile/guide/ios/ios-uri-information>
- Amap Android route docs: <https://lbs.amap.com/api/amap-mobile/guide/android/route>
- Amap iOS route docs: <https://lbs.amap.com/api/amap-mobile/guide/ios/route>
- Amap Android search docs: <https://lbs.amap.com/api/amap-mobile/guide/android/search>
- Amap iOS search docs: <https://lbs.amap.com/api/amap-mobile/guide/ios/search>

## Available Actions

### Launch Amap

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(Amap.open());
```

### My Location

```dart
await deeplinkX.launchAction(Amap.myLocation());
```

### View Map

```dart
await deeplinkX.launchAction(
  Amap.view(
    coordinate: const Coordinate(latitude: 39.98848272, longitude: 116.47560823),
    title: 'Amap HQ',
    sourceApplication: 'my_flutter_app',
    convertFromWgs84: true,
  ),
);
```

### Search

```dart
await deeplinkX.launchAction(
  Amap.search(
    query: 'bank|fuel',
    bounds: const AmapBounds(
      topLeft: Coordinate(latitude: 36.1, longitude: 116.1),
      bottomRight: Coordinate(latitude: 36.2, longitude: 116.2),
    ),
  ),
);
```

### Directions

```dart
await deeplinkX.launchAction(
  Amap.directions(destination: 'Amap HQ'),
);
```

### Directions With Coordinates

```dart
await deeplinkX.launchAction(
  Amap.directionsWithCoords(
    origin: const Coordinate(latitude: 39.92848272, longitude: 116.39560823),
    originTitle: 'Start',
    destination: const Coordinate(latitude: 39.98848272, longitude: 116.47560823),
    destinationTitle: 'Amap HQ',
    waypoints: const [
      AmapWaypoint(
        coordinate: Coordinate(latitude: 39.5, longitude: 116.8),
        title: 'Waypoint',
      ),
    ],
    mode: AmapTravelMode.driving,
    convertFromWgs84: true,
  ),
);
```

## Platform Configuration

### iOS

Add the Amap scheme to the `LSApplicationQueriesSchemes` array in `ios/Runner/Info.plist`:

```xml
<string>iosamap</string>
```

### Android

Allow querying the Amap package in `android/app/src/main/AndroidManifest.xml`:

```xml
<queries>
  <package android:name="com.autonavi.minimap" />
</queries>
```

## URI Formats

### iOS

- My location: `iosamap://mylocation?sourceApplication=deeplink_x`
- View map: `iosamap://viewmap?sourceApplication=deeplink_x&poiname={title}&lat={lat}&lon={lon}&dev={0|1}`
- Search: `iosamap://poi?sourceApplication=deeplink_x&name={query}&lat1={lat1}&lon1={lon1}&lat2={lat2}&lon2={lon2}&dev={0|1}`
- Directions: `iosamap://path?sourceApplication=deeplink_x&dname={destination}&dev=0&t=0`
- Directions with coordinates: `iosamap://path?sourceApplication=deeplink_x&slat={origin_lat}&slon={origin_lng}&sname={origin}&dlat={dest_lat}&dlon={dest_lng}&dname={destination}&dev={0|1}&t={mode}`

### Android

- My location: `androidamap://mylocation?sourceApplication=deeplink_x`
- View map: `androidamap://viewmap?sourceApplication=deeplink_x&poiname={title}&lat={lat}&lon={lon}&dev={0|1}`
- Search: `androidamap://poi?sourceApplication=deeplink_x&keywords={query}&lat1={lat1}&lon1={lon1}&lat2={lat2}&lon2={lon2}&dev={0|1}`
- Directions: `androidamap://keywordNavi?sourceApplication=deeplink_x&keyword={destination}&style=2`
- Directions with coordinates: `amapuri://route/plan/?sourceApplication=deeplink_x&slat={origin_lat}&slon={origin_lng}&sname={origin}&dlat={dest_lat}&dlon={dest_lng}&dname={destination}&dev={0|1}&t={mode}`

`sourceApplication` is optional on every action and defaults to `deeplink_x`.
Marker titles default to `Pin` when omitted. Text-only Android destinations use
Amap's documented `keywordNavi` entry point.

## Fallback Behavior

1. DeeplinkX opens Amap when installed.
2. If the app is missing and `fallbackToStore` is `true`, DeeplinkX redirects to the platform store listing.
3. Otherwise actions fall back to `https://www.amap.com`.
4. Set `disableFallback: true` when calling `launchAction` to skip both store and web fallbacks.

### Fallback Support Matrix

| Action                      | Store Fallback | Web Fallback |
| --------------------------- | -------------- | ------------ |
| Open app                    | ✔️             | ✔️           |
| My location                 | ✔️             | ✔️           |
| View map                    | ✔️             | ✔️           |
| Search                      | ✔️             | ✔️           |
| Directions                  | ✔️             | ✔️           |
| Directions with coordinates | ✔️             | ✔️           |
