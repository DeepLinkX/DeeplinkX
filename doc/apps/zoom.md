# Zoom Deeplinks

DeeplinkX provides support for joining and starting Zoom meetings via deeplinks.

## Available Actions

### Launch Zoom App
```dart
final deeplinkX = DeeplinkX();

// Simple launch
await deeplinkX.launchApp(Zoom.open());

// Launch with store fallback if not installed
await deeplinkX.launchApp(Zoom.open(fallbackToStore: true));

// Launch with fallback disabled
await deeplinkX.launchApp(Zoom.open(), disableFallback: true);
```

### Join Meeting Action
```dart
final deeplinkX = DeeplinkX();

// Simple join
await deeplinkX.launchAction(Zoom.joinMeeting(
  meetingId: '123456789',
));

// Join with password and store fallback
await deeplinkX.launchAction(Zoom.joinMeeting(
  meetingId: '123456789',
  password: 'abc123',
  fallbackToStore: true,
));
```

### Start Meeting Action
```dart
final deeplinkX = DeeplinkX();

await deeplinkX.launchAction(Zoom.startMeeting(
  meetingId: '123456789',
  password: 'abc123',
));
```

## Platform-Specific Configuration

### iOS
Add the following to your `ios/Runner/Info.plist`:
```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>zoomus</string>
    <string>itms-apps</string>
</array>
```

### Android
Add the following to your `android/app/src/main/AndroidManifest.xml` inside the `<queries>` tag:
```xml
<queries>
    <!-- For Zoom app -->
    <package android:name="us.zoom.videomeetings" />

    <!-- For Play Store fallback (if using fallbackToStore) -->
    <package android:name="com.android.vending" />

    <!-- For web fallback (required) -->
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="https" />
    </intent>
</queries>
```

### macOS
Add the following to your `macos/Runner/Info.plist`:
```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>zoomus</string>
    <string>macappstore</string>
</array>
```

## URL Schemes

DeeplinkX uses the following URL schemes for Zoom:

### Native App Deep Links
When Zoom is installed, the following scheme is used:
- `zoomus://` - Native Zoom URL scheme
- Join meeting: `zoomus://zoom.us/join?confno={meetingId}&pwd={password}`
- Start meeting: `zoomus://zoom.us/start?confno={meetingId}&pwd={password}`

### Web Fallback URLs
When Zoom is not installed, DeeplinkX automatically falls back to:
- `https://zoom.us` - Official Zoom web URL
- Join or start meeting: `https://zoom.us/j/{meetingId}?pwd={password}`

## Supported Fallback Stores
When the Zoom app is not installed, DeeplinkX can redirect users to download Zoom from the following app stores:

- iOS App Store
- Google Play Store
- Mac App Store

To enable fallback to app stores, use the `fallbackToStore` parameter:
```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(Zoom.open(fallbackToStore: true));
```

## Fallback Behavior
DeeplinkX follows this sequence when handling Zoom deeplinks:

1. It first attempts to launch the Zoom app if it's installed on the device.
2. If the Zoom app is not installed and `fallbackToStore` is set to `true`, it will redirect to the appropriate app store based on the user's platform.
3. If no supported store is available or the store app cannot be launched, it will fall back to opening the Zoom web interface in the default browser.
4. You can disable all fallbacks by setting `disableFallback: true` in the launch methods.

## Fallback Support for Actions

| Action       | Store Fallback | Web Fallback |
| ------------ | -------------- | ------------ |
| open         | ✅              | ✅            |
| joinMeeting  | ✅              | ✅            |
| startMeeting | ✅              | ✅            |

## Check If Zoom Is Installed
```dart
final deeplinkX = DeeplinkX();
final isInstalled = await deeplinkX.isAppInstalled(Zoom());
```
