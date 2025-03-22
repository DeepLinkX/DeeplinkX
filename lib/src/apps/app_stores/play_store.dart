import 'dart:core';

import 'package:deeplink_x/src/core/app_actions/store_app_action.dart';
import 'package:deeplink_x/src/core/enums/action_type_enum.dart';
import 'package:deeplink_x/src/core/enums/platform_enum.dart';

/// Play Store-specific action types that define available deeplink actions
enum PlayStoreActionType implements ActionTypeEnum {
  /// Opens the Play Store app
  open,

  /// Opens a specific app page in the Play Store
  openAppPage,

  /// Opens the review page for a specific app
  openAppReviewPage,
}

/// Play Store action implementation for handling Play Store-specific deeplinks
class PlayStoreAction extends StoreAppAction {
  /// Creates a new Play Store action
  ///
  /// [type] specifies the type of action to perform
  /// [parameters] contains any additional data needed for the action
  const PlayStoreAction(
    this.type, {
    super.parameters,
  }) : super(actionType: type, platform: platformType);

  /// The native platform type
  static const platformType = PlatformEnum.android;

  /// Base URI for Play Store app deeplinks
  static const baseUrl = 'market://';

  /// Base URI for Play Store web fallback
  static const fallBackUri = 'https://play.google.com';

  /// The type of Play Store action to perform
  final PlayStoreActionType type;

  @override
  Future<Uri> getNativeUri() async {
    switch (type) {
      case PlayStoreActionType.open:
        return Uri.parse(baseUrl);
      case PlayStoreActionType.openAppPage:
        final packageName = parameters!['packageName'];
        final referrer = parameters!['referrer'];
        final hl = parameters!['hl'];

        // Build query parameters
        final queryParams = <String, String>{'id': packageName!};

        if (referrer != null) {
          queryParams['referrer'] = referrer;
        }

        if (hl != null) {
          queryParams['hl'] = hl;
        }

        // Native app URI
        return Uri.parse(baseUrl).replace(
          host: 'details',
          queryParameters: queryParams,
        );
      case PlayStoreActionType.openAppReviewPage:
        final packageName = parameters!['packageName'];
        final referrer = parameters!['referrer'];
        final hl = parameters!['hl'];

        // Build query parameters
        final queryParams = <String, String>{'id': packageName!, 'showAllReviews': 'true'};

        if (referrer != null) {
          queryParams['referrer'] = referrer;
        }

        if (hl != null) {
          queryParams['hl'] = hl;
        }

        // Native app URI for review
        return Uri.parse(baseUrl).replace(
          host: 'details',
          queryParameters: queryParams,
        );
    }
  }

  @override
  Future<Uri> getFallbackUri() async {
    switch (type) {
      case PlayStoreActionType.open:
        return Uri.parse(fallBackUri);
      case PlayStoreActionType.openAppPage:
        final packageName = parameters!['packageName'];
        final referrer = parameters!['referrer'];
        final hl = parameters!['hl'];

        // Build query parameters
        final queryParams = <String, String>{'id': packageName!};

        if (referrer != null) {
          queryParams['referrer'] = referrer;
        }

        if (hl != null) {
          queryParams['hl'] = hl;
        }

        // Web fallback URI
        return Uri(
          scheme: 'https',
          host: 'play.google.com',
          path: '/store/apps/details',
          queryParameters: queryParams,
        );
      case PlayStoreActionType.openAppReviewPage:
        final packageName = parameters!['packageName'];
        final referrer = parameters!['referrer'];
        final hl = parameters!['hl'];

        // Build query parameters
        final queryParams = <String, String>{'id': packageName!, 'showAllReviews': 'true'};

        if (referrer != null) {
          queryParams['referrer'] = referrer;
        }

        if (hl != null) {
          queryParams['hl'] = hl;
        }

        // Web fallback URI for review
        return Uri(
          scheme: 'https',
          host: 'play.google.com',
          path: '/store/apps/details',
          queryParameters: queryParams,
        );
    }
  }
}

/// Factory class for creating Play Store deeplink actions
///
/// This class provides convenient factory methods for creating common Play Store
/// deeplink actions. While it only contains static members, this is intentional
/// as it serves as a namespace for Play Store-specific action creation.
class PlayStore {
  PlayStore._();

  /// Opens the Play Store app
  static const PlayStoreAction open = PlayStoreAction(PlayStoreActionType.open);

  /// Opens a specific app page in the Play Store
  ///
  /// [packageName] is the package name of the app to open (e.g., 'com.example.app')
  /// [referrer] is an optional parameter for tracking the source of the install (optional)
  /// [hl] is an optional parameter for specifying the language (e.g., 'en', 'fr', 'de')
  static PlayStoreAction openAppPage({
    required final String packageName,
    final String? referrer,
    final String? hl,
  }) {
    final parameters = <String, String>{
      'packageName': packageName,
    };

    if (referrer != null) {
      parameters['referrer'] = referrer;
    }

    if (hl != null) {
      parameters['hl'] = hl;
    }

    return PlayStoreAction(
      PlayStoreActionType.openAppPage,
      parameters: parameters,
    );
  }

  /// Opens the review page for a specific app
  ///
  /// [packageName] is the package name of the app to open (e.g., 'com.example.app')
  /// [referrer] is an optional parameter for tracking the source of the install (optional)
  /// [hl] is an optional parameter for specifying the language (e.g., 'en', 'fr', 'de')
  static PlayStoreAction openAppReviewPage({
    required final String packageName,
    final String? referrer,
    final String? hl,
  }) {
    final parameters = <String, String>{
      'packageName': packageName,
    };

    if (referrer != null) {
      parameters['referrer'] = referrer;
    }

    if (hl != null) {
      parameters['hl'] = hl;
    }

    return PlayStoreAction(
      PlayStoreActionType.openAppReviewPage,
      parameters: parameters,
    );
  }
}
