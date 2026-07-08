# Medium Article Claim Audit

Source article:
- [Why DeeplinkX Beats url_launcher for External App Deep Linking in Flutter](https://medium.com/@parham.dev/why-deeplinkx-beats-url-launcher-for-external-app-deep-linking-in-flutter-0c7d8bdb3409)

Use this sheet to ensure every article claim is backed by code/docs/tests.

| Claim | Evidence Path(s) | Status (`Verified`/`Needs proof`/`Revise`) | Notes |
| --- | --- | --- | --- |
| DeeplinkX supports external app deeplinks across multiple providers | `README.md`, `lib/src/apps/downloadable_apps/downloadable_apps.dart` | Verified | Keep provider list synchronized with README table |
| DeeplinkX supports store fallback | `lib/src/core/deeplink_x.dart`, `doc/recipes/fallback_strategy_examples.md` | Verified | Mention behavior with `fallbackToStore` |
| DeeplinkX supports web fallback | `lib/src/core/deeplink_x.dart`, `doc/apps/telegram.md`, `doc/apps/google_maps.md`, `doc/apps/baidu_maps.md` | Verified | Validate examples per provider |
| DeeplinkX supports install checks | `lib/src/core/deeplink_x.dart`, `README.md` | Verified | Include `isAppInstalled` snippet |
| DeeplinkX is better for multi-feature apps | `doc/recipes/multi_feature_app_menu.md` | Needs proof | Keep language implementation-focused, avoid absolute performance claims |
| DeeplinkX has reliable provider-specific behavior | `test/src/apps/telegram_test.dart`, `test/src/apps/google_maps_test.dart`, `test/src/apps/baidu_maps_test.dart`, `test/src/apps/amap_test.dart`, `test/src/apps/whatsapp_test.dart` | Verified | Add more test references as needed |

## Review Notes
- Do not publish claims without evidence links.
- Avoid unverifiable superlatives.
- Keep language practical: use case, behavior, and maintenance value.
