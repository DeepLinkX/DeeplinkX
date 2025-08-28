import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for the Myket store.
class MyketPage extends StatefulWidget {
  /// Creates the Myket example page.
  const MyketPage({super.key});

  @override
  State<MyketPage> createState() => _MyketPageState();
}

class _MyketPageState extends State<MyketPage> {
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
    appBar: AppBar(title: const Text('Myket')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
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
                  MyketStore.openAppPage(
                    packageName: _packageNameController.text,
                    referrer: _referrerController.text.isNotEmpty ? _referrerController.text : null,
                  ),
                );
              }
            },
            child: const Text('Open App Page'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_packageNameController.text.isNotEmpty) {
                await _deeplinkX.launchAction(MyketStore.rateApp(packageName: _packageNameController.text));
              }
            },
            child: const Text('Rate app'),
          ),
        ],
      ),
    ),
  );
}
