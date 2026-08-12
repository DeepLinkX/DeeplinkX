# CoPilot Deeplinks

DeeplinkX supports CoPilot GPS Navigation on iOS and Android for opening the app, showing a coordinate, and starting coordinate navigation. Trimble's URL launch guide says URL launch is supported only by its Truck-licensed application; availability and features depend on the installed CoPilot license.

## References

- [Trimble CoPilot URL launch documentation](https://developer.trimblemaps.com/copilot-navigation/feature-guide/advanced-features/url-launch/): URI format, supported platforms, `VIEW` and `GOTO` actions, coordinate parameters, and Truck-license limitation.
- [Official Google Play listing](https://play.google.com/store/apps/details?id=com.alk.copilot.mapviewer): Android package `com.alk.copilot.mapviewer`.
- [Official App Store listing](https://apps.apple.com/us/app/copilot-gps-navigation/id504677517): iOS store ID `504677517`.

Sources checked on 2026-09-27. Store listings establish the app identity and store identifiers, not device-specific URL handling. No physical-device test has been performed.

## Available Actions

### Launch CoPilot

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(Copilot.open());
```

### View Map

```dart
await deeplinkX.launchAction(
  Copilot.view(
    coordinate: const Coordinate(latitude: 52.5163, longitude: 13.3777),
    title: 'Fleet Yard',
  ),
);
```

### Directions With Coordinates

```dart
await deeplinkX.launchAction(
  Copilot.directionsWithCoords(
    destination: const Coordinate(latitude: 52.5163, longitude: 13.3777),
    destinationTitle: 'Warehouse',
  ),
);
```

CoPilot route links are coordinate based, so DeeplinkX does not expose a text-only `directions` action for this app.

## Platform Configuration

### iOS

Add the CoPilot scheme to the `LSApplicationQueriesSchemes` array in `ios/Runner/Info.plist`:

```xml
<string>copilot</string>
```

### Android

Allow querying the package in `android/app/src/main/AndroidManifest.xml`:

```xml
<queries>
  <package android:name="com.alk.copilot.mapviewer" />
</queries>
```

## URI Formats

- View: `copilot://mydestination?type=LOCATION&action=VIEW&lat={latitude}&long={longitude}&name={title}`
- Directions with coordinates: `copilot://mydestination?type=LOCATION&action=GOTO&name={destinationTitle}&lat={latitude}&long={longitude}`

## Fallback Behavior

1. DeeplinkX opens the native app when installed.
2. If the app is missing and `fallbackToStore` is `true`, we redirect to the appropriate store listing.
3. Otherwise each action falls back to the CoPilot website.
4. Set `disableFallback: true` when calling `launchAction` to skip both store and web fallbacks.

### Fallback Support Matrix

| Action                        | Store Fallback | Web Fallback |
| ----------------------------- | -------------- | ------------ |
| Open app                      | Yes            | Yes          |
| View map                      | Yes            | Yes          |
| Directions with coordinates   | Yes            | Yes          |
