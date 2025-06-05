import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Main entry point for the application.
void main() {
  runApp(const MyApp());
}

/// Main application widget that demonstrates various DeeplinkX features.
///
/// This example app demonstrates different deeplink actions for various
/// popular apps and app stores across multiple platforms.
class MyApp extends StatefulWidget {
  /// Creates a new instance of [MyApp].
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _deeplinkX = DeeplinkX();
  final _messageController = TextEditingController(text: 'Hello! How are you?');
  final _usernameController = TextEditingController(text: 'johndoe');
  final _phoneController = TextEditingController(text: '+14155552671');
  final _whatsappPhoneController = TextEditingController(text: '14155552671'); // WhatsApp phone number without '+' sign
  final _appIdController = TextEditingController(text: '389801252'); // Example: Instagram app ID
  final _appNameController = TextEditingController(text: 'instagram'); // Example: Instagram app name
  final _macAppIdController = TextEditingController(text: '497799835'); // Example: Xcode app ID
  final _macAppNameController = TextEditingController(text: 'xcode'); // Example: Xcode app name
  final _countryController = TextEditingController(text: 'us'); // Example: US country code
  final _msProductIdController = TextEditingController(text: '9WZDNCRFHVJL'); // Example: Microsoft Edge product ID
  final _msLanguageController = TextEditingController(text: 'en-US'); // Example: Language code
  final _huaweiAppIdController = TextEditingController(text: 'C101184875');
  final _huaweiPackageNameController = TextEditingController(text: 'org.telegram.messenger');
  final _huaweiReferrerController = TextEditingController(text: 'utm_source=deeplink_x_example');
  final _huaweiLocaleController = TextEditingController(text: 'en_US');

  // Cafe Bazaar controllers
  final _cafeBazaarPackageNameController = TextEditingController(text: 'org.telegram.messenger');
  final _cafeBazaarReferrerController = TextEditingController(text: 'utm_source=deeplink_x_example');

  // Myket controllers
  final _myketPackageNameController = TextEditingController(text: 'org.telegram.messenger');
  final _myketReferrerController = TextEditingController(text: 'utm_source=deeplink_x_example');

  // Play Store controllers
  final _playStorePackageNameController = TextEditingController(text: 'com.instagram.android');
  final _playStoreReferrerController = TextEditingController(text: 'utm_source=deeplink_x_example');
  final _playStoreLanguageController = TextEditingController(text: 'en');

  // LinkedIn controllers
  final _linkedInProfileController = TextEditingController(text: 'john-doe');
  final _linkedInCompanyController = TextEditingController(text: 'example-company');
  final _linkedInJobsKeywordsController = TextEditingController(text: 'software developer');
  final _linkedInShareController = TextEditingController(text: 'Check out this awesome content!');

  // Facebook controllers
  final _facebookIdController = TextEditingController(text: '123456789'); // Example: Facebook user ID
  final _facebookUsernameController = TextEditingController(text: 'johndoe'); // Example: Facebook username
  final _facebookPageIdController = TextEditingController(text: 'examplepage'); // Example: Facebook page ID
  final _facebookGroupIdController = TextEditingController(text: '869653691215417'); // Example: Facebook group ID
  final _facebookEventIdController = TextEditingController(text: '1599696570680586'); // Example: Facebook event ID

  // YouTube controllers
  final _youtubeVideoIdController = TextEditingController(text: 'dQw4w9WgXcQ'); // Example: YouTube video ID
  final _youtubeChannelIdController = TextEditingController(
    text: 'UCq-Fj5jknLsUf-MWSy4_brA',
  ); // Example: YouTube channel ID
  final _youtubePlaylistIdController = TextEditingController(
    text: 'PLFgquLnL59alCl_2TQvOiD5Vgm1hCaGSI',
  ); // Example: YouTube playlist ID
  final _youtubeSearchQueryController = TextEditingController(
    text: 'flutter tutorial',
  ); // Example: YouTube search query

  // Twitter controllers
  final _twitterUsernameController = TextEditingController(text: 'twitter'); // Example: Twitter username
  final _twitterTweetIdController = TextEditingController(text: '1234567890'); // Example: Twitter tweet ID
  final _twitterSearchQueryController = TextEditingController(
    text: 'flutter tutorial',
  ); // Example: Twitter search query

  // Pinterest controllers
  final _pinterestUsernameController = TextEditingController(text: 'pinterest'); // Example: Pinterest username
  final _pinterestPinIdController = TextEditingController(text: '1120622319784769688'); // Example: Pinterest pin ID
  final _pinterestSearchQueryController = TextEditingController(
    text: 'flutter tutorial',
  ); // Example: Pinterest search query
  final _pinterestBoardUsernameController = TextEditingController(
    text: 'inarikaiyo',
  ); // Example: inarikaiyo username for board
  final _pinterestBoardController = TextEditingController(text: 'anime-couple'); // Example: inarikaiyo board

  // TikTok controllers
  final _tiktokUsernameController = TextEditingController(text: 'tiktok'); // Example: TikTok username
  final _tiktokVideoIdController = TextEditingController(text: '7511774168241704222'); // Example: TikTok video ID
  final _tiktokTagController = TextEditingController(text: 'flutter'); // Example: TikTok tag

