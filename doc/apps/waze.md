# Waze Deeplinks

DeeplinkX provides support for Waze universal deep links on iOS and Android.

## References

- Waze Deep Links: <https://developers.google.com/waze/deeplinks>

## Available Actions

### Launch Waze App

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(Waze.open());
```

### View Map

```dart
await deeplinkX.launchAction(
  Waze.view(
    coordinate: const Coordinate(latitude: 45.6906304, longitude: -120.810983),
  ),
);
```

### Search (no web fallback)

```dart
await deeplinkX.launchAction(
  Waze.search(query: '66 Acacia Avenue'),
);
```

### Directions (destination by text)

```dart
await deeplinkX.launchAction(
  Waze.directions(
    destination: '66 Acacia Avenue',
    zoom: 8, // optional
  ),
);
```

### Directions (destination by coordinates)

```dart
await deeplinkX.launchAction(
  Waze.directionsWithCoords(
    destination: const Coordinate(latitude: 45.6906304, longitude: -120.810983),
    zoom: 8, // optional
  ),
);
```

## Platform Configuration

### iOS

Add the following to your `ios/Runner/Info.plist` inside `LSApplicationQueriesSchemes`:

```xml
<string>waze</string>
```

### Android

Add the following package to `<queries>` in `android/app/src/main/AndroidManifest.xml`:

```xml
<package android:name="com.waze" />
```

## Universal Link Formats

- View map: `https://waze.com/ul?ll={lat},{lng}`
- Search: `https://waze.com/ul?q={query}`
- Directions: `https://waze.com/ul?q={destination}&navigate=yes&z={zoom?}`
- Directions with coordinates: `https://waze.com/ul?ll={lat},{lng}&navigate=yes&z={zoom?}`

## Fallback Behavior

1. If Waze is installed, links open Waze directly.
2. If not installed and `fallbackToStore` is `true`, DeeplinkX redirects to the appropriate app store.
3. If the store cannot be opened or `fallbackToStore` is `false`, actions that implement `Fallbackable` fall back to their universal link.
4. Disable all fallbacks by setting `disableFallback: true` when calling `launchAction`.

### Fallback Support Matrix

| Action                     | Store Fallback | Web Fallback |
| -------------------------- | -------------- | ------------ |
| Open app                   | ✔️              | ✔️ (website) |
| View map                   | ✔️              | ✔️           |
| Search                     | ✔️              | ❌           |
| Directions                 | ✔️              | ✔️           |
| Directions with coordinates| ✔️              | ✔️           |
