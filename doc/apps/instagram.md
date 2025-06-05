# Instagram Deeplinks

DeeplinkX provides support for Instagram deep linking actions.

## Available Actions

### Launch Instagram App
```dart
final deeplinkX = DeeplinkX();

// Simple launch
await deeplinkX.launchApp(Instagram.open());

// Launch with store fallback if not installed
await deeplinkX.launchApp(Instagram.open(fallbackToStore: true));

// Launch with fallback disabled
await deeplinkX.launchApp(Instagram.open(), disableFallback: true);
```

### Launch Instagram Profile Action
```dart
final deeplinkX = DeeplinkX();

// Simple action
await deeplinkX.launchAction(Instagram.openProfile('username'));

// Action with store fallback if not installed
await deeplinkX.launchAction(Instagram.openProfile('username', fallbackToStore: true));

// Action with fallback disabled
await deeplinkX.launchAction(Instagram.openProfile('username'), disableFallback: true);
```

## Parameter Validations

### Username Validation
Instagram usernames must follow these rules:
- Length: 1-30 characters
- Can contain letters, numbers, periods, and underscores
- Cannot contain spaces or special characters
- Cannot start with a period or underscore
- Cannot end with a period or underscore
- Cannot contain consecutive periods or underscores

Example valid usernames:
- `john.doe`
- `johndoe123`
- `john_doe`
- `johndoe`

Example invalid usernames:
- `.johndoe` (starts with period)
- `johndoe.` (ends with period)
- `john..doe` (consecutive periods)
- `john doe` (contains space)
- `john@doe` (contains special character)

## Platform-Specific Configuration

### iOS
Add the following to your `ios/Runner/Info.plist`:
```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>instagram</string>
    <string>itms-apps</string>
</array>
```

### Android
Add the following to your `android/app/src/main/AndroidManifest.xml` inside the `<queries>` tag:
```xml
<queries>
    <!-- For Instagram app -->
    <package android:name="com.instagram.android" />
    
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

DeeplinkX uses the following URL schemes for Instagram:

### Native App Deep Links
When Instagram is installed, the following scheme is used:
- `instagram://` - Native Instagram URL scheme
- For profiles: `instagram://user?username={username}`

### Web Fallback URLs
When Instagram is not installed, DeeplinkX automatically falls back to:
- `https://www.instagram.com` - Official Instagram web URL
- For profiles: `https://www.instagram.com/{username}`

## Supported Fallback Stores
When the Instagram app is not installed, DeeplinkX can redirect users to download Instagram from the following app stores:

- iOS App Store
- Google Play Store

To enable fallback to app stores, use the `fallbackToStore` parameter:

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(Instagram.open(fallbackToStore: true));
```

## Fallback Behavior
DeeplinkX follows this sequence when handling Instagram deeplinks:

1. First, it attempts to launch the Instagram app if it's installed on the device.
2. If the Instagram app is not installed and `fallbackToStore` is set to `true`, it will redirect to the appropriate app store based on the user's platform (iOS App Store or Google Play Store).
3. If no supported store is available for the current platform or the store app cannot be launched, it will fall back to opening the Instagram web interface in the default browser.
4. You can disable all fallbacks by setting `disableFallback: true` in the launch methods.

## Fallback Support for Actions

| Action      | Store Fallback | Web Fallback |
| ----------- | -------------- | ------------ |
| open        | ✅              | ✅            |
| openProfile | ✅              | ✅            |

## Check If Instagram Is Installed

```dart
final deeplinkX = DeeplinkX();
final isInstalled = await deeplinkX.isAppInstalled(Instagram());
```
