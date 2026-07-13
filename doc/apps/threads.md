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

### Search Action

```dart
await deeplinkX.launchAction(
  Threads.search(query: 'flutter'),
);
```

### Open Topic Tag Action

```dart
await deeplinkX.launchAction(
  Threads.openTag(tag: 'flutter'),
);
```

Search queries and topic tags must not be blank. DeeplinkX URI-encodes the
supplied value without trimming or otherwise rewriting it.

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

    <!-- For native Threads scheme fallback -->
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="barcelona" />
    </intent>
</queries>
```

## URL Schemes

DeeplinkX uses the following URLs for Threads:

### Native App Deep Links
- `barcelona://user?username={username}` for profile native fallback
- `barcelona://media?shortcode={postId}` for post/comments native fallback
- `barcelona://create?text={text}` for compose native fallback
- `barcelona://search?search_text={query}` for search
- `barcelona://tag/{tag}` for topic tags
- package-targeted Android intents for:
  - profile permalinks
  - post permalinks
  - compose/share text with `android.intent.action.SEND`

### Web Fallback URLs
- `https://www.threads.com/@{username}`
- `https://www.threads.com/@{username}/post/{postId}`
- `https://www.threads.com/intent/post?text={text}`
- `https://www.threads.com/search?q={query}`
- `https://www.threads.com/tag/{tag}`

## Supported Fallback Stores

When Threads is not installed, DeeplinkX can redirect users to:

- iOS App Store
- Google Play Store

## Notes

- On Android, DeeplinkX first launches package-targeted Threads intents backed by Threads App Links metadata, then tries the native `barcelona://` scheme when available before using web or store fallback.
- The `barcelona://` scheme is not vendor-documented. DeeplinkX pairs it with web fallbacks so profile, post, and compose flows still resolve somewhere useful if the scheme changes.
- Search and topic tags are included because their native destinations passed
  physical Android verification and have matching public web destinations.
- Internal feed, messaging, followers, settings, and debug handlers are not
  exposed.

## Check If Threads Is Installed

```dart
final deeplinkX = DeeplinkX();
final isInstalled = await deeplinkX.isAppInstalled(Threads());
```
