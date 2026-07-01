# DeeplinkX

[![pub package](https://img.shields.io/pub/v/deeplink_x.svg)](https://pub.dev/packages/deeplink_x)
[![Coverage Status](https://coveralls.io/repos/github/DeepLinkX/DeeplinkX/badge.svg)](https://coveralls.io/github/DeepLinkX/DeeplinkX)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20Android%20%7C%20macOS%20%7C%20Windows%20%7C%20Linux%20%7C%20Web-blue.svg)](https://flutter.dev)
[![GitHub Stars](https://img.shields.io/github/stars/DeepLinkX/DeeplinkX?style=social)](https://github.com/DeepLinkX/DeeplinkX/stargazers)

<p align="center">
  <img src="https://github.com/DeeplinkX/DeeplinkX/raw/master/images/deeplink_x_logo.jpg" width="180" alt="DeeplinkX Logo">
</p>

<p align="center">
  <strong>Type-safe deeplinks into external apps — with automatic store &amp; web fallback, on every Flutter platform.</strong>
</p>

<p align="center">
  <a href="https://deeplinkx.github.io/DeeplinkX/">🌐 Live Demo</a> &nbsp;·&nbsp;
  <a href="https://pub.dev/documentation/deeplink_x/latest/">📖 API Reference</a> &nbsp;·&nbsp;
  <a href="https://github.com/DeepLinkX/DeeplinkX/issues/new?template=new_app_request.yml">➕ Request an App</a>
</p>

DeeplinkX is a Flutter plugin for launching typed external deeplinks — it launches deeplinks into **other** apps from your Flutter app. Open a chat in **WhatsApp**, a profile in **Telegram** or **Instagram**, a video on **YouTube**, or a location in **Google Maps, Amap, Apple Maps, Waze, Sygic, or Neshan** with turn-by-turn directions — with one strongly-typed call. When the target app isn't installed, it automatically falls back to the right app store, then to a web URL. No URL strings to maintain, no `Platform.isAndroid` branches to write.

> **What does the X stand for?** *External.* DeeplinkX is built for launching links **out** to other apps — not for handling incoming links into your own. For inbound links, use `app_links` or `go_router`.

## Why DeeplinkX

- **Typed API** — every supported app and action is a Dart call; the package owns the URL schemes, not you.
- **Smart fallback** — installed → open the app; not installed → open its store; no store → open the web URL.
- **Installation check** — ask `isAppInstalled()` before you launch.
- **Cross-platform store redirect** — point users at a store listing (your app, a promoted app, an ad CTA) and DeeplinkX picks the right store for the device.
- **Maps & navigation** — open a location, search a place, or launch turn-by-turn directions in Google Maps, Amap, Apple Maps, Waze, Sygic, or Neshan; list your preferred apps and DeeplinkX opens the first installed one, falling back to the web map otherwise.
- **One package, every platform** — iOS, Android, macOS, Windows, Linux, and Web.

Out of the box: **18 apps** (Facebook, Instagram, LinkedIn, WhatsApp, Telegram, Twitter, Threads, YouTube, TikTok, Pinterest, Zoom, Slack, Google Maps, Amap, Waze, Apple Maps, Sygic, Neshan) and **7 stores** (iOS App Store, Mac App Store, Microsoft Store, Google Play, Huawei AppGallery, Cafe Bazaar, Myket).

## Install

```bash
flutter pub add deeplink_x
```

```dart
import 'package:deeplink_x/deeplink_x.dart';
```

Requires Dart `>=3.1.0` and Flutter `>=3.13.0`.

## Quick Start

Open a Telegram profile, and fall back to the App Store / Play Store if Telegram isn't installed:

```dart
final deeplinkX = DeeplinkX();

await deeplinkX.launchAction(
  Telegram.openProfile(username: 'username', fallbackToStore: true),
);
```

On iOS, declare the schemes you query in `ios/Runner/Info.plist` (each app's [doc page](#documentation) lists its exact values):

```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>tg</string>
    <string>itms-apps</string>
</array>
```

That's the whole flow — DeeplinkX resolves the platform, checks installation, and handles the fallback.

## Demo

Try the [live web demo](https://deeplinkx.github.io/DeeplinkX/), or run the example on a real device for the full experience — installation checks need a native platform.

<table>
  <tr>
    <td align="center">
      <strong>Instagram Profile</strong><br>
      <img src="https://github.com/DeeplinkX/DeeplinkX/raw/master/images/previews/01_instagram_open_profile.gif" alt="Instagram profile deeplink demo" width="200">
    </td>
    <td align="center">
      <strong>Telegram Profile</strong><br>
      <img src="https://github.com/DeeplinkX/DeeplinkX/raw/master/images/previews/02_telegram_open_profile.gif" alt="Telegram profile deeplink demo" width="200">
    </td>
    <td align="center">
      <strong>Facebook App</strong><br>
      <img src="https://github.com/DeeplinkX/DeeplinkX/raw/master/images/previews/03_facebook_open_app.gif" alt="Facebook app deeplink demo" width="200">
    </td>
  </tr>
  <tr>
    <td align="center">
      <strong>YouTube Video</strong><br>
      <img src="https://github.com/DeeplinkX/DeeplinkX/raw/master/images/previews/04_youtube_open_video.gif" alt="YouTube video deeplink demo" width="200">
    </td>
    <td align="center">
      <strong>Facebook Web Fallback</strong><br>
      <img src="https://github.com/DeeplinkX/DeeplinkX/raw/master/images/previews/05_facebook_open_web_profile.gif" alt="Facebook web fallback deeplink demo" width="200">
    </td>
    <td align="center">
      <strong>iOS App Store Page</strong><br>
      <img src="https://github.com/DeeplinkX/DeeplinkX/raw/master/images/previews/06_ios_app_store_open_page.gif" alt="iOS App Store deeplink demo" width="200">
    </td>
  </tr>
</table>

## How it works

Every launch follows the same three-tier strategy, in order:

<p align="center">
  <img src="https://github.com/DeeplinkX/DeeplinkX/raw/master/images/how_it_works.png" width="760" alt="DeeplinkX three-tier fallback flow: try the native deeplink, then the app store, then the web URL">
</p>

1. **Native deeplink** — opens the app directly via a custom URL scheme, App Link, or Android Intent when it's installed.
2. **Store fallback** — if `fallbackToStore: true` and the app is absent, redirects to the correct store for the current platform.
3. **Web fallback** — otherwise opens the action's web URL, when one exists.

Pass `disableFallback: true` to any launch method to attempt **only** the native path (skip ② and ③). Every launch method returns `Future<bool>` — see [Return values](#return-values).

> **Note:** with `fallbackToStore: true`, if a vendor changes or removes a custom scheme, DeeplinkX redirects to the **store** rather than the web URL. Set `fallbackToStore: false` when you always want the web page as the fallback.

**Why custom schemes instead of universal links?** Under the hood, DeeplinkX opens apps with iOS custom URL schemes, Android Intents, and Android/iOS App Links — the same launch mechanics you'd otherwise hand-roll with `url_launcher` — rather than plain HTTPS universal links, because they:

- **Launch directly, no browser flash** — no redirect flicker before the app opens.
- **Skip the "Open with…" dialog on Android** — Intents target the exact package.
- **Allow a real installation check** — universal links return `true` even when the app is missing (the browser would handle them), which breaks fallback logic; a scheme/package check does not.
- **Stay resilient** — every scheme is paired with a web fallback, so a deprecated scheme still lands the user somewhere useful.

## Use cases

### Open a screen inside an app

Deep-link to a specific screen; fall back to the store if the app is missing:

```dart
final deeplinkX = DeeplinkX();

await deeplinkX.launchAction(
  Telegram.openProfile(username: 'flutter', fallbackToStore: true),
);

await deeplinkX.launchAction(
  YouTube.openVideo(videoId: 'dQw4w9WgXcQ', fallbackToStore: true),
);

await deeplinkX.launchAction(
  WhatsApp.chat(phoneNumber: '1234567890', fallbackToStore: true),
);
```

### Open another app from Flutter

Launch a supported app without targeting a screen — no raw URLs, no `Platform.isAndroid` checks:

```dart
await deeplinkX.launchApp(
  Instagram.open(fallbackToStore: true),
);
```

The same call shape works to open WhatsApp, Telegram, or any other [supported app](#supported-apps-and-actions) from your Flutter app.

### Check whether an app is installed

Check whether WhatsApp, Telegram, Google Maps, LinkedIn, or another supported app is installed before you launch it:

```dart
final isInstalled = await deeplinkX.isAppInstalled(LinkedIn());

if (isInstalled) {
  await deeplinkX.launchAction(
    LinkedIn.openProfile(profileId: 'johndoe'),
  );
}
```

### Send users to a store listing

Send users to the right store page for any app you configure — your own app's install/update flow, a promoted app, or an ad CTA. Declare each platform's listing once; DeeplinkX opens the one matching the device. No `Platform.isAndroid` checks.

```dart
await deeplinkX.redirectToStore(
  storeActions: [
    IOSAppStore.openAppPage(appId: 'TARGET_APP_ID', appName: 'target-app'),
    MacAppStore.openAppPage(appId: 'TARGET_APP_ID', appName: 'target-app'),
    PlayStore.openAppPage(packageName: 'com.target.app'),
    MicrosoftStore.openAppPage(productId: 'YOUR_PRODUCT_ID'),
    HuaweiAppGalleryStore.openAppPage(
      packageName: 'com.target.app',
      appId: 'YOUR_HUAWEI_APP_ID',
    ),
    CafeBazaarStore.openAppPage(packageName: 'com.target.app'),
    MyketStore.openAppPage(packageName: 'com.target.app'),
  ],
);
```

For promoted apps or ad CTAs, pass tracking parameters on stores that support them:

```dart
await deeplinkX.redirectToStore(
  storeActions: [
    IOSAppStore.openAppPage(
      appId: 'TARGET_APP_ID',
      appName: 'target-app',
      campaignToken: 'spring_sale',
      providerToken: 'partner_network',
      affiliateToken: 'affiliate_123',
      uniqueOrigin: 'home_banner',
    ),
    PlayStore.openAppPage(
      packageName: 'com.target.app',
      referrer: 'utm_source=deeplink_x&utm_medium=ad&utm_campaign=spring_sale',
    ),
    HuaweiAppGalleryStore.openAppPage(
      packageName: 'com.target.app',
      appId: 'YOUR_HUAWEI_APP_ID',
      referrer: 'utm_source=deeplink_x&utm_medium=ad&utm_campaign=spring_sale',
    ),
  ],
);
```

### Open a map, search a place, or get directions

Launch **Google Maps, Amap, Apple Maps, Waze, Sygic, or Neshan** for supported map actions — **view** a location, **search** a place, get **directions** (by address), or get **directions with coordinates** — on every platform, including web and desktop. For each, list the maps apps you prefer in priority order; DeeplinkX opens the first installed one and falls back to the web map if none are present. Need another provider? [Request it](https://github.com/DeepLinkX/DeeplinkX/issues/new?template=new_app_request.yml) — map support is actively expanding.

```dart
const origin = Coordinate(latitude: 35.6892, longitude: 51.3890);
const destination = Coordinate(latitude: 35.7000, longitude: 51.4000);

// View a location
await deeplinkX.launchMapViewAction(
  actions: [
    GoogleMaps.view(coordinate: origin),
    Amap.view(coordinate: origin),
    AppleMaps.view(coordinate: origin),
    Waze.view(coordinate: origin),
    Sygic.view(coordinate: origin),
    Neshan.view(coordinate: origin),
  ],
);

// Search for a place
await deeplinkX.launchMapSearchAction(
  actions: [
    GoogleMaps.search(query: 'Central Park'),
    Amap.search(query: 'Central Park'),
    AppleMaps.search(query: 'Central Park'),
    Waze.search(query: 'Central Park'),
  ],
);

// Directions by address
await deeplinkX.launchMapDirectionsAction(
  actions: [
    GoogleMaps.directions(destination: 'Eiffel Tower, Paris'),
    Amap.directions(destination: 'Eiffel Tower, Paris'),
    AppleMaps.directions(destination: 'Eiffel Tower, Paris'),
    Waze.directions(destination: 'Eiffel Tower, Paris'),
  ],
);

// Directions by coordinates
await deeplinkX.launchMapDirectionsWithCoordsAction(
  actions: [
    GoogleMaps.directionsWithCoords(destination: destination),
    Amap.directionsWithCoords(destination: destination),
    AppleMaps.directionsWithCoords(destination: destination),
    Waze.directionsWithCoords(destination: destination),
    Sygic.directionsWithCoords(destination: destination),
    Neshan.directionsWithCoords(destination: destination),
  ],
);
```

| Method                                | Supported apps                       |
| ------------------------------------- | ------------------------------------ |
| `launchMapViewAction`                 | Google Maps, Amap, Apple Maps, Waze, Sygic, Neshan |
| `launchMapSearchAction`               | Google Maps, Amap, Apple Maps, Waze                |
| `launchMapDirectionsAction`           | Google Maps, Amap, Apple Maps, Waze                |
| `launchMapDirectionsWithCoordsAction` | Google Maps, Amap, Apple Maps, Waze, Sygic, Neshan |

## Supported apps and actions

| Category       | App               | Actions                                                                         |
| -------------- | ----------------- | ------------------------------------------------------------------------------- |
| **Stores**     | iOS App Store     | Open app page, rate app                                                          |
|                | Mac App Store     | Open app page, rate app                                                          |
|                | Microsoft Store   | Open app page, rate app                                                          |
|                | Google Play Store | Open app page                                                                   |
|                | Huawei AppGallery | Open app page                                                                   |
|                | Cafe Bazaar       | Open app page                                                                   |
|                | Myket             | Open app page, rate app                                                          |
| **Social**     | Telegram          | Open profile by username, open profile by phone number, send message            |
|                | Instagram         | Open profile by username                                                        |
|                | WhatsApp          | Chat with phone number, share text content                                      |
|                | Facebook          | Open profile by ID, open profile by username, open page, open group, open event |
|                | YouTube           | Open video, open channel, open playlist, search                                 |
|                | Twitter           | Open profile by username, open tweet by ID, search                              |
|                | Threads           | Open profile by username, open post, open comments, create post                 |
|                | Pinterest         | Open profile by username, open pin, open board by ID, search                    |
|                | TikTok            | Open profile by username, open video, open tag                                  |
|                | Zoom              | Join meeting by ID                                                              |
|                | Slack             | Open team, open channel, open user                                              |
|                | LinkedIn          | Open profile page, open company page                                            |
| **Navigation** | Google Maps       | View map, search location, directions, directions with coordinates              |
|                | Amap              | Open current location, view map, search, directions, directions with coordinates |
|                | Apple Maps        | View map, search location, directions, directions with coordinates              |
|                | Waze              | View map, search, directions, directions with coordinates                       |
|                | Sygic             | View map, directions with coordinates                                           |
|                | Neshan            | View map, directions with coordinates                                           |

## Platform configuration

Some platforms require you to declare URL schemes or package visibility before the OS will allow installation checks.

| Platform | File                                       | Required? |
| -------- | ------------------------------------------ | --------- |
| iOS      | `ios/Runner/Info.plist`                    | Yes       |
| Android  | `android/app/src/main/AndroidManifest.xml` | Yes       |
| macOS    | `macos/Runner/Info.plist`                  | Yes       |
| Windows / Linux / Web | —                             | No config |

Each app's [doc page](#documentation) lists the exact schemes and package names. For example, Telegram + App Store on iOS:

```xml
<!-- ios/Runner/Info.plist -->
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>tg</string>
    <string>itms-apps</string>
</array>
```

…and Instagram on Android:

```xml
<!-- android/app/src/main/AndroidManifest.xml -->
<queries>
    <package android:name="com.instagram.android" />
</queries>
```

## DeeplinkX vs `url_launcher`

`url_launcher` is a general-purpose URL opener. DeeplinkX is purpose-built for external app deeplinks:

|                                    | DeeplinkX                      | `url_launcher`                                     |
| ---------------------------------- | ------------------------------ | -------------------------------------------------- |
| **Typed API for popular apps**     | ✅ 18 apps, no URL maintenance | ❌ Raw URLs only                                   |
| **Automatic store / web fallback** | ✅ Built in                    | ❌ Manual implementation required                  |
| **Installation check**             | ✅ `isAppInstalled()`          | ⚠️ `canLaunchUrl()` — unreliable for HTTPS schemes |
| **Android Intent support**         | ✅ Advanced intent options     | ⚠️ Basic intent launching only                     |
| **macOS custom scheme check**      | ✅ Supported                   | ❌ Not supported                                   |
| **Map actions across apps**        | ✅ View / search / directions, first installed | ❌ Not available                       |
| **Store listing redirect**         | ✅ One call, all platforms     | ❌ Not available                                   |

Redirecting to a store page with `url_launcher` means detecting the platform, looking up each store's URL format, and handling Huawei edge cases — everywhere you need it. DeeplinkX does it in one `redirectToStore` call.

Compared to single-purpose alternatives: `map_launcher` opens a chosen maps app but doesn't cover social apps or store fallback; `external_app_launcher` opens an app or its store listing but has no typed map or social-app actions. DeeplinkX covers apps, maps, and stores from one typed API.

## Return values

Every launch method returns a `Future<bool>`:

- `launchAction`, `launchApp` — `true` if the app launched **or** a fallback (store/web) succeeded; `false` otherwise.
- `isAppInstalled` — `true` if the app is installed.
- `redirectToStore` — `true` if any matching store opened; `false` if no store matched the platform or none launched.
- `launchMap*Action` — `true` if any listed provider (or its fallback) launched.

DeeplinkX swallows platform errors internally and reports them through this boolean, so a launch never throws — branch on the result.

## Missing an app?

If DeeplinkX doesn't support the app, store, or navigation provider you need, open a [new app request](https://github.com/DeepLinkX/DeeplinkX/issues/new?template=new_app_request.yml) with the app name, target platforms, known schemes/App Link patterns, store links, and the actions you want.

## Documentation

Per-app pages (schemes, required config, fallback behavior) live in [`doc/apps`](https://github.com/DeeplinkX/DeeplinkX/tree/master/doc/apps). Full API reference: [pub.dev](https://pub.dev/documentation/deeplink_x/latest/).

**Stores:** [iOS App Store](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/stores/ios_app_store.md) ·
[Mac App Store](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/stores/mac_app_store.md) ·
[Microsoft Store](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/stores/microsoft_store.md) ·
[Google Play](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/stores/play_store.md) ·
[Huawei AppGallery](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/stores/huawei_app_gallery_store.md) ·
[Cafe Bazaar](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/stores/cafe_bazaar_store.md) ·
[Myket](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/stores/myket_store.md)

**Apps:** [Facebook](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/facebook.md) ·
[Instagram](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/instagram.md) ·
[Telegram](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/telegram.md) ·
[WhatsApp](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/whatsapp.md) ·
[LinkedIn](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/linkedin.md) ·
[YouTube](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/youtube.md) ·
[Twitter](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/twitter.md) ·
[Threads](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/threads.md) ·
[Pinterest](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/pinterest.md) ·
[TikTok](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/tiktok.md) ·
[Zoom](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/zoom.md) ·
[Slack](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/slack.md) ·
[Google Maps](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/google_maps.md) ·
[Amap](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/amap.md) ·
[Waze](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/waze.md) ·
[Apple Maps](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/apple_maps.md) ·
[Sygic](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/sygic.md) ·
[Neshan](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/neshan.md)

## Contributing

Contributions are welcome — fork, branch, and open a PR. Please check existing issues first. Found a rough edge or a gap? The [feedback form](https://github.com/DeepLinkX/DeeplinkX/issues/new?template=feedback.yml) directly shapes the API and docs.

## License

MIT — see [LICENSE](https://github.com/DeeplinkX/DeeplinkX/blob/master/LICENSE).
