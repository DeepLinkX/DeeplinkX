import 'package:deeplink_x/deeplink_x.dart';
import 'package:deeplink_x_example/use_cases/use_case_support.dart';
import 'package:deeplink_x_example/widgets/blocks.dart';
import 'package:deeplink_x_example/widgets/inputs.dart';
import 'package:deeplink_x_example/widgets/screen_header.dart';
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
    body: SafeArea(
      child: Column(
        children: [
          const ScreenHeader(title: 'Meeting & Community'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
              children: [
                FormCard(
                  assetName: 'assets/zoom.png',
                  title: 'Join a Zoom meeting',
                  fields: [
                    LabeledField(
                      key: const ValueKey('zoom-meeting-id'),
                      label: 'Meeting ID',
                      controller: _meetingIdController,
                      placeholder: '0000000000 (replace before launching)',
                      keyboardType: TextInputType.number,
                    ),
                    LabeledField(label: 'Password (optional)', controller: _meetingPasswordController),
                    LabeledField(label: 'Display name (optional)', controller: _displayNameController),
                  ],
                  buttonIcon: Icons.videocam_rounded,
                  buttonLabel: 'Join meeting',
                  buttonKey: const ValueKey('join-zoom'),
                  onPressed: _joinMeeting,
                ),
                const SizedBox(height: 12),
                FormCard(
                  assetName: 'assets/slack.png',
                  title: 'Open a Slack channel',
                  fields: [
                    LabeledField(
                      key: const ValueKey('slack-team-id'),
                      label: 'Workspace ID',
                      controller: _teamIdController,
                      placeholder: 'T00000000 (replace before launching)',
                    ),
                    LabeledField(
                      key: const ValueKey('slack-channel-id'),
                      label: 'Channel ID',
                      controller: _channelIdController,
                      placeholder: 'C00000000 (replace before launching)',
                    ),
                  ],
                  buttonIcon: Icons.forum_rounded,
                  buttonLabel: 'Open channel',
                  buttonKey: const ValueKey('open-slack'),
                  onPressed: _openChannel,
                ),
                if (_launching)
                  const Center(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator())),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
