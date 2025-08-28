import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for the iOS App Store.
class IOSAppStorePage extends StatefulWidget {
  /// Creates the iOS App Store example page.
  const IOSAppStorePage({super.key});

  @override
  State<IOSAppStorePage> createState() => _IOSAppStorePageState();
}

class _IOSAppStorePageState extends State<IOSAppStorePage> {
  final _deeplinkX = DeeplinkX();
  final _appIdController = TextEditingController(text: '389801252');
  final _appNameController = TextEditingController(text: 'instagram');

  @override
  void dispose() {
    _appIdController.dispose();
    _appNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('iOS App Store')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
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
              hintText: 'Enter App ID (e.g., 389801252)',
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
      ),
    ),
  );
}
