import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for Twitter (X).
class TwitterPage extends StatefulWidget {
  /// Creates the Twitter example page.
  const TwitterPage({super.key});

  @override
  State<TwitterPage> createState() => _TwitterPageState();
}

class _TwitterPageState extends State<TwitterPage> {
  final _deeplinkX = DeeplinkX();
  final _usernameController = TextEditingController(text: 'twitter');
  final _tweetIdController = TextEditingController(text: '1234567890');
  final _searchQueryController = TextEditingController();
  bool _fallback = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _tweetIdController.dispose();
    _searchQueryController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Twitter')),
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
              await _deeplinkX.launchApp(Twitter.open(fallbackToStore: _fallback));
            },
            child: const Text('Open Twitter App'),
          ),
          const SizedBox(height: 16),
          const Text('Profile Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Twitter Username',
              hintText: 'Enter Twitter username',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_usernameController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  Twitter.openProfile(username: _usernameController.text, fallbackToStore: _fallback),
                );
              }
            },
            child: const Text('Open Profile'),
          ),
          const SizedBox(height: 16),
          const Text('Tweet Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _tweetIdController,
            decoration: const InputDecoration(
              labelText: 'Tweet ID',
              hintText: 'Enter tweet ID',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_tweetIdController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  Twitter.openTweet(tweetId: _tweetIdController.text, fallbackToStore: _fallback),
                );
              }
            },
            child: const Text('Open Tweet'),
          ),
          const SizedBox(height: 16),
          const Text('Search', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _searchQueryController,
            decoration: const InputDecoration(
              labelText: 'Search Query',
              hintText: 'Enter search query',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_searchQueryController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  Twitter.search(query: _searchQueryController.text, fallbackToStore: _fallback),
                );
              }
            },
            child: const Text('Search Twitter'),
          ),
        ],
      ),
    ),
  );
}