  // Zoom controllers
  final _zoomMeetingIdController = TextEditingController(text: '123456789');
  final _zoomPasswordController = TextEditingController(text: 'abc123');

  // FallBackToStore flags
  bool _instagramFallBackToStore = true;
  bool _telegramFallBackToStore = true;
  bool _whatsappFallBackToStore = true;
  bool _linkedInFallBackToStore = true;
  bool _facebookFallBackToStore = true;
  bool _youtubeFallBackToStore = true;
  bool _twitterFallBackToStore = true;
  bool _pinterestFallBackToStore = true;
  bool _tiktokFallBackToStore = true;
  bool _zoomFallBackToStore = true;

  @override
  void dispose() {
    _messageController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _whatsappPhoneController.dispose();
    _appIdController.dispose();
    _appNameController.dispose();
    _macAppIdController.dispose();
    _macAppNameController.dispose();
    _countryController.dispose();
    _msProductIdController.dispose();
    _msLanguageController.dispose();
    _huaweiAppIdController.dispose();
    _huaweiPackageNameController.dispose();
    _huaweiReferrerController.dispose();
    _huaweiLocaleController.dispose();
    _cafeBazaarPackageNameController.dispose();
    _cafeBazaarReferrerController.dispose();
    _myketPackageNameController.dispose();
    _myketReferrerController.dispose();
    _playStorePackageNameController.dispose();
    _playStoreReferrerController.dispose();
    _playStoreLanguageController.dispose();
    _linkedInProfileController.dispose();
    _linkedInCompanyController.dispose();
    _linkedInJobsKeywordsController.dispose();
    _linkedInShareController.dispose();
    _facebookIdController.dispose();
    _facebookUsernameController.dispose();
    _facebookPageIdController.dispose();
    _facebookGroupIdController.dispose();
    _facebookEventIdController.dispose();
    _youtubeVideoIdController.dispose();
    _youtubeChannelIdController.dispose();
    _youtubePlaylistIdController.dispose();
    _youtubeSearchQueryController.dispose();
    _twitterUsernameController.dispose();
    _twitterTweetIdController.dispose();
    _twitterSearchQueryController.dispose();
    _pinterestUsernameController.dispose();
    _pinterestPinIdController.dispose();
    _pinterestSearchQueryController.dispose();
    _pinterestBoardUsernameController.dispose();
    _pinterestBoardController.dispose();
    _tiktokUsernameController.dispose();
    _tiktokVideoIdController.dispose();
    _tiktokTagController.dispose();
    _zoomMeetingIdController.dispose();
    _zoomPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => MaterialApp(
    theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
    home: DefaultTabController(
      length: 17,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('DeeplinkX Example'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Instagram'),
              Tab(text: 'Telegram'),
              Tab(text: 'WhatsApp'),
              Tab(text: 'LinkedIn'),
              Tab(text: 'Facebook'),
              Tab(text: 'YouTube'),
              Tab(text: 'Twitter'),
              Tab(text: 'Pinterest'),
              Tab(text: 'TikTok'),
              Tab(text: 'Zoom'),
              Tab(text: 'iOS App Store'),
              Tab(text: 'Play Store'),
              Tab(text: 'Mac App Store'),
              Tab(text: 'Microsoft Store'),
              Tab(text: 'Huawei AppGallery'),
              Tab(text: 'Cafe Bazaar'),
              Tab(text: 'Myket'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildInstagramTab(),
            _buildTelegramTab(),
            _buildWhatsAppTab(),
            _buildLinkedInTab(),
            _buildFacebookTab(),
            _buildYouTubeTab(),
            _buildTwitterTab(),
            _buildPinterestTab(),
            _buildTikTokTab(),
            _buildZoomTab(),
            _buildAppStoreTab(),
            _buildPlayStoreTab(),
            _buildMacAppStoreTab(),
            _buildMicrosoftStoreTab(),
            _buildHuaweiAppGalleryTab(),
            _buildCafeBazaarTab(),
            _buildMyketTab(),
          ],
        ),
      ),
    ),
  );

