# Microsoft Store Deeplinks

DeeplinkX provides support for opening the Microsoft Store and specific app pages, including app details and reviews.

## Available Actions

### Open Microsoft Store
```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchAction(MicrosoftStore.open);
```

### Open App Page
```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchAction(MicrosoftStore.openAppPage(
  productId: '9WZDNCRFHVJL',  // Microsoft Edge product ID
  language: 'en-US',          // Optional: language code
));
```

### Open App Review Page
```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchAction(MicrosoftStore.openAppReviewPage(
  productId: '9WZDNCRFHVJL',  // Microsoft Edge product ID
  language: 'en-US',          // Optional: language code
));
```

## Parameter Validations

### Product ID Validation
Microsoft Store product IDs must follow these rules:
- Typically 12 characters long
- Usually alphanumeric (letters and numbers)
- Cannot be empty

Example valid product IDs:
- `9WZDNCRFHVJL` (Microsoft Edge)
- `9NBLGGH4RGN6` (Microsoft To Do)
- `9WZDNCRD29V9` (Microsoft Teams)

### Optional Parameters
- **language**: Language code for the store page (e.g., 'en-US', 'fr-FR', 'de-DE')

## Platform-Specific Configuration

### Windows
No additional configuration is required for Windows platforms.

## URL Schemes

DeeplinkX uses the following URL schemes for Microsoft Store:

### Native App Deep Links
When on Windows, the following schemes are used:
- `ms-windows-store://pdp/?ProductId={app_id}` - For opening app pages
- `ms-windows-store://review/?ProductId={app_id}` - For opening app review pages

### Web Fallback URLs
When on other platforms or when native schemes fail:
- `https://apps.microsoft.com/store/detail/app/{app_id}` - For opening app pages
- `https://apps.microsoft.com/store/detail/app/{app_id}#reviews` - For opening app review pages

## Fallback Behavior
DeeplinkX follows this sequence when handling Microsoft Store deeplinks:

1. First, it attempts to launch the Microsoft Store app if it's installed on the device.
2. If the Microsoft Store app is not installed or the device is not running windows, DeeplinkX will automatically fall back to opening the Microsoft Store web interface in the default browser.