import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for Facebook.
class FacebookPage extends StatefulWidget {
  /// Creates the Facebook example page.
  const FacebookPage({super.key});

  @override
  State<FacebookPage> createState() => _FacebookPageState();
}

class _FacebookPageState extends State<FacebookPage> {
  final _deeplinkX = DeeplinkX();
  final _idController = TextEditingController(text: '4');
  final _usernameController = TextEditingController(text: 'zuck');
  final _pageIdController = TextEditingController(text: 'facebookapp');
  final _groupIdController = TextEditingController(text: '231104380821004');
  final _eventIdController = TextEditingController(text: '10155945715431729');
  bool _fallback = true;

  @override
  void dispose() {
    _idController.dispose();
    _usernameController.dispose();
    _pageIdController.dispose();
    _groupIdController.dispose();
    _eventIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Facebook')),
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
              await _deeplinkX.launchApp(Facebook.open(fallbackToStore: _fallback));
            },
            child: const Text('Open Facebook App'),
          ),
          const SizedBox(height: 16),
          const Text('Profile Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _idController,
            decoration: const InputDecoration(
              labelText: 'Facebook ID',
              hintText: 'Enter Facebook numeric ID',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_idController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  Facebook.openProfileById(id: _idController.text, fallbackToStore: _fallback),
                );
              }
            },
            child: const Text('Open Profile by ID'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Facebook Username',
              hintText: 'Enter Facebook username',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_usernameController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  Facebook.openProfileByUsername(username: _usernameController.text, fallbackToStore: _fallback),
                );
              }
            },
            child: const Text('Open Profile by Username'),
          ),
          const SizedBox(height: 16),
          const Text('Page Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _pageIdController,
            decoration: const InputDecoration(
              labelText: 'Facebook Page ID',
              hintText: 'Enter Facebook page ID',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_pageIdController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  Facebook.openPage(pageId: _pageIdController.text, fallbackToStore: _fallback),
                );
              }
            },
            child: const Text('Open Page'),
          ),
          const SizedBox(height: 16),
          const Text('Group Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _groupIdController,
            decoration: const InputDecoration(
              labelText: 'Facebook Group ID',
              hintText: 'Enter Facebook group ID',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_groupIdController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  Facebook.openGroup(groupId: _groupIdController.text, fallbackToStore: _fallback),
                );
              }
            },
            child: const Text('Open Group'),
          ),
          const SizedBox(height: 16),
          const Text('Event Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _eventIdController,
            decoration: const InputDecoration(
              labelText: 'Facebook Event ID',
              hintText: 'Enter Facebook event ID',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_eventIdController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  Facebook.openEvent(eventId: _eventIdController.text, fallbackToStore: _fallback),
                );
              }
            },
            child: const Text('Open Event'),
          ),
        ],
      ),
    ),
  );
}
