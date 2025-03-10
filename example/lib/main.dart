import 'package:flutter/material.dart';
import 'package:deeplink_x/deeplink_x.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _deeplinkX = const DeeplinkX();
  final _messageController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('DeeplinkX Example'),
            bottom: const TabBar(tabs: [Tab(text: 'Instagram'), Tab(text: 'Telegram'), Tab(text: 'LinkedIn')]),
          ),
          body: TabBarView(children: [_buildInstagramTab(), _buildTelegramTab(), _buildLinkedInTab()]),
        ),
      ),
    );
  }

  Widget _buildInstagramTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Instagram Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          _buildInstagramActions(),
        ],
      ),
    );
  }

  Widget _buildTelegramTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Telegram Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          _buildTelegramActions(),
        ],
      ),
    );
  }

  Widget _buildLinkedInTab() {
    return const Center(child: Text('LinkedIn support coming soon!', style: TextStyle(fontSize: 16)));
  }

  Widget _buildInstagramActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () async {
            await _deeplinkX.launchAction(Instagram.open);
          },
          child: const Text('Open Instagram App'),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _usernameController,
          decoration: const InputDecoration(
            labelText: 'Instagram Username',
            hintText: 'Enter Instagram username',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () async {
            if (_usernameController.text.isNotEmpty) {
              await _deeplinkX.launchAction(Instagram.openProfile(_usernameController.text));
            }
          },
          child: const Text('Open Instagram Profile'),
        ),
      ],
    );
  }

  Widget _buildTelegramActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () async {
            await _deeplinkX.launchAction(Telegram.open);
          },
          child: const Text('Open Telegram App'),
        ),
        const SizedBox(height: 16),
        const Text('Profile Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: _usernameController,
          decoration: const InputDecoration(
            labelText: 'Telegram Username',
            hintText: 'Enter Telegram username',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _phoneController,
          decoration: const InputDecoration(
            labelText: 'Phone Number (with country code)',
            hintText: 'e.g., 1234567890 for US',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  if (_usernameController.text.isNotEmpty) {
                    await _deeplinkX.launchAction(Telegram.openProfile(_usernameController.text));
                  }
                },
                child: const Text('Open Profile by Username'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  if (_phoneController.text.isNotEmpty) {
                    await _deeplinkX.launchAction(Telegram.openProfilePhoneNumber(_phoneController.text));
                  }
                },
                child: const Text('Open Profile by Phone'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Message Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: _messageController,
          decoration: const InputDecoration(
            labelText: 'Message',
            hintText: 'Enter message to send',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  if (_usernameController.text.isNotEmpty && _messageController.text.isNotEmpty) {
                    await _deeplinkX.launchAction(
                      Telegram.sendMessage(_usernameController.text, _messageController.text),
                    );
                  }
                },
                child: const Text('Send Message by Username'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  if (_phoneController.text.isNotEmpty && _messageController.text.isNotEmpty) {
                    await _deeplinkX.launchAction(
                      Telegram.sendMessagePhoneNumber(_phoneController.text, _messageController.text),
                    );
                  }
                },
                child: const Text('Send Message by Phone'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
