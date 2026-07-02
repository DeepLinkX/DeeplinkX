# pub.dev Keyword Visibility Report

Generated: 2026-07-01

Package audited: `deeplink_x`

## Scope

This report checks where `deeplink_x` appears in pub.dev search results for app-specific, deeplink, external-app, store fallback, map/navigation, URL scheme, and competitor-style keywords.

The goal is to understand which searches `deeplink_x` already owns, which searches are controlled by app-specific competitors, and which metadata terms may be worth strengthening.

## Method

- Source: pub.dev package search API and pub.dev package pages.
- Ranking mode: pub.dev default search ranking.
- Page size assumption: 10 results per page.
- Rank format: `#position pPage`.
- `not in top 50` means the package was not found in the first 5 pub.dev API pages for that query.
- `not in top 60` means the package was not found in the first 6 pub.dev API pages for that query.
- `not in top 80` / `not in top 100` means a wider app-specific scan did not find the package in that range.
- Search results are time-sensitive and can change as pub.dev reindexes, downloads change, likes change, or package metadata changes.

Sources:

- <https://pub.dev/packages/deeplink_x>
- <https://pub.dev/api/packages/deeplink_x>
- <https://pub.dev/api/packages/deeplink_x/score>
- <https://pub.dev/help/search#ranking>
- <https://pub.dev/api/search?q=deeplink>
- Medium article search results for Flutter deeplinks, WhatsApp, Google Maps, universal links, and `url_launcher`

## Current Published Package Signals

pub.dev currently reports `deeplink_x` latest as `1.3.3`.

Local repository note: the local `pubspec.yaml` is `1.3.4` and includes Amap-related work. Amap visibility should be rechecked after that version is published and indexed.

Current visible score signals from pub.dev:

| Signal | Value |
| --- | ---: |
| Pub points | 160 / 160 |
| Likes | 12 |
| 30-day downloads | 436 |
| Topics | `deeplink`, `app-links`, `maps`, `navigation`, `open-store` |

## Executive Summary

`deeplink_x` is strong for high-intent deeplink searches. It ranks #1 for most `<app> deeplink` searches, including WhatsApp, Telegram, Instagram, YouTube, TikTok, Pinterest, Zoom, Slack, Google Maps, Apple Maps, Waze, Sygic, and Neshan.

The package is weaker for bare app-name searches such as `whatsapp`, `telegram`, `instagram`, `youtube`, and `zoom`. This is expected: pub.dev favors packages whose names and descriptions exactly match the app name, plus packages with more likes/downloads.

An additional human-search pass found that developer-style phrasing behaves differently from tidy keyword phrases. DeeplinkX is very strong for `open google maps flutter`, `launch google maps flutter`, `open maps directions flutter`, `open waze flutter`, `flutter fallback to app store`, and `flutter external deeplink`. It is weaker for casual phrasing like `open whatsapp from flutter`, `flutter open another app`, `flutter deep link to another app`, `flutter open app by package name`, and `flutter ... without url_launcher`.

Medium article search reinforces this: article titles and snippets are usually written as tasks, not package taxonomy. Common phrases include "open WhatsApp directly from Flutter", "phone number and message", "open Google Map and show navigation", "launch maps from Flutter with coordinates", "Google Maps & URL Launcher", "deep linking and universal linking", "custom scheme deep link", and "without package".

The strongest non-app categories are:

- Store fallback: `store fallback`, `fallback to store`, `app store deeplink`, `play store deeplink`, `app store link`
- External-app intent: `open external app`, `launch external app`, `external app`
- Social deeplink intent: `social deeplink`, `social deep link`, `open social app`, `launch social app`
- Provider-specific maps: `google maps link`, `google maps deeplink`, `apple maps link`, `apple maps deeplink`, `waze link`, `waze deeplink`

The weakest categories are:

- URL scheme terms: `url scheme`, `custom url scheme`, `ios url scheme`, `android intent`
- Generic launcher terms: `url launcher`, `flutter launcher`, `external app launcher`, `map launcher`
- Inbound/routing terms: `deep linking`, `flutter deep linking`, `navigation`, `navigate`
- Installation-check terms: `is app installed`, `check app installed`
- Human phrasing gaps: `from Flutter`, `another app`, `without url_launcher`, `by package name`, `send WhatsApp message`
- Medium/article phrases: `phone number and message`, `pre-filled message`, `show navigation`, `given coordinates`, `universal linking`, `custom scheme`, `without package`

## App-Specific Competitor Matrix

