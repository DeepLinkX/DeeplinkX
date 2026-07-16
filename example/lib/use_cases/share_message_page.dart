import 'package:deeplink_x/deeplink_x.dart';
import 'package:deeplink_x_example/use_cases/use_case_support.dart';
import 'package:flutter/material.dart';

/// Demonstrates sharing and direct messaging actions.
class ShareMessagePage extends StatefulWidget {
  /// Creates the share-and-message use case.
  const ShareMessagePage({this.deeplinkX, super.key});

  /// Optional launcher override used by widget tests.
  final DeeplinkX? deeplinkX;

  @override
  State<ShareMessagePage> createState() => _ShareMessagePageState();
}

class _ShareMessagePageState extends State<ShareMessagePage> {
  late final DeeplinkX _deeplinkX = widget.deeplinkX ?? DeeplinkX();
  final _shareController = TextEditingController(text: 'Try DeeplinkX for type-safe Flutter deeplinks.');
  final _usernameController = TextEditingController(text: 'telegram');
  final _messageController = TextEditingController(text: 'Hello from the DeeplinkX example!');
  bool _launching = false;

  @override
  void dispose() {
    _shareController.dispose();
    _usernameController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _launch(final AppAction action) async {
    if (_launching) {
      return;
    }
    setState(() => _launching = true);
    final result = await _deeplinkX.launchAction(action);
    if (!mounted) {
      return;
    }
    setState(() => _launching = false);
    showLaunchResult(context, succeeded: result);
  }

  Future<void> _share() async {
    final text = _shareController.text.trim();
    if (text.isEmpty) {
      showInputError(context, 'Enter text to share.');
      return;
    }
    await _launch(WhatsApp.shareText(text: text));
  }

  Future<void> _message() async {
    final username = _usernameController.text.trim();
    final message = _messageController.text.trim();
    if (username.isEmpty || message.isEmpty) {
      showInputError(context, 'Enter both a Telegram username and message.');
      return;
    }
    await _launch(Telegram.sendMessage(username: username, message: message));
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Share & Message')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _SectionCard(
          title: 'Share with WhatsApp',
          assetName: 'assets/whatsapp.png',
          children: [
            TextField(
              key: const ValueKey('whatsapp-share-text'),
              controller: _shareController,
              decoration: const InputDecoration(labelText: 'Share text', border: OutlineInputBorder()),
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              key: const ValueKey('share-whatsapp'),
              onPressed: _launching ? null : _share,
              icon: const Icon(Icons.share),
              label: const Text('Share text'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _SectionCard(
          title: 'Message a Telegram user',
          assetName: 'assets/telegram.png',
          children: [
            TextField(
              key: const ValueKey('telegram-username'),
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username', prefixText: '@', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              key: const ValueKey('telegram-message'),
              controller: _messageController,
              decoration: const InputDecoration(labelText: 'Message', border: OutlineInputBorder()),
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              key: const ValueKey('message-telegram'),
              onPressed: _launching ? null : _message,
              icon: const Icon(Icons.send),
              label: const Text('Open conversation'),
            ),
          ],
        ),
        if (_launching) const Center(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator())),
      ],
    ),
  );
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.assetName, required this.children});

  final String title;
  final String assetName;
  final List<Widget> children;

  @override
  Widget build(final BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              UseCaseLeading(assetName: assetName),
              const SizedBox(width: 12),
              Expanded(child: Text(title, style: Theme.of(context).textTheme.titleMedium)),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    ),
  );
}
