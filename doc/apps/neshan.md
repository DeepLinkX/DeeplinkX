# Neshan Deeplinks

DeeplinkX supports Neshan's native iOS `neshan` URI scheme and Android package-targeted `https://nshn.ir` map links so Flutter apps can open map coordinates or launch coordinate-based directions in Neshan on iOS and Android.

## References

- Neshan App Store listing: <https://apps.apple.com/us/app/neshan-map/id1548188093>
- Neshan web map fallback: <https://neshan.org/maps>

## Available Actions

### Launch Neshan

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(Neshan.open());
```

### View Map

```dart
await deeplinkX.launchAction(
  Neshan.view(
    coordinate: const Coordinate(latitude: 35.6892, longitude: 51.3890),
  ),
);
```

### Directions With Coordinates

```dart
await deeplinkX.launchAction(
  Neshan.directionsWithCoords(
    origin: const Coordinate(latitude: 35.6892, longitude: 51.3890),
    destination: const Coordinate(latitude: 35.7000, longitude: 51.4000),
  ),
);
```

Omit `origin` to let Neshan start from the user's current location.

## Platform Configuration

### iOS

Add the Neshan scheme to the `LSApplicationQueriesSchemes` array in `ios/Runner/Info.plist`:

```xml
<string>neshan</string>
```

### Android

Allow querying the package in `android/app/src/main/AndroidManifest.xml`:

```xml
<queries>
  <package android:name="org.rajman.neshan.traffic.tehran.navigator" />
</queries>
```

## URI Formats

- iOS view map: `neshan://?destination={latitude},{longitude}`
- Android package-targeted view map: `https://nshn.ir?lat={latitude}&lng={longitude}`
- Web view fallback: `https://neshan.org/maps/share/{latitude},{longitude}`
- iOS directions: `neshan://?origin={originLatitude},{originLongitude}&destination={destinationLatitude},{destinationLongitude}`
- Android package-targeted directions: `https://nshn.ir/?origin={originLatitude},{originLongitude}&destination={destinationLatitude},{destinationLongitude}`
- Web directions fallback: `https://neshan.org/maps`

## Fallback Behavior

1. DeeplinkX opens the native app when installed.
2. If the app is missing and `fallbackToStore` is `true`, we redirect to the appropriate store listing.
3. Otherwise view actions use Neshan's canonical share URL and directions open
   the canonical web map.
4. Set `disableFallback: true` when calling `launchAction` to skip both store and web fallbacks.

The Android `nshn.ir` URI remains useful when package-targeted to the installed
app, but the live web redirect discards route query parameters. DeeplinkX
therefore does not reuse that short URL as a browser fallback.

### Fallback Support Matrix

| Action                       | Store Fallback | Web Fallback |
| ---------------------------- | -------------- | ------------ |
| Open app                     | Yes            | Yes          |
| View map                     | Yes            | Yes          |
| Directions with coordinates  | Yes            | Yes          |
