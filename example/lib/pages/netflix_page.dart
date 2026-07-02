import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for Netflix.
class NetflixPage extends StatefulWidget {
  /// Creates the Netflix example page.
  const NetflixPage({super.key});

  @override
  State<NetflixPage> createState() => _NetflixPageState();
}

class _NetflixPageState extends State<NetflixPage> {
  final _deeplinkX = DeeplinkX();
  final _titleIdController = TextEditingController(text: '81215567');
  bool _fallback = true;

  @override
  void dispose() {
    _titleIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Netflix')),
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
              await _deeplinkX.launchApp(Netflix.open(fallbackToStore: _fallback));
            },
            child: const Text('Open Netflix App'),
          ),
          const SizedBox(height: 16),
          const Text('Title', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _titleIdController,
            decoration: const InputDecoration(
              labelText: 'Title ID',
              hintText: 'Enter Netflix title ID',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_titleIdController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  Netflix.openTitle(titleId: _titleIdController.text, fallbackToStore: _fallback),
                );
              }
            },
            child: const Text('Open Title'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_titleIdController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  Netflix.watchTitle(titleId: _titleIdController.text, fallbackToStore: _fallback),
                );
              }
            },
            child: const Text('Watch Title'),
          ),
        ],
      ),
    ),
  );
}
