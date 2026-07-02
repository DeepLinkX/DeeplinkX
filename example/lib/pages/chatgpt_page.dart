import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for ChatGPT.
class ChatGPTPage extends StatefulWidget {
  /// Creates the ChatGPT example page.
  const ChatGPTPage({super.key});

  @override
  State<ChatGPTPage> createState() => _ChatGPTPageState();
}

class _ChatGPTPageState extends State<ChatGPTPage> {
  final _deeplinkX = DeeplinkX();
  final _shareIdController = TextEditingController(text: 'abc123');
  final _gptIdController = TextEditingController(text: 'g-NfGMjwvdl');
  bool _fallback = true;

  @override
  void dispose() {
    _shareIdController.dispose();
    _gptIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('ChatGPT')),
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
              await _deeplinkX.launchApp(ChatGPT.open(fallbackToStore: _fallback));
            },
            child: const Text('Open ChatGPT App'),
          ),
          const SizedBox(height: 16),
          const Text('Shared Conversation', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _shareIdController,
            decoration: const InputDecoration(
              labelText: 'Share ID',
              hintText: 'Enter ChatGPT share ID',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_shareIdController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  ChatGPT.openSharedConversation(shareId: _shareIdController.text, fallbackToStore: _fallback),
                );
              }
            },
            child: const Text('Open Shared Conversation'),
          ),
          const SizedBox(height: 16),
          const Text('GPT', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _gptIdController,
            decoration: const InputDecoration(
              labelText: 'GPT ID',
              hintText: 'Enter GPT ID',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_gptIdController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  ChatGPT.openGpt(gptId: _gptIdController.text, fallbackToStore: _fallback),
                );
              }
            },
            child: const Text('Open GPT'),
          ),
        ],
      ),
    ),
  );
}
