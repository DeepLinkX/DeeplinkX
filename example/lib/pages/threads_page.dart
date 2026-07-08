import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for Threads.
class ThreadsPage extends StatefulWidget {
  /// Creates the Threads example page.
  const ThreadsPage({super.key});

  @override
  State<ThreadsPage> createState() => _ThreadsPageState();
}

class _ThreadsPageState extends State<ThreadsPage> {
  final _deeplinkX = DeeplinkX();
  final _usernameController = TextEditingController(text: 'zuck');
  final _postIdController = TextEditingController(text: 'DY11ZLWG_eY');
  final _composeTextController = TextEditingController(text: 'Hello from DeeplinkX');
  bool _fallback = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _postIdController.dispose();
    _composeTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Threads')),
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
              await _deeplinkX.launchApp(Threads.open(fallbackToStore: _fallback));
            },
            child: const Text('Open Threads App'),
          ),
          const SizedBox(height: 16),
          const Text('Profile Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Threads Username',
              hintText: 'Enter Threads username',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_usernameController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  Threads.openProfile(username: _usernameController.text, fallbackToStore: _fallback),
                );
              }
            },
            child: const Text('Open Profile'),
          ),
          const SizedBox(height: 16),
          const Text('Post Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _postIdController,
            decoration: const InputDecoration(
              labelText: 'Post ID',
              hintText: 'Enter Threads post ID',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_usernameController.text.isNotEmpty && _postIdController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  Threads.openPost(
                    username: _usernameController.text,
                    postId: _postIdController.text,
                    fallbackToStore: _fallback,
                  ),
                );
              }
            },
            child: const Text('Open Post'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_usernameController.text.isNotEmpty && _postIdController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  Threads.openComments(
                    username: _usernameController.text,
                    postId: _postIdController.text,
                    fallbackToStore: _fallback,
                  ),
                );
              }
            },
            child: const Text('Open Comments'),
          ),
          const SizedBox(height: 16),
          const Text('Compose Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _composeTextController,
            decoration: const InputDecoration(
              labelText: 'Post Text',
              hintText: 'Enter text to prefill',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_composeTextController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  Threads.createPost(text: _composeTextController.text, fallbackToStore: _fallback),
                );
              }
            },
            child: const Text('Create Post'),
          ),
        ],
      ),
    ),
  );
}
