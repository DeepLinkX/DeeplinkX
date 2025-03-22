import 'package:deeplink_x/src/core/app_actions/app_action.dart';
import 'package:deeplink_x/src/core/enums/platform_enum.dart';

/// Base class for all store-specific app actions.
///
/// This abstract class extends [AppAction] and adds platform-specific
/// functionality for app store actions (Play Store, App Store, etc).
abstract class StoreAppAction extends AppAction {
  /// Creates a new store app action with the specified type, platform and optional parameters.
  const StoreAppAction({
    required this.platform,
    required super.actionType,
    super.parameters,
  });

  /// The platform this store action is intended for.
  ///
  /// This specifies which platform (iOS, Android, Windows, macOS) the store action targets.
  final PlatformEnum platform;
}