| App | Plain app query | App link query | App deeplink query | Main packages above DeeplinkX |
| --- | ---: | ---: | ---: | --- |
| WhatsApp | not in top 100 | #12 p2 | #1 p1 | `whatsapp`, `whatsapp_unilink` |
| Telegram | not in top 100 | #7 p1 | #1 p1 | `telegram`, `telegram_link` |
| Instagram | not in top 100 | #7 p1 | #1 p1 | `instagram` |
| Facebook | not in top 100 | #11 p2 | #4 p1 | `flutter_facebook_app_links`, `flutter_facebook_deeplinks`, `facebook_deeplinks` |
| LinkedIn | #68 p7 | #12 p2 | #1 p1 | `linkedin_login` |
| Twitter | not in top 100 | #10 p1 | #2 p1 | `twitter`, `twitter_login` |
| Threads | #43 p5 | #2 p1 | #1 p1 | `threads_client_grpc` on plain query |
| YouTube | not in top 100 | #6 p1 | #1 p1 | `youtube`, `youtube_validator`, player/API packages |
| TikTok | #56 p6 | #3 p1 | #1 p1 | `tiktok_events_sdk`, `tiktok_api` |
| Pinterest | #13 p2 | #1 p1 | #1 p1 | `pinterest_nav_bar` on plain query |
| Zoom | not in top 100 | #5 p1 | #1 p1 | `zoom`, `gr_zoom` |
| Slack | #34 p4 | #2 p1 | #1 p1 | `slack`, `slack_logger` |
| Google Maps | #28 p3 | #1 p1 | #1 p1 | `google_maps`, `google_maps_flutter` |
| Apple Maps | #15 p2 | #1 p1 | #1 p1 | `apple_maps`, `apple_maps_flutter` |
| Waze | #1 p1 | #1 p1 | #1 p1 | none above DeeplinkX |
| Sygic | #2 p1 | not rechecked | #1 p1 | `map_launcher` on plain query |
| Neshan | #5 p1 | not rechecked | #1 p1 | `neshan_maps_flutter`, `neshanmap_flutter`, `map_launcher` |
| Amap | publish/recheck needed | publish/recheck needed | publish/recheck needed | local support exists, but current pub.dev latest is `1.3.3` |

### App Matrix Takeaways

- Deeplink intent is excellent: most `<app> deeplink` terms rank #1.
- Facebook is the biggest deeplink-specific gap: `facebook deeplink` ranks #4 because Facebook-specific packages outrank it.
- Twitter is also worth watching: `twitter deeplink` ranks #2 behind `twitter_login`.
- WhatsApp link intent is controlled by `whatsapp_unilink`, which has exact name/description relevance and stronger popularity signals.
- Bare app-name discovery is not the primary battle to win. Those searches are too broad and often mean SDK, player, auth, sharing, UI, or map-rendering packages.

## Expanded Keyword Audit

### Core Deeplink Terms

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `deeplink` | #3 p1 | `app_links`, `flutter_branch_sdk` |
| `deep link` | #6 p1 | `app_links`, `flutter_branch_sdk`, `flutter_facebook_app_links`, `chottu_link`, `stack_deferred_link` |
| `deep links` | #6 p1 | `deep_links`, `app_links`, `flutter_branch_sdk`, `flutter_facebook_app_links`, `chottu_link` |
| `deep linking` | not in top 60 | `go_router`, `auto_route`, `kiwi`, `go_router_builder`, `zenrouter` |
| `flutter deeplink` | #3 p1 | `app_links`, `flutter_branch_sdk` |
| `flutter deep link` | #6 p1 | `app_links`, `flutter_branch_sdk`, `flutter_facebook_app_links`, `stack_deferred_link` |
| `flutter deep linking` | not in top 60 | `flutter_deep_linking`, `go_router`, `kiwi`, `zenrouter`, `protocol_handler` |
| `deeplink package` | #8 p1 | several small SDK/router packages |
| `deeplink plugin` | not in top 60 | `flutter_branch_sdk`, `urlynk_flutter`, `flutter_deep_links` |
| `deeplink flutter package` | #7 p1 | several deep-link SDK/router packages |
| `deep link plugin` | not in top 60 | `flutter_branch_sdk`, `flutter_facebook_app_links`, `stack_deferred_link` |
| `deep link package` | #10 p1 | several deep-link SDK/router packages |
| `external deeplink` | #1 p1 | DeeplinkX leads |
| `external deep link` | #1 p1 | DeeplinkX leads |
| `type safe deeplink` | #1 p1 | DeeplinkX leads |
| `typed deeplink` | #1 p1 | DeeplinkX leads |
| `deeplink launcher` | not found in scanned result set | `webf_deeplink`, `sojo_link`, others |

