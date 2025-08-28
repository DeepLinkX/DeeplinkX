import 'package:deeplink_x_example/pages/cafe_bazaar_page.dart';
import 'package:deeplink_x_example/pages/facebook_page.dart';
import 'package:deeplink_x_example/pages/google_maps_page.dart';
import 'package:deeplink_x_example/pages/huawei_app_gallery_page.dart';
import 'package:deeplink_x_example/pages/instagram_page.dart';
import 'package:deeplink_x_example/pages/ios_app_store_page.dart';
import 'package:deeplink_x_example/pages/linkedin_page.dart';
import 'package:deeplink_x_example/pages/mac_app_store_page.dart';
import 'package:deeplink_x_example/pages/microsoft_store_page.dart';
import 'package:deeplink_x_example/pages/myket_page.dart';
import 'package:deeplink_x_example/pages/pinterest_page.dart';
import 'package:deeplink_x_example/pages/play_store_page.dart';
import 'package:deeplink_x_example/pages/slack_page.dart';
import 'package:deeplink_x_example/pages/telegram_page.dart';
import 'package:deeplink_x_example/pages/tiktok_page.dart';
import 'package:deeplink_x_example/pages/twitter_page.dart';
import 'package:deeplink_x_example/pages/whatsapp_page.dart';
import 'package:deeplink_x_example/pages/youtube_page.dart';
import 'package:deeplink_x_example/pages/zoom_page.dart';
import 'package:flutter/material.dart';

/// Simple model describing an example page.
class _DemoItem {
  const _DemoItem({required this.title, required this.logoUrl, required this.builder});

  final String title;
  final String logoUrl;
  final WidgetBuilder builder;
}

// List of application demos.
final _apps = <_DemoItem>[
  _DemoItem(
    title: 'Instagram',
    logoUrl: 'https://www.google.com/s2/favicons?sz=64&domain_url=instagram.com',
    builder: (_) => const InstagramPage(),
  ),
  _DemoItem(
    title: 'Telegram',
    logoUrl: 'https://www.google.com/s2/favicons?sz=64&domain_url=telegram.org',
    builder: (_) => const TelegramPage(),
  ),
  _DemoItem(
    title: 'WhatsApp',
    logoUrl: 'https://www.google.com/s2/favicons?sz=64&domain_url=whatsapp.com',
    builder: (_) => const WhatsAppPage(),
  ),
  _DemoItem(
    title: 'Facebook',
    logoUrl: 'https://www.google.com/s2/favicons?sz=64&domain_url=facebook.com',
    builder: (_) => const FacebookPage(),
  ),
  _DemoItem(
    title: 'LinkedIn',
    logoUrl: 'https://www.google.com/s2/favicons?sz=64&domain_url=linkedin.com',
    builder: (_) => const LinkedInPage(),
  ),
  _DemoItem(
    title: 'YouTube',
    logoUrl: 'https://www.google.com/s2/favicons?sz=64&domain_url=youtube.com',
    builder: (_) => const YouTubePage(),
  ),
  _DemoItem(
    title: 'Twitter',
    logoUrl: 'https://www.google.com/s2/favicons?sz=64&domain_url=twitter.com',
    builder: (_) => const TwitterPage(),
  ),
  _DemoItem(
    title: 'Pinterest',
    logoUrl: 'https://www.google.com/s2/favicons?sz=64&domain_url=pinterest.com',
    builder: (_) => const PinterestPage(),
  ),
  _DemoItem(
    title: 'TikTok',
    logoUrl: 'https://www.google.com/s2/favicons?sz=64&domain_url=tiktok.com',
    builder: (_) => const TikTokPage(),
  ),
  _DemoItem(
    title: 'Zoom',
    logoUrl: 'https://www.google.com/s2/favicons?sz=64&domain_url=zoom.us',
    builder: (_) => const ZoomPage(),
  ),
  _DemoItem(
    title: 'Slack',
    logoUrl: 'https://www.google.com/s2/favicons?sz=64&domain_url=slack.com',
    builder: (_) => const SlackPage(),
  ),
  _DemoItem(
    title: 'Google Maps',
    logoUrl: 'https://www.google.com/s2/favicons?sz=64&domain_url=maps.google.com',
    builder: (_) => const GoogleMapsPage(),
  ),
];

// List of store demos.
final _stores = <_DemoItem>[
  _DemoItem(
    title: 'Play Store',
    logoUrl: 'https://www.google.com/s2/favicons?sz=64&domain_url=play.google.com',
    builder: (_) => const PlayStorePage(),
  ),
  _DemoItem(
    title: 'iOS App Store',
    logoUrl: 'https://www.google.com/s2/favicons?sz=64&domain_url=apple.com',
    builder: (_) => const IOSAppStorePage(),
  ),
  _DemoItem(
    title: 'Mac App Store',
    logoUrl: 'https://www.google.com/s2/favicons?sz=64&domain_url=apple.com',
    builder: (_) => const MacAppStorePage(),
  ),
  _DemoItem(
    title: 'Microsoft Store',
    logoUrl: 'https://www.google.com/s2/favicons?sz=64&domain_url=microsoft.com',
    builder: (_) => const MicrosoftStorePage(),
  ),
  _DemoItem(
    title: 'Huawei AppGallery',
    logoUrl: 'https://www.google.com/s2/favicons?sz=64&domain_url=huawei.com',
    builder: (_) => const HuaweiAppGalleryPage(),
  ),
  _DemoItem(
    title: 'Cafe Bazaar',
    logoUrl: 'https://www.google.com/s2/favicons?sz=64&domain_url=cafebazaar.ir',
    builder: (_) => const CafeBazaarPage(),
  ),
  _DemoItem(
    title: 'Myket',
    logoUrl: 'https://www.google.com/s2/favicons?sz=64&domain_url=myket.ir',
    builder: (_) => const MyketPage(),
  ),
];

List<_DemoItem> get _allItems => <_DemoItem>[..._apps, ..._stores];

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
          childAspectRatio: 1,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: [for (final item in items) _GridItem(item: item)],
        ),
      ],
    );
  }

  int _calculateCrossAxisCount(final BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200) return 6;
    if (width >= 900) return 5;
    if (width >= 600) return 4;
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
            tabs: [for (final item in items) Tab(icon: _Logo(url: item.logoUrl), text: item.title)],
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
            _Logo(url: item.logoUrl, size: 40),
            const SizedBox(height: 8),
            Text(item.title, textAlign: TextAlign.center),
          ],
        ),
      ),
    ),
  );
}

class _Logo extends StatelessWidget {
  const _Logo({required this.url, this.size = 24});

  final String url;
  final double size;

  @override
  Widget build(final BuildContext context) => Image.network(
    url,
    height: size,
    width: size,
    errorBuilder: (final context, final error, final stackTrace) => Icon(Icons.broken_image, size: size),
  );
}
