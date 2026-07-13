# Moovit Deeplinks

DeeplinkX supports Moovit's `moovit` URI scheme so Flutter apps can open nearby transit options or launch coordinate-based directions in the native Moovit app on iOS and Android.

## References

- Moovit deeplinking documentation: <https://moovit.com/developers/deeplinking/>
- Moovit App Store listing: <https://apps.apple.com/us/app/moovit-bus-transit-tracker/id498477945>

## Available Actions

### Launch Moovit

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(Moovit.open());
```

### View Map

```dart
await deeplinkX.launchAction(
  Moovit.view(
    coordinate: const Coordinate(latitude: 40.7128, longitude: -74.0060),
    partnerId: 'my_flutter_app',
  ),
);
```

### Directions With Coordinates

```dart
await deeplinkX.launchAction(
  Moovit.directionsWithCoords(
    origin: const Coordinate(latitude: 40.7580, longitude: -73.9855),
    originTitle: 'Times Square',
    destination: const Coordinate(latitude: 40.7527, longitude: -73.9772),
    destinationTitle: 'Grand Central',
  ),
);
```

Omit `origin` to let Moovit start from the user's current location.

## Platform Configuration

### iOS

Add the Moovit scheme to the `LSApplicationQueriesSchemes` array in `ios/Runner/Info.plist`:

```xml
<string>moovit</string>
```

### Android

Allow querying the package in `android/app/src/main/AndroidManifest.xml`:

```xml
<queries>
  <package android:name="com.tranzmate" />
</queries>
```

## URI Formats

- View map: `moovit://nearby?lat={latitude}&lon={longitude}&partner_id={partnerId}`
- Directions: `moovit://directions?dest_lat={destinationLatitude}&dest_lon={destinationLongitude}&dest_name={destinationTitle}&orig_lat={originLatitude}&orig_lon={originLongitude}&orig_name={originTitle}&partner_id={partnerId}`

`partnerId` is optional and defaults to `deeplink_x`. DeeplinkX emits Moovit's
documented `partner_id` on nearby and directions actions.

## Fallback Behavior

1. DeeplinkX opens the native app when installed.
2. If the app is missing and `fallbackToStore` is `true`, we redirect to the appropriate store listing.
3. Otherwise the action falls back to `https://www.moovit.com/`.
4. Set `disableFallback: true` when calling `launchAction` to skip both store and web fallbacks.

### Fallback Support Matrix

| Action                       | Store Fallback | Web Fallback |
| ---------------------------- | -------------- | ------------ |
| Open app                     | Yes            | Yes          |
| View map                     | Yes            | Yes          |
| Directions with coordinates  | Yes            | Yes          |
