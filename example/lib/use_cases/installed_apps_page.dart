import 'dart:async';

import 'package:deeplink_x/deeplink_x.dart';
import 'package:deeplink_x_example/theme/app_theme.dart';
import 'package:deeplink_x_example/use_cases/use_case_support.dart';
import 'package:deeplink_x_example/widgets/blocks.dart';
import 'package:deeplink_x_example/widgets/list_row.dart';
import 'package:deeplink_x_example/widgets/screen_header.dart';
import 'package:flutter/material.dart';

/// Demonstrates native installation checks for every supported app and store.
class InstalledAppsPage extends StatefulWidget {
  /// Creates the installed-apps use case.
  const InstalledAppsPage({this.deeplinkX, super.key});

  /// Optional launcher override used by widget tests.
  final DeeplinkX? deeplinkX;

  @override
  State<InstalledAppsPage> createState() => _InstalledAppsPageState();
}

class _InstalledAppsPageState extends State<InstalledAppsPage> {
  late final DeeplinkX _deeplinkX = widget.deeplinkX ?? DeeplinkX();
  late final List<_InstalledItem> _items = _buildItems();
  late List<UseCaseAvailability> _availability;
  bool _refreshing = false;
  int? _launchingIndex;

  @override
  void initState() {
    super.initState();
    _availability = List.filled(_items.length, UseCaseAvailability.loading);
    unawaited(_refresh());
  }

  List<_InstalledItem> _buildItems() => [
    _InstalledItem('Apps', 'Instagram', Instagram(), 'assets/instagram.png'),
    _InstalledItem('Apps', 'Telegram', Telegram(), 'assets/telegram.png'),
    _InstalledItem('Apps', 'WhatsApp', WhatsApp(), 'assets/whatsapp.png'),
    _InstalledItem('Apps', 'Facebook', Facebook(), 'assets/facebook.png'),
    _InstalledItem('Apps', 'LinkedIn', LinkedIn(), 'assets/linkedin.png'),
    _InstalledItem('Apps', 'YouTube', YouTube(), 'assets/youtube.png'),
    _InstalledItem('Apps', 'Twitter', Twitter(), 'assets/twitter.png'),
    _InstalledItem('Apps', 'Threads', Threads(), 'assets/threads.png'),
    _InstalledItem('Apps', 'Pinterest', Pinterest(), 'assets/pinterest.png'),
    _InstalledItem('Apps', 'TikTok', TikTok(), 'assets/tiktok.png'),
    _InstalledItem('Apps', 'Zoom', Zoom(), 'assets/zoom.png'),
    _InstalledItem('Apps', 'Slack', Slack(), 'assets/slack.png'),
    _InstalledItem('Maps', 'Google Maps', GoogleMaps(), 'assets/google_maps.png'),
    _InstalledItem('Maps', 'Amap', Amap(), 'assets/amap.png'),
    _InstalledItem('Maps', 'Baidu Maps', BaiduMaps(), 'assets/baidu_maps.png'),
    _InstalledItem('Maps', '2GIS', TwoGis(), 'assets/2gis.png'),
    _InstalledItem('Maps', 'Waze', Waze(), 'assets/waze.png'),
    _InstalledItem('Maps', 'Apple Maps', AppleMaps(), 'assets/apple_maps.png'),
    _InstalledItem('Maps', 'Sygic', Sygic(), 'assets/sygic.png'),
    _InstalledItem('Maps', 'Moovit', Moovit(), 'assets/moovit.png'),
    _InstalledItem('Maps', 'Neshan', Neshan(), 'assets/neshan.png'),
    _InstalledItem('Maps', 'Yandex Maps', YandexMaps(), 'assets/yandex_maps.png'),
    _InstalledItem('Maps', 'Yandex Navigator', YandexNavigator(), 'assets/yandex_navigator.png'),
    _InstalledItem('Stores', 'Google Play Store', PlayStore(), 'assets/google_play.png'),
    _InstalledItem('Stores', 'iOS App Store', IOSAppStore(), 'assets/apple.png'),
    _InstalledItem('Stores', 'Mac App Store', MacAppStore(), 'assets/apple.png'),
    _InstalledItem('Stores', 'Microsoft Store', MicrosoftStore(), 'assets/microsoft.png'),
    _InstalledItem('Stores', 'Huawei AppGallery', HuaweiAppGalleryStore(), 'assets/huawei.png'),
    _InstalledItem('Stores', 'Cafe Bazaar', CafeBazaarStore(), 'assets/cafe_bazaar.png'),
    _InstalledItem('Stores', 'Myket', MyketStore(), 'assets/myket.png'),
  ];

