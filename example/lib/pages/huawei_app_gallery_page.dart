import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for the Huawei AppGallery.
class HuaweiAppGalleryPage extends StatefulWidget {
  /// Creates the Huawei AppGallery example page.
  const HuaweiAppGalleryPage({super.key});

  @override
  State<HuaweiAppGalleryPage> createState() => _HuaweiAppGalleryPageState();
}

class _HuaweiAppGalleryPageState extends State<HuaweiAppGalleryPage> {
  final _deeplinkX = DeeplinkX();
  final _appIdController = TextEditingController(text: 'C101184875');
  final _packageNameController = TextEditingController(text: 'org.telegram.messenger');
  final _referrerController = TextEditingController(text: 'utm_source=deeplink_x_example');
  final _localeController = TextEditingController(text: 'en_US');

  @override
  void dispose() {
    _appIdController.dispose();
    _packageNameController.dispose();
    _referrerController.dispose();
    _localeController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Huawei AppGallery')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
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
            controller: _appIdController,
            decoration: const InputDecoration(
              labelText: 'App ID',
              hintText: 'Enter App ID',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _packageNameController,
            decoration: const InputDecoration(
              labelText: 'Package Name',
              hintText: 'Enter Package Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _referrerController,
            decoration: const InputDecoration(
              labelText: 'Referrer (optional)',
              hintText: 'Enter referrer',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _localeController,
            decoration: const InputDecoration(
              labelText: 'Locale (optional)',
              hintText: 'Enter locale (e.g., en_US)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_appIdController.text.isNotEmpty && _packageNameController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  HuaweiAppGalleryStore.openAppPage(
                    appId: _appIdController.text,
                    packageName: _packageNameController.text,
                    referrer: _referrerController.text.isNotEmpty ? _referrerController.text : null,
                    locale: _localeController.text.isNotEmpty ? _localeController.text : null,
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
