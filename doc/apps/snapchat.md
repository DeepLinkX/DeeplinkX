# Snapchat Deeplinks

DeeplinkX supports opening Snapchat and Snapchat profile links on Android, iOS, and Windows.

## References

- Snapchat public profile links: <https://help.snapchat.com/hc/en-us/articles/7012277563540-How-do-I-make-a-Snapcode-to-share-my-Public-Profile-on-Snapchat>

## Available Actions

### Launch Snapchat

```dart
final deeplinkX = DeeplinkX();

await deeplinkX.launchApp(Snapchat.open());
await deeplinkX.launchApp(Snapchat.open(fallbackToStore: true));
await deeplinkX.launchApp(Snapchat.open(), disableFallback: true);
```

### Open a Profile

```dart
await deeplinkX.launchAction(
  Snapchat.openProfile(username: 'snapchat', fallbackToStore: true),
);
```

## Platform Configuration

### iOS

Add the Snapchat scheme to `ios/Runner/Info.plist`:

```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>snapchat</string>
</array>
```

### Android

Add the Snapchat package to `<queries>` in `android/app/src/main/AndroidManifest.xml`:

```xml
<package android:name="com.snapchat.android" />
```

## Link Formats

- Open app: `snapchat://`
- Profile: `https://www.snapchat.com/add/{username}`

## Fallback Behavior

1. DeeplinkX opens Snapchat when installed.
2. If Snapchat is not installed and `fallbackToStore` is `true`, DeeplinkX redirects to Google Play, the iOS App Store, or the Microsoft Store.
3. If store fallback is disabled or unavailable, DeeplinkX opens Snapchat on the web.
4. Disable all fallbacks with `disableFallback: true`.

## Fallback Support Matrix

| Action       | Store Fallback | Web Fallback |
| ------------ | -------------- | ------------ |
| Open app     | Yes            | Yes          |
| Open profile | Yes            | Yes          |

## Check If Snapchat Is Installed

```dart
final deeplinkX = DeeplinkX();
final isInstalled = await deeplinkX.isAppInstalled(Snapchat());
```
