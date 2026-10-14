# Citymapper Deeplinks

DeeplinkX supports the Citymapper custom URI scheme on iOS and Android for opening the app and building route requests.

## First-party References

- [Citymapper directions-link guide](https://citymapper.com/news/2386/launch-citymapper-for-directions)
- [Citymapper native/web links and arrival-time documentation](https://citymapper.com/news/895/launching-citymapper-from-apps-and-from-the-web)
- [Google Play listing](https://play.google.com/store/apps/details?id=com.citymapper.app.release)
- [Apple App Store listing](https://apps.apple.com/us/app/citymapper-all-live-transit/id469463298)

Checked on **2026-10-14**. Implementation evidence is limited to Citymapper's published URL contract and store identity. No physical-device validation was performed. Tests verify generated URLs, intent options, and fallback configuration—not native handling, app-opening behavior, route availability, or arrival-time behavior in a particular app version. Device results remain the runtime authority.

## Available Actions

### Launch Citymapper

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(Citymapper.open());
```

### View Map

The verified Citymapper contract describes directions rather than a marker-only map. `Citymapper.view` implements the shared `MapViewAction` interface by opening directions to the coordinate from the user's current location. It does not promise a standalone marker view.

```dart
await deeplinkX.launchAction(
  Citymapper.view(
    coordinate: const Coordinate(latitude: 51.503399, longitude: -0.119519),
    title: 'London Eye',
  ),
);
```

### Directions With Coordinates

```dart
await deeplinkX.launchAction(
  Citymapper.directionsWithCoords(
    origin: const Coordinate(latitude: 51.500729, longitude: -0.124625),
    destination: const Coordinate(latitude: 51.503399, longitude: -0.119519),
    originTitle: 'Westminster',
    destinationTitle: 'London Eye',
    arriveBy: DateTime.utc(2026, 12, 2, 15, 30),
  ),
);
```

Citymapper route URLs are coordinate based, so DeeplinkX does not expose a text-only `directions` action for this app.

Omit `origin` to request directions from the current location. Without an origin, `originTitle` and `originAddress` are ignored and all `start*` parameters are omitted. Destination titles and addresses are optional display information, not substitutes for coordinates.

`arriveBy` is optional. DeeplinkX serializes it as UTC ISO-8601 with a `Z` suffix while preserving the instant. A local `DateTime` is interpreted in the caller device's local time zone—not inferred from the destination; use `DateTime.utc` or an offset-aware parsed value to specify an unambiguous instant. Both native and web links receive the same parameters. No travel-mode selector is exposed.

## Platform Configuration

### iOS

Add the Citymapper scheme to the `LSApplicationQueriesSchemes` array in `ios/Runner/Info.plist`:

```xml
<string>citymapper</string>
```

### Android

Allow querying the package in `android/app/src/main/AndroidManifest.xml`:

```xml
<queries>
  <package android:name="com.citymapper.app.release" />
</queries>
```

Navigation intents use `action_view`, package `com.citymapper.app.release`, and `FLAG_ACTIVITY_NEW_TASK` (`0x10000000`). The existing platform adapter may retry without package targeting when resolution fails; this provider does not change that adapter or guarantee strict targeting in every failure case.

## URI Formats

- Directions destination: `citymapper://directions?endcoord={latitude},{longitude}&endname={title?}`
- Directions with origin: `citymapper://directions?startcoord={originLatitude},{originLongitude}&startname={originTitle?}&startaddress={originAddress?}&endcoord={destinationLatitude},{destinationLongitude}&endname={destinationTitle?}&endaddress={destinationAddress?}&arriveby={utcIso8601?}`
- Web fallback: `https://citymapper.com/directions?...`

Optional parameters are omitted when `null`; supplied strings are URL-encoded using Dart's URI query construction. Empty strings remain supplied values.

## Fallback Behavior

1. DeeplinkX opens the native app when installed.
2. If the app is missing and `fallbackToStore` is `true`, we redirect to the appropriate store listing.
3. Otherwise the action falls back to `https://citymapper.com/directions` with the same route parameters.
4. Set `disableFallback: true` when calling `launchAction` to skip both store and web fallbacks.

### Fallback Support Matrix

| Action                       | Store Fallback | Web Fallback |
| ---------------------------- | -------------- | ------------ |
| Open app                     | ✔️              | ✔️ (website) |
| View map                     | ✔️              | ✔️           |
| Directions with coordinates  | ✔️              | ✔️           |
