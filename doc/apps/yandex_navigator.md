# Yandex Navigator Deeplinks

DeeplinkX supports the Yandex Navigator custom URI scheme on iOS and Android for opening the app, showing a point, searching, and building coordinate routes.

## References

- Yandex Navigator URL parameters: <https://yandex.com/dev/navigator/doc/ru/concepts/navigator-url-params>
- Yandex Navigator commercial URL signatures: <https://yandex.com/dev/navigator/doc/ru/concepts/navigator-commercial-use-signature>
- Yandex Maps web launch URLs: <https://yandex.com/dev/yandex-apps-launch-maps/doc/en/concepts/yandexmaps-web>
- Map Launcher 4.5.0 Yandex Navigator implementation:
  <https://github.com/mattermoran/map_launcher/blob/master/lib/src/maps/yandex_navi.dart>

## Available Actions

### Launch Yandex Navigator

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(YandexNavigator.open());
```

### View Map

```dart
await deeplinkX.launchAction(
  YandexNavigator.view(
    coordinate: const Coordinate(latitude: 55.753716, longitude: 37.619902),
    zoom: 16,
    description: 'Red Square',
  ),
);
```

### Search

```dart
await deeplinkX.launchAction(
  YandexNavigator.search(query: 'gas station'),
);
```

### Directions With Coordinates

```dart
await deeplinkX.launchAction(
  YandexNavigator.directionsWithCoords(
    origin: const Coordinate(latitude: 55.753716, longitude: 37.619902),
    destination: const Coordinate(latitude: 55.76009, longitude: 37.648801),
    waypoints: const [
      YandexNavigatorWaypoint(
        coordinate: Coordinate(latitude: 55.745719, longitude: 37.604337),
      ),
    ],
  ),
);
```

Yandex Navigator route URLs are coordinate based, so DeeplinkX does not expose a text-only `directions` action for this app.

### Commercial Launch Parameters

If your Yandex integration requires commercial identification, pass the optional `client` and `signature` query parameters:

```dart
await deeplinkX.launchAction(
  YandexNavigator.search(
    query: 'airport',
    launchParams: const YandexNavigatorLaunchParams(
      client: 'client-id',
      signature: 'signed-url-value',
    ),
  ),
);
```

Yandex requires access-key identification when coordinates, search terms, or
other data are passed to Navigator. Without it, launches can be rate-limited.
DeeplinkX forwards `client` and `signature`; it does not generate signatures.

## Platform Configuration

### iOS

Add the Yandex Navigator scheme to the `LSApplicationQueriesSchemes` array in `ios/Runner/Info.plist`:

```xml
<string>yandexnavi</string>
```

### Android

Allow querying the package in `android/app/src/main/AndroidManifest.xml`:

```xml
<queries>
  <package android:name="ru.yandex.yandexnavi" />
  <intent>
    <action android:name="android.intent.action.VIEW" />
    <data android:scheme="yandexnavi" />
  </intent>
</queries>
```

## URI Formats

- View map: `yandexnavi://show_point_on_map?lat={latitude}&lon={longitude}&zoom={zoom}&no-balloon={0|1}&desc={description?}`
- Search: `yandexnavi://map_search?text={query}`
- Directions with coordinates: `yandexnavi://build_route_on_map?lat_from={originLatitude?}&lon_from={originLongitude?}&lat_to={destinationLatitude}&lon_to={destinationLongitude}&lat_via_0={waypointLatitude?}&lon_via_0={waypointLongitude?}`

## Fallback Behavior

1. DeeplinkX opens the native app when installed.
2. If the app is missing and `fallbackToStore` is `true`, we redirect to the appropriate store listing.
3. Otherwise DeeplinkX opens the matching Yandex Maps web action:
   - View with a marker: `https://yandex.com/maps/?pt={longitude},{latitude}&z={zoom}&l=map`
   - View without a marker: `https://yandex.com/maps/?ll={longitude},{latitude}&z={zoom}&l=map`
   - Search: `https://yandex.com/maps/?text={query}&l=map`
   - Directions: `https://yandex.com/maps/?rtext={origin?}~{waypoints...}~{destination}&rtt=auto`
4. Set `disableFallback: true` when calling `launchAction` to skip both store and web fallbacks.

Placemark URLs use longitude,latitude. Route URLs use latitude,longitude. When
the route origin is omitted, the web URL starts `rtext` with `~` so Yandex Maps
uses the current location. Native-only parameters such as `client`,
`signature`, `description`, and `no-balloon` are not copied into web URLs.

### Fallback Support Matrix

| Action                       | Store Fallback | Web Fallback |
| ---------------------------- | -------------- | ------------ |
| Open app                     | ✔️              | ✔️ (website) |
| View map                     | ✔️              | ✔️           |
| Search                       | ✔️              | ✔️           |
| Directions with coordinates  | ✔️              | ✔️           |

## Map Launcher Comparison

Checked against `map_launcher` 4.5.0 on July 23, 2026. DeeplinkX matches its
Yandex Navigator marker, destination, optional-origin, and waypoint URI
behavior. DeeplinkX additionally exposes Yandex's documented search action,
store fallback, balloon visibility, launch identification parameters, shared
map-action interfaces, and action-preserving Yandex Maps web fallbacks.
