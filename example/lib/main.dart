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
  final _deeplinkX = const DeeplinkX();
  final _messageController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _appIdController = TextEditingController(text: '389801252'); // Example: Instagram app ID
  final _appNameController = TextEditingController(text: 'instagram'); // Example: Instagram app name
  final _macAppIdController = TextEditingController(text: '497799835'); // Example: Xcode app ID
  final _macAppNameController = TextEditingController(text: 'xcode'); // Example: Xcode app name
  final _countryController = TextEditingController(text: 'us'); // Example: US country code
  final _msProductIdController = TextEditingController(text: '9WZDNCRFHVJL'); // Example: Microsoft Edge product ID
  final _msLanguageController = TextEditingController(text: 'en-US'); // Example: Language code

  @override
  void dispose() {
    _messageController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _appIdController.dispose();
    _appNameController.dispose();
    _macAppIdController.dispose();
    _macAppNameController.dispose();
    _countryController.dispose();
    _msProductIdController.dispose();
    _msLanguageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: DefaultTabController(
        length: 7,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('DeeplinkX Example'),
            bottom: const TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'Instagram'),
                Tab(text: 'Telegram'),
                Tab(text: 'iOS App Store'),
                Tab(text: 'Play Store'),
                Tab(text: 'Mac App Store'),
                Tab(text: 'Microsoft Store'),
                Tab(text: 'LinkedIn'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildInstagramTab(),
              _buildTelegramTab(),
              _buildAppStoreTab(),
              _buildPlayStoreTab(),
              _buildMacAppStoreTab(),
              _buildMicrosoftStoreTab(),
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
          const Text('Instagram Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
          const Text('Telegram Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          _buildTelegramActions(),
        ],
      ),
    );
  }

  Widget _buildLinkedInTab() {
    return const Center(child: Text('LinkedIn support coming soon!', style: TextStyle(fontSize: 16)));
  }

  Widget _buildInstagramActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () async {
            await _deeplinkX.launchAction(Instagram.open);
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
              await _deeplinkX.launchAction(Instagram.openProfile(_usernameController.text));
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
            await _deeplinkX.launchAction(Telegram.open);
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
        TextField(
          controller: _phoneController,
          decoration: const InputDecoration(
            labelText: 'Phone Number (with country code)',
            hintText: 'e.g., 1234567890 for US',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  if (_usernameController.text.isNotEmpty) {
                    await _deeplinkX.launchAction(Telegram.openProfile(_usernameController.text));
                  }
                },
                child: const Text('Open Profile by Username'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  if (_phoneController.text.isNotEmpty) {
                    await _deeplinkX.launchAction(Telegram.openProfilePhoneNumber(_phoneController.text));
                  }
                },
                child: const Text('Open Profile by Phone'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Message Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: _messageController,
          decoration: const InputDecoration(
            labelText: 'Message',
            hintText: 'Enter message to send',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  if (_usernameController.text.isNotEmpty && _messageController.text.isNotEmpty) {
                    await _deeplinkX.launchAction(
                      Telegram.sendMessage(_usernameController.text, _messageController.text),
                    );
                  }
                },
                child: const Text('Send Message by Username'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  if (_phoneController.text.isNotEmpty && _messageController.text.isNotEmpty) {
                    await _deeplinkX.launchAction(
                      Telegram.sendMessagePhoneNumber(_phoneController.text, _messageController.text),
                    );
                  }
                },
                child: const Text('Send Message by Phone'),
              ),
            ),
          ],
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
          const Text('Play Store Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          _buildPlayStoreActions(),
        ],
      ),
    );
  }

  Widget _buildPlayStoreActions() {
    // Controller for package name input
    final packageNameController = TextEditingController(text: 'com.instagram.android');
    // Controller for referrer input
    final referrerController = TextEditingController(text: 'utm_source=deeplink_x_example');
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
        const Text('App Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                  referrer: referrerController.text.isNotEmpty ? referrerController.text : null,
                  hl: languageController.text.isNotEmpty ? languageController.text : null,
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
                  referrer: referrerController.text.isNotEmpty ? referrerController.text : null,
                  hl: languageController.text.isNotEmpty ? languageController.text : null,
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
          const Text('iOS App Store Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                IOSAppStore.openReview(appId: _appIdController.text, appName: _appNameController.text),
              );
            }
          },
          child: const Text('Open App Review Page'),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () async {
            if (_appIdController.text.isNotEmpty && _appNameController.text.isNotEmpty) {
              await _deeplinkX.launchAction(
                IOSAppStore.openMessagesExtension(appId: _appIdController.text, appName: _appNameController.text),
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
          const Text('Mac App Store Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                MacAppStore.openReview(
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
  }

  Widget _buildMicrosoftStoreTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Microsoft Store Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
              await _deeplinkX.launchAction(MicrosoftStore.openAppReviewPage(productId: _msProductIdController.text));
            }
          },
          child: const Text('Open App Review Page'),
        ),
      ],
    );
  }
}
