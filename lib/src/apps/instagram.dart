import '../core/app_action.dart';
import '../core/enums/action_type_enum.dart';

/// Instagram-specific action types that define available deeplink actions
enum InstagramActionType implements ActionTypeEnum {
  /// Opens the Instagram app
  open,

  /// Opens a specific Instagram profile
  openProfile,
}

/// Instagram action implementation for handling Instagram-specific deeplinks
class InstagramAction extends AppAction {
  /// Base URI for Instagram app deeplinks
  static const baseUrl = 'instagram://';

  /// Base URI for Instagram web fallback
  static const fallBackUri = 'https://www.instagram.com';

  /// The type of Instagram action to perform
  final InstagramActionType type;

  /// Creates a new Instagram action
  ///
  /// [type] specifies the type of action to perform
  /// [parameters] contains any additional data needed for the action
  const InstagramAction(
    this.type, {
    super.parameters,
  }) : super(actionType: type);

  @override
  Future<List<Uri>> getUris() async {
    final List<Uri> uris = [];

    switch (type) {
      case InstagramActionType.open:
        uris.add(Uri.parse(baseUrl));
        uris.add(Uri.parse(fallBackUri));
      case InstagramActionType.openProfile:
        final username = parameters!['username'];
        uris.add(Uri.parse('${baseUrl}user?username=$username'));
        uris.add(Uri.parse('$fallBackUri/$username'));
    }

    return uris;
  }
}

/// Utility class for creating Instagram deeplink actions
class Instagram {
  /// Opens the Instagram app
  static const InstagramAction open = InstagramAction(InstagramActionType.open);

  /// Opens a specific Instagram profile
  ///
  /// [username] is the Instagram username to open
  static InstagramAction openProfile(String username) => InstagramAction(
        InstagramActionType.openProfile,
        parameters: {'username': username},
      );
}
