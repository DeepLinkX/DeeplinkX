# KakaoMap Deeplinks

DeeplinkX supports KakaoMap's `kakaomap` URI scheme so Flutter apps can open map locations or launch coordinate-based directions in the native KakaoMap app on iOS and Android.

## References

- Map Launcher open-source implementation of the same URI scheme: <https://github.com/mattermoran/map_launcher/blob/master/lib/src/marker_url.dart>
- KakaoMap App Store listing: <https://apps.apple.com/us/app/kakaomap-korea-no-1-map/id304608425>

## Available Actions

### Launch KakaoMap

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(KakaoMap.open());
```

### View Map

```dart
await deeplinkX.launchAction(
  KakaoMap.view(
    coordinate: const Coordinate(latitude: 37.5665, longitude: 126.9780),
  ),
);
```

### Directions With Coordinates

```dart
await deeplinkX.launchAction(
  KakaoMap.directionsWithCoords(
    origin: const Coordinate(latitude: 37.5665, longitude: 126.9780),
    destination: const Coordinate(latitude: 37.5547, longitude: 126.9706),
  ),
);
```

Omit `origin` to let KakaoMap start from the user's current location.

## Platform Configuration

### iOS

Add the KakaoMap scheme to the `LSApplicationQueriesSchemes` array in `ios/Runner/Info.plist`:

```xml
<string>kakaomap</string>
```

### Android

Allow querying the package in `android/app/src/main/AndroidManifest.xml`:

```xml
<queries>
  <package android:name="net.daum.android.map" />
</queries>
```

## URI Formats

- View map: `kakaomap://look?p={latitude},{longitude}`
- Directions: `kakaomap://route?sp={originLatitude},{originLongitude}&ep={destinationLatitude},{destinationLongitude}`

## Fallback Behavior

1. DeeplinkX opens the native app when installed.
2. If the app is missing and `fallbackToStore` is `true`, we redirect to the appropriate store listing.
3. Otherwise the action falls back to `https://map.kakao.com/`.
4. Set `disableFallback: true` when calling `launchAction` to skip both store and web fallbacks.

### Fallback Support Matrix

| Action                       | Store Fallback | Web Fallback |
| ---------------------------- | -------------- | ------------ |
| Open app                     | ✔️              | ✔️ (website) |
| View map                     | ✔️              | ✔️           |
| Directions with coordinates  | ✔️              | ✔️           |
