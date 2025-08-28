import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for Slack.
class SlackPage extends StatefulWidget {
  /// Creates the Slack example page.
  const SlackPage({super.key});

  @override
  State<SlackPage> createState() => _SlackPageState();
}

class _SlackPageState extends State<SlackPage> {
  final _deeplinkX = DeeplinkX();
  final _teamIdController = TextEditingController();
  final _channelIdController = TextEditingController();
  final _userIdController = TextEditingController();
  bool _fallback = true;

  @override
  void dispose() {
    _teamIdController.dispose();
    _channelIdController.dispose();
    _userIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Slack')),
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
              await _deeplinkX.launchApp(Slack.open(fallbackToStore: _fallback));
            },
            child: const Text('Open Slack App'),
          ),
          const SizedBox(height: 16),
          const Text('Open Team', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _teamIdController,
            decoration: const InputDecoration(labelText: 'Team ID', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_teamIdController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  Slack.openTeam(teamId: _teamIdController.text, fallbackToStore: _fallback),
                );
              }
            },
            child: const Text('Open Team'),
          ),
          const SizedBox(height: 16),
          const Text('Open Channel', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _channelIdController,
            decoration: const InputDecoration(labelText: 'Channel ID', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_teamIdController.text.isNotEmpty && _channelIdController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  Slack.openChannel(
                    teamId: _teamIdController.text,
                    channelId: _channelIdController.text,
                    fallbackToStore: _fallback,
                  ),
                );
              }
            },
            child: const Text('Open Channel'),
          ),
          const SizedBox(height: 16),
          const Text('Open User', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _userIdController,
            decoration: const InputDecoration(labelText: 'User ID', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_teamIdController.text.isNotEmpty && _userIdController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  Slack.openUser(
                    teamId: _teamIdController.text,
                    userId: _userIdController.text,
                    fallbackToStore: _fallback,
                  ),
                );
              }
            },
            child: const Text('Open User'),
          ),
        ],
      ),
    ),
  );
}