  Widget _buildInstagramTab() => SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Text('Fallback to App Store:', style: TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Switch(
              value: _instagramFallBackToStore,
              onChanged: (final value) => setState(() => _instagramFallBackToStore = value),
            ),
            const Expanded(
              child: Text(
                'When enabled, redirects to app store if Instagram is not installed',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text('Instagram Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        _buildInstagramActions(),
      ],
    ),
  );

  Widget _buildTelegramTab() => SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Text('Fallback to App Store:', style: TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Switch(
              value: _telegramFallBackToStore,
              onChanged: (final value) => setState(() => _telegramFallBackToStore = value),
            ),
            const Expanded(
              child: Text(
                'When enabled, redirects to app store if Telegram is not installed',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text('Telegram Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        _buildTelegramActions(),
      ],
    ),
  );

  Widget _buildWhatsAppTab() => SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Text('Fallback to App Store:', style: TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Switch(
              value: _whatsappFallBackToStore,
              onChanged: (final value) => setState(() => _whatsappFallBackToStore = value),
            ),
            const Expanded(
              child: Text(
                'When enabled, redirects to app store if WhatsApp is not installed',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text('WhatsApp Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        _buildWhatsAppActions(),
      ],
    ),
  );

  Widget _buildFacebookTab() => SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Text('Fallback to App Store:', style: TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Switch(
              value: _facebookFallBackToStore,
              onChanged: (final value) => setState(() => _facebookFallBackToStore = value),
            ),
            const Expanded(
              child: Text(
                'When enabled, redirects to app store if Facebook is not installed',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text('Facebook Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        _buildFacebookActions(),
      ],
    ),
  );

  Widget _buildFacebookActions() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      ElevatedButton(
        onPressed: () async {
          await _deeplinkX.launchApp(Facebook.open(fallbackToStore: _facebookFallBackToStore));
        },
        child: const Text('Open Facebook App'),
      ),
      const SizedBox(height: 16),
      const Text('Profile Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        controller: _facebookIdController,
        decoration: const InputDecoration(
          labelText: 'Facebook ID',
          hintText: 'Enter Facebook numeric ID',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_facebookIdController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              Facebook.openProfileById(id: _facebookIdController.text, fallbackToStore: _facebookFallBackToStore),
            );
          }
        },
        child: const Text('Open Facebook Profile by ID'),
      ),
      const SizedBox(height: 16),
      TextField(
        controller: _facebookUsernameController,
        decoration: const InputDecoration(
          labelText: 'Facebook Username',
          hintText: 'Enter Facebook username',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_facebookUsernameController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              Facebook.openProfileByUsername(
                username: _facebookUsernameController.text,
                fallbackToStore: _facebookFallBackToStore,
              ),
            );
          }
        },
        child: const Text('Open Facebook Profile by Username'),
      ),
      const SizedBox(height: 16),
      const Text('Page Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        controller: _facebookPageIdController,
        decoration: const InputDecoration(
          labelText: 'Facebook Page ID',
          hintText: 'Enter Facebook page ID',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_facebookPageIdController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              Facebook.openPage(pageId: _facebookPageIdController.text, fallbackToStore: _facebookFallBackToStore),
            );
          }
        },
        child: const Text('Open Facebook Page'),
      ),
      const SizedBox(height: 16),
      const Text('Group Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        controller: _facebookGroupIdController,
        decoration: const InputDecoration(
          labelText: 'Facebook Group ID',
          hintText: 'Enter Facebook group ID',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_facebookGroupIdController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              Facebook.openGroup(groupId: _facebookGroupIdController.text, fallbackToStore: _facebookFallBackToStore),
            );
          }
        },
        child: const Text('Open Facebook Group'),
      ),
      const SizedBox(height: 16),
      const Text('Event Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        controller: _facebookEventIdController,
        decoration: const InputDecoration(
          labelText: 'Facebook Event ID',
          hintText: 'Enter Facebook event ID',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_facebookEventIdController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              Facebook.openEvent(eventId: _facebookEventIdController.text, fallbackToStore: _facebookFallBackToStore),
            );
          }
        },
        child: const Text('Open Facebook Event'),
      ),
    ],
  );

  Widget _buildLinkedInTab() => SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Text('Fallback to App Store:', style: TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Switch(
              value: _linkedInFallBackToStore,
              onChanged: (final value) => setState(() => _linkedInFallBackToStore = value),
            ),
            const Expanded(
              child: Text(
                'When enabled, redirects to app store if LinkedIn is not installed',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text('LinkedIn Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        _buildLinkedInActions(
          _linkedInProfileController,
          _linkedInCompanyController,
          _linkedInJobsKeywordsController,
          _linkedInShareController,
          _linkedInFallBackToStore,
        ),
      ],
    ),
  );

  Widget _buildLinkedInActions(
    final TextEditingController profileController,
    final TextEditingController companyController,
    final TextEditingController jobsKeywordsController,
    final TextEditingController shareController,
    final bool fallbackToStore,
  ) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      ElevatedButton(
        onPressed: () async {
          await _deeplinkX.launchApp(LinkedIn.open(fallbackToStore: _linkedInFallBackToStore));
        },
        child: const Text('Open LinkedIn App'),
      ),
      const SizedBox(height: 16),
      const Text('Profile Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        controller: profileController,
        decoration: const InputDecoration(
          labelText: 'LinkedIn Profile ID',
          hintText: 'Enter LinkedIn profile ID',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (profileController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              LinkedIn.openProfile(profileId: profileController.text, fallbackToStore: fallbackToStore),
            );
          }
        },
        child: const Text('Open LinkedIn Profile'),
      ),
      const SizedBox(height: 16),
      const Text('Company Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        controller: companyController,
        decoration: const InputDecoration(
          labelText: 'LinkedIn Company ID',
          hintText: 'Enter LinkedIn company ID',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (companyController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              LinkedIn.openCompany(companyId: companyController.text, fallbackToStore: fallbackToStore),
            );
          }
        },
        child: const Text('Open LinkedIn Company'),
      ),
      const SizedBox(height: 16),
    ],
  );

  Widget _buildWhatsAppActions() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      ElevatedButton(
        onPressed: () async {
          await _deeplinkX.launchApp(WhatsApp.open(fallbackToStore: _whatsappFallBackToStore));
        },
        child: const Text('Open WhatsApp App'),
      ),
      const SizedBox(height: 16),
      const Text('Chat Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        controller: _whatsappPhoneController,
        decoration: const InputDecoration(
          labelText: 'Phone Number',
          hintText: 'Enter phone number without + (e.g., 14155552671)',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.phone,
      ),
      const SizedBox(height: 8),
      TextField(
        controller: _messageController,
        decoration: const InputDecoration(
          labelText: 'Message (optional)',
          hintText: 'Enter message to pre-fill',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_whatsappPhoneController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              WhatsApp.chat(
                phoneNumber: _whatsappPhoneController.text,
                message: _messageController.text.isNotEmpty ? _messageController.text : null,
                fallbackToStore: _whatsappFallBackToStore,
              ),
            );
          }
        },
        child: const Text('Open WhatsApp Chat'),
      ),
      const SizedBox(height: 16),
      const Text('Share Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        controller: _messageController,
        decoration: const InputDecoration(
          labelText: 'Text to Share',
          hintText: 'Enter text to share via WhatsApp',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_messageController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              WhatsApp.shareText(text: _messageController.text, fallbackToStore: _whatsappFallBackToStore),
            );
          }
        },
        child: const Text('Share via WhatsApp'),
      ),
    ],
  );

  Widget _buildInstagramActions() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      ElevatedButton(
        onPressed: () async {
          await _deeplinkX.launchApp(Instagram.open(fallbackToStore: _instagramFallBackToStore));
        },
        child: const Text('Open Instagram App'),
      ),
      const SizedBox(height: 8),
      TextField(
        controller: _usernameController,
        decoration: const InputDecoration(
          labelText: 'Instagram Username',
          hintText: 'Enter Instagram username',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_usernameController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              Instagram.openProfile(username: _usernameController.text, fallbackToStore: _instagramFallBackToStore),
            );
          }
        },
        child: const Text('Open Instagram Profile'),
      ),
    ],
  );

  Widget _buildTelegramActions() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      ElevatedButton(
        onPressed: () async {
          await _deeplinkX.launchApp(Telegram.open(fallbackToStore: _telegramFallBackToStore));
        },
        child: const Text('Open Telegram App'),
      ),
      const SizedBox(height: 16),
      const Text('Profile Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        controller: _usernameController,
        decoration: const InputDecoration(
          labelText: 'Telegram Username',
          hintText: 'Enter Telegram username',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_usernameController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              Telegram.openProfile(username: _usernameController.text, fallbackToStore: _telegramFallBackToStore),
            );
          }
        },
        child: const Text('Open Telegram Profile'),
      ),
      const SizedBox(height: 16),
      TextField(
        controller: _phoneController,
        decoration: const InputDecoration(
          labelText: 'Phone Number',
          hintText: 'Enter phone number without + (e.g., 14155552671)',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.phone,
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_phoneController.text.isNotEmpty) {
            String phoneNumber = _phoneController.text;
            // Remove + if it exists
            if (phoneNumber.startsWith('+')) {
              phoneNumber = phoneNumber.substring(1);
            }
            await _deeplinkX.launchAction(
              Telegram.openProfileByPhoneNumber(phoneNumber: phoneNumber, fallbackToStore: _telegramFallBackToStore),
            );
          }
        },
        child: const Text('Open Telegram Profile by Phone'),
      ),
      const SizedBox(height: 16),
      const Text('Message Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        controller: _usernameController,
        decoration: const InputDecoration(
          labelText: 'Telegram Username',
          hintText: 'Enter Telegram username',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      TextField(
        controller: _messageController,
        decoration: const InputDecoration(
          labelText: 'Message',
          hintText: 'Enter message to send',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_usernameController.text.isNotEmpty && _messageController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              Telegram.sendMessage(
                username: _usernameController.text,
                message: _messageController.text,
                fallbackToStore: _telegramFallBackToStore,
              ),
            );
          }
        },
        child: const Text('Send Message by Username'),
      ),
      const SizedBox(height: 16),
      TextField(
        controller: _phoneController,
        decoration: const InputDecoration(
          labelText: 'Phone Number',
          hintText: 'Enter phone number without + (e.g., 14155552671)',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.phone,
      ),
      const SizedBox(height: 8),
      TextField(
        controller: _messageController,
        decoration: const InputDecoration(
          labelText: 'Message',
          hintText: 'Enter message to send',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_phoneController.text.isNotEmpty && _messageController.text.isNotEmpty) {
            String phoneNumber = _phoneController.text;
            // Remove + if it exists
            if (phoneNumber.startsWith('+')) {
              phoneNumber = phoneNumber.substring(1);
            }
            await _deeplinkX.launchAction(
              Telegram.sendMessageByPhoneNumber(
                phoneNumber: phoneNumber,
                message: _messageController.text,
                fallbackToStore: _telegramFallBackToStore,
              ),
            );
          }
        },
        child: const Text('Send Message by Phone Number'),
      ),
    ],
  );

  Widget _buildPlayStoreTab() => SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Play Store Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        _buildPlayStoreActions(),
      ],
    ),
  );

  Widget _buildPlayStoreActions() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      ElevatedButton(
        onPressed: () async {
          await _deeplinkX.launchApp(PlayStore.open());
        },
        child: const Text('Open Play Store'),
      ),
      const SizedBox(height: 16),
      const Text('App Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        controller: _playStorePackageNameController,
        decoration: const InputDecoration(
          labelText: 'Package Name',
          hintText: 'Enter Package Name (e.g., com.instagram.android)',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      TextField(
        controller: _playStoreReferrerController,
        decoration: const InputDecoration(
          labelText: 'Referrer (optional)',
          hintText: 'Enter referrer for tracking (e.g., utm_source=your_app)',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      TextField(
        controller: _playStoreLanguageController,
        decoration: const InputDecoration(
          labelText: 'Language Code (optional)',
          hintText: 'Enter language code (e.g., en, fr, de)',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_playStorePackageNameController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              PlayStore.openAppPage(
                packageName: _playStorePackageNameController.text,
                referrer: _playStoreReferrerController.text.isNotEmpty ? _playStoreReferrerController.text : null,
                language: _playStoreLanguageController.text.isNotEmpty ? _playStoreLanguageController.text : null,
              ),
            );
          }
        },
        child: const Text('Open App Page'),
      ),
    ],
  );

  Widget _buildAppStoreTab() => SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('iOS App Store Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        _buildAppStoreActions(),
      ],
    ),
  );

  Widget _buildAppStoreActions() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      ElevatedButton(
        onPressed: () async {
          await _deeplinkX.launchApp(IOSAppStore.open());
        },
        child: const Text('Open App Store'),
      ),
      const SizedBox(height: 16),
      const Text('App Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        controller: _appIdController,
        decoration: const InputDecoration(
          labelText: 'App ID',
          hintText: 'Enter App ID (e.g., 389801252 for Instagram)',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
      ),
      const SizedBox(height: 8),
      TextField(
        controller: _appNameController,
        decoration: const InputDecoration(
          labelText: 'App Name',
          hintText: 'Enter App Name (e.g., instagram)',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_appIdController.text.isNotEmpty && _appNameController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              IOSAppStore.openAppPage(appId: _appIdController.text, appName: _appNameController.text),
            );
          }
        },
        child: const Text('Open App Page'),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_appIdController.text.isNotEmpty && _appNameController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              IOSAppStore.rateApp(appId: _appIdController.text, appName: _appNameController.text),
            );
          }
        },
        child: const Text('Open App Review Page'),
      ),
    ],
  );

  Widget _buildMacAppStoreTab() => SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Mac App Store Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        _buildMacAppStoreActions(),
      ],
    ),
  );

  Widget _buildMacAppStoreActions() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      ElevatedButton(
        onPressed: () async {
          await _deeplinkX.launchApp(MacAppStore.open());
        },
        child: const Text('Open Mac App Store'),
      ),
      const SizedBox(height: 16),
      const Text('App Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        controller: _macAppIdController,
        decoration: const InputDecoration(
          labelText: 'App ID',
          hintText: 'Enter App ID (e.g., 497799835 for Xcode)',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
      ),
      const SizedBox(height: 8),
      TextField(
        controller: _macAppNameController,
        decoration: const InputDecoration(
          labelText: 'App Name',
          hintText: 'Enter App Name (e.g., xcode)',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      TextField(
        controller: _countryController,
        decoration: const InputDecoration(
          labelText: 'Country Code (optional)',
          hintText: 'Enter two-letter country code (e.g., us, uk)',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_macAppIdController.text.isNotEmpty && _macAppNameController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              MacAppStore.openAppPage(
                appId: _macAppIdController.text,
                appName: _macAppNameController.text,
                country: _countryController.text.isNotEmpty ? _countryController.text : null,
              ),
            );
          }
        },
        child: const Text('Open App Page'),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_macAppIdController.text.isNotEmpty && _macAppNameController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              MacAppStore.rateApp(
                appId: _macAppIdController.text,
                appName: _macAppNameController.text,
                country: _countryController.text.isNotEmpty ? _countryController.text : null,
              ),
            );
          }
        },
        child: const Text('Open App Review Page'),
      ),
    ],
  );

  Widget _buildMicrosoftStoreTab() => SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Microsoft Store Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        _buildMicrosoftStoreActions(),
      ],
    ),
  );

  Widget _buildMicrosoftStoreActions() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      ElevatedButton(
        onPressed: () async {
          await _deeplinkX.launchApp(MicrosoftStore.open());
        },
        child: const Text('Open Microsoft Store'),
      ),
      const SizedBox(height: 16),
      const Text('App Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        controller: _msProductIdController,
        decoration: const InputDecoration(
          labelText: 'Product ID',
          hintText: 'Enter Product ID (e.g., 9WZDNCRFHVJL for Microsoft Edge)',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      TextField(
        controller: _msLanguageController,
        decoration: const InputDecoration(
          labelText: 'Language Code (optional)',
          hintText: 'Enter language code (e.g., en-US)',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_msProductIdController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              MicrosoftStore.openAppPage(
                productId: _msProductIdController.text,
                language: _msLanguageController.text.isNotEmpty ? _msLanguageController.text : null,
              ),
            );
          }
        },
        child: const Text('Open App Page'),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_msProductIdController.text.isNotEmpty) {
            await _deeplinkX.launchAction(MicrosoftStore.rateApp(productId: _msProductIdController.text));
          }
        },
        child: const Text('Open App Review Page'),
      ),
    ],
  );

  Widget _buildHuaweiAppGalleryTab() => SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Huawei AppGallery Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        _buildHuaweiAppGalleryActions(),
      ],
    ),
  );

  Widget _buildHuaweiAppGalleryActions() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      ElevatedButton(
        onPressed: () async {
          await _deeplinkX.launchApp(HuaweiAppGalleryStore.open());
        },
        child: const Text('Open Huawei AppGallery'),
      ),
      const SizedBox(height: 16),
      const Text('App Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        controller: _huaweiAppIdController,
        decoration: const InputDecoration(
          labelText: 'App ID',
          hintText: 'Enter App ID (e.g., C100000000)',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      TextField(
        controller: _huaweiPackageNameController,
        decoration: const InputDecoration(
          labelText: 'Package Name',
          hintText: 'Enter Package Name (e.g., org.telegram.messenger)',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      TextField(
        controller: _huaweiReferrerController,
        decoration: const InputDecoration(
          labelText: 'Referrer (optional)',
          hintText: 'Enter referrer for tracking (e.g., utm_source=your_app)',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      TextField(
        controller: _huaweiLocaleController,
        decoration: const InputDecoration(
          labelText: 'Locale (optional)',
          hintText: 'Enter locale (e.g., en_US, zh_CN)',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_huaweiAppIdController.text.isNotEmpty && _huaweiPackageNameController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              HuaweiAppGalleryStore.openAppPage(
                appId: _huaweiAppIdController.text,
                packageName: _huaweiPackageNameController.text,
                referrer: _huaweiReferrerController.text.isNotEmpty ? _huaweiReferrerController.text : null,
                locale: _huaweiLocaleController.text.isNotEmpty ? _huaweiLocaleController.text : null,
              ),
            );
          }
        },
        child: const Text('Open App Page'),
      ),
    ],
  );

  Widget _buildCafeBazaarTab() => SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Cafe Bazaar Store Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        _buildCafeBazaarActions(),
      ],
    ),
  );

  Widget _buildCafeBazaarActions() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      ElevatedButton(
        onPressed: () async {
          await _deeplinkX.launchApp(CafeBazaarStore.open());
        },
        child: const Text('Open Cafe Bazaar'),
      ),
      const SizedBox(height: 16),
      const Text('App Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        controller: _cafeBazaarPackageNameController,
        decoration: const InputDecoration(
          labelText: 'Package Name',
          hintText: 'Enter Package Name (e.g., org.telegram.messenger)',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      TextField(
        controller: _cafeBazaarReferrerController,
        decoration: const InputDecoration(
          labelText: 'Referrer (optional)',
          hintText: 'Enter referrer for tracking (e.g., utm_source=your_app)',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_cafeBazaarPackageNameController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              CafeBazaarStore.openAppPage(
                packageName: _cafeBazaarPackageNameController.text,
                referrer: _cafeBazaarReferrerController.text.isNotEmpty ? _cafeBazaarReferrerController.text : null,
              ),
            );
          }
        },
        child: const Text('Open App Page'),
      ),
    ],
  );

  Widget _buildMyketTab() => SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Myket Store Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        _buildMyketActions(),
      ],
    ),
  );

  Widget _buildYouTubeTab() => SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Text('Fallback to App Store:', style: TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Switch(
              value: _youtubeFallBackToStore,
              onChanged: (final value) => setState(() => _youtubeFallBackToStore = value),
            ),
            const Expanded(
              child: Text(
                'When enabled, redirects to app store if YouTube is not installed',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text('YouTube Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        _buildYouTubeActions(),
      ],
    ),
  );

  Widget _buildYouTubeActions() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      ElevatedButton(
        onPressed: () async {
          await _deeplinkX.launchApp(YouTube.open(fallbackToStore: _youtubeFallBackToStore));
        },
        child: const Text('Open YouTube App'),
      ),
      const SizedBox(height: 16),
      const Text('Video Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        controller: _youtubeVideoIdController,
        decoration: const InputDecoration(
          labelText: 'Video ID',
          hintText: 'Enter YouTube video ID',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_youtubeVideoIdController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              YouTube.openVideo(videoId: _youtubeVideoIdController.text, fallbackToStore: _youtubeFallBackToStore),
            );
          }
        },
        child: const Text('Open YouTube Video'),
      ),
      const SizedBox(height: 16),
      const Text('Channel Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        controller: _youtubeChannelIdController,
        decoration: const InputDecoration(
          labelText: 'Channel ID',
          hintText: 'Enter YouTube channel ID',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_youtubeChannelIdController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              YouTube.openChannel(
                channelId: _youtubeChannelIdController.text,
                fallbackToStore: _youtubeFallBackToStore,
              ),
            );
          }
        },
        child: const Text('Open YouTube Channel'),
      ),
      const SizedBox(height: 16),
      const Text('Playlist Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        controller: _youtubePlaylistIdController,
        decoration: const InputDecoration(
          labelText: 'Playlist ID',
          hintText: 'Enter YouTube playlist ID',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_youtubePlaylistIdController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              YouTube.openPlaylist(
                playlistId: _youtubePlaylistIdController.text,
                fallbackToStore: _youtubeFallBackToStore,
              ),
            );
          }
        },
        child: const Text('Open YouTube Playlist'),
      ),
      const SizedBox(height: 16),
      const Text('Search Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        controller: _youtubeSearchQueryController,
        decoration: const InputDecoration(
          labelText: 'Search Query',
          hintText: 'Enter search query',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_youtubeSearchQueryController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              YouTube.search(query: _youtubeSearchQueryController.text, fallbackToStore: _youtubeFallBackToStore),
            );
          }
        },
        child: const Text('Search on YouTube'),
      ),
    ],
  );

  Widget _buildMyketActions() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      ElevatedButton(
        onPressed: () async {
          await _deeplinkX.launchApp(MyketStore.open());
        },
        child: const Text('Open Myket'),
      ),
      const SizedBox(height: 16),
      const Text('App Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        controller: _myketPackageNameController,
        decoration: const InputDecoration(
          labelText: 'Package Name',
          hintText: 'Enter Package Name (e.g., org.telegram.messenger)',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      TextField(
        controller: _myketReferrerController,
        decoration: const InputDecoration(
          labelText: 'Referrer (optional)',
          hintText: 'Enter referrer for tracking (e.g., utm_source=your_app)',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_myketPackageNameController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              MyketStore.openAppPage(
                packageName: _myketPackageNameController.text,
                referrer: _myketReferrerController.text.isNotEmpty ? _myketReferrerController.text : null,
              ),
            );
          }
        },
        child: const Text('Open App Page'),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_myketPackageNameController.text.isNotEmpty) {
            await _deeplinkX.launchAction(MyketStore.rateApp(packageName: _myketPackageNameController.text));
          }
        },
        child: const Text('Rate app'),
      ),
    ],
  );

  Widget _buildTwitterTab() => SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Text('Fallback to App Store:', style: TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Switch(
              value: _twitterFallBackToStore,
              onChanged: (final value) => setState(() => _twitterFallBackToStore = value),
            ),
            const Expanded(
              child: Text(
                'When enabled, redirects to app store if Twitter is not installed',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text('Twitter Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        _buildTwitterActions(),
      ],
    ),
  );

  Widget _buildTwitterActions() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      ElevatedButton(
        onPressed: () async {
          await _deeplinkX.launchApp(Twitter.open(fallbackToStore: _twitterFallBackToStore));
        },
        child: const Text('Open Twitter App'),
      ),
      const SizedBox(height: 16),
      const Text('Profile Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        controller: _twitterUsernameController,
        decoration: const InputDecoration(
          labelText: 'Twitter Username',
          hintText: 'Enter Twitter username',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_twitterUsernameController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              Twitter.openProfile(username: _twitterUsernameController.text, fallbackToStore: _twitterFallBackToStore),
            );
          }
        },
        child: const Text('Open Twitter Profile'),
      ),
      const SizedBox(height: 16),
      const Text('Tweet Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        controller: _twitterTweetIdController,
        decoration: const InputDecoration(
          labelText: 'Tweet ID',
          hintText: 'Enter Twitter tweet ID',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_twitterTweetIdController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              Twitter.openTweet(tweetId: _twitterTweetIdController.text, fallbackToStore: _twitterFallBackToStore),
            );
          }
        },
        child: const Text('Open Tweet'),
      ),
      const SizedBox(height: 16),
      const Text('Search Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        controller: _twitterSearchQueryController,
        decoration: const InputDecoration(
          labelText: 'Search Query',
          hintText: 'Enter Twitter search query',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_twitterSearchQueryController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              Twitter.search(query: _twitterSearchQueryController.text, fallbackToStore: _twitterFallBackToStore),
            );
          }
        },
        child: const Text('Search Twitter'),
      ),
    ],
  );

  Widget _buildPinterestTab() => SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Text('Fallback to App Store:', style: TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Switch(
              value: _pinterestFallBackToStore,
              onChanged: (final value) => setState(() => _pinterestFallBackToStore = value),
            ),
            const Expanded(
              child: Text(
                'When enabled, redirects to app store if Pinterest is not installed',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text('Pinterest Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        _buildPinterestActions(),
      ],
    ),
  );

  Widget _buildPinterestActions() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      ElevatedButton(
        onPressed: () async {
          await _deeplinkX.launchApp(Pinterest.open(fallbackToStore: _pinterestFallBackToStore));
        },
        child: const Text('Open Pinterest App'),
      ),
      const SizedBox(height: 16),
      const Text('Profile Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        controller: _pinterestUsernameController,
        decoration: const InputDecoration(
          labelText: 'Pinterest Username',
          hintText: 'Enter Pinterest username',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_pinterestUsernameController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              Pinterest.openProfile(
                username: _pinterestUsernameController.text,
                fallbackToStore: _pinterestFallBackToStore,
              ),
            );
          }
        },
        child: const Text('Open Pinterest Profile'),
      ),
      const SizedBox(height: 16),
      const Text('Pin Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        controller: _pinterestPinIdController,
        decoration: const InputDecoration(
          labelText: 'Pin ID',
          hintText: 'Enter Pinterest pin ID',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_pinterestPinIdController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              Pinterest.openPin(pinId: _pinterestPinIdController.text, fallbackToStore: _pinterestFallBackToStore),
            );
          }
        },
        child: const Text('Open Pin'),
      ),
      const SizedBox(height: 16),
      const Text('Search Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        controller: _pinterestSearchQueryController,
        decoration: const InputDecoration(
          labelText: 'Search Query',
          hintText: 'Enter Pinterest search query',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_pinterestSearchQueryController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              Pinterest.search(query: _pinterestSearchQueryController.text, fallbackToStore: _pinterestFallBackToStore),
            );
          }
        },
        child: const Text('Search Pinterest'),
      ),
      const SizedBox(height: 16),
      const Text('Board Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        controller: _pinterestBoardUsernameController,
        decoration: const InputDecoration(
          labelText: 'Board Owner Username',
          hintText: 'Enter Pinterest username (board owner)',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      TextField(
        controller: _pinterestBoardController,
        decoration: const InputDecoration(
          labelText: 'Board',
          hintText: 'Enter board (lower-case, hyphenated)',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_pinterestBoardUsernameController.text.isNotEmpty && _pinterestBoardController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              Pinterest.openBoard(
                username: _pinterestBoardUsernameController.text,
                board: _pinterestBoardController.text,
                fallbackToStore: _pinterestFallBackToStore,
              ),
            );
          }
        },
        child: const Text('Open Pinterest Board'),
      ),
    ],
  );

  Widget _buildTikTokTab() => SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Text('Fallback to App Store:', style: TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Switch(
              value: _tiktokFallBackToStore,
              onChanged: (final value) => setState(() => _tiktokFallBackToStore = value),
            ),
            const Expanded(
              child: Text(
                'When enabled, redirects to app store if TikTok is not installed',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text('TikTok Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        _buildTikTokActions(),
      ],
    ),
  );

  Widget _buildTikTokActions() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      ElevatedButton(
        onPressed: () async {
          await _deeplinkX.launchApp(TikTok.open(fallbackToStore: _tiktokFallBackToStore));
        },
        child: const Text('Open TikTok App'),
      ),
      const SizedBox(height: 16),
      const Text('Profile Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        controller: _tiktokUsernameController,
        decoration: const InputDecoration(
          labelText: 'TikTok Username',
          hintText: 'Enter TikTok username',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_tiktokUsernameController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              TikTok.openProfile(username: _tiktokUsernameController.text, fallbackToStore: _tiktokFallBackToStore),
            );
          }
        },
        child: const Text('Open TikTok Profile'),
      ),
      const SizedBox(height: 16),
      const Text('Video Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        controller: _tiktokVideoIdController,
        decoration: const InputDecoration(
          labelText: 'Video ID',
          hintText: 'Enter TikTok video ID',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      TextField(
        controller: _tiktokUsernameController,
        decoration: const InputDecoration(
          labelText: 'Username',
          hintText: 'Enter username of video owner',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_tiktokVideoIdController.text.isNotEmpty && _tiktokUsernameController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              TikTok.openVideo(
                videoId: _tiktokVideoIdController.text,
                username: _tiktokUsernameController.text,
                fallbackToStore: _tiktokFallBackToStore,
              ),
            );
          }
        },
        child: const Text('Open Video'),
      ),
      const SizedBox(height: 16),
      const Text('Tag Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        controller: _tiktokTagController,
        decoration: const InputDecoration(
          labelText: 'Tag Name',
          hintText: 'Enter TikTok tag name',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_tiktokTagController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              TikTok.openTag(tagName: _tiktokTagController.text, fallbackToStore: _tiktokFallBackToStore),
            );
          }
        },
        child: const Text('Open Tag'),
      ),
    ],
  );

  Widget _buildZoomTab() => SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Text('Fallback to App Store:', style: TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Switch(
              value: _zoomFallBackToStore,
              onChanged: (final value) => setState(() => _zoomFallBackToStore = value),
            ),
            const Expanded(
              child: Text(
                'When enabled, redirects to app store if Zoom is not installed',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text('Zoom Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        _buildZoomActions(),
      ],
    ),
  );

  Widget _buildZoomActions() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      ElevatedButton(
        onPressed: () async {
          await _deeplinkX.launchApp(Zoom.open(fallbackToStore: _zoomFallBackToStore));
        },
        child: const Text('Open Zoom App'),
      ),
      const SizedBox(height: 16),
      TextField(
        controller: _zoomMeetingIdController,
        decoration: const InputDecoration(
          labelText: 'Meeting ID',
          hintText: 'Enter meeting ID',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      TextField(
        controller: _zoomPasswordController,
        decoration: const InputDecoration(
          labelText: 'Password (optional)',
          hintText: 'Enter meeting password',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_zoomMeetingIdController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              Zoom.joinMeeting(
                meetingId: _zoomMeetingIdController.text,
                password: _zoomPasswordController.text.isNotEmpty ? _zoomPasswordController.text : null,
                fallbackToStore: _zoomFallBackToStore,
              ),
            );
          }
        },
        child: const Text('Join Meeting'),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () async {
          if (_zoomMeetingIdController.text.isNotEmpty) {
            await _deeplinkX.launchAction(
              Zoom.startMeeting(
                meetingId: _zoomMeetingIdController.text,
                password: _zoomPasswordController.text.isNotEmpty ? _zoomPasswordController.text : null,
                fallbackToStore: _zoomFallBackToStore,
              ),
            );
          }
        },
        child: const Text('Start Meeting'),
      ),
    ],
  );
}
