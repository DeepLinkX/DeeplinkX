# DeeplinkX

[![pub package](https://img.shields.io/pub/v/deeplink_x.svg)](https://pub.dev/packages/deeplink_x)
[![Coverage Status](https://coveralls.io/repos/github/DeepLinkX/DeeplinkX/badge.svg)](https://coveralls.io/github/DeepLinkX/DeeplinkX)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub Issues](https://img.shields.io/github/issues/DeepLinkX/DeeplinkX)](https://github.com/DeepLinkX/DeeplinkX/issues)
[![GitHub Stars](https://img.shields.io/github/stars/DeepLinkX/DeeplinkX?style=social)](https://github.com/DeepLinkX/DeeplinkX/stargazers)
[![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20Android%20%7C%20macOS%20%7C%20Windows%20%7C%20Linux%20%7C%20Web-blue.svg)](https://flutter.dev)

<p align="center">
  <img src="https://github.com/DeeplinkX/DeeplinkX/raw/master/images/deeplink_x_logo.jpg" width="180" alt="DeeplinkX Logo">
</p>

<p align="center">
  <strong>Type-safe deeplinks to external apps — with automatic store fallback, across every Flutter platform.</strong>
</p>

<p align="center">
  <a href="https://deeplinkx.github.io/DeeplinkX/">🌐 Live Demo</a> &nbsp;·&nbsp;
  <a href="https://pub.dev/documentation/deeplink_x/latest/">📖 API Reference</a> &nbsp;·&nbsp;
  <a href="https://github.com/DeepLinkX/DeeplinkX/blob/master/CHANGELOG.md">📋 Changelog</a> &nbsp;·&nbsp;
  <a href="https://github.com/DeepLinkX/DeeplinkX/issues/new?template=new_app_request.yml">➕ Request an App</a>
</p>

> **What does the X stand for?** External. DeeplinkX is specifically built for launching deeplinks into *other* apps, not handling incoming links into your own.

---

## Table of Contents

- [Features](#features)
- [Demo](#demo)
- [Install](#install)
- [Quick Start](#quick-start)
- [Core Concepts](#core-concepts)
  - [The three-tier fallback system](#the-three-tier-fallback-system)
  - [Why custom schemes instead of universal links?](#why-custom-schemes-instead-of-universal-links)
- [Recipes](#recipes)
  - [1. Launch an app action](#1-launch-an-app-action)
  - [2. Launch an app](#2-launch-an-app)
  - [3. Check if an app is installed](#3-check-if-an-app-is-installed)
  - [4. Redirect to an app store](#4-redirect-to-an-app-store)
  - [5. Map provider fallback](#5-map-provider-fallback)
- [Supported Apps and Actions](#supported-apps-and-actions)
- [Platform Configuration](#platform-configuration)
- [Why Custom Schemes Instead of Universal Links?](#why-custom-schemes-instead-of-universal-links-1)
- [DeeplinkX vs `url_launcher`](#deeplinkx-vs-url_launcher)
- [Missing an App?](#missing-an-app)
- [Documentation](#documentation)
- [Contributing](#contributing)
- [Feedback](#feedback)
- [License](#license)

---

## Features

- **Typed API** — launch any supported app or in-app action with strongly-typed Dart calls; no URL string maintenance.
- **Smart fallback** — automatically redirects to the app store or a web URL when the target app is not installed.
- **Installation check** — query whether any supported app is present on the device before attempting a launch.
- **Store redirect** — send users to the correct store listing for any app you configure, including your own app, promoted apps, or ad landing pages, without detecting the platform manually.
- **Map provider fallback** — declare a navigation action once (view, search, directions); DeeplinkX checks which apps are installed and opens the first available one automatically.
- **Cross-platform** — works on iOS, Android, macOS, Windows, Linux, and Web from a single package.
- **7 supported stores** — iOS App Store, Mac App Store, Microsoft Store, Google Play Store, Huawei AppGallery, Cafe Bazaar, Myket.
- **17 supported apps** — Facebook, Instagram, LinkedIn, WhatsApp, Telegram, Twitter, Threads, YouTube, TikTok, Pinterest, Zoom, Slack, Google Maps, Citymapper, Waze, Apple Maps, Sygic.

---

## Demo

Try the [live web demo](https://deeplinkx.github.io/DeeplinkX/) or build the example on a real device for the full experience — app installation checks require a native platform.

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

---

## Install

```bash
flutter pub add deeplink_x
```

Then import the package wherever you need it:

```dart
import 'package:deeplink_x/deeplink_x.dart';
```

---

## Quick Start

The example below opens a Telegram profile on iOS. If Telegram is not installed, the user is redirected to the App Store.

**Step 1 — declare the URL scheme in `ios/Runner/Info.plist`:**

```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>tg</string>
    <string>itms-apps</string>
</array>
```

**Step 2 — launch the action:**

```dart
final deeplinkX = DeeplinkX();

final launched = await deeplinkX.launchAction(
  Telegram.openProfile(username: 'username', fallbackToStore: true),
);
```

That's it. DeeplinkX resolves the platform, checks installation, and handles the fallback for you.

---

## Core Concepts

### The three-tier fallback system

DeeplinkX applies the following strategy on every launch, in order:

1. **Native deeplink** — opens the app directly using a custom URL scheme, App Link, or Android Intent when the app is installed.
2. **Store fallback** — if `fallbackToStore: true` and the app is not installed, redirects to the appropriate app store for the current platform.
3. **Web fallback** — if no store redirect applies, opens the web URL for the action (when one exists).

Pass `disableFallback: true` to any launch method to skip steps 2 and 3 entirely and attempt only the native path.

> **Important:** When `fallbackToStore: true` is set and a custom scheme is removed or changed by the app vendor, DeeplinkX will redirect to the store rather than the web fallback. Set `fallbackToStore: false` if you always want the web URL as the fallback destination.

### Why custom schemes instead of universal links?

Custom URL schemes and Android Intents let DeeplinkX reliably check whether an app is installed *before* attempting a launch, so the fallback logic works correctly. Universal links cannot be checked in advance and open a browser tab on failure. See the full explanation in [Why Custom Schemes Instead of Universal Links?](#why-custom-schemes-instead-of-universal-links-1).

---

## Recipes

### 1. Launch an app action

Open a specific screen inside an app. Falls back to the store if the app is not installed:

```dart
final deeplinkX = DeeplinkX();

// Open a Telegram profile
await deeplinkX.launchAction(
  Telegram.openProfile(username: 'flutter', fallbackToStore: true),
);

// Open a YouTube video
await deeplinkX.launchAction(
  YouTube.openVideo(videoId: 'dQw4w9WgXcQ', fallbackToStore: true),
);

// Open a WhatsApp chat
await deeplinkX.launchAction(
  WhatsApp.chat(phoneNumber: '1234567890', fallbackToStore: true),
);
```

### 2. Launch an app

Open a supported app without targeting a specific screen:

```dart
await deeplinkX.launchApp(
  Instagram.open(fallbackToStore: true),
);
```

### 3. Check if an app is installed

```dart
final isInstalled = await deeplinkX.isAppInstalled(LinkedIn());

if (isInstalled) {
  await deeplinkX.launchAction(
    LinkedIn.openProfile(profileId: 'johndoe'),
  );
}
```

### 4. Redirect to an app store

Use this to send users to the correct store page for any app you configure. That can be your own app for install or update flows, or another app's listing from a promotion, recommendation, or ad. You declare each platform-specific listing, and DeeplinkX opens the one that matches the user's platform automatically. No platform detection needed.

```dart
// Add every store listing you want to support.
// DeeplinkX opens the one that matches the current platform.
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

Common patterns include an "Update App" button, a promoted app card, or an ad call-to-action. When the user taps it on Android they land on Google Play, on iOS on the App Store, on Huawei devices on AppGallery — without a single `Platform.isAndroid` check in your code.

For promoted apps or ad CTAs, pass tracking values on stores that support them:

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

### 5. Map provider fallback

Instead of checking which navigation app is installed and then deciding which one to call, you declare what you want to do and list the apps you want to support. DeeplinkX checks installation and opens the first available one. If none are installed, it falls back to the web URL when one exists.

```dart
final deeplinkX = DeeplinkX();

const origin = Coordinate(latitude: 35.6892, longitude: 51.3890);
const destination = Coordinate(latitude: 35.7000, longitude: 51.4000);

// View a location
await deeplinkX.launchMapViewAction(
  actions: [
    GoogleMaps.view(coordinate: origin),
    AppleMaps.view(coordinate: origin),
    Citymapper.view(coordinate: origin),
    Waze.view(coordinate: origin),
    Sygic.view(coordinate: origin),
  ],
);

// Search for a place
await deeplinkX.launchMapSearchAction(
  actions: [
    GoogleMaps.search(query: 'Central Park'),
    AppleMaps.search(query: 'Central Park'),
    Waze.search(query: 'Central Park'),
  ],
);

// Get directions by address
await deeplinkX.launchMapDirectionsAction(
  actions: [
    GoogleMaps.directions(destination: 'Eiffel Tower, Paris'),
    AppleMaps.directions(destination: 'Eiffel Tower, Paris'),
    Waze.directions(destination: 'Eiffel Tower, Paris'),
  ],
);

// Get directions by coordinates
await deeplinkX.launchMapDirectionsWithCoordsAction(
  actions: [
    GoogleMaps.directionsWithCoords(destination: destination),
    AppleMaps.directionsWithCoords(destination: destination),
    Citymapper.directionsWithCoords(destination: destination),
    Waze.directionsWithCoords(destination: destination),
    Sygic.directionsWithCoords(destination: destination),
  ],
);
```

| Method                                | Supported apps                                      |
| ------------------------------------- | --------------------------------------------------- |
| `launchMapViewAction`                 | Google Maps, Apple Maps, Citymapper, Waze, Sygic    |
| `launchMapSearchAction`               | Google Maps, Apple Maps, Waze                       |
| `launchMapDirectionsAction`           | Google Maps, Apple Maps, Waze                       |
| `launchMapDirectionsWithCoordsAction` | Google Maps, Apple Maps, Citymapper, Waze, Sygic    |

---

## Supported Apps and Actions

| Category       | App               | Actions                                                                         |
| -------------- | ----------------- | ------------------------------------------------------------------------------- |
| **Stores**     | iOS App Store     | Open app page, rate app                                                         |
|                | Mac App Store     | Open app page, rate app                                                         |
|                | Microsoft Store   | Open app page, rate app                                                         |
|                | Google Play Store | Open app page                                                                   |
|                | Huawei AppGallery | Open app page                                                                   |
|                | Cafe Bazaar       | Open app page                                                                   |
|                | Myket             | Open app page, rate app                                                         |
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
|                | Apple Maps        | View map, search location, directions, directions with coordinates              |
|                | Citymapper        | View map, directions with coordinates                                           |
|                | Waze              | View map, search, directions, directions with coordinates                       |
|                | Sygic             | View map, directions with coordinates                                           |

---

## Platform Configuration

Some platforms require you to declare URL schemes or package visibility before the OS allows installation checks.

| Platform | File                                       |
| -------- | ------------------------------------------ |
| iOS      | `ios/Runner/Info.plist`                    |
| Android  | `android/app/src/main/AndroidManifest.xml` |
| macOS    | `macos/Runner/Info.plist`                  |

Windows, Linux, and Web do not require additional configuration.

Each app's documentation page (linked in [Documentation](#documentation)) lists the exact schemes and package names to declare. As a reference, here is the iOS entry for Telegram and the App Store:

```xml
<!-- ios/Runner/Info.plist -->
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>tg</string>
    <string>itms-apps</string>
</array>
```

And the Android entry for Instagram:

```xml
<!-- android/app/src/main/AndroidManifest.xml -->
<queries>
    <package android:name="com.instagram.android" />
</queries>
```

For Citymapper specifically, declare `<string>citymapper</string>` on iOS and `<package android:name="com.citymapper.app.release" />` on Android.

---

## Why Custom Schemes Instead of Universal Links?

DeeplinkX prefers custom URL schemes, App Links, and Android Intents over plain HTTPS universal links for several concrete reasons:

**Direct app launch, no browser flash.** Custom schemes and App Links open the native app without routing through a browser first, which eliminates the redirect flicker that users see with universal links. The result is a smoother, more native-feeling experience.

**No "Open with…" dialog on Android.** Android Intents let DeeplinkX target the exact app package, so the system launches it directly. Universal links can show a disambiguation dialog when multiple apps claim the same domain.

**Reliable installation check.** DeeplinkX can query `canLaunch` for a custom scheme or check for a package name before attempting a launch. Universal links return `true` even when the app is absent, because the browser will handle them — making fallback logic unreliable.

**Resilience to scheme changes.** Custom schemes are unofficial and can be deprecated by app vendors. DeeplinkX always pairs a custom scheme with a web fallback URL, so if a scheme disappears, users are still redirected somewhere useful rather than landing on an error.

**Best of both.** DeeplinkX uses the speed and precision of custom schemes for native launches and the reliability of web URLs as the last-resort fallback, giving users the best possible path to the content regardless of what is installed.

---

## DeeplinkX vs `url_launcher`

`url_launcher` is a general-purpose URL launcher. DeeplinkX is purpose-built for external app deeplinks and goes further in every dimension that matters for that use case:

|                                    | DeeplinkX                     | `url_launcher`                                    |
| ---------------------------------- | ----------------------------- | ------------------------------------------------- |
| **Typed API for popular apps**     | ✅ 17 apps, no URL maintenance | ❌ Raw URLs only                                   |
| **Automatic store / web fallback** | ✅ Built in                    | ❌ Manual implementation required                  |
| **Installation check**             | ✅ `isAppInstalled()`          | ⚠️ `canLaunchUrl()` — unreliable for HTTPS schemes |
| **Android Intent support**         | ✅ Advanced intent options     | ⚠️ Basic intent launching only                     |
| **macOS custom scheme check**      | ✅ Supported                   | ❌ Not supported                                   |
| **Map provider fallback**          | ✅ Try multiple apps in order  | ❌ Not available                                   |
| **Store listing redirect**         | ✅ One call, all platforms     | ❌ Not available                                   |

In practice: redirecting users to a target app's store page with `url_launcher` requires you to detect the platform, look up each store URL format, handle edge cases for Huawei devices, and wire that logic in every place you need it. DeeplinkX handles all of it with one `redirectToStore` call — you just supply the app IDs for each store once.

---

## Missing an App?

If DeeplinkX does not support the app, store, or navigation provider you need, open a [new app request](https://github.com/DeepLinkX/DeeplinkX/issues/new?template=new_app_request.yml). Include the app name, target platforms, known URL schemes or App Link patterns, store links, and the actions you want to launch.

---

## Documentation

Per-app documentation covering URL schemes, required configuration, and fallback behavior is available in [`doc/apps`](https://github.com/DeeplinkX/DeeplinkX/tree/master/doc/apps):

**Stores**

| Store             | Link                                                                                                                          |
| ----------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| iOS App Store     | [ios_app_store.md](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/stores/ios_app_store.md)                       |
| Mac App Store     | [mac_app_store.md](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/stores/mac_app_store.md)                       |
| Microsoft Store   | [microsoft_store.md](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/stores/microsoft_store.md)                   |
| Google Play Store | [play_store.md](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/stores/play_store.md)                             |
| Huawei AppGallery | [huawei_app_gallery_store.md](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/stores/huawei_app_gallery_store.md) |
| Cafe Bazaar       | [cafe_bazaar_store.md](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/stores/cafe_bazaar_store.md)               |
| Myket             | [myket_store.md](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/stores/myket_store.md)                           |

**Apps**

| App         | Link                                                                                         |
| ----------- | -------------------------------------------------------------------------------------------- |
| Facebook    | [facebook.md](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/facebook.md)       |
| Instagram   | [instagram.md](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/instagram.md)     |
| Telegram    | [telegram.md](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/telegram.md)       |
| WhatsApp    | [whatsapp.md](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/whatsapp.md)       |
| LinkedIn    | [linkedin.md](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/linkedin.md)       |
| YouTube     | [youtube.md](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/youtube.md)         |
| Twitter     | [twitter.md](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/twitter.md)         |
| Threads     | [threads.md](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/threads.md)         |
| Pinterest   | [pinterest.md](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/pinterest.md)     |
| TikTok      | [tiktok.md](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/tiktok.md)           |
| Zoom        | [zoom.md](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/zoom.md)               |
| Slack       | [slack.md](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/slack.md)             |
| Google Maps | [google_maps.md](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/google_maps.md) |
| Citymapper  | [citymapper.md](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/citymapper.md)   |
| Waze        | [waze.md](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/waze.md)               |
| Apple Maps  | [apple_maps.md](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/apple_maps.md)   |
| Sygic       | [sygic.md](https://github.com/DeeplinkX/DeeplinkX/blob/master/doc/apps/sygic.md)             |

Full API reference is on [pub.dev](https://pub.dev/documentation/deeplink_x/latest/).

---

## Contributing

Contributions are welcome. To get started:

1. Fork the repository.
2. Create a feature branch: `git checkout -b feature/my-feature`
3. Commit your changes: `git commit -m 'Add my feature'`
4. Push to the branch: `git push origin feature/my-feature`
5. Open a Pull Request.

Please check existing issues before opening a new one.

---

## Feedback

If DeeplinkX works well for you, feels confusing in places, or is missing something important for your app, please share it through the [feedback form](https://github.com/DeepLinkX/DeeplinkX/issues/new?template=feedback.yml). User feedback directly shapes the package API and documentation.

---

## License

This project is licensed under the MIT License. See [LICENSE](https://github.com/DeeplinkX/DeeplinkX/blob/master/LICENSE) for details.
