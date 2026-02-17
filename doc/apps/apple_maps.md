# Apple Maps Deeplinks

DeeplinkX provides support for Apple Maps deep linking actions on iOS and macOS devices.

## References

- [Apple Maps URL Schemes](https://developer.apple.com/library/archive/featuredarticles/iPhoneURLScheme_Reference/MapLinks/MapLinks.html)

## Available Actions

### Launch Apple Maps App

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(AppleMaps.open());
```

### View Map Action

```dart
await deeplinkX.launchAction(
  AppleMaps.view(
    coordinate: const Coordinate(latitude: 40.7812, longitude: -73.9665),
    zoom: 12.5,
  ),
);
```

### Search Location Action

```dart
await deeplinkX.launchAction(
  AppleMaps.search(query: 'Central Park, New York'),
);
```

### Directions Action

```dart
await deeplinkX.launchAction(
  AppleMaps.directions(
    origin: 'Central Park, New York',
    destination: 'Statue of Liberty',
    mode: AppleMapsTransportType.transit,
  ),
);
```

### Directions with Coordinates Action

```dart
await deeplinkX.launchAction(
  AppleMaps.directionsWithCoords(
    origin: const Coordinate(latitude: 40.7812, longitude: -73.9665),
    destination: const Coordinate(latitude: 40.6892, longitude: -74.0445),
    mode: AppleMapsTransportType.walking,
  ),
);
```

## Platform Configuration

### iOS

Add the following to your `ios/Runner/Info.plist` inside the `LSApplicationQueriesSchemes` array:

```xml
<string>maps</string>
```

### macOS

Add the same scheme entry to your `macos/Runner/Info.plist` inside the `LSApplicationQueriesSchemes` array:

```xml
<string>maps</string>
```

> Apple Maps deeplinks are available on iOS and macOS. Android is not supported.

## URL Schemes

### Native App Deep Links

- View map: `maps://?ll={lat},{lng}&z={zoom}`
- Search: `maps://?q={query}`
- Directions: `maps://?saddr={origin}&daddr={destination}&dirflg={mode}`
- Directions with coordinates: `maps://?saddr={origin_lat},{origin_lng}&daddr={dest_lat},{dest_lng}&dirflg={mode}`

### Web Fallback URLs

- View map: `https://maps.apple.com/?ll={lat},{lng}&z={zoom}`
- Search: `https://maps.apple.com/?q={query}`
- Directions: `https://maps.apple.com/?saddr={origin}&daddr={destination}&dirflg={mode}`
- Directions with coordinates: `https://maps.apple.com/?saddr={origin_lat},{origin_lng}&daddr={dest_lat},{dest_lng}&dirflg={mode}`

`dirflg` accepts:

- `d` – Driving
- `w` – Walking
- `r` – Transit

## Supported Fallback Stores

When the Apple Maps app is not installed (removed from the device), DeeplinkX can redirect users to download it from:

- iOS App Store

Enable fallback with the `fallbackToStore` parameter when launching actions or apps.

## Fallback Behavior

1. Attempt to launch the Apple Maps app if installed.
2. If not installed and `fallbackToStore` is `true`, redirect to the iOS App Store listing.
3. If the store cannot be opened, fall back to opening the Apple Maps website.
4. Disable all fallbacks by setting `disableFallback: true`.

## Fallback Support for Actions

| Action                     | Store Fallback | Web Fallback |
| -------------------------- | -------------- | ------------ |
| Open app                   | ✔️ | ✔️ |
| View map                   | ✔️ | ✔️ |
| Search                     | ✔️ | ✔️ |
| Directions                 | ✔️ | ✔️ |
| Directions with coordinates| ✔️ | ✔️ |
