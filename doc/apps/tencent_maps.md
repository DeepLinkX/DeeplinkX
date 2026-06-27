# Tencent Maps Deeplinks

DeeplinkX supports the Tencent Maps custom URI scheme on iOS and Android for opening the app, showing a marker, searching, nearby searching, and coordinate route planning.

## References

- Tencent Maps mobile URI guide: <https://lbs.qq.com/webApi/uriV1/uriGuide/uriMobileGuide>
- Tencent Maps route planning: <https://lbs.qq.com/webApi/uriV1/uriGuide/uriMobileRoute>
- Tencent Maps POI search: <https://lbs.qq.com/webApi/uriV1/uriGuide/uriMobilePoisearch>
- Tencent Maps nearby search: <https://lbs.qq.com/webApi/uriV1/uriGuide/uriMobileRoundsearch>
- Tencent Maps markers: <https://lbs.qq.com/webApi/uriV1/uriGuide/uriMobileMarker>

## Available Actions

### Launch Tencent Maps

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(TencentMaps.open());
```

### View Map

```dart
await deeplinkX.launchAction(
  TencentMaps.view(
    coordinate: const Coordinate(latitude: 39.867192, longitude: 116.493187),
    title: 'Community',
    address: 'Beijing',
  ),
);
```

### Search

```dart
await deeplinkX.launchAction(
  TencentMaps.search(
    query: 'coffee',
    region: 'Shanghai',
  ),
);
```

### Nearby Search

```dart
await deeplinkX.launchAction(
  TencentMaps.nearbySearch(
    query: 'restaurant',
    center: const Coordinate(latitude: 39.994745, longitude: 116.247282),
    radius: 800,
  ),
);
```

When `center` is omitted, Tencent Maps receives `CurrentLocation` and uses the device location.

### Directions With Coordinates

```dart
await deeplinkX.launchAction(
  TencentMaps.directionsWithCoords(
    origin: const Coordinate(latitude: 39.994745, longitude: 116.247282),
    originTitle: 'Tsinghua',
    destination: const Coordinate(latitude: 39.867192, longitude: 116.493187),
    destinationTitle: 'Community',
    mode: TencentMapsTravelMode.driving,
  ),
);
```

Tencent route planning requires destination coordinates, so DeeplinkX does not expose a text-only `directions` action for this app.

## Platform Configuration

### iOS

Add the Tencent Maps scheme to the `LSApplicationQueriesSchemes` array in `ios/Runner/Info.plist`:

```xml
<string>qqmap</string>
```

### Android

Allow querying the package in `android/app/src/main/AndroidManifest.xml`:

```xml
<queries>
  <package android:name="com.tencent.map" />
</queries>
```

## URI Formats

- App scheme: `qqmap://map/`
- View map: `qqmap://map/marker?marker=coord:{latitude},{longitude};title:{title};addr:{address}&coord_type={1|2}&referer={referer}`
- Search: `qqmap://map/search?keyword={query}&region={region}&referer={referer}`
- Nearby search: `qqmap://map/search?keyword={query}&center={latitude},{longitude}&radius={meters}&coord_type={1|2}&referer={referer}`
- Directions with coordinates: `qqmap://map/routeplan?type={drive|bus|walk|bike}&fromcoord={origin}&tocoord={destination}&referer={referer}`
- Web fallbacks use the matching `https://apis.map.qq.com/uri/v1/...` endpoint.

## Fallback Behavior

1. DeeplinkX opens the native app when installed.
2. If the app is missing and `fallbackToStore` is `true`, we redirect to the matching store listing.
3. Otherwise each action falls back to the Tencent Maps web URI endpoint.
4. Set `disableFallback: true` when calling `launchAction` to skip both store and web fallbacks.

### Fallback Support Matrix

| Action                         | Store Fallback | Web Fallback |
| ------------------------------ | -------------- | ------------ |
| Open app                       | Yes            | Yes          |
| View map                       | Yes            | Yes          |
| Search                         | Yes            | Yes          |
| Nearby search                  | Yes            | Yes          |
| Directions with coordinates    | Yes            | Yes          |
