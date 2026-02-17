## 1.1.6

* Added Sygic GPS Navigation app with the following actions:
  * Open app
  * View map action
  * Directions with coordinates action (drive or walk)
* Added documentation for Sygic deeplinks
* Added unit tests covering all Sygic actions and exports
* Updated the example app with a dedicated Sygic page and assets

## 1.1.5

* Added Apple Maps app with the following actions:
  * Open app
  * View map action
  * Search action
  * Directions action
  * Directions with coordinates action
* Added documentation for Apple Maps deeplinks
* Added tests for the Apple Maps integration
* Updated example app with an Apple Maps tab

## 1.1.4

* Bump dependency deeplink_x_android version to 1.0.0 ([#Change](https://pub.dev/packages/deeplink_x_android/changelog#100))

## 1.1.3+3

* Update coordinate model tests for coverage issue
* Added Waze app with the following actions:
  * Open app
  * View map action
  * Search action — no web fallback
  * Directions action
  * Directions with coordinates action
* Added documentation for Waze deeplinks
* Updated example app with a Waze tab

## 1.1.3+2

* Fixed changelog format

## 1.1.3+1

* Added coordinate model tests for better reliability

## 1.1.3

* Added Waze app with the following actions:
  * Open app
  * View map action
  * Search action — no web fallback
  * Directions action
  * Directions with coordinates action
* Added documentation for Waze deeplinks
* Updated example app with a Waze tab

## 1.1.2+1

* Updated example project
  * Added splash screen with DeeplinkX logo
  * Added home screen with grid or list view of apps and stores
  * Splited main.dart to specific per app page
* Updated readme
  * Added DeeplinkX logo
  * Add demo link

## 1.1.2

* Added Google Maps app with following actions:
  * Open app
  * View map action
  * Search location action
  * Directions action
  * Directions with coordinates action
* Added documentation for Google Maps deeplinks
* Updated example app with Google Maps tab

## 1.1.1

* Added Slack app with following actions:
  * Open app
  * Open Team Action
  * Open Channel Action
  * Open User Action
* Added documentation for Slack deeplinks
* Updated example app with Slack tab

## 1.1.0

* Now DeeplinkX is more reliable for 100% test coverage
* Bug Fixes
* Added Zoom app with following actions:
  * Open app
  * Join Meeting Action
* Added documentation for Zoom deeplinks
* Updated example app with Zoom tab

## 1.0.5

* Added TikTok app with following actions:
  * Open app
  * Open Profile Action
  * Open Video Action
  * Open Tag Action
* Added documentation for TikTok deeplinks
* Updated example app with TikTok tab

## 1.0.4

* Added Pinterest app with following actions:
  * Open app
  * Open Profile Action
  * Open Pin Action
  * Open Board Action
  * Search action
* Added documentation for Pinterest deeplinks
* Updated example app with Pinterest tab

## 1.0.3

* Added Twitter (X) app with following actions:
  * Open app
  * Open Profile Action
  * Open Tweet Action
  * Search action
* Added documentation for Twitter deeplinks
* Updated example app with Twitter tab

## 1.0.2

* Added YouTube app with following actions:
  * Open app
  * Open video action
  * Open channel action
  * Open playlist action
  * Search action
* Added documentation for YouTube deeplinks
* Updated example app with YouTube tab

## 1.0.1

* Added Facebook app with following actions:
  * Open app
  * Open profile by username action
  * Open profile by profile ID action
  * Open page action
  * Open group action
  * Open event action
* Added platform support for apps for checking if app is installed
* Fixed some bugs

## 1.0.0

* First major release
* More reliable deeplinks:
  * App Links
  * Universal Links
  * Android Intent call
* New methods:
  * Redirect To Store
  * Launch App
  * Is App Installed
* Added ability to ignore fallback to web or store when native app is not installed
* Changed required permissions for Android:
  * Instead of adding intent filter query, we now use package query to check if app is installed
  * Checkout each app's documentation for required permissions

## 0.1.3

* Improved README
  * Used complete GitHub links instead of relative paths

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
* Added support for Telegram deeplinks:
  * Open app
  * Start chat by phone number and pre-filled message
  * Share text content
* Added WASM support
* Added third party licenses in LICENSES

## 0.1.1

* Improved readme

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
