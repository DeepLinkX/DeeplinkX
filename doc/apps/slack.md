# Slack Deeplinks

DeeplinkX provides support for Slack deep linking actions.

## Available Actions

### Launch Slack App
```dart
final deeplinkX = DeeplinkX();

// Simple launch
await deeplinkX.launchApp(Slack.open());

// Launch with store fallback if not installed
await deeplinkX.launchApp(Slack.open(fallbackToStore: true));

// Launch with fallback disabled
await deeplinkX.launchApp(Slack.open(), disableFallback: true);
```

### Open Team Action
```dart
final deeplinkX = DeeplinkX();

await deeplinkX.launchAction(
  Slack.openTeam(teamId: 'T123456'),
);
```

### Open Channel Action
```dart
final deeplinkX = DeeplinkX();

await deeplinkX.launchAction(
  Slack.openChannel(
    teamId: 'T123456',
    channelId: 'C123456',
  ),
);
```

### Open User Action
```dart
final deeplinkX = DeeplinkX();

await deeplinkX.launchAction(
  Slack.openUser(
    teamId: 'T123456',
    userId: 'U123456',
  ),
);
```

## Platform-Specific Configuration

### iOS
Add the following to your `ios/Runner/Info.plist`:
```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>slack</string>
    <string>itms-apps</string>
</array>
```

### Android
Add the following to your `android/app/src/main/AndroidManifest.xml` inside the `<queries>` tag:
```xml
<queries>
    <!-- For Slack app -->
    <package android:name="com.Slack" />

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
    <string>slack</string>
    <string>macappstore</string>
</array>
```

## URL Schemes

DeeplinkX uses the following URL schemes for Slack:

### Native App Deep Links
When Slack is installed, the following scheme is used:
- `slack://` - Native Slack URL scheme
- Open team: `slack://open?team={teamId}`
- Open channel: `slack://channel?team={teamId}&id={channelId}`
- Open user: `slack://user?team={teamId}&id={userId}`

### Web Fallback URLs
When Slack is not installed, DeeplinkX automatically falls back to:
- `https://slack.com/app_redirect?team={teamId}`
- For channels: `https://slack.com/app_redirect?team={teamId}&channel={channelId}`
- For users: `https://slack.com/app_redirect?team={teamId}&channel={userId}`

## Supported Fallback Stores
When the Slack app is not installed, DeeplinkX can redirect users to download Slack from the following app stores:

- iOS App Store
- Google Play Store
- Microsoft Store
- Mac App Store

To enable fallback to app stores, use the `fallbackToStore` parameter:
```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(Slack.open(fallbackToStore: true));
```

## Fallback Behavior
DeeplinkX follows this sequence when handling Slack deeplinks:

1. It first attempts to launch the Slack app if it's installed on the device.
2. If the Slack app is not installed and `fallbackToStore` is set to `true`, it will redirect to the appropriate app store based on the user's platform.
3. If no supported store is available or the store app cannot be launched, it will fall back to opening the Slack web interface in the default browser.
4. You can disable all fallbacks by setting `disableFallback: true` in the launch methods.

## Fallback Support for Actions

| Action      | Store Fallback | Web Fallback |
| ----------- | -------------- | ------------ |
| open        | ✅              | ✅            |
| openTeam    | ✅              | ✅            |
| openChannel | ✅              | ✅            |
| openUser    | ✅              | ✅            |

## Check If Slack Is Installed
```dart
final deeplinkX = DeeplinkX();
final isInstalled = await deeplinkX.isAppInstalled(Slack());
```
