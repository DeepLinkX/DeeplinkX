# HERE WeGo Deeplinks

DeeplinkX supports HERE WeGo on iOS and Android through HERE share links for showing locations and planning coordinate routes.

## First-party References

- [HERE Deeplinking API introduction](https://docs.here.com/wego-pro/docs/readme-here-deeplinking-api-developer-guide-dl)
- [HERE URL format and mobile examples](https://docs.here.com/wego-pro/docs/request-format-dl)
- [HERE location sharing](https://docs.here.com/wego-pro/docs/share-location-dl)
- [HERE route sharing](https://docs.here.com/wego-pro/docs/share-route-dl)
- [Google Play listing](https://play.google.com/store/apps/details?id=com.here.app.maps)
- [Apple App Store listing](https://apps.apple.com/us/app/here-wego-maps-navigation/id955837609)

Checked on **2026-10-11**. Although hosted under WeGo Pro, the general HERE Deeplinking API introduction explicitly covers the HERE WeGo mobile app and desktop web. This provider uses only the general location and route contract, not Pro activation, truck settings, or extra waypoint APIs.

No physical-device validation was performed. Tests verify generated links, metadata, and fallback configuration, not native app handling. Device results remain the runtime authority.

## Available Actions

### Launch HERE WeGo

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(HereWeGo.open());
```

### View Map

```dart
await deeplinkX.launchAction(
  HereWeGo.view(
    coordinate: const Coordinate(latitude: 52.5163, longitude: 13.3777),
    title: 'Brandenburg Gate',
    zoom: 15,
  ),
);
```

### Directions With Coordinates

```dart
await deeplinkX.launchAction(
  HereWeGo.directionsWithCoords(
    origin: const Coordinate(latitude: 52.5308, longitude: 13.3847),
    originTitle: 'Berlin Central Station',
    destination: const Coordinate(latitude: 52.5163, longitude: 13.3777),
    destinationTitle: 'Brandenburg Gate',
    mode: HereWeGoTravelMode.transit,
  ),
);
```

HERE share route links are coordinate based, so DeeplinkX does not expose a text-only `directions` action for this app.

Omit `origin` to use HERE's `mylocation` waypoint as the start. `originTitle` is ignored without an explicit origin. The requested travel modes are driving (`d`), transit (`pt`), walking (`w`), and bicycling (`b`); availability varies by receiving client. The store listing does not establish that every mode is available in the mobile app.

`zoom` must be between 0 and 20 and defaults to 16. HERE documents that the mobile app ignores zoom; it is retained for the web share link.

## Platform Configuration

### iOS

Add the HERE WeGo scheme to the `LSApplicationQueriesSchemes` array in `ios/Runner/Info.plist`:

```xml
<string>here-location</string>
```

This is the legacy scheme retained from the proposed integration for installation checks and `open()`. Current first-party sources above document HTTPS share links, not this scheme. Native iOS opening and installation detection remain unverified. If scheme detection fails, the existing core can take the store/web fallback path even when the app is installed; with `disableFallback: true`, it may return `false`. No core changes are made by this provider.

### Android

Allow querying the package in `android/app/src/main/AndroidManifest.xml`:

```xml
<queries>
  <package android:name="com.here.app.maps" />
</queries>
```

## URI Formats

- Legacy iOS app detection/opening scheme (device-unverified): `here-location://`
- View map: `https://share.here.com/l/{latitude},{longitude},{title}?z={zoom}`
- Directions with coordinates: `https://share.here.com/r/{originLatitude},{originLongitude},{originTitle}/{destinationLatitude},{destinationLongitude},{destinationTitle}?m={d|pt|w|b}`
- Directions without an explicit origin: `https://share.here.com/r/mylocation/{destinationLatitude},{destinationLongitude},{destinationTitle}?m={d|pt|w|b}`

Titles are optional and URL-encoded separately from coordinate delimiters. Without a title the extra comma is omitted.

## Fallback Behavior

1. After installation detection succeeds, DeeplinkX sends navigation actions through the HTTPS share link. HERE and the operating system decide whether the native app or web client receives it; native interception is not guaranteed.
2. If the app is missing and `fallbackToStore` is `true`, we redirect to the appropriate store listing.
3. Otherwise each action falls back to the same HERE share link.
4. Set `disableFallback: true` when calling `launchAction` to skip both store and web fallbacks.

### Fallback Support Matrix

| Action                        | Store Fallback | Web Fallback |
| ----------------------------- | -------------- | ------------ |
| Open app                      | Yes            | Yes          |
| View map                      | Yes            | Yes          |
| Directions with coordinates   | Yes            | Yes          |
