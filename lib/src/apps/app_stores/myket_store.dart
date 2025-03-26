import 'dart:core';

import 'package:deeplink_x/src/core/app_actions/store_app_action.dart';
import 'package:deeplink_x/src/core/enums/action_type_enum.dart';
import 'package:deeplink_x/src/core/enums/platform_enum.dart';

/// Myket-specific action types that define available deeplink actions
enum MyketActionType implements ActionTypeEnum {
  /// Opens the Myket app
  open,

  /// Opens a specific app page in the Myket
  openAppPage,

  /// Rate specific app
  rateApp,
}

/// Myket action implementation for handling Myket-specific deeplinks
class MyketAction extends StoreAppAction {
  /// Creates a new Myket action
  ///
  /// [type] specifies the type of action to perform
  /// [parameters] contains any additional data needed for the action
  const MyketAction(
    this.type, {
    super.parameters,
  }) : super(actionType: type, platform: platformType);

  /// The native platform type
  static const platformType = PlatformEnum.android;

  /// Base URI for Myket app deeplinks
  static const baseUrl = 'myket://';

  /// Base URI for Myket web fallback
  static const fallBackUri = 'https://myket.ir';

  /// The type of Myket action to perform
  final MyketActionType type;

  @override
  Future<Uri> getNativeUri() async {
    switch (type) {
      case MyketActionType.open:
        return Uri.parse(baseUrl).replace(host: 'main');
      case MyketActionType.openAppPage:
        final packageName = parameters!['packageName'];
        final referrer = parameters!['referrer'];

        // Build query parameters
        final queryParams = <String, String>{'id': packageName!};

        if (referrer != null) {
          queryParams['referrer'] = referrer;
        }

        // Native app URI
        return Uri.parse(baseUrl).replace(
          host: 'details',
          queryParameters: queryParams,
        );
      case MyketActionType.rateApp:
        final packageName = parameters!['packageName'];

        // Build query parameters
        final queryParams = <String, String>{'id': packageName!};

        // Native app URI for review
        return Uri.parse(baseUrl).replace(
          host: 'comment',
          queryParameters: queryParams,
        );
    }
  }

  @override
  Future<Uri> getFallbackUri() async {
    switch (type) {
      case MyketActionType.open:
        return Uri.parse(fallBackUri);
      case MyketActionType.openAppPage:
        final packageName = parameters!['packageName'];
        final referrer = parameters!['referrer'];

        // Build query parameters
        final queryParams = <String, String>{};

        if (referrer != null) {
          queryParams['referrer'] = referrer;
        }

        // Web fallback URI
        return Uri.parse(fallBackUri).replace(
          path: '/app/$packageName',
          queryParameters: queryParams.isNotEmpty ? queryParams : null,
        );
      case MyketActionType.rateApp:
        final packageName = parameters!['packageName'];
        final referrer = parameters!['referrer'];

        // Build query parameters
        final queryParams = <String, String>{};

        if (referrer != null) {
          queryParams['referrer'] = referrer;
        }

        // Web fallback URI for review
        return Uri.parse(fallBackUri).replace(
          path: '/app/$packageName',
          fragment: 'reviews',
          queryParameters: queryParams.isNotEmpty ? queryParams : null,
        );
    }
  }
}

/// Factory class for creating Myket deeplink actions
///
/// This class provides convenient factory methods for creating common Myket
/// deeplink actions. While it only contains static members, this is intentional
/// as it serves as a namespace for Myket-specific action creation.
class MyketStore {
  MyketStore._();

  /// Opens the Myket app
  static const MyketAction open = MyketAction(MyketActionType.open);

  /// Opens a specific app page in the Myket
  ///
  /// [packageName] is the package name of the app to open (e.g., 'com.example.app')
  /// [referrer] is an optional parameter for tracking the source of the install (optional)
  static MyketAction openAppPage({
    required final String packageName,
    final String? referrer,
  }) {
    final parameters = <String, String>{
      'packageName': packageName,
    };

    if (referrer != null) {
      parameters['referrer'] = referrer;
    }

    return MyketAction(
      MyketActionType.openAppPage,
      parameters: parameters,
    );
  }

  /// Rate specific app
  ///
  /// On Android and when myket and app is installed, it opens Myket rating page.
  /// On other platforms, it opens the app page review section.
  ///
  /// [packageName] is the package name of the app to rate (e.g., 'com.example.app')
  static MyketAction rateApp({
    required final String packageName,
  }) {
    final parameters = <String, String>{
      'packageName': packageName,
    };

    return MyketAction(
      MyketActionType.rateApp,
      parameters: parameters,
    );
  }
}
