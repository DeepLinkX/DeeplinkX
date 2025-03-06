import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'deeplink_x_platform_interface.dart';

/// An implementation of [Deeplink_xPlatform] that uses method channels.
class MethodChannelDeeplink_x extends Deeplink_xPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('deeplink_x');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
