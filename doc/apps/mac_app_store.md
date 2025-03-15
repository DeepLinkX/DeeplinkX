# Mac App Store Deeplinks

DeeplinkX provides support for opening the Mac App Store and specific app pages, including app details and reviews.

## Available Actions

### Open Mac App Store
```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchAction(MacAppStore.open);
```

### Open App Page
```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchAction(MacAppStore.openAppPage(
  appId: '497799835',  // Xcode app ID
  appName: 'xcode',
  country: 'us',       // Optional: two-letter country code
));
```

### Open App Review Page
```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchAction(MacAppStore.openReview(
  appId: '497799835',  // Xcode app ID
  appName: 'xcode',
  country: 'us',       // Optional: two-letter country code
));
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

## Fallback Behavior
If the Mac App Store app is not installed or the device is not running macOS, DeeplinkX will automatically fall back to opening the Mac App Store web interface in the default browser.