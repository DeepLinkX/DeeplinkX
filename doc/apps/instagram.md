# Instagram Deeplinks

DeeplinkX provides support for Instagram deep linking actions.

## Available Actions

### Open Instagram App
```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchAction(Instagram.open);
```

### Open Instagram Profile
```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchAction(Instagram.openProfile('username'));
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
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="instagram" />
    </intent>
    <!-- Play store fallback -->
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="market" />
    </intent>
    <!-- Web fallback -->
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

### Web Fallback URLs
When Instagram is not installed, DeeplinkX automatically falls back to:
- `https://instagram.com` - Official Instagram web URL

## Supported Fallback Stores
When the Instagram app is not installed, DeeplinkX can redirect users to download Instagram from the following app stores:

- iOS App Store
- Google Play Store

To enable fallback to app stores, use the `fallBackToStore` parameter:

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchAction(Instagram.open(fallBackToStore: true));
```

## Fallback Behavior
DeeplinkX follows this sequence when handling Instagram deeplinks:

1. First, it attempts to launch the Instagram app if it's installed on the device.
2. If the Instagram app is not installed and `fallBackToStore` is set to `true`, it will redirect to the appropriate app store based on the user's platform (iOS App Store or Google Play Store).
3. If no supported store is available for the current platform or the store app cannot be launched, it will fall back to opening the Instagram web interface in the default browser.