  Future<void> _refresh() async {
    if (_refreshing) {
      return;
    }
    setState(() {
      _refreshing = true;
      _availability = List.filled(_items.length, UseCaseAvailability.loading);
    });
    final statuses = await Future.wait(
      _items.map((final item) async {
        if (!item.app.supportedPlatforms.contains(_deeplinkX.currentPlatform)) {
          return UseCaseAvailability.unsupported;
        }
        final installed = await _deeplinkX.isAppInstalled(item.app);
        return installed ? UseCaseAvailability.installed : UseCaseAvailability.notInstalled;
      }),
    );
    if (!mounted) {
      return;
    }
    setState(() {
      _availability = statuses;
      _refreshing = false;
    });
  }

  Future<void> _launch(final int index) async {
    if (_launchingIndex != null || _availability[index] != UseCaseAvailability.installed) {
      return;
    }
    setState(() => _launchingIndex = index);
    final result = await _deeplinkX.launchApp(_items[index].app, disableFallback: true);
    if (!mounted) {
      return;
    }
    setState(() => _launchingIndex = null);
    showLaunchResult(context, succeeded: result);
  }

  String _status(final UseCaseAvailability availability) => switch (availability) {
    UseCaseAvailability.loading => 'Checking…',
    UseCaseAvailability.installed => 'Installed',
    UseCaseAvailability.notInstalled => 'Not installed',
    UseCaseAvailability.unsupported => 'Unsupported on ${_deeplinkX.currentPlatform.value}',
  };

  Color? _dotColor(final UseCaseAvailability availability) => switch (availability) {
    UseCaseAvailability.loading => null,
    UseCaseAvailability.installed => AppPalette.statusInstalled,
    UseCaseAvailability.notInstalled => AppPalette.statusMissing,
    UseCaseAvailability.unsupported => AppPalette.statusUnsupported,
  };

  OptionRow _row(final int index, {required final bool showDivider}) {
    final item = _items[index];
    final availability = _availability[index];
    return OptionRow(
      key: ValueKey('installed-${item.title}'),
      title: item.title,
      assetName: item.assetName,
      statusText: _status(availability),
      statusDotColor: _dotColor(availability),
      enabled: availability == UseCaseAvailability.installed && _launchingIndex == null,
      showDivider: showDivider,
      trailingIcon: availability == UseCaseAvailability.installed ? Icons.open_in_new_rounded : Icons.remove_rounded,
      trailing:
          _launchingIndex == index
              ? const SizedBox.square(dimension: 20, child: CircularProgressIndicator(strokeWidth: 2))
              : null,
      onTap: () => _launch(index),
    );
  }

  @override
  Widget build(final BuildContext context) {
    final sections = <Widget>[
      const NoteText(
        'Native installation checks for every supported app and store. Tap an installed row to launch it with fallbacks disabled.',
      ),
    ];
    for (var index = 0; index < _items.length; index++) {
      final item = _items[index];
      if (index == 0 || item.category != _items[index - 1].category) {
        var end = index;
        while (end < _items.length && _items[end].category == item.category) {
          end++;
        }
        sections
          ..add(const SizedBox(height: 12))
          ..add(LabelText(item.category))
          ..add(const SizedBox(height: 8))
          ..add(RowsCard(children: [for (var i = index; i < end; i++) _row(i, showDivider: i < end - 1)]));
      }
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ScreenHeader(
              title: 'Installed Apps',
              trailing: HeaderIconButton(
                key: const ValueKey('refresh-installed-apps'),
                icon: Icons.refresh_rounded,
                tooltip: 'Refresh',
                onPressed: _refreshing ? null : _refresh,
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refresh,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
                  children: sections,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InstalledItem {
  const _InstalledItem(this.category, this.title, this.app, this.assetName);

  final String category;
  final String title;
  final App app;
  final String assetName;
}
