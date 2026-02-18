import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for LinkedIn.
class LinkedInPage extends StatefulWidget {
  /// Creates the LinkedIn example page.
  const LinkedInPage({super.key});

  @override
  State<LinkedInPage> createState() => _LinkedInPageState();
}

class _LinkedInPageState extends State<LinkedInPage> {
  final _deeplinkX = DeeplinkX();
  final _profileController = TextEditingController(text: 'satyanadella');
  final _companyController = TextEditingController(text: 'microsoft');
  bool _fallback = true;

  @override
  void dispose() {
    _profileController.dispose();
    _companyController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('LinkedIn')),
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
              await _deeplinkX.launchApp(LinkedIn.open(fallbackToStore: _fallback));
            },
            child: const Text('Open LinkedIn App'),
          ),
          const SizedBox(height: 16),
          const Text('Profile Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _profileController,
            decoration: const InputDecoration(
              labelText: 'LinkedIn Profile ID',
              hintText: 'Enter LinkedIn profile ID',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_profileController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  LinkedIn.openProfile(profileId: _profileController.text, fallbackToStore: _fallback),
                );
              }
            },
            child: const Text('Open Profile'),
          ),
          const SizedBox(height: 16),
          const Text('Company Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _companyController,
            decoration: const InputDecoration(
              labelText: 'LinkedIn Company ID',
              hintText: 'Enter LinkedIn company ID',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_companyController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  LinkedIn.openCompany(companyId: _companyController.text, fallbackToStore: _fallback),
                );
              }
            },
            child: const Text('Open Company'),
          ),
        ],
      ),
    ),
  );
}
