# TomTom Go Fleet Deeplinks

DeeplinkX supports TomTom Go Fleet on iOS and Android for opening the app, showing a coordinate, and starting coordinate navigation.

## References

- Map Launcher marker implementation: <https://github.com/mattermoran/map_launcher/blob/master/lib/src/marker_url.dart>
- Map Launcher directions implementation: <https://github.com/mattermoran/map_launcher/blob/master/lib/src/directions_url.dart>
- Map Launcher platform app metadata: <https://github.com/mattermoran/map_launcher>

## Available Actions

### Launch TomTom Go Fleet

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(TomTomGoFleet.open());
```

### View Map

```dart
await deeplinkX.launchAction(
  TomTomGoFleet.view(
    coordinate: const Coordinate(latitude: 52.5163, longitude: 13.3777),
    title: 'Fleet Yard',
  ),
);
```

### Directions With Coordinates

```dart
await deeplinkX.launchAction(
  TomTomGoFleet.directionsWithCoords(
    destination: const Coordinate(latitude: 52.5163, longitude: 13.3777),
  ),
);
```

TomTom Go Fleet route links are coordinate based, so DeeplinkX does not expose a text-only `directions` action for this app.

## Platform Configuration

### iOS

Add the TomTom Go Fleet scheme to the `LSApplicationQueriesSchemes` array in `ios/Runner/Info.plist`:

```xml
<string>tomtomgofleet</string>
```

The upstream launcher metadata exposes an iOS scheme, but no public iOS App Store listing was available when this action was added. iOS uses the app scheme for installation checks and the website fallback when the app is missing.

### Android

Allow querying the package in `android/app/src/main/AndroidManifest.xml`:

```xml
<queries>
  <package android:name="com.tomtom.gplay.navapp.gofleet" />
</queries>
```

## URI Formats

- View intent/link: `geo:{latitude},{longitude}?q={latitude},{longitude}{title}`
- Directions intent/link: `google.navigation:?q={latitude},{longitude}`

## Fallback Behavior

1. DeeplinkX opens the native app when installed.
2. If the app is missing and `fallbackToStore` is `true`, Android redirects to the Google Play listing.
3. Otherwise each action falls back to the TomTom fleet website.
4. Set `disableFallback: true` when calling `launchAction` to skip both store and web fallbacks.

### Fallback Support Matrix

| Action                        | Store Fallback | Web Fallback |
| ----------------------------- | -------------- | ------------ |
| Open app                      | Android        | Yes          |
| View map                      | Android        | Yes          |
| Directions with coordinates   | Android        | Yes          |
