# HERE WeGo Deeplinks

DeeplinkX supports HERE WeGo on iOS and Android through HERE share links for showing locations and planning coordinate routes.

## References

- Map Launcher marker implementation: <https://github.com/mattermoran/map_launcher/blob/master/lib/src/marker_url.dart>
- Map Launcher directions implementation: <https://github.com/mattermoran/map_launcher/blob/master/lib/src/directions_url.dart>
- Map Launcher platform app metadata: <https://github.com/mattermoran/map_launcher>
- HERE share links: <https://docs.here.com/wego-pro/docs/share-location-dl>

## Available Actions

### Launch HERE WeGo

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(HereWeGo.open());
```

### View Map

```dart
await deeplinkX.launchAction(
  HereWeGo.view(
    coordinate: const Coordinate(latitude: 52.5163, longitude: 13.3777),
    title: 'Brandenburg Gate',
    zoom: 15,
  ),
);
```

### Directions With Coordinates

```dart
await deeplinkX.launchAction(
  HereWeGo.directionsWithCoords(
    origin: const Coordinate(latitude: 52.5308, longitude: 13.3847),
    originTitle: 'Berlin Central Station',
    destination: const Coordinate(latitude: 52.5163, longitude: 13.3777),
    destinationTitle: 'Brandenburg Gate',
    mode: HereWeGoTravelMode.transit,
  ),
);
```

HERE share route links are coordinate based, so DeeplinkX does not expose a text-only `directions` action for this app.

## Platform Configuration

### iOS

Add the HERE WeGo scheme to the `LSApplicationQueriesSchemes` array in `ios/Runner/Info.plist`:

```xml
<string>here-location</string>
```

### Android

Allow querying the package in `android/app/src/main/AndroidManifest.xml`:

```xml
<queries>
  <package android:name="com.here.app.maps" />
</queries>
```

## URI Formats

- App detection scheme: `here-location://`
- View map: `https://share.here.com/l/{latitude},{longitude},{title}?z={zoom}`
- Directions with coordinates: `https://share.here.com/r/{originLatitude},{originLongitude},{originTitle}/{destinationLatitude},{destinationLongitude},{destinationTitle}?m={d|pt|w|b}`
- Destination-only directions: `https://share.here.com/r/{destinationLatitude},{destinationLongitude},{destinationTitle}?m={d|pt|w|b}`

## Fallback Behavior

1. DeeplinkX opens the native app when installed.
2. If the app is missing and `fallbackToStore` is `true`, we redirect to the appropriate store listing.
3. Otherwise each action falls back to the same HERE share link.
4. Set `disableFallback: true` when calling `launchAction` to skip both store and web fallbacks.

### Fallback Support Matrix

| Action                        | Store Fallback | Web Fallback |
| ----------------------------- | -------------- | ------------ |
| Open app                      | Yes            | Yes          |
| View map                      | Yes            | Yes          |
| Directions with coordinates   | Yes            | Yes          |
