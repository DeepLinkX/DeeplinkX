# Mapy.com Deeplinks

DeeplinkX supports Mapy.com (formerly Mapy.cz) URL actions for showing a point, searching, and planning a coordinate route. The documented HTTPS URLs open the mobile app when supported and otherwise remain usable as web fallbacks.

## References

- Official Mapy.com URL documentation: <https://developer.mapy.com/further-uses-of-mapycz/mapy-cz-url/>
- Official mobile-app invocation documentation: <https://developer.mapy.com/cs/dalsi-vyuziti-mapy-cz/volani-mobilni-aplikace-mapy-cz/>
- Google Play listing: <https://play.google.com/store/apps/details?id=cz.seznam.mapy>
- App Store listing: <https://apps.apple.com/us/app/mapy-com-offline-maps-gps/id411411020>

## Available Actions

### Launch Mapy.com

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(MapyCz.open());
```

### View Map

```dart
await deeplinkX.launchAction(
  MapyCz.view(
    coordinate: const Coordinate(latitude: 50.0755, longitude: 14.4378),
    zoom: 15,
    mapSet: MapyCzMapSet.outdoor,
  ),
);
```

The view action supports the `basic`, `outdoor`, `winter`, `aerial`, and `traffic` map sets. A marker is shown by default.

### Search

```dart
await deeplinkX.launchAction(
  MapyCz.search(
    query: 'coffee shop',
    center: const Coordinate(latitude: 50.0755, longitude: 14.4378),
    zoom: 14,
  ),
);
```

The center and zoom are optional.

### Directions With Coordinates

```dart
await deeplinkX.launchAction(
  MapyCz.directionsWithCoords(
    origin: const Coordinate(latitude: 50.0755, longitude: 14.4378),
    destination: const Coordinate(latitude: 50.0292, longitude: 14.3681),
    waypoints: const [
      Coordinate(latitude: 50.0335, longitude: 14.5087),
    ],
    routeType: MapyCzRouteType.carFastTraffic,
    mapSet: MapyCzMapSet.traffic,
    navigate: true,
  ),
);
```

The origin is optional, and Mapy.com accepts up to 15 waypoints. Route types cover fast, traffic-aware, and short driving; fast walking and hiking; and road or mountain cycling. `navigate: true` requests immediate navigation in app versions released from April 2024 onward.

## Platform Configuration

### iOS

Add the Mapy.com installation-check scheme to `LSApplicationQueriesSchemes` in `ios/Runner/Info.plist`:

```xml
<string>szn-mapy</string>
```

Actions themselves use the provider's HTTPS URLs. Mapy.com's mobile-app documentation notes that iOS callers cannot directly target only the native app, so launch behavior must be verified on a device.

### Android

Allow querying the package in `android/app/src/main/AndroidManifest.xml`:

```xml
<queries>
  <package android:name="cz.seznam.mapy" />
</queries>
```

DeeplinkX targets the HTTPS URL to `cz.seznam.mapy` through an Android `VIEW` intent.

## URL Formats

- View map: `https://mapy.com/fnc/v1/showmap?mapset={mapSet}&center={longitude},{latitude}&zoom={zoom}&marker={marker}`
- Search: `https://mapy.com/fnc/v1/search?mapset={mapSet}&query={query}`
- Route: `https://mapy.com/fnc/v1/route?mapset={mapSet}&start={longitude},{latitude}&end={longitude},{latitude}&routeType={routeType}`

## Fallback Behavior

1. DeeplinkX opens the native app when the platform accepts the URL for the installed app.
2. If the app is missing and `fallbackToStore` is `true`, DeeplinkX redirects to the appropriate store listing.
3. Otherwise the action falls back to the same Mapy.com HTTPS URL.
4. Set `disableFallback: true` when calling `launchAction` to skip both store and web fallbacks.

| Action                      | Store Fallback | Web Fallback |
| --------------------------- | -------------- | ------------ |
| Open app                    | ✔️             | ✔️ (website) |
| View map                    | ✔️             | ✔️           |
| Search                      | ✔️             | ✔️           |
| Directions with coordinates | ✔️             | ✔️           |
