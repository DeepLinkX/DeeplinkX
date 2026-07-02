import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for Snapchat.
class SnapchatPage extends StatefulWidget {
  /// Creates the Snapchat example page.
  const SnapchatPage({super.key});

  @override
  State<SnapchatPage> createState() => _SnapchatPageState();
}

class _SnapchatPageState extends State<SnapchatPage> {
  final _deeplinkX = DeeplinkX();
  final _usernameController = TextEditingController(text: 'snapchat');
  bool _fallback = true;

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Snapchat')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Text('Fallback to App Store:'),
              const SizedBox(width: 8),
              Switch(value: _fallback, onChanged: (final v) => setState(() => _fallback = v)),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              await _deeplinkX.launchApp(Snapchat.open(fallbackToStore: _fallback));
            },
            child: const Text('Open Snapchat App'),
          ),
          const SizedBox(height: 16),
          const Text('Profile', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
              hintText: 'Enter Snapchat username',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_usernameController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  Snapchat.openProfile(username: _usernameController.text, fallbackToStore: _fallback),
                );
              }
            },
            child: const Text('Open Profile'),
          ),
        ],
      ),
    ),
  );
}
