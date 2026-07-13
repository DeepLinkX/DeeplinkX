# Yandex Maps Deeplinks

DeeplinkX supports the Yandex Maps `yandexmaps` URI scheme on iOS and Android.
It can open the app, show a map or placemark, search, open an organization
card, open the "What's here?" card, build coordinate routes, and launch
panoramas.

## References

- Yandex Maps Android launch URLs: <https://yandex.com/dev/yandex-apps-launch-maps/doc/en/concepts/yandexmaps-android-app>
- Yandex Maps iOS launch URLs: <https://yandex.com/dev/yandex-apps-launch-maps/doc/en/concepts/yandexmaps-ios-app>
- Yandex Maps web launch URLs: <https://yandex.com/dev/yandex-apps-launch-maps/doc/en/concepts/yandexmaps-web>

## Available Actions

### Launch Yandex Maps

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(YandexMaps.open());
```

### Open Map

```dart
await deeplinkX.launchAction(
  YandexMaps.openMap(
    center: const Coordinate(latitude: 55.753716, longitude: 37.619902),
    zoom: 11,
    showTraffic: true,
  ),
);
```

### View Map

```dart
await deeplinkX.launchAction(
  YandexMaps.view(
    coordinate: const Coordinate(latitude: 55.753716, longitude: 37.619902),
    zoom: 12,
  ),
);
```

### Search

```dart
await deeplinkX.launchAction(
  YandexMaps.search(
    query: 'cafe with wi-fi',
    center: const Coordinate(latitude: 55.753716, longitude: 37.619902),
    zoom: 16,
  ),
);
```

### Organization Card

```dart
await deeplinkX.launchAction(
  YandexMaps.organization(objectId: '1221676748'),
);
```

### What Is Here

```dart
await deeplinkX.launchAction(
  YandexMaps.whatIsHere(
    coordinate: const Coordinate(latitude: 55.753716, longitude: 37.619902),
    zoom: 17,
  ),
);
```

### Directions With Coordinates

```dart
await deeplinkX.launchAction(
  YandexMaps.directionsWithCoords(
    origin: const Coordinate(latitude: 55.753716, longitude: 37.619902),
    destination: const Coordinate(latitude: 55.76009, longitude: 37.648801),
    waypoints: const [
      YandexMapsWaypoint(
        coordinate: Coordinate(latitude: 55.745719, longitude: 37.604337),
      ),
    ],
    mode: YandexMapsTravelMode.transit,
  ),
);
```

### Panorama

```dart
await deeplinkX.launchAction(
  YandexMaps.panorama(
    coordinate: const Coordinate(latitude: 55.753716, longitude: 37.619902),
    direction: const YandexMapsPanoramaDirection(
      azimuth: 228.97,
      elevation: 6.060547,
    ),
    span: const YandexMapsPanoramaSpan(horizontal: 130, vertical: 71.919192),
  ),
);
```

## Platform Configuration

### iOS

Add the Yandex Maps scheme to the `LSApplicationQueriesSchemes` array in
`ios/Runner/Info.plist`:

```xml
<string>yandexmaps</string>
```

### Android

Allow querying the package in `android/app/src/main/AndroidManifest.xml`:

```xml
<queries>
  <package android:name="ru.yandex.yandexmaps" />
</queries>
```

## URI Formats

- Open map: `yandexmaps://maps.yandex.com/?ll={longitude},{latitude}&z={zoom}&l={layer}`
- View map: `yandexmaps://maps.yandex.ru/?pt={longitude},{latitude}&z={zoom}&l={layer}`
- Search: `yandexmaps://maps.yandex.com/?text={query}`
- Organization card: `yandexmaps://maps.yandex.com/?oid={objectId}`
- What is here: `yandexmaps://?whatshere[point]={longitude},{latitude}&whatshere[zoom]={zoom}`
- Directions: `yandexmaps://maps.yandex.com/?rtext={originLat},{originLng}~{destinationLat},{destinationLng}&rtt={mode}`
- Destination-only directions: `yandexmaps://maps.yandex.com/?rtext=~{destinationLat},{destinationLng}&rtt={mode}`
- Panorama: `yandexmaps://?panorama[point]={longitude},{latitude}&panorama[direction]={azimuth},{elevation}&panorama[span]={horizontal},{vertical}`

Routes use latitude-longitude pairs in `rtext`. Map display, search areas,
object lookup, and panorama points use longitude-latitude pairs, matching the
Yandex Maps launch URL docs.

Marker and route coordinate ordering, destination-only routes, and waypoint
ordering remain compatible with existing integrations. Destination-only routes
retain the leading `~` placeholder so Yandex uses the current location as the
origin. DeeplinkX also
validates provider ranges: zoom is 1 through 18, viewport deltas and panorama
spans must be positive and finite, organization IDs must contain only digits,
and panorama direction values must be finite and between 0 and 360.

## Fallback Behavior

1. DeeplinkX opens Yandex Maps when installed.
2. If the app is missing and `fallbackToStore` is `true`, it redirects to the
   matching App Store or Google Play listing.
3. Otherwise actions fall back to Yandex Maps on the web.
4. Set `disableFallback: true` when calling `launchAction` to skip both store
   and web fallbacks.

Organization cards use `https://yandex.com/maps/org/{objectId}` for their web
fallback. The native-only public map layer falls back to the standard map layer
on the web, while retaining the traffic layer when requested.

### Fallback Support Matrix

| Action                       | Store Fallback | Web Fallback |
| ---------------------------- | -------------- | ------------ |
| Open app                     | Yes            | Yes          |
| Open map                     | Yes            | Yes          |
| View map                     | Yes            | Yes          |
| Search                       | Yes            | Yes          |
| Organization card            | Yes            | Yes          |
| What is here                 | Yes            | Yes          |
| Directions with coordinates  | Yes            | Yes          |
| Panorama                     | Yes            | Yes          |

DeeplinkX does not expose a text-only `directions` action for Yandex Maps
because the Yandex Maps mobile launch URLs route by coordinates.
