import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for Pinterest.
class PinterestPage extends StatefulWidget {
  /// Creates the Pinterest example page.
  const PinterestPage({super.key});

  @override
  State<PinterestPage> createState() => _PinterestPageState();
}

class _PinterestPageState extends State<PinterestPage> {
  final _deeplinkX = DeeplinkX();
  final _usernameController = TextEditingController(text: 'pinterest');
  final _pinIdController = TextEditingController(text: '1120622319784769688');
  final _searchQueryController = TextEditingController();
  final _boardUsernameController = TextEditingController(text: 'pinterest');
  final _boardController = TextEditingController(text: 'official-news');
  bool _fallback = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _pinIdController.dispose();
    _searchQueryController.dispose();
    _boardUsernameController.dispose();
    _boardController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Pinterest')),
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
              await _deeplinkX.launchApp(Pinterest.open(fallbackToStore: _fallback));
            },
            child: const Text('Open Pinterest App'),
          ),
          const SizedBox(height: 16),
          const Text('Profile Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Pinterest Username',
              hintText: 'Enter Pinterest username',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_usernameController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  Pinterest.openProfile(username: _usernameController.text, fallbackToStore: _fallback),
                );
              }
            },
            child: const Text('Open Profile'),
          ),
          const SizedBox(height: 16),
          const Text('Pin Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _pinIdController,
            decoration: const InputDecoration(
              labelText: 'Pin ID',
              hintText: 'Enter Pinterest pin ID',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_pinIdController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  Pinterest.openPin(pinId: _pinIdController.text, fallbackToStore: _fallback),
                );
              }
            },
            child: const Text('Open Pin'),
          ),
          const SizedBox(height: 16),
          const Text('Search', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _searchQueryController,
            decoration: const InputDecoration(
              labelText: 'Search Query',
              hintText: 'Enter Pinterest search query',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_searchQueryController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  Pinterest.search(query: _searchQueryController.text, fallbackToStore: _fallback),
                );
              }
            },
            child: const Text('Search Pinterest'),
          ),
          const SizedBox(height: 16),
          const Text('Board Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _boardUsernameController,
            decoration: const InputDecoration(
              labelText: 'Board Owner Username',
              hintText: 'Enter Pinterest username',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _boardController,
            decoration: const InputDecoration(
              labelText: 'Board',
              hintText: 'Enter board (lower-case, hyphenated)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_boardUsernameController.text.isNotEmpty && _boardController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  Pinterest.openBoard(
                    username: _boardUsernameController.text,
                    board: _boardController.text,
                    fallbackToStore: _fallback,
                  ),
                );
              }
            },
            child: const Text('Open Board'),
          ),
        ],
      ),
    ),
  );
}
