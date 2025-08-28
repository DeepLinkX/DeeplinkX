import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for the Mac App Store.
class MacAppStorePage extends StatefulWidget {
  /// Creates the Mac App Store example page.
  const MacAppStorePage({super.key});

  @override
  State<MacAppStorePage> createState() => _MacAppStorePageState();
}

class _MacAppStorePageState extends State<MacAppStorePage> {
  final _deeplinkX = DeeplinkX();
  final _appIdController = TextEditingController(text: '497799835');
  final _appNameController = TextEditingController(text: 'xcode');
  final _countryController = TextEditingController(text: 'us');

  @override
  void dispose() {
    _appIdController.dispose();
    _appNameController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Mac App Store')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
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
            controller: _appIdController,
            decoration: const InputDecoration(
              labelText: 'App ID',
              hintText: 'Enter App ID (e.g., 497799835)',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _appNameController,
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
              hintText: 'Enter two-letter country code',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_appIdController.text.isNotEmpty && _appNameController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  MacAppStore.openAppPage(
                    appId: _appIdController.text,
                    appName: _appNameController.text,
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
              if (_appIdController.text.isNotEmpty && _appNameController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  MacAppStore.rateApp(
                    appId: _appIdController.text,
                    appName: _appNameController.text,
                    country: _countryController.text.isNotEmpty ? _countryController.text : null,
                  ),
                );
              }
            },
            child: const Text('Open App Review Page'),
          ),
        ],
      ),
    ),
  );
}
