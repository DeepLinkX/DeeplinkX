# NAVER Map Deeplinks

DeeplinkX supports NAVER Maps on iOS and Android for opening the app, showing a coordinate, and starting coordinate navigation.

## References

- Map Launcher marker implementation: <https://github.com/mattermoran/map_launcher/blob/master/lib/src/marker_url.dart>
- Map Launcher directions implementation: <https://github.com/mattermoran/map_launcher/blob/master/lib/src/directions_url.dart>
- Map Launcher platform app metadata: <https://github.com/mattermoran/map_launcher>

## Available Actions

### Launch NAVER Map

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(NaverMap.open());
```

### View Map

```dart
await deeplinkX.launchAction(
  NaverMap.view(
    coordinate: const Coordinate(latitude: 37.5547, longitude: 126.9706),
    title: 'Seoul Station',
    zoom: 15,
  ),
);
```

### Directions With Coordinates

```dart
await deeplinkX.launchAction(
  NaverMap.directionsWithCoords(
    origin: const Coordinate(latitude: 37.5665, longitude: 126.9780),
    originTitle: 'City Hall',
    destination: const Coordinate(latitude: 37.5547, longitude: 126.9706),
    destinationTitle: 'Seoul Station',
  ),
);
```

NAVER Map route links are coordinate based, so DeeplinkX does not expose a text-only `directions` action for this app.

## Platform Configuration

### iOS

Add the NAVER Map scheme to the `LSApplicationQueriesSchemes` array in `ios/Runner/Info.plist`:

```xml
<string>nmap</string>
```

### Android

Allow querying the package in `android/app/src/main/AndroidManifest.xml`:

```xml
<queries>
  <package android:name="com.nhn.android.nmap" />
</queries>
```

## URI Formats

- View: `nmap://place?lat={latitude}&lng={longitude}&zoom={zoom}&name={title}`
- Directions with coordinates: `nmap://route/car?slat={originLatitude}&slng={originLongitude}&sname={originTitle}&dlat={destinationLatitude}&dlng={destinationLongitude}&dname={destinationTitle}`

## Fallback Behavior

1. DeeplinkX opens the native app when installed.
2. If the app is missing and `fallbackToStore` is `true`, we redirect to the appropriate store listing.
3. Otherwise each action falls back to the NAVER Maps website.
4. Set `disableFallback: true` when calling `launchAction` to skip both store and web fallbacks.

### Fallback Support Matrix

| Action                        | Store Fallback | Web Fallback |
| ----------------------------- | -------------- | ------------ |
| Open app                      | Yes            | Yes          |
| View map                      | Yes            | Yes          |
| Directions with coordinates   | Yes            | Yes          |
