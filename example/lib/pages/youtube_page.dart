import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for YouTube.
class YouTubePage extends StatefulWidget {
  /// Creates the YouTube example page.
  const YouTubePage({super.key});

  @override
  State<YouTubePage> createState() => _YouTubePageState();
}

class _YouTubePageState extends State<YouTubePage> {
  final _deeplinkX = DeeplinkX();
  final _videoIdController = TextEditingController(text: 'dQw4w9WgXcQ');
  final _channelIdController = TextEditingController();
  final _playlistIdController = TextEditingController();
  final _searchQueryController = TextEditingController();
  bool _fallback = true;

  @override
  void dispose() {
    _videoIdController.dispose();
    _channelIdController.dispose();
    _playlistIdController.dispose();
    _searchQueryController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('YouTube')),
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
              await _deeplinkX.launchApp(YouTube.open(fallbackToStore: _fallback));
            },
            child: const Text('Open YouTube App'),
          ),
          const SizedBox(height: 16),
          const Text('Video Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _videoIdController,
            decoration: const InputDecoration(
              labelText: 'Video ID',
              hintText: 'Enter YouTube video ID',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_videoIdController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  YouTube.openVideo(videoId: _videoIdController.text, fallbackToStore: _fallback),
                );
              }
            },
            child: const Text('Open Video'),
          ),
          const SizedBox(height: 16),
          const Text('Channel Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _channelIdController,
            decoration: const InputDecoration(
              labelText: 'Channel ID',
              hintText: 'Enter YouTube channel ID',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_channelIdController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  YouTube.openChannel(channelId: _channelIdController.text, fallbackToStore: _fallback),
                );
              }
            },
            child: const Text('Open Channel'),
          ),
          const SizedBox(height: 16),
          const Text('Playlist Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _playlistIdController,
            decoration: const InputDecoration(
              labelText: 'Playlist ID',
              hintText: 'Enter YouTube playlist ID',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_playlistIdController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  YouTube.openPlaylist(playlistId: _playlistIdController.text, fallbackToStore: _fallback),
                );
              }
            },
            child: const Text('Open Playlist'),
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
                  YouTube.search(query: _searchQueryController.text, fallbackToStore: _fallback),
                );
              }
            },
            child: const Text('Search on YouTube'),
          ),
        ],
      ),
    ),
  );
}
