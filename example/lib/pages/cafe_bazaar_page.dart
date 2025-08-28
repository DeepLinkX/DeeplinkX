import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for the Cafe Bazaar store.
class CafeBazaarPage extends StatefulWidget {
  /// Creates the Cafe Bazaar example page.
  const CafeBazaarPage({super.key});

  @override
  State<CafeBazaarPage> createState() => _CafeBazaarPageState();
}

class _CafeBazaarPageState extends State<CafeBazaarPage> {
  final _deeplinkX = DeeplinkX();
  final _packageNameController = TextEditingController(text: 'org.telegram.messenger');
  final _referrerController = TextEditingController();

  @override
  void dispose() {
    _packageNameController.dispose();
    _referrerController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Cafe Bazaar')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
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
          ElevatedButton(
            onPressed: () async {
              if (_packageNameController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  CafeBazaarStore.openAppPage(
                    packageName: _packageNameController.text,
                    referrer: _referrerController.text.isNotEmpty ? _referrerController.text : null,
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
