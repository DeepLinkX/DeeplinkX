# TomTom Go Fleet Deeplinks

DeeplinkX supports TomTom GO Fleet Android intents for opening the app, showing a coordinate, and starting coordinate navigation. TomTom GO Fleet is a commercial fleet product; the official listing describes access through partner fleet-management licenses.

## References

- [TomTom GO Fleet integration documentation](https://media.webfleet.com/fl_attachment/media/doc/documentations/pro-x-driver-terminal-developer-documentation.pdf): Android navigation intents, coordinate formats, and application package identifier (section 3.2, pages 6–7; package table page 27).
- [Official Google Play listing](https://play.google.com/store/apps/details?id=com.tomtom.gplay.navapp.gofleet): app identity and package `com.tomtom.gplay.navapp.gofleet`.

The example uses the official app icon from this Google Play listing.

Sources checked on 2026-10-02. The integration guide describes Android intents; no iOS integration contract or App Store listing was found. No physical-device test has been performed.

## Available Actions

### Launch TomTom Go Fleet

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(TomTomGoFleet.open());
```

### View Map

```dart
await deeplinkX.launchAction(
  TomTomGoFleet.view(
    coordinate: const Coordinate(latitude: 52.5163, longitude: 13.3777),
  ),
);
```

### Directions With Coordinates

```dart
await deeplinkX.launchAction(
  TomTomGoFleet.directionsWithCoords(
    destination: const Coordinate(latitude: 52.5163, longitude: 13.3777),
  ),
);
```

TomTom GO Fleet route links are coordinate based, so DeeplinkX does not expose a text-only `directions` action for this app. TomTom’s guide says to use the Android platform navigation intents and notes that the `google.navigation` URI is supported by GO Fleet.

## Platform Configuration

### Android

Allow querying the package in `android/app/src/main/AndroidManifest.xml`:

```xml
<queries>
  <package android:name="com.tomtom.gplay.navapp.gofleet" />
</queries>
```

## URI Formats

- View: `geo:{latitude},{longitude}`
- Directions with coordinates: `google.navigation:q={latitude},{longitude}`

The documented location intent accepts a coordinate only; this integration does not attach a label. Both actions send `ACTION_VIEW` intents with `package: com.tomtom.gplay.navapp.gofleet`. The shared `geo` and `google.navigation` URIs are intent data only: `appLink` is `null`, so DeeplinkX does not retry them as unqualified URLs.

The existing Android adapter delegates to `android_intent_plus`, which can clear the package and retry implicitly when the target intent cannot resolve. This integration leaves that adapter behavior unchanged; strict target isolation in that failure case is not guaranteed.

## Fallback Behavior

1. DeeplinkX targets the TomTom GO Fleet Android package when installed.
2. If the app is missing or its intent fails and `fallbackToStore` is `true`, it redirects to the Google Play listing.
3. Otherwise each action falls back to the TomTom fleet website.
4. Set `disableFallback: true` when calling `launchAction` to skip both store and web fallbacks.

### Fallback Support Matrix

| Action                        | Store Fallback | Web Fallback |
| ----------------------------- | -------------- | ------------ |
| Open app                      | Android        | Yes          |
| View map                      | Android        | Yes          |
| Directions with coordinates   | Android        | Yes          |
