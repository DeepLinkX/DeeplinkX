# Pinterest Deeplinks

DeeplinkX provides comprehensive support for Pinterest deep linking actions.

## Basic Usage

### Launch Pinterest App

To simply open the Pinterest app:

```dart
await deeplinkX.launchApp(Pinterest.open());
```

With fallback to app store:

```dart
await deeplinkX.launchApp(Pinterest.open(fallbackToStore: true));
```

Without fallback:

```dart
await deeplinkX.launchApp(Pinterest.open(), disableFallback: true);
```

### Open Profile

To open a specific Pinterest profile:

```dart
await deeplinkX.launchAction(Pinterest.openProfile(username: 'pinterest')); // Pinterest username
```

With fallback to app store:

```dart
await deeplinkX.launchAction(Pinterest.openProfile(
  username: 'pinterest', // Pinterest username
  fallbackToStore: true,
));
```

Without fallback:

```dart
await deeplinkX.launchAction(
  Pinterest.openProfile(username: 'pinterest'), // Pinterest username
  disableFallback: true,
);
```

### Open Pin

To open a specific Pinterest pin:

```dart
await deeplinkX.launchAction(Pinterest.openPin(pinId: '1234567890')); // Pinterest pin ID
```

With fallback to app store:

```dart
await deeplinkX.launchAction(Pinterest.openPin(
  pinId: '1234567890', // Pinterest pin ID
  fallbackToStore: true,
));
```

Without fallback:

```dart
await deeplinkX.launchAction(
  Pinterest.openPin(pinId: '1234567890'), // Pinterest pin ID
  disableFallback: true,
);
```

### Search

To search on Pinterest:

```dart
await deeplinkX.launchAction(Pinterest.search(query: 'flutter')); // Search query
```

With fallback to app store:

```dart
await deeplinkX.launchAction(Pinterest.search(
  query: 'flutter', // Search query
  fallbackToStore: true,
));
```

Without fallback:

```dart
await deeplinkX.launchAction(
  Pinterest.search(query: 'flutter'), // Search query
  disableFallback: true,
);
```

### Open Board

To open a specific Pinterest board:

```dart
await deeplinkX.launchAction(Pinterest.openBoard(
  username: 'pinterest', // Board owner username
  board: 'my-board', // Board (lower-case, hyphenated)
));
```

With fallback to app store:

```dart
await deeplinkX.launchAction(Pinterest.openBoard(
  username: 'pinterest',
  board: 'my-board',
  fallbackToStore: true,
));
```

Without fallback:

```dart
await deeplinkX.launchAction(
  Pinterest.openBoard(username: 'pinterest', board: 'my-board'),
  disableFallback: true,
);
```

## Platform Configuration

### iOS

Add the following to your `Info.plist`:

```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>pinterest</string>
</array>
```

### Android

Add the following to your `AndroidManifest.xml`:

```xml
<queries>
    <!-- For Pinterest app -->
    <package android:name="com.pinterest" />
</queries>
```

## URL Schemes

DeeplinkX uses the following URL schemes for Pinterest:

### Native App

When Pinterest is installed, the following scheme is used:
- `pinterest://` - Native Pinterest URL scheme
- For profiles: `pinterest://user/{username}`
- For pins: `pinterest://pin/{pinId}`
- For search: `pinterest://search/pins?q={query}`
- For boards: `pinterest://board/<USER>/<BOARD>`

### Web Fallback

When Pinterest is not installed, DeeplinkX automatically falls back to:
- `https://www.pinterest.com` - Official Pinterest web URL
- For profiles: `https://www.pinterest.com/{username}`
- For pins: `https://www.pinterest.com/pin/{pinId}`
- For search: `https://www.pinterest.com/search/pins?q={query}`
- For boards: `https://www.pinterest.com/<USER>/<BOARD>`

### App Store Fallback

When the Pinterest app is not installed, DeeplinkX can redirect users to download Pinterest from the following app stores:

```dart
await deeplinkX.launchApp(Pinterest.open(fallbackToStore: true));
```

## Fallback Behavior

DeeplinkX follows this sequence when handling Pinterest deeplinks:

1. First, it attempts to launch the Pinterest app if it's installed on the device.
2. If the Pinterest app is not installed and `fallbackToStore` is set to `true`, it will redirect to the appropriate app store based on the user's platform (iOS App Store or Google Play Store).
3. If no supported store is available for the current platform or the store app cannot be launched, it will fall back to opening the Pinterest web interface in the default browser.
4. You can disable all fallbacks by setting `disableFallback: true` in the launch methods.

## Check If Pinterest Is Installed

```dart
final deeplinkX = DeeplinkX();
final isInstalled = await deeplinkX.isAppInstalled(Pinterest());
```
