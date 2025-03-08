/// A cross-platform deeplink plugin that supports various apps and platforms.
///
/// This library provides a simple way to create and launch deeplinks with fallback
/// support for web URLs when native apps are not available.
///
/// Example usage:
/// ```dart
/// import 'package:deeplink_x/deeplink_x.dart';
///
/// // Create a DeeplinkX instance
/// final deeplinkX = const DeeplinkX();
///
/// // Open Instagram app
/// await deeplinkX.launchAction(Instagram.open);
///
/// // Open a specific profile
/// await deeplinkX.launchAction(Instagram.openProfile('username'));
/// ```
library deeplink_x;

export 'src/src.dart';
