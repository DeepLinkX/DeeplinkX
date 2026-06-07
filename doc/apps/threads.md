# Threads Deeplinks

DeeplinkX provides support for Threads deep linking actions on Android and iOS, with web fallback available on all platforms.

## Available Actions

### Launch Threads App
```dart
final deeplinkX = DeeplinkX();

await deeplinkX.launchApp(Threads.open());
await deeplinkX.launchApp(Threads.open(fallbackToStore: true));
await deeplinkX.launchApp(Threads.open(), disableFallback: true);
```

### Open Profile Action
```dart
final deeplinkX = DeeplinkX();

await deeplinkX.launchAction(Threads.openProfile(username: 'zuck'));

await deeplinkX.launchAction(Threads.openProfile(
  username: 'zuck',
  fallbackToStore: true,
));

await deeplinkX.launchAction(
  Threads.openProfile(username: 'zuck'),
  disableFallback: true,
);
```

### Open Post Action
```dart
final deeplinkX = DeeplinkX();

await deeplinkX.launchAction(Threads.openPost(
  username: 'zuck',
  postId: 'CuN0hdYv8Lq',
));
```

### Open Comments Action
```dart
final deeplinkX = DeeplinkX();

await deeplinkX.launchAction(Threads.openComments(
  username: 'zuck',
  postId: 'CuN0hdYv8Lq',
));
```

Threads surfaces replies on the post permalink, so `openComments` intentionally targets the same URL as `openPost`.

### Create Post Action
```dart
final deeplinkX = DeeplinkX();

await deeplinkX.launchAction(Threads.createPost(text: 'Hello from Threads'));

await deeplinkX.launchAction(Threads.createPost(
  text: 'Hello from Threads',
  fallbackToStore: true,
));
```

## Platform-Specific Configuration

### iOS
Add the following to your `ios/Runner/Info.plist`:
```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>barcelona</string>
    <string>itms-apps</string>
</array>
```

### Android
Add the following to your `android/app/src/main/AndroidManifest.xml` inside the `<queries>` tag:
```xml
<queries>
    <!-- For Threads app -->
    <package android:name="com.instagram.barcelona" />

    <!-- For Play Store fallback (if using fallbackToStore) -->
    <package android:name="com.android.vending" />

    <!-- For permalink and web intent fallback -->
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="https" />
    </intent>
</queries>
```

## URL Schemes

DeeplinkX uses the following URLs for Threads:

### Native App Deep Links
- `barcelona://` for iOS app and compose/profile flows
- package-targeted Android intents for:
  - profile permalinks
  - post permalinks
  - compose/share text

### Web Fallback URLs
- `https://www.threads.com/@{username}`
- `https://www.threads.com/@{username}/post/{postId}`
- `https://www.threads.com/intent/post?text={text}`

## Supported Fallback Stores

When Threads is not installed, DeeplinkX can redirect users to:

- iOS App Store
- Google Play Store

## Notes

- The `barcelona://` iOS scheme is not vendor-documented. DeeplinkX pairs it with web fallbacks so profile and compose flows still resolve somewhere useful if the scheme changes.
- This release intentionally ships the stable, verified exposed deeplinks: profile, post permalink, and compose intent.
- Search, tag, and feed-specific APIs are not included yet.

## Check If Threads Is Installed

```dart
final deeplinkX = DeeplinkX();
final isInstalled = await deeplinkX.isAppInstalled(Threads());
```
