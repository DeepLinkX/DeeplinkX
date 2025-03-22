import 'package:deeplink_x/src/core/app_actions/downloadable_app_action.dart';
import 'package:deeplink_x/src/core/app_actions/store_app_action.dart';
import 'package:deeplink_x/src/core/enums/action_type_enum.dart';
import 'package:deeplink_x/src/core/enums/platform_enum.dart';
import 'package:flutter_test/flutter_test.dart';

enum TestActionType implements ActionTypeEnum {
  open;
}

class TestStoreAppAction extends StoreAppAction {
  TestStoreAppAction({
    super.platform = PlatformEnum.android,
    super.actionType = TestActionType.open,
  });

  @override
  Future<Uri> getFallbackUri() async => Uri(
        scheme: 'https',
        host: 'store.com',
      );

  @override
  Future<Uri> getNativeUri() async => Uri(
        scheme: 'test-store',
        host: 'store.com',
      );
}

class TestStoreAppAction2 extends StoreAppAction {
  TestStoreAppAction2({
    super.platform = PlatformEnum.android,
    super.actionType = TestActionType.open,
  });

  @override
  Future<Uri> getFallbackUri() async => Uri(
        scheme: 'https',
        host: 'store2.com',
      );

  @override
  Future<Uri> getNativeUri() async => Uri(
        scheme: 'test-store',
        host: 'store2.com',
      );
}

class TestDownloadableAppAction extends DownloadableAppAction {
  TestDownloadableAppAction(
    this.type, {
    required super.fallBackToStore,
    super.parameters,
  }) : super(
          actionType: type,
          supportedStoresActions: storesActions,
        );

  final TestActionType type;
  static final storesActions = [
    TestStoreAppAction(),
    TestStoreAppAction2(),
    TestStoreAppAction(platform: PlatformEnum.ios),
  ];

  @override
  Future<Uri> getFallbackUri() async => Uri(scheme: 'https', host: 'example.com');

  @override
  Future<Uri> getNativeUri() async => Uri(scheme: 'test', host: 'example.com');
}

void main() {
  group('DownloadableAppAction', () {
    test('getUris generates correct URIs when fallBackToStore is true and Android platfrom', () async {
      final action = TestDownloadableAppAction(TestActionType.open, fallBackToStore: true);
      final uris = await action.getUris(PlatformEnum.android);

      expect(uris.length, 4);
      expect(uris[0].toString(), 'test://example.com');
      expect(uris[1].toString(), 'test-store://store.com');
      expect(uris[2].toString(), 'test-store://store2.com');
      expect(uris[3].toString(), 'https://example.com');
    });

    test('getUris generates correct URIs when fallBackToStore is true and iOS platfrom', () async {
      final action = TestDownloadableAppAction(TestActionType.open, fallBackToStore: true);
      final uris = await action.getUris(PlatformEnum.ios);

      expect(uris.length, 3);
      expect(uris[0].toString(), 'test://example.com');
      expect(uris[1].toString(), 'test-store://store.com');
      expect(uris[2].toString(), 'https://example.com');
    });

    test('getUris generates correct URIs when fallBackToStore is true and Windows platfrom', () async {
      final action = TestDownloadableAppAction(TestActionType.open, fallBackToStore: true);
      final uris = await action.getUris(PlatformEnum.windows);

      expect(uris.length, 2);
      expect(uris[0].toString(), 'test://example.com');
      expect(uris[1].toString(), 'https://example.com');
    });

    test('getUris generates correct URIs when fallBackToStore is true and MacOS platfrom', () async {
      final action = TestDownloadableAppAction(TestActionType.open, fallBackToStore: true);
      final uris = await action.getUris(PlatformEnum.macos);

      expect(uris.length, 2);
      expect(uris[0].toString(), 'test://example.com');
      expect(uris[1].toString(), 'https://example.com');
    });

    test('getUris generates correct URIs when fallBackToStore is true and Linux platfrom', () async {
      final action = TestDownloadableAppAction(TestActionType.open, fallBackToStore: true);
      final uris = await action.getUris(PlatformEnum.linux);

      expect(uris.length, 2);
      expect(uris[0].toString(), 'test://example.com');
      expect(uris[1].toString(), 'https://example.com');
    });
  });
}
