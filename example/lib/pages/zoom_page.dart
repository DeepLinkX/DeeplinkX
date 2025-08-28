import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for Zoom.
class ZoomPage extends StatefulWidget {
  /// Creates the Zoom example page.
  const ZoomPage({super.key});

  @override
  State<ZoomPage> createState() => _ZoomPageState();
}

class _ZoomPageState extends State<ZoomPage> {
  final _deeplinkX = DeeplinkX();
  final _meetingIdController = TextEditingController();
  final _passwordController = TextEditingController();
  final _displayNameController = TextEditingController();
  bool _fallback = true;

  @override
  void dispose() {
    _meetingIdController.dispose();
    _passwordController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Zoom')),
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
              await _deeplinkX.launchApp(Zoom.open(fallbackToStore: _fallback));
            },
            child: const Text('Open Zoom App'),
          ),
          const SizedBox(height: 16),
          const Text('Join Meeting', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _meetingIdController,
            decoration: const InputDecoration(labelText: 'Meeting ID', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password (optional)', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _displayNameController,
            decoration: const InputDecoration(labelText: 'Display Name (optional)', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_meetingIdController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  Zoom.joinMeeting(
                    meetingId: _meetingIdController.text,
                    password: _passwordController.text.isNotEmpty ? _passwordController.text : null,
                    displayName: _displayNameController.text.isNotEmpty ? _displayNameController.text : null,
                    fallbackToStore: _fallback,
                  ),
                );
              }
            },
            child: const Text('Join Meeting'),
          ),
        ],
      ),
    ),
  );
}
