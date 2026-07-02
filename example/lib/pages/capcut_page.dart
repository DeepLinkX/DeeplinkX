import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for CapCut.
class CapCutPage extends StatefulWidget {
  /// Creates the CapCut example page.
  const CapCutPage({super.key});

  @override
  State<CapCutPage> createState() => _CapCutPageState();
}

class _CapCutPageState extends State<CapCutPage> {
  final _deeplinkX = DeeplinkX();
  final _templateLinkController = TextEditingController(text: 'https://www.capcut.com/template-detail/example/1');
  bool _fallback = true;

  @override
  void dispose() {
    _templateLinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('CapCut')),
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
              await _deeplinkX.launchApp(CapCut.open(fallbackToStore: _fallback));
            },
            child: const Text('Open CapCut App'),
          ),
          const SizedBox(height: 16),
          const Text('Template', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _templateLinkController,
            decoration: const InputDecoration(
              labelText: 'Template Link',
              hintText: 'Enter a CapCut template link',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              final templateLink = Uri.tryParse(_templateLinkController.text);
              if (templateLink != null && templateLink.hasScheme) {
                await _deeplinkX.launchAction(
                  CapCut.openTemplate(templateLink: templateLink, fallbackToStore: _fallback),
                );
              }
            },
            child: const Text('Open Template'),
          ),
        ],
      ),
    ),
  );
}
