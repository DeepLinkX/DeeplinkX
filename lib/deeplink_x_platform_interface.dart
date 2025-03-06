import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'deeplink_x_method_channel.dart';

abstract class Deeplink_xPlatform extends PlatformInterface {
  /// Constructs a Deeplink_xPlatform.
  Deeplink_xPlatform() : super(token: _token);

  static final Object _token = Object();

  static Deeplink_xPlatform _instance = MethodChannelDeeplink_x();

  /// The default instance of [Deeplink_xPlatform] to use.
  ///
  /// Defaults to [MethodChannelDeeplink_x].
  static Deeplink_xPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [Deeplink_xPlatform] when
  /// they register themselves.
  static set instance(Deeplink_xPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
