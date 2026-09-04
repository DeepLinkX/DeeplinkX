# TMAP Deeplinks

DeeplinkX supports TMAP's `tmap` URI scheme so Flutter apps can open map locations or launch coordinate-based directions in the native TMAP app on iOS and Android.

## References

- TMAP developer center: <https://tmapapi.tmapmobility.com/>
- Google Play listing: <https://play.google.com/store/apps/details?id=com.skt.tmap.ku>
- App Store listing: <https://apps.apple.com/us/app/id431589174>

## Available Actions

### Launch TMAP

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(TMap.open());
```

### View Map

```dart
await deeplinkX.launchAction(
  TMap.view(
    coordinate: const Coordinate(latitude: 37.5665, longitude: 126.9780),
    title: 'Seoul City Hall',
  ),
);
```

### Directions With Coordinates

```dart
await deeplinkX.launchAction(
  TMap.directionsWithCoords(
    origin: const Coordinate(latitude: 37.5665, longitude: 126.9780),
    originTitle: 'City Hall',
    destination: const Coordinate(latitude: 37.5547, longitude: 126.9706),
    destinationTitle: 'Seoul Station',
  ),
);
```

Omit `origin` to let TMAP start from the user's current location. `originTitle` is ignored unless `origin` is provided.

## Platform Configuration

### iOS

Add the TMAP scheme to the `LSApplicationQueriesSchemes` array in `ios/Runner/Info.plist`:

```xml
<string>tmap</string>
```

### Android

Allow querying the package in `android/app/src/main/AndroidManifest.xml`:

```xml
<queries>
  <package android:name="com.skt.tmap.ku" />
</queries>
```

## URI Formats

- View map: `tmap://viewmap?name={title}&x={longitude}&y={latitude}`
- Directions: `tmap://route?startname={originTitle}&startx={originLongitude}&starty={originLatitude}&goalname={destinationTitle}&goaly={destinationLatitude}&goalx={destinationLongitude}&carType=1`

## Fallback Behavior

1. DeeplinkX opens the native app when installed.
2. If the app is missing and `fallbackToStore` is `true`, we redirect to the appropriate store listing.
3. Otherwise the action falls back to `https://www.tmap.co.kr/`.
4. Set `disableFallback: true` when calling `launchAction` to skip both store and web fallbacks.

### Fallback Support Matrix

| Action                       | Store Fallback | Web Fallback |
| ---------------------------- | -------------- | ------------ |
| Open app                     | ✔️              | ✔️ (website) |
| View map                     | ✔️              | ✔️           |
| Directions with coordinates  | ✔️              | ✔️           |
