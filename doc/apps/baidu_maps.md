# Baidu Maps Deeplinks

DeeplinkX supports Baidu Maps URI actions on Android and iOS. The integration uses the `baidumap` scheme and Android package-targeted intents so launch attempts can prefer the native app before falling back.

## References

- Baidu Maps Android URI API: <https://lbs.baidu.com/faq/api?title=webapi%2Furi%2Fandriod>
- Baidu Maps iOS URI API: <https://lbs.baidu.com/docs/webapi?title=mapadjustment%2Furi%2Fios>

## Usage

### Launch Baidu Maps

```dart
final deeplinkX = DeeplinkX();

await deeplinkX.launchApp(BaiduMaps.open());
```

### View A Marker

```dart
await deeplinkX.launchAction(
  BaiduMaps.view(
    coordinate: const Coordinate(latitude: 39.915, longitude: 116.404),
    title: 'Tiananmen',
    content: 'Beijing landmark',
    zoom: 16,
    coordType: BaiduMapsCoordType.wgs84,
  ),
);
```

### Search

```dart
await deeplinkX.launchAction(
  BaiduMaps.search(
    query: 'coffee',
    region: 'Beijing',
    center: const Coordinate(latitude: 39.915, longitude: 116.404),
    radius: 1000,
  ),
);
```

### Nearby Search

```dart
await deeplinkX.launchAction(
  BaiduMaps.nearbySearch(
    query: 'hotel',
    center: const Coordinate(latitude: 31.2304, longitude: 121.4737),
    radius: 2500,
  ),
);
```

### Transit Line

```dart
await deeplinkX.launchAction(
  BaiduMaps.line(
    name: 'Line 1',
    region: 'Beijing',
  ),
);
```

### Directions By Text

```dart
await deeplinkX.launchAction(
  BaiduMaps.directions(
    origin: 'Beijing Railway Station',
    destination: 'Tiananmen',
    region: 'Beijing',
    mode: BaiduMapsTravelMode.transit,
  ),
);
```

If `origin` is omitted, DeeplinkX uses Baidu Maps' current-location token.

### Directions By Coordinates

```dart
await deeplinkX.launchAction(
  BaiduMaps.directionsWithCoords(
    origin: const Coordinate(latitude: 39.9042, longitude: 116.4074),
    originTitle: 'Start',
    destination: const Coordinate(latitude: 39.915, longitude: 116.404),
    destinationTitle: 'Tiananmen',
    region: 'Beijing',
    mode: BaiduMapsTravelMode.walking,
    coordType: BaiduMapsCoordType.wgs84,
  ),
);
```

### Native Navigation

```dart
await deeplinkX.launchAction(
  BaiduMaps.navigate(
    destination: const Coordinate(latitude: 39.915, longitude: 116.404),
    mode: BaiduMapsNavigationMode.walking,
  ),
);
```

## Map Launcher Interfaces

These actions implement shared map-launcher abstractions:

| Interface                       | Baidu Maps action                  |
| ------------------------------- | ---------------------------------- |
| `MapViewAction`                 | `BaiduMaps.view`                   |
| `MapSearchAction`               | `BaiduMaps.search`                 |
| `MapDirectionsAction`           | `BaiduMaps.directions`             |
| `MapDirectionsWithCoordsAction` | `BaiduMaps.directionsWithCoords`   |

The `nearbySearch`, `line`, and `navigate` actions are Baidu-specific extras.

## Platform Configuration

### iOS

Add the Baidu Maps scheme to `LSApplicationQueriesSchemes` in `ios/Runner/Info.plist`:

```xml
<key>LSApplicationQueriesSchemes</key>
<array>
  <string>baidumap</string>
</array>
```

### Android

Add Baidu Maps to package visibility in `android/app/src/main/AndroidManifest.xml`:

```xml
<queries>
  <package android:name="com.baidu.BaiduMap" />
  <intent>
    <action android:name="android.intent.action.VIEW" />
    <data android:scheme="baidumap" />
  </intent>
</queries>
```

## URI Formats

| Action             | URI format                              |
| ------------------ | --------------------------------------- |
| View marker        | `baidumap://map/marker`                 |
| Search             | `baidumap://map/place/search`           |
| Nearby search      | `baidumap://map/place/nearby`           |
| Transit line       | `baidumap://map/line`                   |
| Directions         | `baidumap://map/direction`              |
| Driving navigation | `baidumap://map/navi`                   |
| Walking navigation | `baidumap://map/walknavi`               |
| Riding navigation  | Android `bikenavi`, iOS `ridenavi`      |

## Fallbacks

| Condition                         | Behavior                                   |
| --------------------------------- | ------------------------------------------ |
| Baidu Maps installed             | Opens Baidu Maps using URI/intents         |
| Baidu Maps missing, store enabled | Opens Google Play or the iOS App Store     |
| Baidu Maps missing, store off     | Falls back to `https://map.baidu.com`      |
