# TomTom GO Expert — unpublished navigation draft

TomTom GO Expert is the current brand of GO Navigation. It is a separate
application from TomTom GO Fleet and the newer free TomTom app. DeeplinkX
exposes it as `TomTomGoExpert`, not as another copy of the former brand.

## Draft operations

* Open the installed Android app by package name.
* Redirect to the official Google Play or iOS App Store listing.
* Fall back to the official GO Expert product website.
* Propose `view(coordinate, title)` and `directionsWithCoords(destination)` using package-targeted Android intents and an iOS navigation URL.

**Do not treat this draft as verified support.** Branding and store identities
are confirmed, but native iOS opening and navigation actions remain unverified.
The target platforms are Android and iOS; this does not establish runtime
compatibility. The draft appears in the example selector for development only.
No search, explicit origin, travel-mode or route-import API is proposed.

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(TomTomGoExpert.open(fallbackToStore: true));

// Store links work independently of native opening support.
await deeplinkX.redirectToStore(storeActions: TomTomGoExpert().storeActions);

// Experimental proposals: validate with the installed app before use.
await deeplinkX.launchAction(TomTomGoExpert.view(
  coordinate: const Coordinate(latitude: 52.5163, longitude: 13.3777),
  title: 'Brandenburg Gate',
));
await deeplinkX.launchAction(TomTomGoExpert.directionsWithCoords(
  destination: const Coordinate(latitude: 52.5163, longitude: 13.3777),
));
```

Use `disableFallback: true` with `launchApp` to return `false` instead of
opening a store or website when native opening is unavailable. A successful
fallback does not mean the native app opened.

## Configuration

Add this package to `<queries>` in your Android manifest:

```xml
<package android:name="com.tomtom.gplay.navapp" />
```

For testing the proposed iOS scheme, add `<string>tomtomgo</string>` to
`LSApplicationQueriesSchemes`. This is a draft hypothesis, not confirmation
that GO Expert handles it. The example retains its existing store queries.

## Proposed link serialization

| Action | Android intent data (package `com.tomtom.gplay.navapp`) | Proposed iOS URL |
| --- | --- | --- |
| View map | `geo:<lat>,<lon>?q=<lat>,<lon>(<encoded title>)` | `tomtomgo://x-callback-url/navigate?destination=<lat>,<lon>` |
| Directions with coordinates | `google.navigation:q=<lat>,<lon>` | `tomtomgo://x-callback-url/navigate?destination=<lat>,<lon>` |

The optional view title is included only in the Android intent. Both proposed
iOS actions use the same navigation endpoint; `view` is not a verified
view-only operation. Android uses `action_view`, the GO Expert package and
the existing new-task flag. Core launch code is unchanged. The Android
adapter may retry an unresolved package implicitly, so package selection is
not a guarantee that another handler cannot open. Device validation must
cover that case as well as the intended GO Expert app.

## Deep-link research and validation limits

Checked on **2026-10-05** using these first-party sources:

* [TomTom: GO Navigation becoming GO Expert](https://help.tomtom.com/hc/en-gb/articles/29231703543314-GO-Navigation-becoming-GO-Expert-app) confirms the rebrand and continued car navigation.
* [Official Google Play listing](https://play.google.com/store/apps/details?id=com.tomtom.gplay.navapp) confirms the Android package and current branding; the example icon comes from this listing.
* [Official iOS App Store listing](https://apps.apple.com/us/app/tomtom-go-expert-truck-gps/id884963367) confirms the app ID and current brand.
* [Official product page](https://www.tomtom.com/navigation/mobile-apps/go-expert-app/) supplies the website fallback.
* [TomTom: syncing Plan.TomTom.com routes with GO Expert](https://help.tomtom.com/hc/en-us/articles/11508089162898-Syncing-Plan-TomTom-com-routes-with-the-GO-Expert-app) describes user-mediated account synchronisation, not a public coordinate deep-link API. Plan and save a route, enable sync, and sign in to the same TomTom account in the app.

No first-party GO Expert contract was found for `geo:`, `google.navigation:`,
or an iOS navigation URL. Published BRIDGE and GO Fleet intent contracts
apply to different products and are not evidence for GO Expert. Absence of
documentation is not proof that these links cannot work. The links above
remain unverified hypotheses retained only in this unpublished draft.

Automated tests cover metadata, store identities, proposed URI serialization,
shared interfaces and existing launch/fallback selection. They do not prove
behavior inside GO Expert. No physical-device validation was performed.
Before publishing navigation actions, obtain applicable
provider documentation and validate the exact installed app/version on each
target platform, including missing-app and failed-launch cases.