### App Links and URL Scheme Terms

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `app links` | #9 p1 | `app_links`, `whatsapp_unilink`, `flutter_branch_sdk`, `flutter_share` |
| `app link` | #6 p1 | `app_links`, `whatsapp_unilink`, `flutter_branch_sdk`, `flutter_facebook_app_links` |
| `app-links` | #9 p1 | `app_links`, `whatsapp_unilink`, `flutter_branch_sdk`, `flutter_share` |
| `universal links` | #29 p3 | `universal_links`, `app_links`, `whatsapp_unilink`, `flutter_branch_sdk` |
| `universal link` | #27 p3 | `app_links`, `whatsapp_unilink`, `flutter_branch_sdk`, `link_bridge` |
| `custom url scheme` | not in top 60 | `appscheme`, `app_links`, `link_bridge`, `uni_links3` |
| `custom url schemes` | #35 p4 | `app_links`, `flutter_branch_sdk`, `link_bridge`, `appscheme` |
| `url scheme` | not in top 60 | `appscheme`, `android_scheme_search`, `app_links`, `url_launcher` |
| `url schemes` | #53 p6 | `url_launcher`, `app_links`, `flutter_branch_sdk`, `telegram` |
| `scheme launcher` | not in top 60 | `url_launcher`, `maps_launcher`, `external_app_launcher` |
| `intent launcher` | not in top 60 | `intent_launcher`, `url_launcher`, `android_intent_plus` |
| `android intent` | not in top 60 | `android_intent`, `open_file`, `android_intent_plus`, `share_plus` |
| `ios url scheme` | not in top 60 | `appscheme`, `app_links`, `ios_native_utils`, `link_bridge` |

### Open and Launch External Apps

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `open app` | #26 p3 | `open_app`, `open_file`, `serverpod`, icon packages |
| `launch app` | #15 p2 | `launchapp`, launcher icon packages, `appcheck`, `external_app_launcher` |
| `open external app` | #2 p1 | `external_app_launcher` |
| `launch external app` | #3 p1 | `launchexternalapp`, `external_app_launcher` |
| `external app` | #3 p1 | `external_app_launcher`, `dropbox_client` |
| `external app launcher` | not in top 60 | `external_app_launcher`, `app_activity_launcher`, `external_app_launcher_plus` |
| `flutter open app` | #20 p2 | `flutter_open_app`, `open_file`, `serverpod`, icon packages |
| `flutter launch app` | #14 p2 | launcher icon packages, `appcheck`, `external_app_launcher` |
| `flutter app launcher` | not in top 60 | launcher icon packages and package launchers |
| `open installed app` | #12 p2 | mail/app-check packages |
| `launch installed app` | #12 p2 | `appcheck`, `app_launcher`, `open_mail_launcher` |
| `is app installed` | not in top 60 | `is_app_installed`, `appcheck`, `check_app_version`, `app_install_checker` |
| `check app installed` | not in top 60 | `appcheck`, `check_app_version`, `device_apps_plus`, `app_install_checker` |
| `app installed flutter` | #59 p6 | `appcheck`, `installed_apps`, `app_launcher`, `open_mail` |

### Store Fallback and Redirect

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `store fallback` | #1 p1 | DeeplinkX leads |
| `app fallback` | #1 p1 | DeeplinkX leads |
| `web fallback` | #23 p3 | unrelated web/media/image packages ahead |
| `smart fallback` | #1 p1 | DeeplinkX leads |
| `fallback to store` | #1 p1 | DeeplinkX leads |
| `fallback app store` | #1 p1 | DeeplinkX leads |
| `store redirect` | #4 p1 | `store_redirect`, `flutter_app_update_lib`, `store_redirect2` |
| `app store redirect` | #4 p1 | `store_redirect`, `flutter_app_update_lib`, `store_redirect2` |
| `open store` | #5 p1 | `open_store`, `geoflutterfire2`, `app_review`, `geoflutterfire` |
| `open app store` | #3 p1 | `open_appstore`, `app_review` |
| `open play store` | #10 p1 | update/install-referrer packages |
| `google play redirect` | #7 p1 | `store_redirect`, `store_redirect2`, icon packages |
| `play store deeplink` | #1 p1 | DeeplinkX leads |
| `app store deeplink` | #1 p1 | DeeplinkX leads |
| `app store link` | #1 p1 | DeeplinkX leads |
| `google play link` | #4 p1 | integrity/update/checker packages |
| `redirect to store` | #3 p1 | `store_redirect`, `store_redirect2` |

### Maps and Navigation

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `maps` | #47 p5 | map rendering/toolkit packages |
| `map` | not in top 60 | `map`, `flutter_map`, `dart_mappable`, `map_launcher`, `maps_toolkit` |
| `map launcher` | not in top 60 | `map_launcher`, `maps_launcher`, `mappls_map_launcher` |
| `maps launcher` | not in top 60 | `maps_launcher`, `map_launcher`, `mappls_map_launcher` |
| `open map` | #44 p5 | `maps_launcher`, picker/search packages |
| `open maps` | #3 p1 | `maps_launcher`, `location_picker_flutter_map` |
| `launch maps` | #3 p1 | `map_launcher`, `maps_launcher` |
| `flutter maps launcher` | not in top 60 | `map_launcher`, `maps_launcher`, `mappls_map_launcher` |
| `navigation` | not in top 60 | routing/navigation UI packages |
| `navigate` | not in top 60 | routing/navigation UI packages |
| `directions` | #12 p2 | `map_launcher`, UI packages |
| `get directions` | #12 p2 | `google_maps_directions`, `map_launcher` |
| `map directions` | #16 p2 | Google Maps API/routes packages |
| `turn by turn` | not in top 60 | Mapbox/Vietmap/Situm navigation packages |
| `turn by turn navigation` | #39 p4 | Mapbox/Vietmap/Situm navigation packages |
| `google maps link` | #1 p1 | DeeplinkX leads |
| `google maps deeplink` | #1 p1 | DeeplinkX leads |
| `apple maps link` | #1 p1 | DeeplinkX leads |
| `apple maps deeplink` | #1 p1 | DeeplinkX leads |
| `waze link` | #1 p1 | DeeplinkX leads |
| `waze deeplink` | #1 p1 | DeeplinkX leads |

