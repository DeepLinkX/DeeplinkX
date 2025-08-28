import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for WhatsApp.
class WhatsAppPage extends StatefulWidget {
  /// Creates the WhatsApp example page.
  const WhatsAppPage({super.key});

  @override
  State<WhatsAppPage> createState() => _WhatsAppPageState();
}

class _WhatsAppPageState extends State<WhatsAppPage> {
  final _deeplinkX = DeeplinkX();
  final _phoneController = TextEditingController(text: '14155552671');
  final _messageController = TextEditingController(text: 'Hello! How are you?');
  bool _fallback = true;

  @override
  void dispose() {
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('WhatsApp')),
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
              await _deeplinkX.launchApp(WhatsApp.open(fallbackToStore: _fallback));
            },
            child: const Text('Open WhatsApp App'),
          ),
          const SizedBox(height: 16),
          const Text('Chat Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _phoneController,
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              hintText: 'Enter phone number without + (e.g., 14155552671)',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _messageController,
            decoration: const InputDecoration(
              labelText: 'Message (optional)',
              hintText: 'Enter message to pre-fill',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_phoneController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  WhatsApp.chat(
                    phoneNumber: _phoneController.text,
                    message: _messageController.text.isNotEmpty ? _messageController.text : null,
                    fallbackToStore: _fallback,
                  ),
                );
              }
            },
            child: const Text('Open WhatsApp Chat'),
          ),
          const SizedBox(height: 16),
          const Text('Share Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _messageController,
            decoration: const InputDecoration(
              labelText: 'Text to Share',
              hintText: 'Enter text to share via WhatsApp',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_messageController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  WhatsApp.shareText(text: _messageController.text, fallbackToStore: _fallback),
                );
              }
            },
            child: const Text('Share via WhatsApp'),
          ),
        ],
      ),
    ),
  );
}
