import 'package:deeplink_x_example/pages/amap_page.dart';
import 'package:deeplink_x_example/pages/apple_maps_page.dart';
import 'package:deeplink_x_example/pages/baidu_maps_page.dart';
import 'package:deeplink_x_example/pages/cafe_bazaar_page.dart';
import 'package:deeplink_x_example/pages/facebook_page.dart';
import 'package:deeplink_x_example/pages/google_maps_page.dart';
import 'package:deeplink_x_example/pages/huawei_app_gallery_page.dart';
import 'package:deeplink_x_example/pages/instagram_page.dart';
import 'package:deeplink_x_example/pages/ios_app_store_page.dart';
import 'package:deeplink_x_example/pages/linkedin_page.dart';
import 'package:deeplink_x_example/pages/mac_app_store_page.dart';
import 'package:deeplink_x_example/pages/microsoft_store_page.dart';
import 'package:deeplink_x_example/pages/moovit_page.dart';
import 'package:deeplink_x_example/pages/myket_page.dart';
import 'package:deeplink_x_example/pages/neshan_page.dart';
import 'package:deeplink_x_example/pages/pinterest_page.dart';
import 'package:deeplink_x_example/pages/play_store_page.dart';
import 'package:deeplink_x_example/pages/slack_page.dart';
import 'package:deeplink_x_example/pages/sygic_page.dart';
import 'package:deeplink_x_example/pages/telegram_page.dart';
import 'package:deeplink_x_example/pages/threads_page.dart';
import 'package:deeplink_x_example/pages/tiktok_page.dart';
import 'package:deeplink_x_example/pages/twitter_page.dart';
import 'package:deeplink_x_example/pages/two_gis_page.dart';
import 'package:deeplink_x_example/pages/waze_page.dart';
import 'package:deeplink_x_example/pages/whatsapp_page.dart';
import 'package:deeplink_x_example/pages/yandex_maps_page.dart';
import 'package:deeplink_x_example/pages/youtube_page.dart';
import 'package:deeplink_x_example/pages/zoom_page.dart';
import 'package:deeplink_x_example/use_cases/about_support_page.dart';
import 'package:deeplink_x_example/use_cases/fallback_playground_page.dart';
import 'package:deeplink_x_example/use_cases/installed_apps_page.dart';
import 'package:deeplink_x_example/use_cases/map_selector_page.dart';
import 'package:deeplink_x_example/use_cases/meeting_community_page.dart';
import 'package:deeplink_x_example/use_cases/promoted_app_page.dart';
import 'package:deeplink_x_example/use_cases/rate_review_page.dart';
import 'package:deeplink_x_example/use_cases/share_message_page.dart';
import 'package:deeplink_x_example/use_cases/update_app_page.dart';
import 'package:deeplink_x_example/use_cases/use_case_support.dart';
import 'package:flutter/material.dart';

/// Simple model describing an example page.
class _DemoItem {
  const _DemoItem({required this.title, required this.builder, this.assetName, this.icon})
    : assert(assetName != null || icon != null, 'An asset or icon is required.');

  final String title;
  final WidgetBuilder builder;
  final String? assetName;
  final IconData? icon;
}

// List of application demos.
final _apps = <_DemoItem>[
  _DemoItem(title: 'Instagram', assetName: 'assets/instagram.png', builder: (_) => const InstagramPage()),
  _DemoItem(title: 'Telegram', assetName: 'assets/telegram.png', builder: (_) => const TelegramPage()),
  _DemoItem(title: 'WhatsApp', assetName: 'assets/whatsapp.png', builder: (_) => const WhatsAppPage()),
  _DemoItem(title: 'Facebook', assetName: 'assets/facebook.png', builder: (_) => const FacebookPage()),
  _DemoItem(title: 'LinkedIn', assetName: 'assets/linkedin.png', builder: (_) => const LinkedInPage()),
  _DemoItem(title: 'YouTube', assetName: 'assets/youtube.png', builder: (_) => const YouTubePage()),
  _DemoItem(title: 'Twitter', assetName: 'assets/twitter.png', builder: (_) => const TwitterPage()),
  _DemoItem(title: 'Threads', assetName: 'assets/threads.png', builder: (_) => const ThreadsPage()),
  _DemoItem(title: 'Pinterest', assetName: 'assets/pinterest.png', builder: (_) => const PinterestPage()),
  _DemoItem(title: 'TikTok', assetName: 'assets/tiktok.png', builder: (_) => const TikTokPage()),
  _DemoItem(title: 'Zoom', assetName: 'assets/zoom.png', builder: (_) => const ZoomPage()),
  _DemoItem(title: 'Slack', assetName: 'assets/slack.png', builder: (_) => const SlackPage()),
  _DemoItem(title: 'Google Maps', assetName: 'assets/google_maps.png', builder: (_) => const GoogleMapsPage()),
  _DemoItem(title: 'Amap', assetName: 'assets/amap.png', builder: (_) => const AmapPage()),
  _DemoItem(title: 'Baidu Maps', assetName: 'assets/baidu_maps.png', builder: (_) => const BaiduMapsPage()),
  _DemoItem(title: '2GIS', assetName: 'assets/2gis.png', builder: (_) => const TwoGisPage()),
  _DemoItem(title: 'Waze', assetName: 'assets/waze.png', builder: (_) => const WazePage()),
  _DemoItem(title: 'Apple Maps', assetName: 'assets/apple_maps.png', builder: (_) => const AppleMapsPage()),
  _DemoItem(title: 'Sygic', assetName: 'assets/sygic.png', builder: (_) => const SygicPage()),
  _DemoItem(title: 'Moovit', assetName: 'assets/moovit.png', builder: (_) => const MoovitPage()),
  _DemoItem(title: 'Neshan', assetName: 'assets/neshan.png', builder: (_) => const NeshanPage()),
  _DemoItem(title: 'Yandex Maps', assetName: 'assets/yandex_maps.png', builder: (_) => const YandexMapsPage()),
];