### Social Deeplink Terms

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `social app` | #2 p1 | `appinio_social_share` |
| `social apps` | #2 p1 | `social_share` |
| `social deeplink` | #1 p1 | DeeplinkX leads |
| `social deep link` | #1 p1 | DeeplinkX leads |
| `social link` | #2 p1 | `social_link` |
| `social media link` | not in top 60 | social share/link generator packages |
| `open social app` | #1 p1 | DeeplinkX leads |
| `launch social app` | #1 p1 | DeeplinkX leads |
| `social app launcher` | not found in scanned result set | launcher/icon packages |

### Competitor and Alternative Intent

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `url launcher` | not in top 60 | `url_launcher` federated packages |
| `url_launcher` | not in top 60 | `url_launcher` federated packages |
| `url launcher alternative` | not found in scanned result set | `sojo_link`, `mailto`, other small packages |
| `url_launcher alternative` | not found in scanned result set | `sojo_link`, `mailto`, other small packages |
| `app links alternative` | not in top 60 | `appsonair_flutter_applink`, `sojo_link`, `media_link_generator` |
| `map launcher alternative` | not found in scanned result set | `sojo_link`, `android_native` |
| `external app launcher alternative` | not found in scanned result set | `android_native`, `intent_plus` |
| `flutter launcher` | not in top 60 | `url_launcher`, launcher icon packages, `map_launcher`, `maps_launcher` |

## Human Search Query Expansion

This section covers related phrases that were not in the first pass but are closer to how Flutter developers often search. These queries include natural wording like "from Flutter", "another app", "if installed", "by package name", and "without url_launcher".

### Human App Action Searches

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `open whatsapp flutter` | #10 p1 | `open_share_plus`, `flutter_plugin_openwhatsapp`, `flutter_open_whatsapp` |
| `open whatsapp from flutter` | not in top 50 | `whatsapp`, icon packages |
| `open whatsapp chat flutter` | #16 p2 | icon packages dominate the first page |
| `send whatsapp message flutter` | not in top 50 | `flutter_open_whatsapp`, `whatsapp`, `whatsapp_sender_flutter` |
| `whatsapp chat link flutter` | #15 p2 | `chat_bubbles`, `whatsapp_unilink`, icon packages |
| `open telegram flutter` | #5 p1 | `photo_opener`, `telegram`, `flutter_telegram_miniapp` |
| `open telegram from flutter` | not in top 50 | Telegram utility and icon packages |
| `open telegram profile flutter` | #10 p1 | icon packages dominate the first page |
| `open instagram flutter` | #3 p1 | `getwidget`, `external_app_launcher` |
| `open instagram profile flutter` | #10 p1 | `profile_view`, icon packages |
| `open youtube flutter` | #3 p1 | `simple_circular_progress_bar`, `flutterando_analysis` |
| `open youtube video flutter` | #26 p3 | YouTube/video player packages |
| `open tiktok flutter` | #2 p1 | `flutter_tiktoken` |
| `open linkedin profile flutter` | #11 p2 | LinkedIn auth packages |
| `open slack flutter` | #1 p1 | DeeplinkX leads |

### Human Map Searches

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `open google maps flutter` | #1 p1 | DeeplinkX leads |
| `open google maps from flutter` | not in top 50 | Google Maps widget/place-picker packages |
| `launch google maps flutter` | #1 p1 | DeeplinkX leads |
| `google maps directions flutter` | #2 p1 | `flutter_google_maps_webservices` |
| `open location in google maps flutter` | #2 p1 | `place_picker_google` |
| `open maps directions flutter` | #1 p1 | DeeplinkX leads |
| `open apple maps flutter` | #2 p1 | `maps_launcher` |
| `open waze flutter` | #1 p1 | DeeplinkX leads |
| `launch waze flutter` | #1 p1 | DeeplinkX leads |
| `open map app flutter` | #4 p1 | map picker/launcher packages |
| `open maps app flutter` | #1 p1 | DeeplinkX leads |
| `flutter open navigation app` | #1 p1 | DeeplinkX leads |
| `flutter map directions app` | #3 p1 | `mappls_map_launcher`, Google Maps API packages |

