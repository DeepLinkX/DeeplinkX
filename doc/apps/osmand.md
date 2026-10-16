# OsmAnd Deeplinks

DeeplinkX exposes OsmAnd app opening, map viewing, and coordinate directions using package-targeted Android intents and HTTPS map links for iOS.

## First-party References

- [OsmAnd intents documentation](https://osmand.net/docs/technical/algorithms/osmand-intents/)
- [OsmAnd web-map links](https://osmand.net/docs/user/web/web-map/)
- [OsmAnd web navigation](https://osmand.net/docs/user/web/web-navigation/)
- [Google Play listing](https://play.google.com/store/apps/details?id=net.osmand)
- [Apple App Store listing](https://apps.apple.com/us/app/osmand-maps-travel-navigate/id934850257)
- [Android intent registration](https://github.com/osmandapp/OsmAnd/blob/a8af06ba9650f49bb88b10da47485c5a0dcca8aa/OsmAnd/AndroidManifest.xml) and [intent handling](https://github.com/osmandapp/OsmAnd/blob/a8af06ba9650f49bb88b10da47485c5a0dcca8aa/OsmAnd/src/net/osmand/plus/helpers/IntentHelper.java)
- [iOS link parsing](https://github.com/osmandapp/OsmAnd-iOS/blob/bf08acc980b8086e015ce07816f934b302f5273e/Sources/Helpers/DeepLinkManager/DeepLinkParser.swift), [URL recognition](https://github.com/osmandapp/OsmAnd-iOS/blob/bf08acc980b8086e015ce07816f934b302f5273e/Sources/Helpers/OAUtilities.m), and [scheme registration](https://github.com/osmandapp/OsmAnd-iOS/blob/bf08acc980b8086e015ce07816f934b302f5273e/Resources/OsmAnd-Info.plist)

Checked on **2026-10-14**. The public documentation confirms HTTPS map links; the pinned first-party source snapshots corroborate legacy Android intent handling and current iOS route parameters. Source snapshots are not proof of support in every released app version. No physical-device validation was performed; tests establish serialization and configuration only. Device results remain the runtime authority.

## Available Actions

### Launch OsmAnd

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(OsmAnd.open());
```

### View Map

```dart
await deeplinkX.launchAction(
  OsmAnd.view(
    coordinate: const Coordinate(latitude: 52.516275, longitude: 13.377704),
    zoom: 12,
  ),
);
```

### Directions With Coordinates

```dart
await deeplinkX.launchAction(
  OsmAnd.directionsWithCoords(
    destination: const Coordinate(latitude: 52.516275, longitude: 13.377704),
  ),
);
```

The native request uses the destination and leaves the start point to OsmAnd's current-location/default handling. DeeplinkX does not expose an origin, travel mode, waypoints, or text-only `directions` action for this integration, even though OsmAnd itself supports additional capabilities. The browser fallback preselects the destination; the user may need to select a start point before a route can be calculated.

## Platform Configuration

### iOS

Add the OsmAnd scheme to the `LSApplicationQueriesSchemes` array in `ios/Runner/Info.plist`:

```xml
<string>osmandmaps</string>
```

This legacy scheme is retained only for installation detection and `open()`. Its bare-scheme opening and registration in installed versions remain device-unverified. If detection fails, the unchanged core may choose store/web fallback despite the app being installed; disabling fallback can then return `false`.

Navigation actions send HTTPS links. The current iOS parser uses `end` for the destination; published web links use `finish`, so the native route request supplies both with the same coordinate. It omits start/profile/waypoint parameters. Native interception depends on operating-system settings and the installed app version; it is not guaranteed. Unsupported web parameters may be ignored, with `finish` retaining the browser destination.

### Android

Allow querying the package in `android/app/src/main/AndroidManifest.xml`:

```xml
<queries>
  <package android:name="net.osmand" />
</queries>
```

This provider targets the free Android app `net.osmand`, not the separate OsmAnd+ package `net.osmand.plus`. Both actions specify `action_view` and `FLAG_ACTIVITY_NEW_TASK` (`0x10000000`). The unchanged platform adapter may retry without package targeting if resolution fails; this integration does not promise strict targeting in every failure case.

## URI Formats

- iOS view map and view fallback: `https://osmand.net/map/?pin={latitude},{longitude}#{zoom}/{latitude}/{longitude}`
- Android view map intent data: `https://osmand.net/go?lat={latitude}&lon={longitude}&z={zoom}`
- iOS directions with coordinates: `https://osmand.net/map/?end={latitude},{longitude}&finish={latitude},{longitude}#15/{latitude}/{longitude}`
- Android directions intent data: `osmand.navigation:q={latitude},{longitude}`
- Directions web fallback: `https://osmand.net/map/?finish={latitude},{longitude}#15/{latitude}/{longitude}`

The default view zoom is 15. Coordinates and query values are serialized with Dart's URI builder; zoom handling remains the receiving client's responsibility.

## Fallback Behavior

1. After installation detection succeeds, Android actions attempt the package-targeted intent; iOS actions request the HTTPS link and rely on native interception or browser handling.
2. If the app is missing and `fallbackToStore` is `true`, we redirect to the appropriate store listing.
3. Otherwise the action falls back to `https://osmand.net/map/` with the same coordinate.
4. Set `disableFallback: true` when calling `launchAction` to skip both store and web fallbacks.

### Fallback Support Matrix

| Action                       | Store Fallback | Web Fallback |
| ---------------------------- | -------------- | ------------ |
| Open app                     | ✔️              | ✔️ (website) |
| View map                     | ✔️              | ✔️           |
| Directions with coordinates  | ✔️              | ✔️           |
