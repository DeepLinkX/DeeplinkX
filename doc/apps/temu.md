# Temu Deeplinks

DeeplinkX supports opening Temu, Temu links, and Temu searches on Android and iOS.

## Available Actions

### Launch Temu

```dart
final deeplinkX = DeeplinkX();

await deeplinkX.launchApp(Temu.open());
await deeplinkX.launchApp(Temu.open(fallbackToStore: true));
await deeplinkX.launchApp(Temu.open(), disableFallback: true);
```

### Open a Temu Link

```dart
await deeplinkX.launchAction(
  Temu.openLink(
    link: Uri.parse('https://www.temu.com/search_result.html?search_key=shoes'),
    fallbackToStore: true,
  ),
);
```

### Search Temu

```dart
await deeplinkX.launchAction(
  Temu.search(query: 'running shoes', fallbackToStore: true),
);
```

## Platform Configuration

### iOS

Add the Temu scheme to `ios/Runner/Info.plist`:

```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>temu</string>
</array>
```

### Android

Add the Temu package to `<queries>` in `android/app/src/main/AndroidManifest.xml`:

```xml
<package android:name="com.einnovation.temu" />
```

## Link Formats

- Open app: `temu://`
- Search: `https://www.temu.com/search_result.html?search_key={query}`
- Product, affiliate, and share links: pass the Temu URL to `Temu.openLink(...)`

## Fallback Behavior

1. DeeplinkX opens Temu when installed.
2. If Temu is not installed and `fallbackToStore` is `true`, DeeplinkX redirects to Google Play or the iOS App Store.
3. If store fallback is disabled or unavailable, DeeplinkX opens Temu on the web.
4. Disable all fallbacks with `disableFallback: true`.

## Fallback Support Matrix

| Action       | Store Fallback | Web Fallback |
| ------------ | -------------- | ------------ |
| Open app     | Yes            | Yes          |
| Open link    | Yes            | Yes          |
| Search       | Yes            | Yes          |

## Check If Temu Is Installed

```dart
final deeplinkX = DeeplinkX();
final isInstalled = await deeplinkX.isAppInstalled(Temu());
```