// List of store demos.
final _stores = <_DemoItem>[
  _DemoItem(title: 'Play Store', assetName: 'assets/google_play.png', builder: (_) => const PlayStorePage()),
  _DemoItem(title: 'iOS App Store', assetName: 'assets/apple.png', builder: (_) => const IOSAppStorePage()),
  _DemoItem(title: 'Mac App Store', assetName: 'assets/apple.png', builder: (_) => const MacAppStorePage()),
  _DemoItem(title: 'Microsoft Store', assetName: 'assets/microsoft.png', builder: (_) => const MicrosoftStorePage()),
  _DemoItem(title: 'Huawei AppGallery', assetName: 'assets/huawei.png', builder: (_) => const HuaweiAppGalleryPage()),
  _DemoItem(title: 'Cafe Bazaar', assetName: 'assets/cafe_bazaar.png', builder: (_) => const CafeBazaarPage()),
  _DemoItem(title: 'Myket', assetName: 'assets/myket.png', builder: (_) => const MyketPage()),
];

// List of real-world use cases.
final _useCases = <_DemoItem>[
  _DemoItem(title: 'Update App', icon: Icons.system_update, builder: (_) => const UpdateAppPage()),
  _DemoItem(title: 'About & Support', icon: Icons.contact_support, builder: (_) => const AboutSupportPage()),
  _DemoItem(title: 'Map Selector', icon: Icons.map, builder: (_) => const MapSelectorPage()),
  _DemoItem(title: 'Rate & Review', icon: Icons.star_rate, builder: (_) => const RateReviewPage()),
  _DemoItem(title: 'Share & Message', icon: Icons.share, builder: (_) => const ShareMessagePage()),
  _DemoItem(title: 'Installed Apps', icon: Icons.install_mobile, builder: (_) => const InstalledAppsPage()),
  _DemoItem(title: 'Meeting & Community', icon: Icons.groups, builder: (_) => const MeetingCommunityPage()),
  _DemoItem(title: 'Promoted App CTA', icon: Icons.campaign, builder: (_) => const PromotedAppPage()),
  _DemoItem(title: 'Fallback Playground', icon: Icons.science, builder: (_) => const FallbackPlaygroundPage()),
];

List<_DemoItem> get _allItems => <_DemoItem>[..._apps, ..._stores, ..._useCases];

/// Displays a list of available deeplink examples.
class HomePage extends StatefulWidget {
  /// Creates the home page.
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _useGrid = true;

  void _toggle() => setState(() => _useGrid = !_useGrid);

  @override
  Widget build(final BuildContext context) => _useGrid ? _buildGridScaffold() : _buildTabScaffold();

  Scaffold _buildGridScaffold() => Scaffold(
    appBar: AppBar(
      title: const Text('DeeplinkX Example'),
      actions: [IconButton(icon: const Icon(Icons.view_week), onPressed: _toggle)],
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(context, 'Apps', _apps),
          const SizedBox(height: 24),
          _buildSection(context, 'Stores', _stores),
          const SizedBox(height: 24),
          _buildSection(context, 'Use Cases', _useCases),
        ],
      ),
    ),
  );

  Widget _buildSection(final BuildContext context, final String title, final List<_DemoItem> items) {
    final crossAxisCount = _calculateCrossAxisCount(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        GridView.count(
          crossAxisCount: crossAxisCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: [for (final item in items) _GridItem(item: item)],
        ),
      ],
    );
  }

  int _calculateCrossAxisCount(final BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200) {
      return 6;
    }
    if (width >= 900) {
      return 5;
    }
    if (width >= 600) {
      return 4;
    }
    return 3;
  }

  Widget _buildTabScaffold() {
    final items = _allItems;
    return DefaultTabController(
      length: items.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('DeeplinkX Example'),
          actions: [IconButton(icon: const Icon(Icons.grid_view), onPressed: _toggle)],
          bottom: TabBar(
            isScrollable: true,
            tabs: [for (final item in items) Tab(icon: _DemoLeading(item: item, size: 24), text: item.title)],
          ),
        ),
        body: TabBarView(children: [for (final item in items) item.builder(context)]),
      ),
    );
  }
}

class _GridItem extends StatelessWidget {
  const _GridItem({required this.item});

  final _DemoItem item;

  @override
  Widget build(final BuildContext context) => Card(
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: item.builder)),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _DemoLeading(item: item, size: 40),
            const SizedBox(height: 8),
            Text(item.title, textAlign: TextAlign.center),
          ],
        ),
      ),
    ),
  );
}

class _DemoLeading extends StatelessWidget {
  const _DemoLeading({required this.item, required this.size});

  final _DemoItem item;
  final double size;

  @override
  Widget build(final BuildContext context) => UseCaseLeading(assetName: item.assetName, icon: item.icon, size: size);
}