### Human External App Searches

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `flutter open another app` | not in top 50 | `external_app_launcher`, `external_app_launcher_plus` |
| `flutter launch another app` | not in top 50 | `external_app_launcher`, `external_app_launcher_plus` |
| `flutter open external app` | #2 p1 | `external_app_launcher` |
| `flutter launch external app` | #2 p1 | `external_app_launcher` |
| `flutter open installed app` | #9 p1 | mail/app-list packages |
| `flutter launch installed app` | #12 p2 | `appcheck`, `app_launcher` |
| `flutter check app installed` | #46 p5 | `appcheck`, `check_app_version`, app availability packages |
| `flutter check if app installed` | #50 p5 | `appcheck`, app availability packages |
| `flutter is app installed` | not in top 50 | `appcheck`, app availability packages |
| `flutter open app by package name` | not in top 50 | `openapp_by_package` |
| `flutter open app with package name` | not in top 50 | package-name/open-file packages |
| `flutter app to app launch` | #9 p1 | `appcheck`, `external_app_launcher`, store/launcher packages |
| `flutter launch app by package name` | not in top 50 | `app_launcher_packagename` |
| `flutter open app if installed` | #16 p2 | mail/app availability packages |

### Human Deep Link and Scheme Searches

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `flutter deep link to another app` | not found in scanned result set | `uni_links` variants |
| `flutter deeplink to another app` | not found in scanned result set | unrelated small packages |
| `flutter external deep link` | #1 p1 | DeeplinkX leads |
| `flutter external deeplink` | #1 p1 | DeeplinkX leads |
| `flutter open url scheme` | #7 p1 | `app_links`, `maps_launcher`, `url_launcher`, `external_app_launcher` |
| `flutter launch url scheme` | #11 p2 | `url_launcher`, `launchify`, custom-tab/launcher packages |
| `flutter custom url scheme` | #47 p5 | `appscheme`, `app_links`, `link_bridge`, `uni_links3` |
| `flutter custom scheme` | not in top 50 | color-scheme packages and `appscheme` |
| `flutter android intent open app` | #28 p3 | open-file packages |
| `flutter launch android intent` | #33 p4 | `upi_intent`, `flutter_android_intent`, `android_intent_plus` |
| `flutter ios url scheme` | not in top 50 | `appscheme`, `app_links`, `ios_native_utils` |
| `flutter open universal link` | #3 p1 | `app_links`, `whatsapp_unilink` |

### Human Store Searches

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `flutter open app store` | #3 p1 | `flutter_open_app_store`, `app_review` |
| `flutter open play store` | #9 p1 | update/store packages |
| `flutter redirect to app store` | #3 p1 | `store_redirect`, `store_redirect2` |
| `flutter redirect to play store` | #6 p1 | store/update packages |
| `flutter store redirect` | #4 p1 | `store_redirect`, update packages |
| `flutter fallback to app store` | #1 p1 | DeeplinkX leads |
| `flutter fallback to play store` | #1 p1 | DeeplinkX leads |
| `flutter app store fallback` | #1 p1 | DeeplinkX leads |
| `flutter play store link` | #4 p1 | update/checker packages |
| `flutter app store link` | #1 p1 | DeeplinkX leads |
| `flutter open store listing` | #4 p1 | review/store-listing packages |
| `flutter open app page in store` | #3 p1 | `store_redirect`, `app_review` |

### Human Alternative Searches

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `url launcher alternative flutter` | not found in scanned result set | `simple_html_css`, `mailto`, `sojo_link` |
| `flutter url launcher alternative` | not found in scanned result set | `simple_html_css`, `mailto`, `sojo_link` |
| `map launcher alternative flutter` | not found in scanned result set | `sojo_link` |
| `external app launcher alternative flutter` | not found in scanned result set | unrelated native/intent packages |
| `app links alternative flutter` | not in top 50 | `appsonair_flutter_applink`, `gpt_markdown`, `mailto`, `sojo_link`, `link_bridge` |
| `flutter app links alternative` | not in top 50 | `appsonair_flutter_applink`, `gpt_markdown`, `mailto`, `sojo_link`, `link_bridge` |
| `flutter open app without url launcher` | not in top 50 | `url_launcher`, `route_pilot`, `enhanced_url_launcher`, `url_launcher2` |
| `flutter deeplink without url_launcher` | not found in scanned result set | very small result set |

## Medium Article Search Signals

This section is not a pub.dev rank table. It summarizes related Medium articles and the human phrases they use. These phrases are useful because developers often discover packages through Google/Medium-style searches before they search pub.dev directly.

### Representative Medium Results

