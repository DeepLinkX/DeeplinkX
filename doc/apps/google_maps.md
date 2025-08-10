# Google Maps Deeplinks

DeeplinkX provides support for Google Maps deep linking actions on iOS and Android.

## References

- [Android Intents](https://developer.android.com/guide/components/google-maps-intents)
- [iOS URL Scheme](https://developers.google.com/maps/documentation/urls/ios-urlscheme)

## Available Actions

### Launch Google Maps App
```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(GoogleMaps.open());
```

### View Coordinates Action
```dart
await deeplinkX.launchAction(
  GoogleMaps.view(
    coordinate: const Coordinate(latitude: 37.4220, longitude: -122.0841),
    zoom: 14,
  ),
);
```

### Search Location Action
```dart
await deeplinkX.launchAction(
  GoogleMaps.search(query: 'Central Park, New York'),
);
```

### Directions Action
```dart
await deeplinkX.launchAction(
  GoogleMaps.directions(
    origin: 'Times Square, New York',
    destination: 'Statue of Liberty',
    mode: GoogleMapsTravelMode.transit,
  ),
);
```

### Directions with Coordinates Action
```dart
await deeplinkX.launchAction(
  GoogleMaps.directionsWithCoords(
    origin: const Coordinate(latitude: 40.7580, longitude: -73.9855),
    destination: const Coordinate(latitude: 40.6892, longitude: -74.0445),
    mode: GoogleMapsTravelMode.walking,
  ),
);
```

## Platform Configuration

### iOS
Add the following to your `ios/Runner/Info.plist` inside the `LSApplicationQueriesSchemes` array:
```xml
<string>comgooglemaps</string>
```

### Android
Add the following to your `android/app/src/main/AndroidManifest.xml` inside the `<queries>` tag:
```xml
<package android:name="com.google.android.apps.maps" />
```

## URL Schemes

### Native App Deep Links
- View coordinates: `comgooglemaps://?center={lat},{lng}&zoom={zoom}`
- Search: `comgooglemaps://?q={query}`
- Directions: `comgooglemaps://?saddr={origin}&daddr={destination}&directionsmode={mode}`
- Directions with coordinates: `comgooglemaps://?saddr={origin_lat},{origin_lng}&daddr={dest_lat},{dest_lng}&directionsmode={mode}`

### Android Intent URIs
- View coordinates: `geo:{lat},{lng}?z={zoom}`
- Search: `geo:0,0?q={query}`
- Directions: `https://www.google.com/maps/dir/?api=1&destination={destination}&origin={origin}&travelmode={mode}`
- Directions with coordinates: `https://www.google.com/maps/dir/?api=1&destination={dest_lat},{dest_lng}&origin={origin_lat},{origin_lng}&travelmode={mode}`

### Web Fallback URLs
- View coordinates: `https://www.google.com/maps/@{lat},{lng},{zoom}z`
- Search: `https://www.google.com/maps/@?api=1&query={query}`
- Directions: `https://maps.google.com/maps/dir/?destination={destination}&origin={origin}&travelmode={mode}`
- Directions with coordinates: `https://maps.google.com/maps/dir/?origin={origin_lat},{origin_lng}&destination={dest_lat},{dest_lng}&travelmode={mode}`

## Supported Fallback Stores
When the Google Maps app is not installed, DeeplinkX can redirect users to download Google Maps from:

- iOS App Store
- Google Play Store

Enable fallback with the `fallbackToStore` parameter when launching actions or apps.

## Fallback Behavior

1. Attempt to launch the Google Maps app if installed.
2. If not installed and `fallbackToStore` is `true`, redirect to the appropriate app store.
3. If the store cannot be opened, fall back to opening the Google Maps website.
4. Disable all fallbacks by setting `disableFallback: true`.

## Fallback Support for Actions

| Action                     | Store Fallback | Web Fallback |
| -------------------------- | -------------- | ------------ |
| Open app                   | ✔️ | ✔️ |
| View map                   | ✔️ | ✔️ |
| Search                     | ✔️ | ✔️ |
| Directions                 | ✔️ | ✔️ |
| Directions with coordinates| ✔️ | ✔️ |
