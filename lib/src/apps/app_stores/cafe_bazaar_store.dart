import 'dart:core';

import 'package:deeplink_x/src/core/app_actions/store_app_action.dart';
import 'package:deeplink_x/src/core/enums/action_type_enum.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';

/// Cafe Bazaar-specific action types that define available deeplink actions
enum CafeBazaarActionType implements ActionTypeEnum {
  /// Opens the Cafe Bazaar app
  open,

  /// Opens a specific app page in the Cafe Bazaar
  openAppPage,
}

/// Cafe Bazaar action implementation for handling Cafe Bazaar-specific deeplinks
class CafeBazaarAction extends StoreAppAction {
  /// Creates a new Cafe Bazaar action
  ///
  /// [type] specifies the type of action to perform
  /// [parameters] contains any additional data needed for the action
  const CafeBazaarAction(
    this.type, {
    super.parameters,
  }) : super(actionType: type, platform: platformType);

  /// The native platform type
  static const platformType = PlatformType.android;

  /// Base URI for Cafe Bazaar app deeplinks
  static const baseUrl = 'bazaar://';

  /// Base URI for Cafe Bazaar web fallback
  static const fallBackUri = 'https://cafebazaar.ir';

  /// The type of Cafe Bazaar action to perform
  final CafeBazaarActionType type;

  @override
  Future<Uri> getNativeUri() async {
    switch (type) {
      case CafeBazaarActionType.open:
        return Uri.parse(baseUrl).replace(host: 'home');
      case CafeBazaarActionType.openAppPage:
        final packageName = parameters!['packageName'];
        final referrer = parameters!['referrer'];

        // Build query parameters
        final queryParams = <String, String>{};

        if (referrer != null) {
          queryParams['referrer'] = referrer;
        }

        // Native app URI
        return Uri.parse(baseUrl).replace(
          host: 'details',
          path: '$packageName',
          queryParameters: queryParams.isNotEmpty ? queryParams : null,
        );
    }
  }

  @override
  Future<Uri> getFallbackUri() async {
    switch (type) {
      case CafeBazaarActionType.open:
        return Uri.parse(fallBackUri);
      case CafeBazaarActionType.openAppPage:
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
    }
  }
}

/// Factory class for creating Cafe Bazaar deeplink actions
///
/// This class provides convenient factory methods for creating common Cafe Bazaar
/// deeplink actions. While it only contains static members, this is intentional
/// as it serves as a namespace for Cafe Bazaar-specific action creation.
class CafeBazaarStore {
  CafeBazaarStore._();

  /// Opens the Cafe Bazaar app
  static const CafeBazaarAction open = CafeBazaarAction(CafeBazaarActionType.open);

  /// Opens a specific app page in the Cafe Bazaar
  ///
  /// [packageName] is the package name of the app to open (e.g., 'com.example.app')
  /// [referrer] is an optional parameter for tracking the source of the install (optional)
  static CafeBazaarAction openAppPage({
    required final String packageName,
    final String? referrer,
  }) {
    final parameters = <String, String>{
      'packageName': packageName,
    };

    if (referrer != null) {
      parameters['referrer'] = referrer;
    }

    return CafeBazaarAction(
      CafeBazaarActionType.openAppPage,
      parameters: parameters,
    );
  }
}
