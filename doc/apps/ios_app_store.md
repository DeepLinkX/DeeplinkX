# iOS App Store Deeplinks

DeeplinkX provides support for opening the iOS App Store and specific app pages, including app details, reviews, and iMessage extensions.

## Available Actions

### Open App Store
```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchAction(IOSAppStore.open);
```

### Open App Page
```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchAction(IOSAppStore.openAppPage(
  appId: '284882215',  // Facebook app ID
  appName: 'facebook',
  country: 'us',       // Optional: two-letter country code
));
```

### Open App Review Page
```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchAction(IOSAppStore.openReview(
  appId: '284882215',  // Facebook app ID
  appName: 'facebook',
  country: 'us',       // Optional: two-letter country code
));
```

### Open App iMessage Extension
```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchAction(IOSAppStore.openMessagesExtension(
  appId: '284882215',  // Facebook app ID
  appName: 'facebook',
  country: 'us',       // Optional: two-letter country code
));
```

## Parameter Validations

### App ID Validation
iOS App Store app IDs must follow these rules:
- Must contain only digits
- Length: 1-10 digits
- Cannot be empty

Example valid app IDs:
- `284882215` (Facebook)
- `310633997` (WhatsApp)
- `389801252` (Instagram)

Example invalid app IDs:
- `abc123` (contains letters)
- `12345678901` (too long)
- `123-456` (contains special characters)

### App Name Validation
App names must follow these rules:
- Must be a valid URL slug format
- Typically lowercase with hyphens instead of spaces
- Should match the app's name in the App Store URL

Example valid app names:
- `facebook`
- `whatsapp-messenger`
- `instagram`

### Optional Parameters
- **country**: Two-letter country code (e.g., 'us', 'uk', 'jp')
- **mediaType**: Specifies content type (default: '8' for iOS apps)
- **campaignToken**: Used for tracking marketing campaigns
- **providerToken**: Numeric identifier for your team/developer
- **affiliateToken**: Used for Apple's affiliate tracking
- **uniqueOrigin**: Indicates the origin of the link

## Platform-Specific Configuration

### iOS
Add the following to your `ios/Runner/Info.plist`:
```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>itms-apps</string>
</array>
```

## URL Schemes

DeeplinkX uses the following URL schemes for iOS App Store:

### Native App Deep Links
When on iOS, the following scheme is used:
- `itms-apps://` - Primary iOS App Store URL scheme

### Web Fallback URLs
When on other platforms or when native schemes fail:
- `https://apps.apple.com` - Official App Store web URL

## Official Documentation
- [Apple Developer Documentation - Universal Links](https://developer.apple.com/documentation/uikit/inter-process_communication/allowing_apps_and_websites_to_link_to_your_content)
- [Apple Developer Documentation - URL Schemes](https://developer.apple.com/documentation/uikit/inter-process_communication/allowing_apps_and_websites_to_link_to_your_content#3001215)
- [Apple Developer Documentation - App Store Connect](https://appstoreconnect.apple.com/help)

## Fallback Behavior
If the iOS App Store app is not installed or the device is not running iOS, DeeplinkX will automatically fall back to opening the App Store web interface in the default browser.