import 'package:flutter/material.dart';
import 'package:deeplink_x/deeplink_x.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _deeplinkX = DeeplinkX();
  final _messageController = TextEditingController(text: 'Hello! How are you?');
  final _usernameController = TextEditingController(text: 'johndoe');
  final _phoneController = TextEditingController(text: '+14155552671');
  final _whatsappPhoneController = TextEditingController(
    text: '14155552671',
  ); // WhatsApp phone number without '+' sign
  final _appIdController = TextEditingController(
    text: '389801252',
  ); // Example: Instagram app ID
  final _appNameController = TextEditingController(
    text: 'instagram',
  ); // Example: Instagram app name
  final _macAppIdController = TextEditingController(
    text: '497799835',
  ); // Example: Xcode app ID
  final _macAppNameController = TextEditingController(
    text: 'xcode',
  ); // Example: Xcode app name
  final _countryController = TextEditingController(
    text: 'us',
  ); // Example: US country code
  final _msProductIdController = TextEditingController(
    text: '9WZDNCRFHVJL',
  ); // Example: Microsoft Edge product ID
  final _msLanguageController = TextEditingController(
    text: 'en-US',
  ); // Example: Language code
  final _huaweiAppIdController = TextEditingController(text: 'C101184875');
  final _huaweiPackageNameController = TextEditingController(
    text: 'org.telegram.messenger',
  );
  final _huaweiReferrerController = TextEditingController(
    text: 'utm_source=deeplink_x_example',
  );
  final _huaweiLocaleController = TextEditingController(text: 'en_US');

  // Cafe Bazaar controllers
  final _cafeBazaarPackageNameController = TextEditingController(
    text: 'org.telegram.messenger',
  );
  final _cafeBazaarReferrerController = TextEditingController(
    text: 'utm_source=deeplink_x_example',
  );

  // Myket controllers
  final _myketPackageNameController = TextEditingController(
    text: 'org.telegram.messenger',
  );
  final _myketReferrerController = TextEditingController(
    text: 'utm_source=deeplink_x_example',
  );

  // FallBackToStore flags
  bool _instagramFallBackToStore = true;
  bool _telegramFallBackToStore = true;
  bool _whatsappFallBackToStore = true;

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: DefaultTabController(
        length: 11,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('DeeplinkX Example'),
            bottom: const TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'Instagram'),
                Tab(text: 'Telegram'),
                Tab(text: 'WhatsApp'),
                Tab(text: 'iOS App Store'),
                Tab(text: 'Play Store'),
                Tab(text: 'Mac App Store'),
                Tab(text: 'Microsoft Store'),
                Tab(text: 'Huawei AppGallery'),
                Tab(text: 'Cafe Bazaar'),
                Tab(text: 'Myket'),
                Tab(text: 'LinkedIn'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildInstagramTab(),
              _buildTelegramTab(),
              _buildWhatsAppTab(),
              _buildAppStoreTab(),
              _buildPlayStoreTab(),
              _buildMacAppStoreTab(),
              _buildMicrosoftStoreTab(),
              _buildHuaweiAppGalleryTab(),
              _buildCafeBazaarTab(),
              _buildMyketTab(),
              _buildLinkedInTab(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInstagramTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Text(
                'Fallback to App Store:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 8),
              Switch(
                value: _instagramFallBackToStore,
                onChanged:
                    (value) =>
                        setState(() => _instagramFallBackToStore = value),
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
          const Text(
            'Instagram Actions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _buildInstagramActions(),
        ],
      ),
    );
  }

  Widget _buildTelegramTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Text(
                'Fallback to App Store:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 8),
              Switch(
                value: _telegramFallBackToStore,
                onChanged:
                    (value) => setState(() => _telegramFallBackToStore = value),
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
          const Text(
            'Telegram Actions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _buildTelegramActions(),
        ],
      ),
    );
  }

  Widget _buildWhatsAppTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Text(
                'Fallback to App Store:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 8),
              Switch(
                value: _whatsappFallBackToStore,
                onChanged:
                    (value) => setState(() => _whatsappFallBackToStore = value),
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
          const Text(
            'WhatsApp Actions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _buildWhatsAppActions(),
        ],
      ),
    );
  }

  Widget _buildLinkedInTab() {
    return const Center(
      child: Text(
        'LinkedIn support coming soon!',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildWhatsAppActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () async {
            await _deeplinkX.launchAction(
              WhatsApp.open(fallBackToStore: _whatsappFallBackToStore),
            );
          },
          child: const Text('Open WhatsApp App'),
        ),
        const SizedBox(height: 16),
        const Text(
          'Chat Actions',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
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
                  _whatsappPhoneController.text,
                  text:
                      _messageController.text.isNotEmpty
                          ? _messageController.text
                          : null,
                  fallBackToStore: _whatsappFallBackToStore,
                ),
              );
            }
          },
          child: const Text('Open WhatsApp Chat'),
        ),
        const SizedBox(height: 16),
        const Text(
          'Share Actions',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
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
                WhatsApp.share(
                  _messageController.text,
                  fallBackToStore: _whatsappFallBackToStore,
                ),
              );
            }
          },
          child: const Text('Share via WhatsApp'),
        ),
      ],
    );
  }

  Widget _buildInstagramActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () async {
            await _deeplinkX.launchAction(
              Instagram.open(fallBackToStore: _instagramFallBackToStore),
            );
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
                Instagram.openProfile(
                  _usernameController.text,
                  fallBackToStore: _instagramFallBackToStore,
                ),
              );
            }
          },
          child: const Text('Open Instagram Profile'),
        ),
      ],
    );
  }

  Widget _buildTelegramActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () async {
            await _deeplinkX.launchAction(
              Telegram.open(fallBackToStore: _telegramFallBackToStore),
            );
          },
          child: const Text('Open Telegram App'),
        ),
        const SizedBox(height: 16),
        const Text(
          'Profile Actions',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
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
                Telegram.openProfile(
                  _usernameController.text,
                  fallBackToStore: _telegramFallBackToStore,
                ),
              );
            }
          },
          child: const Text('Open Telegram Profile'),
        ),
      ],
    );
  }

  Widget _buildPlayStoreTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Play Store Actions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _buildPlayStoreActions(),
        ],
      ),
    );
  }

  Widget _buildPlayStoreActions() {
    // Controller for package name input
    final packageNameController = TextEditingController(
      text: 'com.instagram.android',
    );
    // Controller for referrer input
    final referrerController = TextEditingController(
      text: 'utm_source=deeplink_x_example',
    );
    // Controller for language code input
    final languageController = TextEditingController(text: 'en');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () async {
            await _deeplinkX.launchAction(PlayStore.open);
          },
          child: const Text('Open Play Store'),
        ),
        const SizedBox(height: 16),
        const Text(
          'App Actions',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: packageNameController,
          decoration: const InputDecoration(
            labelText: 'Package Name',
            hintText: 'Enter Package Name (e.g., com.instagram.android)',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: referrerController,
          decoration: const InputDecoration(
            labelText: 'Referrer (optional)',
            hintText: 'Enter referrer for tracking (e.g., utm_source=your_app)',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: languageController,
          decoration: const InputDecoration(
            labelText: 'Language Code (optional)',
            hintText: 'Enter language code (e.g., en, fr, de)',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () async {
            if (packageNameController.text.isNotEmpty) {
              await _deeplinkX.launchAction(
                PlayStore.openAppPage(
                  packageName: packageNameController.text,
                  referrer:
                      referrerController.text.isNotEmpty
                          ? referrerController.text
                          : null,
                  hl:
                      languageController.text.isNotEmpty
                          ? languageController.text
                          : null,
                ),
              );
            }
          },
          child: const Text('Open App Page'),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () async {
            if (packageNameController.text.isNotEmpty) {
              await _deeplinkX.launchAction(
                PlayStore.openAppReviewPage(
                  packageName: packageNameController.text,
                  referrer:
                      referrerController.text.isNotEmpty
                          ? referrerController.text
                          : null,
                  hl:
                      languageController.text.isNotEmpty
                          ? languageController.text
                          : null,
                ),
              );
            }
          },
          child: const Text('Open App Review Page'),
        ),
      ],
    );
  }

  Widget _buildAppStoreTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'iOS App Store Actions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _buildAppStoreActions(),
        ],
      ),
    );
  }

  Widget _buildAppStoreActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () async {
            await _deeplinkX.launchAction(IOSAppStore.open);
          },
          child: const Text('Open App Store'),
        ),
        const SizedBox(height: 16),
        const Text(
          'App Actions',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
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
            if (_appIdController.text.isNotEmpty &&
                _appNameController.text.isNotEmpty) {
              await _deeplinkX.launchAction(
                IOSAppStore.openAppPage(
                  appId: _appIdController.text,
                  appName: _appNameController.text,
                ),
              );
            }
          },
          child: const Text('Open App Page'),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () async {
            if (_appIdController.text.isNotEmpty &&
                _appNameController.text.isNotEmpty) {
              await _deeplinkX.launchAction(
                IOSAppStore.openReview(
                  appId: _appIdController.text,
                  appName: _appNameController.text,
                ),
              );
            }
          },
          child: const Text('Open App Review Page'),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () async {
            if (_appIdController.text.isNotEmpty &&
                _appNameController.text.isNotEmpty) {
              await _deeplinkX.launchAction(
                IOSAppStore.openMessagesExtension(
                  appId: _appIdController.text,
                  appName: _appNameController.text,
                ),
              );
            }
          },
          child: const Text('Open App iMessage Extension'),
        ),
      ],
    );
  }

  Widget _buildMacAppStoreTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Mac App Store Actions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _buildMacAppStoreActions(),
        ],
      ),
    );
  }

  Widget _buildMacAppStoreActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () async {
            await _deeplinkX.launchAction(MacAppStore.open);
          },
          child: const Text('Open Mac App Store'),
        ),
        const SizedBox(height: 16),
        const Text(
          'App Actions',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
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
            if (_macAppIdController.text.isNotEmpty &&
                _macAppNameController.text.isNotEmpty) {
              await _deeplinkX.launchAction(
                MacAppStore.openAppPage(
                  appId: _macAppIdController.text,
                  appName: _macAppNameController.text,
                  country:
                      _countryController.text.isNotEmpty
                          ? _countryController.text
                          : null,
                ),
              );
            }
          },
          child: const Text('Open App Page'),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () async {
            if (_macAppIdController.text.isNotEmpty &&
                _macAppNameController.text.isNotEmpty) {
              await _deeplinkX.launchAction(
                MacAppStore.openReview(
                  appId: _macAppIdController.text,
                  appName: _macAppNameController.text,
                  country:
                      _countryController.text.isNotEmpty
                          ? _countryController.text
                          : null,
                ),
              );
            }
          },
          child: const Text('Open App Review Page'),
        ),
      ],
    );
  }

  Widget _buildMicrosoftStoreTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Microsoft Store Actions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _buildMicrosoftStoreActions(),
        ],
      ),
    );
  }

  Widget _buildMicrosoftStoreActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () async {
            await _deeplinkX.launchAction(MicrosoftStore.open);
          },
          child: const Text('Open Microsoft Store'),
        ),
        const SizedBox(height: 16),
        const Text(
          'App Actions',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _msProductIdController,
          decoration: const InputDecoration(
            labelText: 'Product ID',
            hintText:
                'Enter Product ID (e.g., 9WZDNCRFHVJL for Microsoft Edge)',
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
                  language:
                      _msLanguageController.text.isNotEmpty
                          ? _msLanguageController.text
                          : null,
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
              await _deeplinkX.launchAction(
                MicrosoftStore.openAppReviewPage(
                  productId: _msProductIdController.text,
                ),
              );
            }
          },
          child: const Text('Open App Review Page'),
        ),
      ],
    );
  }

  Widget _buildHuaweiAppGalleryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Huawei AppGallery Actions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _buildHuaweiAppGalleryActions(),
        ],
      ),
    );
  }

  Widget _buildHuaweiAppGalleryActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 16),
        const Text(
          'App Actions',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
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
            if (_huaweiAppIdController.text.isNotEmpty &&
                _huaweiPackageNameController.text.isNotEmpty) {
              await _deeplinkX.launchAction(
                HuaweiAppGalleryStore.openAppPage(
                  appId: _huaweiAppIdController.text,
                  packageName: _huaweiPackageNameController.text,
                  referrer:
                      _huaweiReferrerController.text.isNotEmpty
                          ? _huaweiReferrerController.text
                          : null,
                  locale:
                      _huaweiLocaleController.text.isNotEmpty
                          ? _huaweiLocaleController.text
                          : null,
                ),
              );
            }
          },
          child: const Text('Open App Page'),
        ),
      ],
    );
  }

  Widget _buildCafeBazaarTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Cafe Bazaar Store Actions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _buildCafeBazaarActions(),
        ],
      ),
    );
  }

  Widget _buildCafeBazaarActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () async {
            await _deeplinkX.launchAction(CafeBazaarStore.open);
          },
          child: const Text('Open Cafe Bazaar'),
        ),
        const SizedBox(height: 16),
        const Text(
          'App Actions',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
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
                  referrer:
                      _cafeBazaarReferrerController.text.isNotEmpty
                          ? _cafeBazaarReferrerController.text
                          : null,
                ),
              );
            }
          },
          child: const Text('Open App Page'),
        ),
      ],
    );
  }

  Widget _buildMyketTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Myket Store Actions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _buildMyketActions(),
        ],
      ),
    );
  }

  Widget _buildMyketActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () async {
            await _deeplinkX.launchAction(MyketStore.open);
          },
          child: const Text('Open Myket'),
        ),
        const SizedBox(height: 16),
        const Text(
          'App Actions',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
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
                  referrer:
                      _myketReferrerController.text.isNotEmpty
                          ? _myketReferrerController.text
                          : null,
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
              await _deeplinkX.launchAction(
                MyketStore.rateApp(
                  packageName: _myketPackageNameController.text,
                ),
              );
            }
          },
          child: const Text('Rate app'),
        ),
      ],
    );
  }
}
