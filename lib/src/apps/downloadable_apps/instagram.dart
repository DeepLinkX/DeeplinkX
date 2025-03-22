import 'package:deeplink_x/src/apps/app_stores/app_stores.dart';
import 'package:deeplink_x/src/core/app_actions/downloadable_app_action.dart';
import 'package:deeplink_x/src/core/app_actions/store_app_action.dart';
import 'package:deeplink_x/src/core/enums/action_type_enum.dart';

/// Instagram-specific action types that define available deeplink actions
enum InstagramActionType implements ActionTypeEnum {
  /// Opens the Instagram app
  open,

  /// Opens a specific Instagram profile
  openProfile,
}

/// Instagram action implementation for handling Instagram-specific deeplinks
class InstagramAction extends DownloadableAppAction {
  /// Creates a new Instagram action
  ///
  /// [type] specifies the type of action to perform (e.g., open app, open profile)
  /// [fallBackToStore] determines if the action should redirect to app store when app isn't installed
  /// [parameters] contains any additional data needed for the action (e.g., username for profile)
  /// [actionType] is internally set to [type] for action handling
  /// [supportedStoresActions] is set to predefined [storesActions] for store handling
  InstagramAction(
    this.type, {
    required super.fallBackToStore,
    super.parameters,
  }) : super(
          actionType: type,
          supportedStoresActions: storesActions,
        );

  /// Base URI for Instagram app deeplinks
  static const baseUrl = 'instagram://';

  /// Base URI for Instagram web fallback
  static const fallBackUri = 'https://www.instagram.com';

  /// The type of Instagram action to perform
  final InstagramActionType type;

  /// List of store actions for downloading/opening Instagram across different platforms
  ///
  /// Contains actions for:
  /// - Play Store
  /// - iOS App Store
  static final List<StoreAppAction> storesActions = [
    PlayStore.openAppPage(packageName: 'com.instagram.android'),
    IOSAppStore.openAppPage(appId: '389801252', appName: 'instagram'),
  ];

  @override
  Future<Uri> getNativeUri() async {
    switch (type) {
      case InstagramActionType.open:
        return Uri.parse(baseUrl);
      case InstagramActionType.openProfile:
        final username = parameters!['username'];
        return Uri.parse('${baseUrl}user?username=$username');
    }
  }

  @override
  Future<Uri> getFallbackUri() async {
    switch (type) {
      case InstagramActionType.open:
        return Uri.parse(fallBackUri);
      case InstagramActionType.openProfile:
        final username = parameters!['username'];
        return Uri.parse('$fallBackUri/$username');
    }
  }
}

/// Factory class for creating Instagram deeplink actions
///
/// This class provides convenient factory methods for creating common Instagram
/// deeplink actions. While it only contains static members, this is intentional
/// as it serves as a namespace for Instagram-specific action creation.
class Instagram {
  Instagram._();

  /// Opens the Instagram app
  static InstagramAction open({
    final bool fallBackToStore = false,
  }) =>
      InstagramAction(
        InstagramActionType.open,
        fallBackToStore: fallBackToStore,
      );

  /// Opens a specific Instagram profile
  ///
  /// [username] is the Instagram username to open
  static InstagramAction openProfile(
    final String username, {
    final bool fallBackToStore = false,
  }) =>
      InstagramAction(
        InstagramActionType.openProfile,
        parameters: {'username': username},
        fallBackToStore: fallBackToStore,
      );
}
