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

## Fallback Behavior
If the Instagram app is not installed, DeeplinkX will automatically fall back to opening the Instagram web profile in the default browser. 
