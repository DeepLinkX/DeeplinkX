import 'package:flutter_test/flutter_test.dart';
import 'package:deeplink_x/deeplink_x.dart';
import 'package:deeplink_x/deeplink_x_platform_interface.dart';
import 'package:deeplink_x/deeplink_x_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDeeplink_xPlatform
    with MockPlatformInterfaceMixin
    implements Deeplink_xPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final Deeplink_xPlatform initialPlatform = Deeplink_xPlatform.instance;

  test('$MethodChannelDeeplink_x is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDeeplink_x>());
  });

  test('getPlatformVersion', () async {
    Deeplink_x deeplink_xPlugin = Deeplink_x();
    MockDeeplink_xPlatform fakePlatform = MockDeeplink_xPlatform();
    Deeplink_xPlatform.instance = fakePlatform;

    expect(await deeplink_xPlugin.getPlatformVersion(), '42');
  });
}
