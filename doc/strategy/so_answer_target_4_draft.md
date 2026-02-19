# Stack Overflow Draft: Target 4

## Suggested question title
Flutter: check if external app is installed before launching deeplink

## Draft answer
Use `isAppInstalled` first, then branch into your preferred action.

```dart
import 'package:deeplink_x/deeplink_x.dart';

final deeplinkX = DeeplinkX();

Future<void> openLinkedInProfile() async {
  final installed = await deeplinkX.isAppInstalled(LinkedIn());

  if (installed) {
    await deeplinkX.launchAction(
      LinkedIn.openProfile(
        username: 'john-doe',
      ),
      disableFallback: true,
    );
  } else {
    await deeplinkX.redirectToStore(
      storeActions: [
        IOSAppStore.openAppPage(appId: '288429040', appName: 'linkedin-networking-job-search'),
        PlayStore.openAppPage(packageName: 'com.linkedin.android'),
      ],
    );
  }
}
```

Proof links:
- `isAppInstalled` API: https://github.com/DeepLinkX/DeeplinkX/blob/master/lib/src/core/deeplink_x.dart
- LinkedIn docs: https://github.com/DeepLinkX/DeeplinkX/blob/master/doc/apps/linkedin.md
