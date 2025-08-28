import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for TikTok.
class TikTokPage extends StatefulWidget {
  /// Creates the TikTok example page.
  const TikTokPage({super.key});

  @override
  State<TikTokPage> createState() => _TikTokPageState();
}

class _TikTokPageState extends State<TikTokPage> {
  final _deeplinkX = DeeplinkX();
  final _usernameController = TextEditingController(text: 'tiktok');
  final _videoIdController = TextEditingController(text: '7511774168241704222');
  final _videoUsernameController = TextEditingController(text: 'tiktok');
  final _tagController = TextEditingController(text: 'flutter');
  bool _fallback = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _videoIdController.dispose();
    _videoUsernameController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('TikTok')),
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
              await _deeplinkX.launchApp(TikTok.open(fallbackToStore: _fallback));
            },
            child: const Text('Open TikTok App'),
          ),
          const SizedBox(height: 16),
          const Text('Profile Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'TikTok Username',
              hintText: 'Enter TikTok username',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_usernameController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  TikTok.openProfile(username: _usernameController.text, fallbackToStore: _fallback),
                );
              }
            },
            child: const Text('Open Profile'),
          ),
          const SizedBox(height: 16),
          const Text('Video Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _videoIdController,
            decoration: const InputDecoration(
              labelText: 'Video ID',
              hintText: 'Enter TikTok video ID',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _videoUsernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
              hintText: 'Enter username of video owner',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_videoIdController.text.isNotEmpty && _videoUsernameController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  TikTok.openVideo(
                    videoId: _videoIdController.text,
                    username: _videoUsernameController.text,
                    fallbackToStore: _fallback,
                  ),
                );
              }
            },
            child: const Text('Open Video'),
          ),
          const SizedBox(height: 16),
          const Text('Tag Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _tagController,
            decoration: const InputDecoration(
              labelText: 'Tag Name',
              hintText: 'Enter TikTok tag name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_tagController.text.isNotEmpty) {
                await _deeplinkX.launchAction(TikTok.openTag(tagName: _tagController.text, fallbackToStore: _fallback));
              }
            },
            child: const Text('Open Tag'),
          ),
        ],
      ),
    ),
  );
}
