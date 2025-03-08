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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('DeeplinkX Example'),
            bottom: const TabBar(
              tabs: [Tab(text: 'Instagram'), Tab(text: 'LinkedIn')],
            ),
          ),
          body: TabBarView(
            children: [_buildInstagramTab(), _buildLinkedInTab()],
          ),
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
          const Text(
            'Instagram Actions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _buildInstagramActions(),
        ],
      ),
    );
  }

  Widget _buildLinkedInTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'LinkedIn Actions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _buildLinkedInActions(),
        ],
      ),
    );
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
        ElevatedButton(
          onPressed: () async {
            await _deeplinkX.launchAction(
              Instagram.openProfile('example_user'),
            );
          },
          child: const Text('Open Profile'),
        ),
      ],
    );
  }

  Widget _buildLinkedInActions() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'LinkedIn support coming soon!',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
