# LinkedIn Deeplinks

DeeplinkX provides support for LinkedIn deep linking actions.

## Available Actions

### Open LinkedIn Profile
```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchAction(LinkedIn.openProfile('profile-id'));
```

### Open LinkedIn Company Page
```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchAction(LinkedIn.openCompany('company-id'));
```

## Parameter Validations

### Profile ID and Company ID Validation
LinkedIn profile IDs and company IDs should be valid identifiers as used by LinkedIn.

Example valid profile IDs:
- `johndoe`
- `jane-smith-123456789`

## Platform-Specific Configuration

### iOS
Add the following to your `ios/Runner/Info.plist`:
```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>linkedin</string>
    <string>itms-apps</string>
</array>
```

### Android
Add the following to your `android/app/src/main/AndroidManifest.xml` inside the `<queries>` tag:
```xml
<queries>
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="linkedin" />
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

DeeplinkX uses the following URL schemes for LinkedIn:

### Native App Deep Links
When LinkedIn is installed, the following scheme is used:
- `linkedin://` - Native LinkedIn URL scheme

### Web Fallback URLs
When LinkedIn is not installed, DeeplinkX automatically falls back to:
- `https://www.linkedin.com` - Official LinkedIn web URL

## Supported Fallback Stores
When the LinkedIn app is not installed, DeeplinkX can redirect users to download LinkedIn from the following app stores:

- iOS App Store
- Google Play Store

To enable fallback to app stores, use the `fallBackToStore` parameter:

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchAction(LinkedIn.openCompany('company-id', fallBackToStore: true));
```

## Fallback Behavior
DeeplinkX follows this sequence when handling LinkedIn deeplinks:

1. First, it attempts to launch the LinkedIn app if it's installed on the device.
2. If the LinkedIn app is not installed and `fallBackToStore` is set to `true`, it will redirect to the appropriate app store based on the user's platform (iOS App Store or Google Play Store).
3. If no supported store is available for the current platform or the store app cannot be launched, it will fall back to opening the LinkedIn web interface in the default browser.