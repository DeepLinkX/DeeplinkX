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

/// Displays a list of available deeplink examples.
class HomePage extends StatelessWidget {
  /// Creates the home page.
  const HomePage({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('DeeplinkX Example')),
    body: ListView(
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text('Apps', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        ListTile(
          title: const Text('Instagram'),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const InstagramPage())),
        ),
        ListTile(
          title: const Text('Telegram'),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TelegramPage())),
        ),
        ListTile(
          title: const Text('WhatsApp'),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WhatsAppPage())),
        ),
        ListTile(
          title: const Text('Facebook'),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FacebookPage())),
        ),
        ListTile(
          title: const Text('LinkedIn'),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LinkedInPage())),
        ),
        ListTile(
          title: const Text('YouTube'),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const YouTubePage())),
        ),
        ListTile(
          title: const Text('Twitter'),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TwitterPage())),
        ),
        ListTile(
          title: const Text('Pinterest'),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PinterestPage())),
        ),
        ListTile(
          title: const Text('TikTok'),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TikTokPage())),
        ),
        ListTile(
          title: const Text('Zoom'),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ZoomPage())),
        ),
        ListTile(
          title: const Text('Slack'),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SlackPage())),
        ),
        ListTile(
          title: const Text('Google Maps'),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const GoogleMapsPage())),
        ),
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text('Stores', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        ListTile(
          title: const Text('Play Store'),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PlayStorePage())),
        ),
        ListTile(
          title: const Text('iOS App Store'),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const IOSAppStorePage())),
        ),
        ListTile(
          title: const Text('Mac App Store'),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MacAppStorePage())),
        ),
        ListTile(
          title: const Text('Microsoft Store'),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MicrosoftStorePage())),
        ),
        ListTile(
          title: const Text('Huawei AppGallery'),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HuaweiAppGalleryPage())),
        ),
        ListTile(
          title: const Text('Cafe Bazaar'),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CafeBazaarPage())),
        ),
        ListTile(
          title: const Text('Myket'),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MyketPage())),
        ),
      ],
    ),
  );
}
