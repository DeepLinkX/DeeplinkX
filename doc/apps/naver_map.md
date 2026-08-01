# NAVER Map Deeplinks

DeeplinkX supports NAVER Map on iOS and Android for map display, integrated and bus search, route planning, turn-by-turn navigation, and safe-driving mode.

## References

- [Official NAVER Map URL-scheme guide](https://guide.ncloud-docs.com/docs/en/maps-url-scheme)
- [NAVER-confirmed coordinate web link](https://www.ncloud-forums.com/topic/242/)
- [Google Play listing](https://play.google.com/store/apps/details?id=com.nhn.android.nmap)
- [`map_launcher` 5.0.1](https://pub.dev/packages/map_launcher) comparison checked on 2026-08-02

## Calling-App Identifiers

NAVER requires every native action URL to identify the calling app. Android uses the app's `applicationId`; iOS uses its bundle ID. These values are normally different, so DeeplinkX keeps both in one immutable value:

```dart
const naverLaunchParams = NaverMapLaunchParams(
  androidAppName: 'com.example.myapp',
  iosAppName: 'com.example.myApp',
);
```

Empty identifiers are rejected before a link is built.

## Available Actions

### Open NAVER Map

```dart
await deeplinkX.launchApp(NaverMap.open());
```

### View a Map or Marker

Omit `title` to center the main map. Supply a non-empty title to show a marker.

```dart
await deeplinkX.launchAction(
  NaverMap.view(
    coordinate: const Coordinate(latitude: 37.5209436, longitude: 127.1230074),
    title: 'Olympic Park',
    zoom: 16,
    launchParams: naverLaunchParams,
  ),
);
```

### Search

```dart
await deeplinkX.launchAction(
  NaverMap.search(
    query: 'Gangnam Station',
    launchParams: naverLaunchParams,
  ),
);

await deeplinkX.launchAction(
  NaverMap.busSearch(
    query: '222',
    launchParams: naverLaunchParams,
  ),
);
```

### Directions With Coordinates

```dart
await deeplinkX.launchAction(
  NaverMap.directionsWithCoords(
    origin: const Coordinate(latitude: 37.5665, longitude: 126.9780),
    originTitle: 'Seoul City Hall',
    destination: const Coordinate(latitude: 37.5209436, longitude: 127.1230074),
    destinationTitle: 'Olympic Park',
    waypoints: const [
      NaverMapWaypoint(
        coordinate: Coordinate(latitude: 37.464007, longitude: 126.9522394),
        title: 'Seoul National University',
      ),
    ],
    mode: NaverMapTravelMode.publicTransit,
    launchParams: naverLaunchParams,
  ),
);
```

NAVER Map supports driving, public transit, walking, and bicycling routes. Omit the origin to use the current location. Up to five ordered waypoints are supported.

### Navigation and Safe Driving

```dart
await deeplinkX.launchAction(
  NaverMap.navigate(
    destination: const Coordinate(latitude: 37.5209436, longitude: 127.1230074),
    destinationTitle: 'Olympic Park',
    launchParams: naverLaunchParams,
  ),
);

await deeplinkX.launchAction(
  NaverMap.safeDriving(launchParams: naverLaunchParams),
);
```

## Provider Limits

The official native URI contract accepts latitude `31.43..44.35`, longitude `122.37..132.00`, and map zoom `4..20`. DeeplinkX validates these limits, requires non-empty searches and supplied names, and rejects more than five waypoints.

## Platform Configuration

### iOS

Add `nmap` to `LSApplicationQueriesSchemes`:

```xml
<string>nmap</string>
```

### Android

Add the package and scheme query inside `<queries>`:

```xml
<package android:name="com.nhn.android.nmap" />
<intent>
    <action android:name="android.intent.action.VIEW" />
    <data android:scheme="nmap" />
</intent>
```

Native Android actions use `ACTION_VIEW`, `CATEGORY_BROWSABLE`, the NAVER Map package, and a new-task flag.

## Native URI Formats

- Main map: `nmap://map?lat={lat}&lng={lng}&zoom={zoom}&appname={appId}`
- Marker: `nmap://place?lat={lat}&lng={lng}&name={title}&appname={appId}`
- Search: `nmap://search?query={query}&appname={appId}`
- Bus search: `nmap://search/bus?query={busNumber}&appname={appId}`
- Route: `nmap://route/{mode}?dlat={lat}&dlng={lng}&...&appname={appId}`
- Navigation: `nmap://navigation?dlat={lat}&dlng={lng}&...&appname={appId}`
- Safe driving: `nmap://navigation?appname={appId}`

## Fallback Behavior

1. DeeplinkX attempts the platform-specific native URL.
2. When `fallbackToStore` is enabled, it can redirect to Google Play or the iOS App Store if NAVER Map is unavailable.
3. View actions preserve their coordinate, title, and zoom on NAVER's web map.
4. Search and bus search preserve their query on NAVER's web search.
5. NAVER does not document a public web-routing contract, so route and navigation actions fall back to the destination marker instead of inventing an unsupported route URL.
6. Open and safe-driving actions use the NAVER Map homepage because they have no portable web payload.

## `map_launcher` Comparison

`map_launcher` 5.0.1 overlaps with NAVER marker and directions launches. DeeplinkX additionally exposes integrated search, bus search, explicit navigation and safe-driving actions, separate Android/iOS calling-app identifiers, store fallback, and action-preserving web fallbacks. Provider documentation remains authoritative for native URI behavior.
