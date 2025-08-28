import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for the Microsoft Store.
class MicrosoftStorePage extends StatefulWidget {
  /// Creates the Microsoft Store example page.
  const MicrosoftStorePage({super.key});

  @override
  State<MicrosoftStorePage> createState() => _MicrosoftStorePageState();
}

class _MicrosoftStorePageState extends State<MicrosoftStorePage> {
  final _deeplinkX = DeeplinkX();
  final _productIdController = TextEditingController(text: '9WZDNCRFHVJL');
  final _languageController = TextEditingController(text: 'en-US');

  @override
  void dispose() {
    _productIdController.dispose();
    _languageController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Microsoft Store')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
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
            controller: _productIdController,
            decoration: const InputDecoration(
              labelText: 'Product ID',
              hintText: 'Enter Product ID',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _languageController,
            decoration: const InputDecoration(
              labelText: 'Language Code (optional)',
              hintText: 'Enter language code (e.g., en-US)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_productIdController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  MicrosoftStore.openAppPage(
                    productId: _productIdController.text,
                    language: _languageController.text.isNotEmpty ? _languageController.text : null,
                  ),
                );
              }
            },
            child: const Text('Open App Page'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_productIdController.text.isNotEmpty) {
                await _deeplinkX.launchAction(MicrosoftStore.rateApp(productId: _productIdController.text));
              }
            },
            child: const Text('Open App Review Page'),
          ),
        ],
      ),
    ),
  );
}
