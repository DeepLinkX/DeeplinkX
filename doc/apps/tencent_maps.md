# Tencent Maps Deeplinks

DeeplinkX supports Tencent Maps on iOS and Android for opening the app, displaying a coordinate or marker, searching, nearby searching, and coordinate route planning.

## References

- [Mobile URI guide](https://lbs.qq.com/webApi/uriV1/uriGuide/uriMobileGuide)
- [Mobile marker and geocoder](https://lbs.qq.com/webApi/uriV1/uriGuide/uriMobileMarker)
- [Mobile search](https://lbs.qq.com/webApi/uriV1/uriGuide/uriMobilePoisearch)
- [Mobile route planning](https://lbs.qq.com/webApi/uriV1/uriGuide/uriMobileRoute)
- [Web marker and geocoder](https://lbs.qq.com/webApi/uriV1/uriGuide/uriWebMarker)
- [Web search](https://lbs.qq.com/webApi/uriV1/uriGuide/uriWebPoisearch)
- [Web route planning](https://lbs.qq.com/webApi/uriV1/uriGuide/uriWebRoute)
- [Official Android distribution page](https://sj.qq.com/appdetail/com.tencent.map)

## Developer Key

Tencent's mobile URI contract requires a developer key in the `referer` parameter. Create a key in the [Tencent Location Service console](https://lbs.qq.com/dev/console/key/add), then pass it to every action except `open`.

```dart
const tencentMapsKey = 'YOUR_TENCENT_MAPS_KEY';
```

DeeplinkX rejects an empty key. It does not include or log a key for you.

## Available Actions

### Open App

```dart
final deeplinkX = DeeplinkX();

await deeplinkX.launchApp(
  TencentMaps.open(fallbackToStore: true),
);
```

Tencent Maps currently has an iOS App Store action. Its old Google Play listing is not used. When a native launch has no matching store action, `open` uses Tencent's official cross-platform download page:

```text
https://pr.map.qq.com/j/tmap/download
```

### View Map

Pass only a coordinate to let Tencent Maps reverse-geocode it:

```dart
await deeplinkX.launchAction(
  TencentMaps.view(
    coordinate: const Coordinate(
      latitude: 39.867192,
      longitude: 116.493187,
    ),
    referer: tencentMapsKey,
  ),
);
```

Pass both `title` and `address` to display a custom marker:

```dart
await deeplinkX.launchAction(
  TencentMaps.view(
    coordinate: const Coordinate(
      latitude: 39.867192,
      longitude: 116.493187,
    ),
    title: 'Tencent Office',
    address: 'Beijing',
    coordType: TencentMapsCoordType.gps,
    referer: tencentMapsKey,
  ),
);
```

Supplying only one marker field throws `ArgumentError`.

### Search

```dart
await deeplinkX.launchAction(
  TencentMaps.search(
    query: 'coffee',
    region: 'Shanghai',
    referer: tencentMapsKey,
  ),
);
```

### Nearby Search

```dart
await deeplinkX.launchAction(
  TencentMaps.nearbySearch(
    query: 'restaurant',
    center: const Coordinate(
      latitude: 39.994745,
      longitude: 116.247282,
    ),
    radius: 800,
    coordType: TencentMapsCoordType.gps,
    referer: tencentMapsKey,
  ),
);
```

When `center` is omitted, native Tencent Maps and mobile web use `CurrentLocation`. Tencent documents that value as mobile-only, so a desktop browser may not complete a current-location nearby search.

### Directions With Coordinates

```dart
await deeplinkX.launchAction(
  TencentMaps.directionsWithCoords(
    origin: const Coordinate(
      latitude: 39.994745,
      longitude: 116.247282,
    ),
    originTitle: 'Tsinghua',
    destination: const Coordinate(
      latitude: 39.867192,
      longitude: 116.493187,
    ),
    destinationTitle: 'Community',
    destinationPoiId: '12609347545913930473',
    waypoints: const [
      TencentMapsWaypoint(
        title: 'Metro Station',
        coordinate: Coordinate(
          latitude: 30.248015,
          longitude: 120.207788,
        ),
      ),
    ],
    mode: TencentMapsTravelMode.driving,
    coordType: TencentMapsCoordType.gps,
    referer: tencentMapsKey,
  ),
);
```

Tencent Maps supports driving, transit, walking, and bicycling in its Android and iOS URI. Up to 15 waypoints are accepted. When `origin` is omitted, the native URI uses `CurrentLocation`.

Tencent's web route endpoint supports driving, transit, and walking. The bicycling fallback therefore opens the destination through Tencent's web geocoder instead of inventing an unsupported cycling route.

## Native And Web Parameter Differences

DeeplinkX builds native and web parameters separately:

- Native marker, geocoder, nearby-search, and route URIs do not receive the web-only `coord_type` parameter.
- `coordType` controls coordinate conversion in Tencent's HTTPS fallback. Native URIs receive the supplied coordinates unchanged.
- Native route `destinationPoiId` and `waypoints` are omitted from the web route because Tencent does not document `touid` or `passes` for that endpoint.
- A web route always receives a destination name. DeeplinkX uses `Destination` when `destinationTitle` is omitted.
- A destination-only web route omits origin parameters so mobile Tencent Maps can use the current location.

## Platform Configuration

### iOS

Add `qqmap` under `LSApplicationQueriesSchemes`:

```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>qqmap</string>
</array>
```

### Android

Add the package and scheme intent under the manifest-level `queries` element:

```xml
<queries>
    <package android:name="com.tencent.map" />
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="qqmap" />
    </intent>
</queries>
```

## URI Formats

- Open/download fallback: `https://pr.map.qq.com/j/tmap/download`
- Native marker: `qqmap://map/marker?marker=...&referer={developerKey}`
- Native coordinate geocoder: `qqmap://map/geocoder?coord={latitude},{longitude}&referer={developerKey}`
- Native search: `qqmap://map/search?keyword={query}&region={region}&referer={developerKey}`
- Native nearby search: `qqmap://map/search?keyword={query}&center={coordinate|CurrentLocation}&radius={meters}&referer={developerKey}`
- Native route: `qqmap://map/routeplan?type={drive|bus|walk|bike}&fromcoord={origin|CurrentLocation}&tocoord={destination}&referer={developerKey}`
- Web actions: matching `https://apis.map.qq.com/uri/v1/...` endpoints, with the documented web parameter set

## Fallback Behavior

| Action | iOS Store | Android Store | Provider Web Fallback |
| --- | --- | --- | --- |
| Open app | App Store | Official download page | Official download page |
| View map | App Store when enabled | Not available | Marker or geocoder |
| Search | App Store when enabled | Not available | Search |
| Nearby search | App Store when enabled | Not available | Nearby search |
| Directions with coordinates | App Store when enabled | Not available | Route plan, or destination geocoder for bicycling |

Set `disableFallback: true` on `launchApp` or `launchAction` to skip store and web fallbacks.

## Comparison With `map_launcher`

Checked against [`map_launcher` 6.0.0](https://pub.dev/packages/map_launcher/versions/6.0.0) on 2026-07-28.

Both packages support Tencent Maps markers and coordinate directions and require a Tencent `referer` key. DeeplinkX additionally exposes keyword search, nearby search, typed store fallback, the official download fallback, native waypoint and destination-POI parameters, and provider-specific HTTPS fallbacks that preserve the requested action where Tencent's web contract supports it.
