## 0.1.2
* Added support for LinkedIn deeplinks:
  * Open profile
  * Open company page
* Added support for Huawei AppGallery Store deeplinks:
  * Open app page by app ID and package name
* Added support for Cafe Bazaar Android app store deeplinks:
  * Open Cafe Bazaar app
  * Open app page by package name
* Added support for Myket Android app store deeplinks:
  * Open Myket app
  * Open app page by package name
  * Rate app by package name
* Added can launch native deeplink method to check app installed and action can be launched
* * Added support for Telegram deeplinks:
  * Open app
  * Start chat by phone number and pre-filled message
  * Share text content

## 0.1.1
* Improve readme

## 0.1.0
* New Feature:
  * Added fallback to supported stores option when desired app is not installed
* Added support for Mac App Store deeplinks:
  * Open Mac App Store
  * Open app page by app ID
  * Open app review page
* Added support for Microsoft Store deeplinks:
  * Open Microsoft Store
  * Open app page by app ID
  * Open app review page

## 0.0.3
* Added support for Google Play Store deeplinks:
  * Open Play Store
  * Open app page by app package name
  * Open app review page
* Added support for Huawei AppGallery deeplinks:
  * Open AppGallery
  * Open app page by app ID
  * Open app review page

## 0.0.2

* Added support for App Store deeplinks:
  * Open App Store
  * Open app page by app ID
  * Open app review page
  * Open app iMessage extension
* Added support for Telegram deeplinks:
  * Open app
  * Open profile by username
  * Open profile by phone number
  * Send message by username
  * Send message by phone number
* Added comprehensive documentation:
  * App-specific document structure
  * Links to official API documentation
  * URL schemes and web fallbacks
* Added platform-specific configuration guides:
  * LSApplicationQueriesSchemes for iOS
  * Android manifest query requirements
* Improved example project:
  * Added Material 3 design
  * Enhanced UI/UX
  * Added URL scheme handling
* Fixed platform support information
* Fixed Android manifest requirements
* Updated dependencies and linting rules
* Improved code quality with stricter analysis options

## 0.0.1

Initial release of DeeplinkX with the following features:

* Added support for Instagram deeplinks:
  * Open app
  * Open profile

* Cross-platform support for iOS, Android, Web, and Desktop platforms
* Automatic fallback to web URLs when native apps are not available
* Type-safe API for creating deeplinks
