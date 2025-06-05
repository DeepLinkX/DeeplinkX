# TikTok Deeplinks

DeeplinkX provides comprehensive support for TikTok deep linking actions.

## Available Actions

### Launch TikTok App
```dart
final deeplinkX = DeeplinkX();

// Simple launch
await deeplinkX.launchApp(TikTok.open());

// Launch with store fallback if not installed
await deeplinkX.launchApp(TikTok.open(fallbackToStore: true));

// Launch with fallback disabled
await deeplinkX.launchApp(TikTok.open(), disableFallback: true);
```

### Open Profile Action
```dart
final deeplinkX = DeeplinkX();

// Simple action
await deeplinkX.launchAction(TikTok.openProfile(username: 'tiktok')); // TikTok username

// Action with store fallback if not installed
await deeplinkX.launchAction(TikTok.openProfile(
  username: 'tiktok', // TikTok username
  fallbackToStore: true,
));

// Action with fallback disabled
await deeplinkX.launchAction(
  TikTok.openProfile(username: 'tiktok'), // TikTok username
  disableFallback: true,
);
```

### Open Video Action
```dart
final deeplinkX = DeeplinkX();

// Simple action
await deeplinkX.launchAction(TikTok.openVideo(videoId: '7123456789012345678')); // TikTok video ID

// Action with store fallback if not installed
await deeplinkX.launchAction(TikTok.openVideo(
  videoId: '7123456789012345678', // TikTok video ID
  fallbackToStore: true,
));

// Action with fallback disabled
await deeplinkX.launchAction(
  TikTok.openVideo(videoId: '7123456789012345678'), // TikTok video ID
  disableFallback: true,
);
```

### Open Tag Action
```dart
final deeplinkX = DeeplinkX();

// Simple action
await deeplinkX.launchAction(TikTok.openTag(tagName: 'flutter')); // TikTok tag name

// Action with store fallback if not installed
await deeplinkX.launchAction(TikTok.openTag(
  tagName: 'flutter', // TikTok tag name
  fallbackToStore: true,
));

// Action with fallback disabled
await deeplinkX.launchAction(
  TikTok.openTag(tagName: 'flutter'), // TikTok tag name
  disableFallback: true,
);
```

## Parameter Validations

### Username Validation
TikTok usernames must follow these rules:
- Length: 1-24 characters
- Can contain letters, numbers, underscores, and periods
- Cannot contain spaces or special characters (except underscores and periods)

Example valid usernames:
- `tiktok`
- `charli.damelio`
- `khaby.lame`

Example invalid usernames:
- `tiktok user` (contains space)
- `tiktok@user` (contains special character)

### Video ID Validation
TikTok video IDs must follow these rules:
- Must be a valid numeric string
- Cannot be empty

### Tag Name Validation
TikTok tag names must follow these rules:
- Cannot contain spaces (use single words or hashtags without the # symbol)
- Cannot contain special characters
- Should be alphanumeric

Example valid tag names:
- `flutter`
- `coding`
- `dance`

## Platform-Specific Configuration

### iOS
Add the following to your `ios/Runner/Info.plist`:
```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>tiktok</string>
    <string>itms-apps</string>
</array>
```

### Android
Add the following to your `android/app/src/main/AndroidManifest.xml` inside the `<queries>` tag:
```xml
<queries>
    <!-- For TikTok app -->
    <package android:name="com.zhiliaoapp.musically" />
    
    <!-- For Play Store fallback (if using fallbackToStore) -->
    <package android:name="com.android.vending" />
    
    <!-- For web fallback (required) -->
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="https" />
    </intent>
</queries>
```

## URL Schemes

DeeplinkX uses the following URL schemes for TikTok:

### Native App Deep Links
When TikTok is installed, the following scheme is used:
- `tiktok://` - Native TikTok URL scheme
- For profiles: `tiktok://user?username={username}`
- For videos: `tiktok://video?id={videoId}`
- For tags: `tiktok://tag?name={tagName}`

### Web Fallback URLs
When TikTok is not installed, DeeplinkX automatically falls back to:
- `https://www.tiktok.com` - Official TikTok web URL
- For profiles: `https://www.tiktok.com/@{username}`
- For videos: `https://www.tiktok.com/video/{videoId}`
- For tags: `https://www.tiktok.com/tag/{tagName}`

## Supported Fallback Stores
When the TikTok app is not installed, DeeplinkX can redirect users to download TikTok from the following app stores:

- iOS App Store
- Google Play Store

To enable fallback to app stores, use the `fallbackToStore` parameter:

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(TikTok.open(fallbackToStore: true));
```

## Fallback Behavior
DeeplinkX follows this sequence when handling TikTok deeplinks:

1. First, it attempts to launch the TikTok app if it's installed on the device.
2. If the TikTok app is not installed and `fallbackToStore` is set to `true`, it will redirect to the appropriate app store based on the user's platform (iOS App Store or Google Play Store).
3. If no supported store is available for the current platform or the store app cannot be launched, it will fall back to opening the TikTok web interface in the default browser.
4. You can disable all fallbacks by setting `disableFallback: true` in the launch methods.

## Fallback Support for Actions

| Action      | Store Fallback | Web Fallback |
| ----------- | -------------- | ------------ |
| open        | ✅              | ✅            |
| openProfile | ✅              | ✅            |
| openVideo   | ✅              | ✅            |
| openTag     | ✅              | ✅            |