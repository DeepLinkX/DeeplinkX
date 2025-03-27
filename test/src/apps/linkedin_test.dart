import 'package:deeplink_x/src/apps/downloadable_apps/linkedin.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LinkedIn', () {
    test('openProfile action creates correct URIs', () async {
      final action = LinkedIn.openProfile('john-doe');
      expect(await action.getNativeUri(), Uri.parse('linkedin://profile/john-doe'));
      expect(await action.getFallbackUri(), Uri.parse('https://www.linkedin.com/in/john-doe'));
    });

    test('openCompany action creates correct URIs', () async {
      final action = LinkedIn.openCompany('example-company');
      expect(await action.getNativeUri(), Uri.parse('linkedin://company/example-company'));
      expect(await action.getFallbackUri(), Uri.parse('https://www.linkedin.com/company/example-company'));
    });

    test('parameters are correctly stored for openProfile', () {
      final action = LinkedIn.openProfile('john-doe');
      expect(action.parameters, {
        'profileId': 'john-doe',
      });
    });

    test('parameters are correctly stored for sendMessagePhoneNumber', () {
      final action = LinkedIn.openCompany('example-company');
      expect(action.parameters, {
        'companyId': 'example-company',
      });
    });
  });
}
