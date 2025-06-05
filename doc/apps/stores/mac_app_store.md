# Mac App Store Deeplinks

DeeplinkX provides support for opening the Mac App Store and specific app pages, including app details and reviews.

## Available Actions

### Launch Mac App Store
```dart
final deeplinkX = DeeplinkX();

// Simple launch
await deeplinkX.launchApp(MacAppStore.open());

// Launch with fallback disabled
await deeplinkX.launchApp(MacAppStore.open(), disableFallback: true);
```

### Launch Mac App Store App Page Action
```dart
final deeplinkX = DeeplinkX();

// Simple action
await deeplinkX.launchAction(MacAppStore.openAppPage(
  appId: '123456789',
  appName: 'example-app',
));

// Action with fallback disabled
await deeplinkX.launchAction(
  MacAppStore.openAppPage(
    appId: '123456789',
    appName: 'example-app',
  ),
  disableFallback: true,
);
```

### Launch App Review Page Action
```dart
final deeplinkX = DeeplinkX();

// Simple action
await deeplinkX.launchAction(MacAppStore.rateApp(
  appId: '123456789',  // Example app ID 
  appName: 'example-app',
  country: 'us',       // Optional: two-letter country code
));

// Action with fallback disabled
await deeplinkX.launchAction(
  MacAppStore.rateApp(
    appId: '123456789',
    appName: 'example-app',
  ),
  disableFallback: true,
);
```

## Parameter Validations

### App ID Validation
Mac App Store app IDs must follow these rules:
- Must contain only digits
- Length: 1-10 digits
- Cannot be empty

Example valid app IDs:
- `497799835` (Xcode)
- `409203825` (Numbers)
- `409201541` (Pages)

Example invalid app IDs:
- `abc123` (contains letters)
- `12345678901` (too long)
- `123-456` (contains special characters)

### App Name Validation
App names must follow these rules:
- Must be a valid URL slug format
- Typically lowercase with hyphens instead of spaces
- Should match the app's name in the Mac App Store URL

Example valid app names:
- `xcode`
- `final-cut-pro`
- `logic-pro`

### Optional Parameters
- **country**: Two-letter country code (e.g., 'us', 'uk', 'jp')
- **mediaType**: Specifies content type (default: '12' for macOS apps)
- **campaignToken**: Used for tracking marketing campaigns
- **providerToken**: Numeric identifier for your team/developer
- **affiliateToken**: Used for Apple's affiliate tracking

## Platform-Specific Configuration

### macOS
Add the following to your `macos/Runner/Info.plist`:
```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>macappstore</string>
</array>
```

## URL Schemes

DeeplinkX uses the following URL schemes for Mac App Store:

### Native App Deep Links
When on macOS, the following scheme is used:
- `macappstore://` - Primary Mac App Store URL scheme

### Web Fallback URLs
When on other platforms or when native schemes fail:
- `https://apps.apple.com/app/mac` - Official Mac App Store web URL

## Official Documentation
- [Apple Developer Documentation - Universal Links](https://developer.apple.com/documentation/uikit/inter-process_communication/allowing_apps_and_websites_to_link_to_your_content)
- [Apple Developer Documentation - URL Schemes](https://developer.apple.com/documentation/uikit/inter-process_communication/allowing_apps_and_websites_to_link_to_your_content#3001215)
- [Apple Developer Documentation - App Store Connect](https://appstoreconnect.apple.com/help)

## Fallback Support for Actions

| Action      | Web Fallback |
| ----------- | ------------ |
| open        | ✅            |
| openAppPage | ✅            |
| rateApp     | ❌            |

## Check If Mac App Store Is Installed

```dart
final deeplinkX = DeeplinkX();
final isInstalled = await deeplinkX.isAppInstalled(MacAppStore());
```
