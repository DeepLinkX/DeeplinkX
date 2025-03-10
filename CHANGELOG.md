## 0.0.2

* Added support for Telegram deeplinks:
  * Open app
  * Open profile by username
  * Open profile by phone number
  * Send message by username
  * Send message by phone number
* Added comprehensive documentation for Telegram features:
  * Parameter validation rules for usernames and phone numbers
  * Links to official Telegram API documentation
  * URL schemes (`tg://`) and web fallbacks (`https://t.me`)
* Added platform-specific configuration guides for iOS and Android:
  * LSApplicationQueriesSchemes for iOS
  * Android manifest query requirements
* Documentation improvements:
  * Created app-specific documentation structure
  * Improved example project with Material 3 design
  * Enhanced UI/UX in example project
  * Added URL scheme handling documentation
* Fixed platform support information
* Fixed Android manifest requirements
* Fixed Linux platform configuration information

## 0.0.1

Initial release of DeeplinkX with the following features:

* Added support for Instagram deeplinks:
  * Open app
  * Open profile

* Cross-platform support for iOS, Android, Web, and Desktop platforms
* Automatic fallback to web URLs when native apps are not available
* Type-safe API for creating deeplinks
