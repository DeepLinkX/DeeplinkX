# Sygic Truck Deeplinks

DeeplinkX exposes Sygic Truck & RV Navigation actions for opening the app, showing a coordinate, and starting coordinate navigation. Native behavior still requires device validation; see the limitations below before shipping this integration.

## References

- [Official Google Play listing](https://play.google.com/store/apps/details?id=com.sygic.truck): Android package `com.sygic.truck`.
- [Official App Store listing](https://apps.apple.com/us/app/sygic-truck-rv-navigation/id992127700): iOS store ID `992127700`.
- [Sygic Android SDK reference](https://developers.sygic.com/reference/java3d/html/classcom_1_1sygic_1_1sdk_1_1remoteapi_1_1_api.html): identifies the consumer Truck package separately from regular Sygic; this does not establish the URL contract.

Sources checked on 2026-09-15. The legacy Sygic custom-URL documentation returned HTTP 403 and could not be verified. Store listings establish app identity, not supported URL actions.

## Validation Status

The URI formats below describe the current implementation, not a device-verified provider contract. No physical-device checks have been performed for this integration.

- Android intents explicitly target `com.sygic.truck`, but the installed app's acceptance of the `show` and `drive` URI commands needs validation.
- iOS uses `com.sygic.aura`, also used by regular Sygic. Scheme availability cannot distinguish the two apps, and Truck-specific launching is not guaranteed. Verify with only Truck installed, only regular Sygic installed, and both installed before relying on detection or launch results.
- Confirm coordinate order and encoding, map display, navigation, and missing-app fallbacks on supported device versions. Unit tests verify serialization and dispatch configuration only.
- Truck dimensions, restrictions, and route preferences remain configured in Sygic Truck; these actions do not set them.

## Available Actions

### Launch Sygic Truck

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(SygicTruck.open());
```

### View Map

```dart
await deeplinkX.launchAction(
  SygicTruck.view(
    coordinate: const Coordinate(latitude: 48.1486, longitude: 17.1077),
  ),
);
```

### Directions With Coordinates

```dart
await deeplinkX.launchAction(
  SygicTruck.directionsWithCoords(
    destination: const Coordinate(latitude: 48.1486, longitude: 17.1077),
  ),
);
```

Sygic Truck route links are coordinate based, so DeeplinkX does not expose a text-only `directions` action for this app.

## Platform Configuration

### iOS

The proposed iOS integration queries the following shared scheme in `LSApplicationQueriesSchemes` in `ios/Runner/Info.plist`. Add it only once if regular Sygic is also configured; the validation limitation above still applies:

```xml
<string>com.sygic.aura</string>
```

### Android

Allow querying the package in `android/app/src/main/AndroidManifest.xml`:

```xml
<queries>
  <package android:name="com.sygic.truck" />
</queries>
```

## URI Formats

- View: `com.sygic.aura://coordinate|{longitude}|{latitude}|show`
- Directions with coordinates: `com.sygic.aura://coordinate|{longitude}|{latitude}|drive`

## Fallback Behavior

1. DeeplinkX attempts a native launch when availability checks succeed, subject to the shared iOS scheme limitation above.
2. If the app is missing and `fallbackToStore` is `true`, we redirect to the appropriate store listing.
3. Otherwise each action falls back to the Sygic Truck website.
4. Set `disableFallback: true` when calling `launchAction` to skip both store and web fallbacks.

Store and website fallbacks do not preserve the requested coordinates or start a route.

### Fallback Support Matrix

| Action                        | Store Fallback | Web Fallback |
| ----------------------------- | -------------- | ------------ |
| Open app                      | Yes            | Yes          |
| View map                      | Yes            | Yes          |
| Directions with coordinates   | Yes            | Yes          |
