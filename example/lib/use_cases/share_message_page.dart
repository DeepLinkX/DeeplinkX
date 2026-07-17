import 'package:deeplink_x/deeplink_x.dart';
import 'package:deeplink_x_example/use_cases/use_case_support.dart';
import 'package:deeplink_x_example/widgets/blocks.dart';
import 'package:deeplink_x_example/widgets/inputs.dart';
import 'package:deeplink_x_example/widgets/screen_header.dart';
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
    body: SafeArea(
      child: Column(
        children: [
          const ScreenHeader(title: 'Share & Message'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
              children: [
                FormCard(
                  assetName: 'assets/whatsapp.png',
                  title: 'Share with WhatsApp',
                  fields: [
                    LabeledField(
                      key: const ValueKey('whatsapp-share-text'),
                      label: 'Share text',
                      controller: _shareController,
                    ),
                  ],
                  buttonIcon: Icons.share_rounded,
                  buttonLabel: 'Share text',
                  buttonKey: const ValueKey('share-whatsapp'),
                  onPressed: _share,
                ),
                const SizedBox(height: 12),
                FormCard(
                  assetName: 'assets/telegram.png',
                  title: 'Message a Telegram user',
                  fields: [
                    LabeledField(
                      key: const ValueKey('telegram-username'),
                      label: 'Username',
                      controller: _usernameController,
                    ),
                    LabeledField(
                      key: const ValueKey('telegram-message'),
                      label: 'Message',
                      controller: _messageController,
                    ),
                  ],
                  buttonIcon: Icons.send_rounded,
                  buttonLabel: 'Open conversation',
                  buttonKey: const ValueKey('message-telegram'),
                  onPressed: _message,
                ),
                if (_launching)
                  const Center(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator())),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
