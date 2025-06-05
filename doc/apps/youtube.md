# YouTube Deeplinks

DeeplinkX provides comprehensive support for YouTube deep linking actions.

## Available Actions

### Launch YouTube App
```dart
final deeplinkX = DeeplinkX();

// Simple launch
await deeplinkX.launchApp(YouTube.open());

// Launch with store fallback if not installed
await deeplinkX.launchApp(YouTube.open(fallbackToStore: true));

// Launch with fallback disabled
await deeplinkX.launchApp(YouTube.open(), disableFallback: true);
```

### Open Video Action
```dart
final deeplinkX = DeeplinkX();

// Simple action
await deeplinkX.launchAction(YouTube.openVideo(videoId: 'dQw4w9WgXcQ')); // YouTube video ID

// Action with store fallback if not installed
await deeplinkX.launchAction(YouTube.openVideo(
  videoId: 'dQw4w9WgXcQ', // YouTube video ID
  fallbackToStore: true,
));

// Action with fallback disabled
await deeplinkX.launchAction(
  YouTube.openVideo(videoId: 'dQw4w9WgXcQ'), // YouTube video ID
  disableFallback: true,
);
```

### Open Channel Action
```dart
final deeplinkX = DeeplinkX();

// Simple action
await deeplinkX.launchAction(YouTube.openChannel(channelId: 'UCq-Fj5jknLsUf-MWSy4_brA')); // YouTube channel ID

// Action with store fallback if not installed
await deeplinkX.launchAction(YouTube.openChannel(
  channelId: 'UCq-Fj5jknLsUf-MWSy4_brA', // YouTube channel ID
  fallbackToStore: true,
));

// Action with fallback disabled
await deeplinkX.launchAction(
  YouTube.openChannel(channelId: 'UCq-Fj5jknLsUf-MWSy4_brA'), // YouTube channel ID
  disableFallback: true,
);
```

### Open Playlist Action
```dart
final deeplinkX = DeeplinkX();

// Simple action
await deeplinkX.launchAction(YouTube.openPlaylist(playlistId: 'PLFgquLnL59alCl_2TQvOiD5Vgm1hCaGSI')); // YouTube playlist ID

// Action with store fallback if not installed
await deeplinkX.launchAction(YouTube.openPlaylist(
  playlistId: 'PLFgquLnL59alCl_2TQvOiD5Vgm1hCaGSI', // YouTube playlist ID
  fallbackToStore: true,
));

// Action with fallback disabled
await deeplinkX.launchAction(
  YouTube.openPlaylist(playlistId: 'PLFgquLnL59alCl_2TQvOiD5Vgm1hCaGSI'), // YouTube playlist ID
  disableFallback: true,
);
```

### Search Action
```dart
final deeplinkX = DeeplinkX();

// Simple action
await deeplinkX.launchAction(YouTube.search(query: 'flutter tutorial')); // Search query

// Action with store fallback if not installed
await deeplinkX.launchAction(YouTube.search(
  query: 'flutter tutorial', // Search query
  fallbackToStore: true,
));

// Action with fallback disabled
await deeplinkX.launchAction(
  YouTube.search(query: 'flutter tutorial'), // Search query
  disableFallback: true,
);
```

## Required Permissions

### Android

To check if YouTube is installed on Android, add the following to your `AndroidManifest.xml`:

```xml
<queries>
    <package android:name="com.google.android.youtube" />
</queries>
```

## Scheme Configuration

### iOS

To handle YouTube deeplinks on iOS, add the following to your `Info.plist`:

```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>youtube</string>
</array>
```

## Supported Fallback Stores
When the YouTube app is not installed, DeeplinkX can redirect users to download YouTube from the following app stores:

- iOS App Store
- Google Play Store
- Microsoft Store

## Fallback Behavior

DeeplinkX follows this sequence when handling YouTube deeplinks:

1. First, it attempts to launch the YouTube app if it's installed on the device.
2. If the YouTube app is not installed and `fallbackToStore` is set to `true`, it will redirect to the appropriate app store based on the user's platform (iOS App Store or Google Play Store).
3. If no supported store is available for the current platform or the store app cannot be launched, it will fall back to opening the YouTube web interface in the default browser.
4. You can disable all fallbacks by setting `disableFallback: true` in the launch methods.

## Check If YouTube Is Installed

```dart
final deeplinkX = DeeplinkX();
final isInstalled = await deeplinkX.isAppInstalled(YouTube());
```

