import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for the Google Play Store.
class PlayStorePage extends StatefulWidget {
  /// Creates the Play Store example page.
  const PlayStorePage({super.key});

  @override
  State<PlayStorePage> createState() => _PlayStorePageState();
}

class _PlayStorePageState extends State<PlayStorePage> {
  final _deeplinkX = DeeplinkX();
  final _packageNameController = TextEditingController(text: 'com.instagram.android');
  final _referrerController = TextEditingController();
  final _languageController = TextEditingController();

  @override
  void dispose() {
    _packageNameController.dispose();
    _referrerController.dispose();
    _languageController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Play Store')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
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
            controller: _packageNameController,
            decoration: const InputDecoration(
              labelText: 'Package Name',
              hintText: 'Enter Package Name (e.g., com.instagram.android)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _referrerController,
            decoration: const InputDecoration(
              labelText: 'Referrer (optional)',
              hintText: 'Enter referrer for tracking',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _languageController,
            decoration: const InputDecoration(
              labelText: 'Language Code (optional)',
              hintText: 'Enter language code (e.g., en, fr)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_packageNameController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  PlayStore.openAppPage(
                    packageName: _packageNameController.text,
                    referrer: _referrerController.text.isNotEmpty ? _referrerController.text : null,
                    language: _languageController.text.isNotEmpty ? _languageController.text : null,
                  ),
                );
              }
            },
            child: const Text('Open App Page'),
          ),
        ],
      ),
    ),
  );
}
