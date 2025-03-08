import '../core/app_action.dart';
import '../core/enums/action_type_enum.dart';

/// Instagram-specific action types
enum InstagramActionType implements ActionTypeEnum {
  open,
  openProfile,
}

/// Instagram action implementation
class InstagramAction extends AppAction {
  static const baseUrl = 'instagram://';
  static const fallBackUri = 'https://www.instagram.com';

  final InstagramActionType type;

  InstagramAction(
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

/// Instagram deeplink builder class for easy usage
class Instagram {
  static InstagramAction open = InstagramAction(InstagramActionType.open);

  static InstagramAction openProfile(String username) => InstagramAction(
        InstagramActionType.openProfile,
        parameters: {'username': username},
      );
}
