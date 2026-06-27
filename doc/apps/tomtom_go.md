# TomTom Go Deeplinks

DeeplinkX supports TomTom Go on iOS and Android for opening the app, showing a coordinate, and starting coordinate navigation.

## References

- Map Launcher marker implementation: <https://github.com/mattermoran/map_launcher/blob/master/lib/src/marker_url.dart>
- Map Launcher directions implementation: <https://github.com/mattermoran/map_launcher/blob/master/lib/src/directions_url.dart>
- Map Launcher platform app metadata: <https://github.com/mattermoran/map_launcher>

## Available Actions

### Launch TomTom Go

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(TomTomGo.open());
```

### View Map

TomTom Go on iOS exposes its coordinate navigation endpoint, so the iOS link opens the coordinate through navigation. Android uses the provider-supported `geo:` intent.

```dart
await deeplinkX.launchAction(
  TomTomGo.view(
    coordinate: const Coordinate(latitude: 52.5163, longitude: 13.3777),
    title: 'Brandenburg Gate',
  ),
);
```

### Directions With Coordinates

```dart
await deeplinkX.launchAction(
  TomTomGo.directionsWithCoords(
    destination: const Coordinate(latitude: 52.5163, longitude: 13.3777),
  ),
);
```

TomTom Go route links are coordinate based, so DeeplinkX does not expose a text-only `directions` action for this app.

## Platform Configuration

### iOS

Add the TomTom Go scheme to the `LSApplicationQueriesSchemes` array in `ios/Runner/Info.plist`:

```xml
<string>tomtomgo</string>
```

### Android

Allow querying the package in `android/app/src/main/AndroidManifest.xml`:

```xml
<queries>
  <package android:name="com.tomtom.gplay.navapp" />
</queries>
```

## URI Formats

- iOS view and directions: `tomtomgo://x-callback-url/navigate?destination={latitude},{longitude}`
- Android view intent data: `geo:{latitude},{longitude}?q={latitude},{longitude}({title})`
- Android directions intent data: `google.navigation:q={latitude},{longitude}`

## Fallback Behavior

1. DeeplinkX opens the native app when installed.
2. If the app is missing and `fallbackToStore` is `true`, we redirect to the appropriate store listing.
3. Otherwise each action falls back to the TomTom Go website.
4. Set `disableFallback: true` when calling `launchAction` to skip both store and web fallbacks.

### Fallback Support Matrix

| Action                        | Store Fallback | Web Fallback |
| ----------------------------- | -------------- | ------------ |
| Open app                      | Yes            | Yes          |
| View map                      | Yes            | Yes          |
| Directions with coordinates   | Yes            | Yes          |
