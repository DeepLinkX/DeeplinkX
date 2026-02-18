import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for Telegram.
class TelegramPage extends StatefulWidget {
  /// Creates the Telegram example page.
  const TelegramPage({super.key});

  @override
  State<TelegramPage> createState() => _TelegramPageState();
}

class _TelegramPageState extends State<TelegramPage> {
  final _deeplinkX = DeeplinkX();
  final _usernameController = TextEditingController(text: 'durov');
  final _phoneController = TextEditingController(text: '14155552671');
  final _messageController = TextEditingController(text: 'Hello! How are you?');
  bool _fallback = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Telegram')),
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
              await _deeplinkX.launchApp(Telegram.open(fallbackToStore: _fallback));
            },
            child: const Text('Open Telegram App'),
          ),
          const SizedBox(height: 16),
          const Text('Profile Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'Telegram Username', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_usernameController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  Telegram.openProfile(username: _usernameController.text, fallbackToStore: _fallback),
                );
              }
            },
            child: const Text('Open Telegram Profile'),
          ),
          const SizedBox(height: 16),
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
          ElevatedButton(
            onPressed: () async {
              if (_phoneController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  Telegram.openProfileByPhoneNumber(phoneNumber: _phoneController.text, fallbackToStore: _fallback),
                );
              }
            },
            child: const Text('Open Telegram Profile by Phone'),
          ),
          const SizedBox(height: 16),
          const Text('Message Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'Telegram Username', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _messageController,
            decoration: const InputDecoration(labelText: 'Message', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_usernameController.text.isNotEmpty && _messageController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  Telegram.sendMessage(
                    username: _usernameController.text,
                    message: _messageController.text,
                    fallbackToStore: _fallback,
                  ),
                );
              }
            },
            child: const Text('Send Message by Username'),
          ),
          const SizedBox(height: 16),
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
            decoration: const InputDecoration(labelText: 'Message', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_phoneController.text.isNotEmpty && _messageController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  Telegram.sendMessageByPhoneNumber(
                    phoneNumber: _phoneController.text,
                    message: _messageController.text,
                    fallbackToStore: _fallback,
                  ),
                );
              }
            },
            child: const Text('Send Message by Phone Number'),
          ),
        ],
      ),
    ),
  );
}
