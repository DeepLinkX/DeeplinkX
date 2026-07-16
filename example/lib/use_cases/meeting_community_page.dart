import 'package:deeplink_x/deeplink_x.dart';
import 'package:deeplink_x_example/use_cases/use_case_support.dart';
import 'package:flutter/material.dart';

/// Demonstrates meeting and community deeplink workflows.
class MeetingCommunityPage extends StatefulWidget {
  /// Creates the meeting-and-community use case.
  const MeetingCommunityPage({this.deeplinkX, super.key});

  /// Optional launcher override used by widget tests.
  final DeeplinkX? deeplinkX;

  @override
  State<MeetingCommunityPage> createState() => _MeetingCommunityPageState();
}

class _MeetingCommunityPageState extends State<MeetingCommunityPage> {
  late final DeeplinkX _deeplinkX = widget.deeplinkX ?? DeeplinkX();
  final _meetingIdController = TextEditingController();
  final _meetingPasswordController = TextEditingController();
  final _displayNameController = TextEditingController(text: 'DeeplinkX Guest');
  final _teamIdController = TextEditingController();
  final _channelIdController = TextEditingController();
  bool _launching = false;

  @override
  void dispose() {
    _meetingIdController.dispose();
    _meetingPasswordController.dispose();
    _displayNameController.dispose();
    _teamIdController.dispose();
    _channelIdController.dispose();
    super.dispose();
  }

  Future<void> _launch(final AppAction action) async {
    if (_launching) {
      return;
    }
    setState(() => _launching = true);
    final result = await _deeplinkX.launchAction(action);
    if (!mounted) {
      return;
    }
    setState(() => _launching = false);
    showLaunchResult(context, succeeded: result);
  }

  Future<void> _joinMeeting() async {
    final meetingId = _meetingIdController.text.trim();
    if (meetingId.isEmpty) {
      showInputError(context, 'Enter a Zoom meeting ID.');
      return;
    }
    await _launch(
      Zoom.joinMeeting(
        meetingId: meetingId,
        password: _meetingPasswordController.text.trim().isEmpty ? null : _meetingPasswordController.text.trim(),
        displayName: _displayNameController.text.trim().isEmpty ? null : _displayNameController.text.trim(),
      ),
    );
  }

  Future<void> _openChannel() async {
    final teamId = _teamIdController.text.trim();
    final channelId = _channelIdController.text.trim();
    if (teamId.isEmpty || channelId.isEmpty) {
      showInputError(context, 'Enter both Slack workspace and channel IDs.');
      return;
    }
    await _launch(Slack.openChannel(teamId: teamId, channelId: channelId));
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Meeting & Community')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _CollaborationCard(
          title: 'Join a Zoom meeting',
          assetName: 'assets/zoom.png',
          children: [
            TextField(
              key: const ValueKey('zoom-meeting-id'),
              controller: _meetingIdController,
              decoration: const InputDecoration(
                labelText: 'Meeting ID',
                hintText: '0000000000 (replace before launching)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _meetingPasswordController,
              decoration: const InputDecoration(labelText: 'Password (optional)', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _displayNameController,
              decoration: const InputDecoration(labelText: 'Display name (optional)', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              key: const ValueKey('join-zoom'),
              onPressed: _launching ? null : _joinMeeting,
              icon: const Icon(Icons.video_call),
              label: const Text('Join meeting'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _CollaborationCard(
          title: 'Open a Slack channel',
          assetName: 'assets/slack.png',
          children: [
            TextField(
              key: const ValueKey('slack-team-id'),
              controller: _teamIdController,
              decoration: const InputDecoration(
                labelText: 'Workspace ID',
                hintText: 'T00000000 (replace before launching)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              key: const ValueKey('slack-channel-id'),
              controller: _channelIdController,
              decoration: const InputDecoration(
                labelText: 'Channel ID',
                hintText: 'C00000000 (replace before launching)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              key: const ValueKey('open-slack'),
              onPressed: _launching ? null : _openChannel,
              icon: const Icon(Icons.forum),
              label: const Text('Open channel'),
            ),
          ],
        ),
        if (_launching) const Center(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator())),
      ],
    ),
  );
}

class _CollaborationCard extends StatelessWidget {
  const _CollaborationCard({required this.title, required this.assetName, required this.children});

  final String title;
  final String assetName;
  final List<Widget> children;

  @override
  Widget build(final BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              UseCaseLeading(assetName: assetName),
              const SizedBox(width: 12),
              Expanded(child: Text(title, style: Theme.of(context).textTheme.titleMedium)),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    ),
  );
}
