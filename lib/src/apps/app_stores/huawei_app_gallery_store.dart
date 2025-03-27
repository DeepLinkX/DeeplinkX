import 'dart:core';

import 'package:deeplink_x/src/core/app_actions/store_app_action.dart';
import 'package:deeplink_x/src/core/enums/action_type_enum.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';

/// Huawei AppGallery-specific action types that define available deeplink actions
enum HuaweiAppGalleryActionType implements ActionTypeEnum {
  /// Opens a specific app page in the Huawei AppGallery
  openAppPage,
}

/// Huawei AppGallery action implementation for handling Huawei AppGallery-specific deeplinks
class HuaweiAppGalleryAction extends StoreAppAction {
  /// Creates a new Huawei AppGallery action
  ///
  /// [type] specifies the type of action to perform
  /// [parameters] contains any additional data needed for the action
  const HuaweiAppGalleryAction(
    this.type, {
    super.parameters,
  }) : super(actionType: type, platform: platformType);

  /// The native platform type
  static const platformType = PlatformType.android;

  /// Base URI for Huawei AppGallery app deeplinks
  static const baseUrl = 'appmarket://details';

  /// Base URI for Huawei AppGallery web fallback
  static const fallBackUri = 'https://appgallery.huawei.com';

  /// The type of Huawei AppGallery action to perform
  final HuaweiAppGalleryActionType type;

  @override
  Future<Uri> getNativeUri() async {
    switch (type) {
      case HuaweiAppGalleryActionType.openAppPage:
        final packageName = parameters!['packageName'];
        final referrer = parameters!['referrer'];
        final locale = parameters!['locale'];

        // Build query parameters
        final queryParams = <String, String>{'id': packageName!};

        if (referrer != null) {
          queryParams['referrer'] = referrer;
        }

        if (locale != null) {
          queryParams['locale'] = locale;
        }

        // Native app URI
        return Uri.parse(baseUrl).replace(
          queryParameters: queryParams,
        );
    }
  }

  @override
  Future<Uri> getFallbackUri() async {
    switch (type) {
      case HuaweiAppGalleryActionType.openAppPage:
        final appId = parameters!['appId'];
        final referrer = parameters!['referrer'];
        final locale = parameters!['locale'];

        // Build query parameters
        final queryParams = <String, String>{};

        if (referrer != null) {
          queryParams['referrer'] = referrer;
        }

        if (locale != null) {
          queryParams['locale'] = locale;
        }

        return Uri.parse(fallBackUri).replace(
          path: '/app/$appId',
          queryParameters: queryParams.isNotEmpty ? queryParams : null,
        );
    }
  }
}

/// Factory class for creating Huawei AppGallery deeplink actions
///
/// This class provides convenient factory methods for creating common Huawei AppGallery
/// deeplink actions. While it only contains static members, this is intentional
/// as it serves as a namespace for Huawei AppGallery-specific action creation.
class HuaweiAppGalleryStore {
  HuaweiAppGalleryStore._();

  /// Opens a specific app page in the Huawei AppGallery
  ///
  /// [packageName] is the package name of the app to open (e.g., 'com.example.app')
  /// [appId] is the app ID of the app to open (e.g., 'C100000000')
  /// [referrer] is an optional parameter for tracking the source of the install (optional)
  /// [locale] is an optional parameter for specifying the language and region (e.g., 'en_US', 'zh_CN')
  ///
  /// The [packageName] is used for native app deeplinks while [appId] is used for web fallback.
  /// Both are required to ensure proper functionality across platforms.
  static HuaweiAppGalleryAction openAppPage({
    required final String packageName,
    required final String appId,
    final String? referrer,
    final String? locale,
  }) {
    final parameters = <String, String>{
      'appId': appId,
      'packageName': packageName,
    };

    if (referrer != null) {
      parameters['referrer'] = referrer;
    }

    if (locale != null) {
      parameters['locale'] = locale;
    }

    return HuaweiAppGalleryAction(
      HuaweiAppGalleryActionType.openAppPage,
      parameters: parameters,
    );
  }
}
