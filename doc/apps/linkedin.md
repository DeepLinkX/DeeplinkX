# LinkedIn Deeplinks

DeeplinkX provides support for LinkedIn deep linking actions.

## Available Actions

### Launch LinkedIn App
```dart
final deeplinkX = DeeplinkX();

// Simple launch
await deeplinkX.launchApp(LinkedIn.open());

// Launch with store fallback if not installed
await deeplinkX.launchApp(LinkedIn.open(fallBackToStore: true));

// Launch with fallback disabled
await deeplinkX.launchApp(LinkedIn.open(), disableFallback: true);
```

### Launch Profile Action
```dart
final deeplinkX = DeeplinkX();

// Simple action
await deeplinkX.launchAction(LinkedIn.openProfile(
  profileId: 'johndoe',
));

// Action with store fallback if not installed
await deeplinkX.launchAction(
  LinkedIn.openProfile(
    profileId: 'johndoe',
    fallBackToStore: true,
  ),
);

// Action with fallback disabled
await deeplinkX.launchAction(
  LinkedIn.openProfile(
    profileId: 'johndoe',
  ),
  disableFallback: true,
);
```

### Launch Company Page Action
```dart
final deeplinkX = DeeplinkX();

// Simple action
await deeplinkX.launchAction(LinkedIn.openCompany(
  companyId: 'company-id',
));

// Action with store fallback if not installed
await deeplinkX.launchAction(
  LinkedIn.openCompany(
    companyId: 'company-id',
    fallBackToStore: true,
  ),
);

// Action with fallback disabled
await deeplinkX.launchAction(
  LinkedIn.openCompany(
    companyId: 'company-id',
  ),
  disableFallback: true,
);
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
    <!-- For LinkedIn app -->
    <package android:name="com.linkedin.android" />
    
    <!-- For Play Store fallback (if using fallbackToStore) -->
    <package android:name="com.android.vending" />
    
    <!-- For web fallback (required for universal links) -->
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
- Microsoft Store

To enable fallback to app stores, use the `fallBackToStore` parameter:

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(LinkedIn.open(fallBackToStore: true));
```

## Fallback Behavior
LinkedIn uses universal links, which work seamlessly across platforms:

1. First, it attempts to open the LinkedIn app if it's installed on the device using universal links.
2. If the LinkedIn app is not installed and `fallbackToStore` is set to `true`, it will redirect to the appropriate app store based on the user's platform (iOS App Store, Google Play Store, or Microsoft Store).
3. If no supported store is available for the current platform or the store app cannot be launched, it will automatically fall back to opening the URL in a web browser, as LinkedIn uses universal links.
4. You can disable all fallbacks by setting `disableFallback: true` in the launch methods.

## Fallback Support for Actions

| Action      | Store Fallback | Web Fallback |
| ----------- | -------------- | ------------ |
| open        | ✅              | ✅            |
| openProfile | ✅              | ✅            |
| openCompany | ✅              | ✅            |

## Check If LinkedIn Is Installed

```dart
final deeplinkX = DeeplinkX();
final isInstalled = await deeplinkX.isAppInstalled(LinkedIn());
```