| Theme | Representative article/result | Phrase signals |
| --- | --- | --- |
| WhatsApp from Flutter | [Open WhatsApp Directly from Flutter Using a Phone Number & Message](https://medium.com/@vinodbaste9/open-whatsapp-directly-from-flutter-using-a-phone-number-message-713e185df089) | open WhatsApp directly, phone number, message |
| WhatsApp from Flutter | [Open WhatsApp from Your Flutter App](https://medium.com/flutter-community/open-whatsapp-from-your-flutter-app-40e6828dd1f1) | open WhatsApp from Flutter app, phone number, text |
| WhatsApp direct message | [Send direct message to WhatsApp contacts & groups in Flutter](https://medium.com/flutter-community/send-direct-message-to-whatsapp-contacts-groups-in-flutter-8e0319d63316) | send direct message, contacts, groups |
| Google Maps directions | [Open Google map and show navigation in Flutter](https://medium.com/@kamranzafar128/open-google-map-and-show-navigation-in-flutter-e0cb6c634aae) | open Google Map, show navigation, Android intents, `url_launcher` |
| Google Maps with URL launcher | [Google Maps & URL Launcher in Flutter](https://medium.com/@shivani.patel18/google-maps-url-launcher-in-flutter-54cf6388b381) | Google Maps, URL Launcher, navigation |
| Launch maps with coordinates | [Launch Google Maps Or Apple Maps from Flutter App With Given Coordinates](https://medium.com/@rajaibrahimckl/launch-maps-or-ios-maps-from-flutter-app-with-given-coordinates-4a9c71e3e8a9) | launch maps, Apple Maps, given coordinates |
| Launch other apps | [Launch Other App From Your Flutter App](https://medium.com/@rk0936626/launch-other-app-from-your-flutter-app-ba8737d97545) | launch other app, `url_launcher`, open maps apps |
| Store redirect | [Easily Redirect Users to App Stores with Flutter's Store Redirect Plugin](https://medium.com/@flutternewshub/easily-redirect-users-to-app-stores-with-flutters-store-redirect-plugin-e75779ebbf10) | redirect users, Google Play Store, Apple App Store |
| Store fallback concept | [Deeplinking in Flutter](https://medium.com/nammaflutter/deeplinking-in-flutter-ad5a40759ef3) | app not installed, redirect to store, store fallback |
| Navigation apps | [Android Tutorial: Open Navigation for Google Maps, Waze, and HERE WeGo](https://medium.com/swlh/android-tutorial-open-navigation-for-google-maps-waze-and-here-wego-e40bf0cc4bfe) | open navigation, Google Maps, Waze, intents |
| Deep linking and universal linking | [Flutter Deep Linking & Universal Linking](https://medium.com/@darshankawar/flutter-deep-linking-universal-linking-2c2131d05c91) | deep linking, universal linking |
| App links package guide | [Implementing Deep Linking in Flutter Using app_links](https://medium.com/@daria.orlova/implementing-deep-linking-in-flutter-using-app-links-5d616f2c7709) | app_links, deep linking |
| Custom scheme | [Custom Scheme (Deep Link) Integration for iOS and Android in Flutter](https://medium.com/@vayongkeu/custom-scheme-deep-link-integration-for-ios-and-android-in-flutter-2c4fd4867c3f) | custom scheme, iOS, Android |
| Deep link without package | [Deep Link in Flutter Without Package](https://medium.com/@gireesh.kumar/deep-link-in-flutter-without-package-7cf993298acc) | without package, deep link |
| DeeplinkX comparison | [Why DeepLinkX Beats url_launcher for External App Deep Linking in Flutter](https://medium.com/@parham.dev/why-deeplinkx-beats-url-launcher-for-external-app-deep-linking-in-flutter-0c7d8bdb3409) | DeepLinkX vs url_launcher, external app deep linking, fallback handling |

### Medium-Derived Phrase Position Scan

These phrases were not fully covered by the first pub.dev keyword pass. The table below adds pub.dev positions for each remaining Medium-derived phrase.

### Pub.dev Positions for Medium-Derived Phrases

| Phrase | DeeplinkX pub.dev rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `open WhatsApp directly from Flutter` | not found in scanned result set | `whatsapp`, `whatsapp_direct_send`, `native_social_share`, `media_launcher_plugin`, `social_sender_whatsapp` |
| `WhatsApp phone number and message` | not in top 50 | `smart_phone_number`, icon packages |
| `WhatsApp phone number pre-filled message` | not found in scanned result set | `social_sender_whatsapp`, `whatsapp_launcher`, `whatsapp_direct_send` |
| `pre-filled WhatsApp message Flutter` | not found in scanned result set | `preferred_upi_launcher`, `social_sender_whatsapp`, `launcher_utils`, `universal_share`, `whatsapp_launcher` |
| `send WhatsApp message Flutter` | not in top 50 | `flutter_open_whatsapp`, `whatsapp`, `flutter_chatflow`, `whatsapp_sender_flutter`, `social_sender_whatsapp` |
| `open Telegram profile from Flutter` | not found in scanned result set | icon packages, `telegram`, `telegram_login` |
| `open Instagram profile from Flutter` | not found in scanned result set | icon/story packages |
| `open YouTube video from Flutter` | not in top 50 | icon packages |
| `open Google Map and show navigation` | not in top 50 | icon packages |
| `open Google Maps and show navigation Flutter` | not found in scanned result set | icon packages |
| `show navigation Flutter Google Maps` | not in top 50 | `map_launcher`, `google_maps_flutter`, `google_maps_widget`, icon packages |
| `launch other app from Flutter app` | not in top 50 | unrelated app/runtime packages |
| `launch Google Maps or Apple Maps with coordinates` | not found in scanned result set | `maps_launcher`, `casa_google_map` |
| `launch maps with given coordinates Flutter` | no pub.dev API results in scan | none |
| `given coordinates Flutter maps` | not found in scanned result set | `flutter_simple_map`, `open_route_service`, `mapwize`, `fl_geocoder` |
| `Google Maps URL Launcher Flutter` | not found in scanned result set | `maps_launcher`, `map_launcher`, `url_launcher_utils`, `mappls_map_launcher`, `launcher_utils` |
| `Google Maps and URL Launcher in Flutter` | not found in scanned result set | `map_launcher`, `url_launcher_utils`, `mappls_map_launcher`, `launcher_utils`, `webf_deeplink` |
| `DeepLinkX vs url_launcher` | no pub.dev API results in scan | none |
| `Flutter deep linking and universal linking` | not found in scanned result set | `deeplink_sdk`, `deep_link_orchestrator`, `flutter_deep_linker`, `flutter_linkme_sdk` |
| `custom scheme deep link Flutter` | #12 p2 | `app_links`, `link_bridge`, `screen_launch_by_notfication`, `uni_links3`, `uni_links5` |
| `iOS URL scheme Android intent Flutter` | not in top 50 | `appscheme`, `link_bridge`, `uni_links3`, `uni_links5`, `upi_intent` |
| `redirect users to App Store Play Store` | #8 p1 | `store_redirect`, `store_redirect2`, `win32`, `flutter_app_update_lib`, `win32_gui` |
| `Flutter redirect users to app store` | #4 p1 | `store_redirect`, `store_redirect2`, `in_app_review` |
| `deep link without package Flutter` | #5 p1 | `my_deep_link_sdk`, `flutter_facebook_app_links_spm`, `deep_link_manager`, `smart_deeplink_router` |
| `without url_launcher Flutter deeplink` | not found in scanned result set | very small result set |
| `open another app without url_launcher Flutter` | not found in scanned result set | very small result set |
| `app not installed redirect to store Flutter` | #1 p1 | DeeplinkX leads |
| `fallback to App Store Play Store web Flutter` | #1 p1 | DeeplinkX leads |

### Medium-Derived Keyword Opportunities

The most useful phrase opportunities from the Medium pass are:

| Opportunity | Current rank | Why it matters |
| --- | ---: | --- |
| `open WhatsApp directly from Flutter` | not found | Medium titles use "directly" and "from Flutter", while pub.dev metadata currently emphasizes "social apps". |
| `WhatsApp phone number and message` | not in top 50 | Users search for the concrete action, not just "WhatsApp deeplink". |
| `send WhatsApp message Flutter` | not in top 50 | DeeplinkX can support chat/message workflows, but this phrase did not rank well in pub.dev search. |
| `open Telegram profile from Flutter` | not found | Mirrors the concrete profile examples in DeeplinkX docs. |
| `open Instagram profile from Flutter` | not found | Strong fit for DeeplinkX examples and screenshots. |
| `open YouTube video from Flutter` | not in top 50 | Better human phrase than only `YouTube deeplink`. |
| `open Google Map and show navigation` | not in top 50 | Medium uses "show navigation"; DeeplinkX docs usually use "directions". |
| `launch other app from Flutter app` | not in top 50 | Medium article titles often use "other app", while DeeplinkX usually says "external app". |
| `launch Google Maps or Apple Maps with coordinates` | not found | Coordinates are a frequent article phrase and map workflow. |
| `given coordinates` | not found | Useful for map action docs and examples. |
| `Google Maps & URL Launcher in Flutter` | not found | A direct comparison/search bridge to `url_launcher`. |
| `DeepLinkX vs url_launcher` | no API results | Already a good positioning theme; keep using it in headings and articles. |
| `Flutter deep linking and universal linking` | not found | Mostly inbound-link intent, but users may not know the distinction. |
| `custom scheme deep link Flutter` | #12 p2 | Good explanatory keyword for DeeplinkX's native launch strategy. |
| `iOS URL scheme Android intent Flutter` | not in top 50 | Captures platform-specific launch mechanics. |
| `redirect users to App Store / Play Store` | #8 p1 | Medium store articles use "redirect users", not only "fallback". |
| `app not installed redirect to store Flutter` | #1 p1 | Strong existing fit for fallback copy. |
| `fallback to App Store Play Store web Flutter` | #1 p1 | Strong existing fit for fallback copy. |
| `deep link without package` / `without url_launcher` | #5 p1 / not found | Good comparison content, but should be framed carefully: DeeplinkX avoids raw URL maintenance, not packages entirely. |

### Medium Content Recommendations

- Publish or update Medium posts with task-first titles:
  - "Open WhatsApp, Telegram, and Instagram from Flutter with DeeplinkX"
  - "Open Google Maps, Apple Maps, and Waze Directions from Flutter"
  - "Flutter Store Fallback: Open App Store or Play Store When an App Is Missing"
  - "DeeplinkX vs url_launcher: Typed External App Deep Links in Flutter"
- Use article subtitles to include exact phrase clusters:
  - WhatsApp phone number and pre-filled message
  - Google Maps directions with coordinates
  - iOS URL schemes and Android intents
  - fallback to App Store, Play Store, and web
- Link articles back to the pub.dev package and README sections that use the same wording.
- Mirror the same task-first headings in README so Google, Medium, and pub.dev reinforce each other.

## Interpretation

### What DeeplinkX Already Owns

DeeplinkX owns the clearest outbound-deeplink intent:

- `<app> deeplink`
- `<map provider> link`
- `<map provider> deeplink`
- `store fallback`
- `fallback to store`
- `app store deeplink`
- `play store deeplink`
- `external deeplink`
- `type safe deeplink`
- `social deeplink`
- `open social app`
- `open google maps flutter`
- `launch google maps flutter`
- `open waze flutter`
- `flutter fallback to app store`
- `flutter fallback to play store`

This is the right core. These searches match the package's actual product position.

### Where DeeplinkX Is Being Outranked for Good Reasons

Bare app names are usually not DeeplinkX's best target:

- `whatsapp`
- `telegram`
- `instagram`
- `youtube`
- `zoom`
- `google maps`

Those searches often mean official SDKs, API wrappers, players, map widgets, authentication packages, sharing packages, or UI packages. Pub.dev reasonably favors exact-name packages there.

### Where DeeplinkX Has Real Metadata Opportunities

The most useful gaps are not bare app names. They are terms close to DeeplinkX's feature set:

- `deeplink plugin`
- `deep link plugin`
- `custom url scheme`
- `url scheme`
- `ios url scheme`
- `android intent`
- `is app installed`
- `check app installed`
- `external app launcher`
- `flutter open another app`
- `flutter launch another app`
- `flutter deep link to another app`
- `flutter open app by package name`
- `flutter open app without url launcher`
- `send whatsapp message flutter`
- `map launcher`
- `url_launcher alternative`

These are close enough to the package's purpose that stronger README/pubspec wording could plausibly help.

## Recommended SEO and Metadata Actions

### 1. Strengthen the pubspec description

The current published description says "social apps" but does not name WhatsApp, Telegram, Instagram, or YouTube. Exact terms matter in pub.dev ranking.

Candidate direction:

```yaml
description: Type-safe Flutter deeplinks for WhatsApp, Telegram, Instagram, YouTube, Google Maps, Waze, app stores, and external-app fallback.
```

This would likely help app-specific `link` and bare app-name adjacency without keyword stuffing.

### 2. Add exact app names earlier in README

The README opening should include a compact sentence with the most searched providers:

```md
Launch WhatsApp chats, Telegram profiles, Instagram pages, YouTube videos, Google Maps directions, Waze routes, and app store pages from Flutter with typed deeplinks.
```

### 3. Add human-search phrasing

Developers often search in task form. Add natural headings or sentences that include:

- open another app from Flutter
- launch another app from Flutter
- open WhatsApp from Flutter
- send a WhatsApp message from Flutter
- open app if installed
- open an app by URL scheme
- open an app without raw `url_launcher` URLs

Avoid promising package-name launching if DeeplinkX does not support arbitrary Android package-name launching directly. Phrase it around supported apps and typed actions.

### 4. Add "plugin" wording

DeeplinkX misses `deeplink plugin` and `deep link plugin`. Add natural wording such as:

```md
DeeplinkX is a Flutter plugin for launching typed external deeplinks...
```

### 5. Add URL scheme and Android intent wording

The URL scheme category is weak. Add explicit wording in the README and docs:

- custom URL schemes
- Android intents
- iOS URL schemes
- app links
- universal links

Do this in explanatory sections, not as a keyword dump.

### 6. Add install-check wording

DeeplinkX has `isAppInstalled()`, but install-check searches do not surface it well. Add wording like:

```md
Check whether WhatsApp, Telegram, Google Maps, or another supported app is installed before launching.
```

### 7. Add comparison pages or README headings

Useful comparison headings:

- "DeeplinkX vs url_launcher"
- "DeeplinkX vs map_launcher"
- "DeeplinkX vs external_app_launcher"
- "When to use DeeplinkX instead of raw URL schemes"
- "Open another app without managing raw url_launcher URLs"

These would target the alternative-intent gap.

### 8. Recheck after publishing `1.3.4`

Because current pub.dev latest is `1.3.3`, Amap visibility should be checked only after `1.3.4` is published and indexed.

## Priority List

1. Update pubspec description with exact high-value app names.
2. Update README opening paragraph with exact app names, "from Flutter", and "Flutter plugin" wording.
3. Add a short task-oriented section for "open another app from Flutter" and "open app if installed".
4. Add a small URL scheme / Android intent explanation near "How it works".
5. Add install-check wording around `isAppInstalled()`.
6. Add comparison headings for `url_launcher`, `map_launcher`, and `external_app_launcher`.
7. Re-run this report after the next publish.

## Suggested Commit Message

```text
docs: improve pub.dev keyword visibility
```
