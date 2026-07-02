import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for Temu.
class TemuPage extends StatefulWidget {
  /// Creates the Temu example page.
  const TemuPage({super.key});

  @override
  State<TemuPage> createState() => _TemuPageState();
}

class _TemuPageState extends State<TemuPage> {
  final _deeplinkX = DeeplinkX();
  final _linkController = TextEditingController(text: 'https://www.temu.com/search_result.html?search_key=shoes');
  final _searchController = TextEditingController(text: 'running shoes');
  bool _fallback = true;

  @override
  void dispose() {
    _linkController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Temu')),
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
              await _deeplinkX.launchApp(Temu.open(fallbackToStore: _fallback));
            },
            child: const Text('Open Temu App'),
          ),
          const SizedBox(height: 16),
          const Text('Open Link', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _linkController,
            decoration: const InputDecoration(
              labelText: 'Temu Link',
              hintText: 'Enter a Temu link',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              final link = Uri.tryParse(_linkController.text);
              if (link != null && link.hasScheme) {
                await _deeplinkX.launchAction(Temu.openLink(link: link, fallbackToStore: _fallback));
              }
            },
            child: const Text('Open Temu Link'),
          ),
          const SizedBox(height: 16),
          const Text('Search', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              labelText: 'Search Query',
              hintText: 'Enter search query',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_searchController.text.isNotEmpty) {
                await _deeplinkX.launchAction(Temu.search(query: _searchController.text, fallbackToStore: _fallback));
              }
            },
            child: const Text('Search Temu'),
          ),
        ],
      ),
    ),
  );
}
