# pub.dev Keyword Visibility Report

Generated: 2026-07-10

Package audited: `deeplink_x`

## Scope

This report checks where `deeplink_x` appears in pub.dev search results for app-specific, deeplink, external-app, store fallback, map/navigation, URL scheme, human-style, Medium-derived, competitor-style, supported-action, alias, and related-intent keywords.

The snapshot follows the `1.3.8` publish and expands the July 6 audit to cover all 22 supported apps, all seven stores, Baidu Maps, 2GIS, Yandex Maps, documented action families, developer spellings, and source-backed human search language.

## Method

- Source: pub.dev package search API, package metadata API, score API, rendered package page, and rendered score page.
- Ranking mode: pub.dev default search ranking.
- Page size: 10 results.
- Rank format: `#position pPage`.
- Every query was scanned through the top 100 unless the result set ended earlier or `deeplink_x` was found.
- The scan normalized case and whitespace, fetched each unique query once, and reused the result where a phrase belongs to multiple sections.
- The initial parallel collection attempt reached pub.dev rate limiting. Collection paused until the limit cleared, then all 484 unique queries completed through one paced, retrying worker; no query was skipped.
- Search results are time-sensitive and can change as pub.dev reindexes, downloads change, likes change, or package metadata changes.

Sources:

- <https://pub.dev/packages/deeplink_x>
- <https://pub.dev/api/packages/deeplink_x>
- <https://pub.dev/api/packages/deeplink_x/score>
- <https://pub.dev/help/search#ranking>
- <https://stackoverflow.com/questions/55771211/can-any-one-tell-me-how-to-open-another-app-using-flutter>
- <https://stackoverflow.com/questions/55892495/how-to-send-a-message-directly-from-my-flutter-app-to-whatsapp-using-urllauncher>
- <https://stackoverflow.com/questions/73543573/opening-maps-apps-google-maps-apple-maps-waze-in-flutter-with-url-launcher>
- <https://stackoverflow.com/questions/53967477/how-to-implement-deep-linking-in-flutter-with-redirect-to-app-store>

## Current Published Package Signals

pub.dev reports `deeplink_x` latest as `1.3.8`, published on `2026-07-10T18:48:37.265552Z`.

Current published description:

```yaml
description: Type-safe Flutter deeplinks for WhatsApp, Telegram, Instagram, YouTube, Google Maps, Waze and app stores, with automatic store and web fallback.
```

| Signal | Value |
| --- | ---: |
| Pub points | 160 / 160 |
| Likes | 12 |
| 30-day downloads | 925 |
| Topics | `deeplink`, `app-links`, `maps`, `navigation`, `open-store` |

The metadata API, score API, rendered package page, and rendered score page agreed on these values at final collection.

## Executive Summary

- DeeplinkX ranked for 312 of 484 unique searches and was outside the top 100 for 172.
- The newest providers have strong exact intent: `baidu maps link`, `baidu maps deeplink`, `2gis link`, `2gis deeplink`, `yandex maps link`, and `yandex maps deeplink` all rank #1.
- Plain provider visibility is also useful: Baidu Maps ranks #2, Yandex Maps #8, and 2GIS #11.
- Related fallback and typed-API language is the strongest expansion: all five installation/fallback phrases and all four typed-API phrases rank, mostly at #1.
- Store-provider intent is strong: 21 of 24 new store phrases rank, including #1 positions for Huawei AppGallery, Cafe Bazaar, Myket, Microsoft Store, Mac App Store, and several App Store/Google Play link terms.
- Broad map-intent language remains weak: none of the ten new generic map-choice/coordinate phrases rank in the top 100, despite strong provider-specific link/deeplink positions.
- WhatsApp remains behind `whatsapp_unilink` for `whatsapp link` (#2), while `whatsapp deeplink` remains #1. Only one of six new WhatsApp task phrases ranks.
- Baseline movement is mostly stable: 153 unchanged, 19 improved, 18 regressed, one newly ranked, five lost, and 57 unranked in both snapshots.

## App-Specific Competitor Matrix

| App | Plain app query | App link query | App deeplink query | Open from Flutter | Main packages ahead or around it |
| --- | ---: | ---: | ---: | ---: | --- |
| WhatsApp | #17 p2 | #2 p1 | #1 p1 | #2 p1 | `whatsapp`, `chat_bubbles`, `whatsapp_unilink`, `story_view`, `flutter_chat_bubble` |
| Telegram | #12 p2 | #2 p1 | #1 p1 | #1 p1 | `telegram`, `flutter_chat_bubble`, `televerse`, `appinio_social_share`, `social_sharing_plus` |
| Instagram | #11 p2 | #1 p1 | #1 p1 | #2 p1 | `instagram`, `story_view`, `zoom_pinch_overlay`, `story`, `pinch_zoom_release_unzoom` |
| Facebook | not in top 100 | #11 p2 | #4 p1 | #15 p2 | `facebook`, `firebase_auth`, `facebook_app_events`, `fade_shimmer`, `flutter_login_facebook` |
| LinkedIn | #74 p8 | #14 p2 | #1 p1 | #10 p1 | `linkedin_login`, `social_sharing_plus`, `signin_with_linkedin`, `linkedin_login_android`, `flutter_animated_reaction` |
| Twitter | not in top 100 | #11 p2 | #2 p1 | #14 p2 | `twitter`, `firebase_auth`, `like_button`, `metadata_fetch`, `twitter_login` |
| Threads | #42 p5 | #2 p1 | #1 p1 | #2 p1 | `squadron`, `easy_isolate`, `flutter_pinned_shortcut_plus`, `syn_thread_safe_logger`, `toast_notification` |
| YouTube | #11 p2 | #1 p1 | #1 p1 | #1 p1 | `youtube`, `youtube_player_flutter`, `youtube_player_iframe`, `youtube_explode_dart`, `pod_player` |
| TikTok | #53 p6 | #3 p1 | #1 p1 | #10 p1 | `tiktok_events_sdk`, `appinio_social_share`, `tiktoklikescroller`, `drag_ball`, `tiktoken` |
| Pinterest | #12 p2 | #1 p1 | #1 p1 | #9 p1 | `flexbox_layout`, `overscroll_pop`, `custom_masonry_grid`, `masonry_gallery`, `pinterest_nav_bar` |
| Zoom | not in top 100 | #5 p1 | #1 p1 | #15 p2 | `zoom`, `extended_image`, `pinch_zoom`, `easy_image_viewer`, `zoom_pinch_overlay` |
| Slack | #31 p4 | #2 p1 | #1 p1 | #9 p1 | `slack`, `slack_notifier`, `slack_logger`, `flutter_chat_io`, `loggme` |
| Google Maps | #24 p3 | #1 p1 | #1 p1 | #2 p1 | `google_maps`, `google_maps_flutter`, `google_maps_flutter_web`, `widget_to_marker`, `google_maps_flutter_android` |
| Apple Maps | #16 p2 | #1 p1 | #1 p1 | #5 p1 | `apple_maps`, `apple_maps_flutter`, `platform_maps_flutter`, `mapkit_js`, `apple_maps_place_picker` |
| Waze | #1 p1 | #1 p1 | #1 p1 | #1 p1 | DeeplinkX leads |
| Sygic | #2 p1 | #1 p1 | #1 p1 | #1 p1 | `map_launcher`, `deeplink_x`, `mappls_map_launcher`, `maplauncherplus`, `paygic` |
| Neshan | #5 p1 | #1 p1 | #1 p1 | #1 p1 | `neshan_maps_flutter`, `neshanmap_flutter`, `map_launcher`, `shelf_packages_handler`, `deeplink_x` |
| Amap | #81 p9 | #1 p1 | #1 p1 | #1 p1 | `amap_flutter_location`, `ultra_map_place_picker`, `amap_map`, `fl_amap`, `xbr_gaode_navi_amap` |
| Moovit | #2 p1 | #1 p1 | #1 p1 | #1 p1 | `map_launcher`, `deeplink_x`, `iconify_flutter_plus`, `iconify_flutter`, `ubicons` |
| Baidu Maps | #2 p1 | #1 p1 | #1 p1 | #2 p1 | `map_launcher`, `deeplink_x`, `flutter_tabler_icons`, `mappls_map_launcher`, `iconify_flutter_plus` |
| 2GIS | #11 p2 | #1 p1 | #1 p1 | #3 p1 | `dgis_map_kit`, `dgis_flutter`, `flutter_echarts`, `geoengine`, `mapmyindia_flutter` |
| Yandex Maps | #8 p1 | #1 p1 | #1 p1 | #2 p1 | `yandex_maps_mapkit_lite`, `yandex_maps_mapkit`, `yandex_maps_navikit`, `yandex_js_maps`, `yandex_map_desktop` |

## Expanded Keyword Audit

### Core Deeplink Terms

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `deep link` | #4 p1 | `app_links`, `flutter_branch_sdk`, `flutter_facebook_app_links`, `deeplink_x`, `chottu_link` |
| `deep link package` | #10 p1 | `djangoflow_deep_link_interface`, `flutter_facebook_app_links_spm`, `app_wide_search`, `deep_link_manager`, `djangoflow_app_links` |
| `deep link plugin` | #28 p3 | `flutter_branch_sdk`, `flutter_facebook_app_links`, `stack_deferred_link`, `eimzo_flutter`, `link_bridge` |
| `deep linking` | not in top 100 | `go_router`, `auto_route`, `kiwi`, `go_router_builder`, `zenrouter` |
| `deep links` | #5 p1 | `deep_links`, `app_links`, `flutter_branch_sdk`, `flutter_facebook_app_links`, `deeplink_x` |
| `deeplink` | #3 p1 | `app_links`, `flutter_branch_sdk`, `deeplink_x`, `zenrouter_devtools`, `flutter_link_nav` |
| `deeplink flutter package` | #7 p1 | `djangoflow_deep_link_interface`, `deep_link_manager`, `toropass_client`, `my_deep_link_sdk`, `smart_deeplink_router` |
| `deeplink launcher` | #1 p1 | DeeplinkX leads |
| `deeplink package` | #8 p1 | `override_api_endpoint`, `djangoflow_deep_link_interface`, `deep_link_manager`, `toropass_client`, `my_deep_link_sdk` |
| `deeplink plugin` | #21 p3 | `flutter_branch_sdk`, `urlynk_flutter`, `flutter_deep_links`, `google_ads_deferred_deep_link`, `xy_umeng` |
| `external deep link` | #1 p1 | DeeplinkX leads |
| `external deeplink` | #1 p1 | DeeplinkX leads |
| `flutter deep link` | #4 p1 | `app_links`, `flutter_branch_sdk`, `flutter_facebook_app_links`, `deeplink_x`, `stack_deferred_link` |
| `flutter deep linking` | not in top 100 | `flutter_deep_linking`, `go_router`, `kiwi`, `zenrouter`, `protocol_handler` |
| `flutter deeplink` | #3 p1 | `app_links`, `flutter_branch_sdk`, `deeplink_x`, `flutter_link_nav`, `deeplink_sdk` |
| `type safe deeplink` | #1 p1 | DeeplinkX leads |
| `typed deeplink` | #1 p1 | DeeplinkX leads |

### App Links and URL Scheme Terms

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `android intent` | not in top 100 | `android_intent`, `open_file`, `android_intent_plus`, `share_plus`, `open_filex` |
| `app link` | #5 p1 | `app_links`, `whatsapp_unilink`, `flutter_branch_sdk`, `flutter_facebook_app_links`, `deeplink_x` |
| `app links` | #8 p1 | `app_links`, `whatsapp_unilink`, `flutter_branch_sdk`, `flutter_share`, `flutter_facebook_app_links` |
| `app-links` | #8 p1 | `app_links`, `whatsapp_unilink`, `flutter_branch_sdk`, `flutter_share`, `flutter_facebook_app_links` |
| `custom url scheme` | #68 p7 | `appscheme`, `app_links`, `link_bridge`, `flutter_dominant_color_container`, `uni_links3` |
| `custom url schemes` | #36 p4 | `app_links`, `flutter_branch_sdk`, `link_bridge`, `appscheme`, `flutter_deep_links` |
| `intent launcher` | #51 p6 | `intent_launcher`, `url_launcher`, `android_intent_plus`, `maps_launcher`, `external_app_launcher` |
| `ios url scheme` | not in top 100 | `appscheme`, `app_links`, `ios_native_utils`, `link_bridge`, `uni_links3` |
| `scheme launcher` | #20 p2 | `url_launcher`, `maps_launcher`, `external_app_launcher`, `open_mail_launcher`, `launchify` |
| `universal link` | #28 p3 | `app_links`, `whatsapp_unilink`, `flutter_branch_sdk`, `link_bridge`, `flutter_link_nav` |
| `universal links` | #30 p3 | `universal_links`, `app_links`, `whatsapp_unilink`, `flutter_branch_sdk`, `link_bridge` |
| `url scheme` | not in top 100 | `appscheme`, `android_scheme_search`, `app_links`, `url_launcher`, `ios_native_utils` |
| `url schemes` | #54 p6 | `url_launcher`, `app_links`, `flutter_branch_sdk`, `telegram`, `link_bridge` |

### Open and Launch External Apps

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `app installed flutter` | #57 p6 | `appcheck`, `installed_apps`, `app_launcher`, `open_mail`, `flutter_install_referrer` |
| `check app installed` | #64 p7 | `appcheck`, `check_app_version`, `device_apps_plus`, `app_install_checker`, `is_pirated` |
| `external app` | #46 p5 | `external_app_launcher`, `dropbox_client`, `app_activity_launcher`, `ensemble_ts_interpreter`, `external_app_launcher_plus` |
| `external app launcher` | #9 p1 | `external_app_launcher`, `app_activity_launcher`, `external_app_launcher_plus`, `app_launcher_packagename`, `launchify` |
| `flutter app launcher` | #55 p6 | `icons_launcher`, `flutter_launcher_icons`, `dynamic_app_icon_flutter_plus`, `external_app_launcher`, `flutter_app_badge` |
| `flutter launch app` | #85 p9 | `icons_launcher`, `flutter_launcher_icons`, `appcheck`, `external_app_launcher`, `launch_app_store` |
| `flutter open app` | #19 p2 | `flutter_open_app`, `open_file`, `serverpod`, `iconify_flutter_plus`, `iconify_flutter` |
| `is app installed` | not in top 100 | `is_app_installed`, `appcheck`, `check_app_version`, `new_device_apps`, `app_install_checker` |
| `launch app` | not in top 100 | `launchapp`, `icons_launcher`, `flutter_launcher_icons`, `appcheck`, `external_app_launcher` |
| `launch external app` | #26 p3 | `launchexternalapp`, `external_app_launcher`, `app_activity_launcher`, `external_app_launcher_plus`, `app_launcher_packagename` |
| `launch installed app` | #43 p5 | `appcheck`, `app_launcher`, `open_mail_launcher`, `mappls_map_launcher`, `apps_utils` |
| `open app` | #24 p3 | `open_app`, `open_file`, `serverpod`, `iconify_flutter_plus`, `iconify_flutter` |
| `open external app` | #11 p2 | `external_app_launcher`, `app_activity_launcher`, `external_app_launcher_plus`, `flutter_external_app`, `open_file` |
| `open installed app` | #12 p2 | `open_mail`, `open_mail_launcher`, `open_mail_app`, `open_mail_app_plus`, `is_pirated` |

### Store Fallback and Redirect

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `app fallback` | #1 p1 | DeeplinkX leads |
| `app store deeplink` | #1 p1 | DeeplinkX leads |
| `app store link` | #1 p1 | DeeplinkX leads |
| `app store redirect` | #4 p1 | `store_redirect`, `flutter_app_update_lib`, `store_redirect2`, `deeplink_x`, `update_checker` |
| `fallback app store` | #1 p1 | DeeplinkX leads |
| `fallback to store` | #2 p1 | `flutter_in_store_app_version_checker`, `deeplink_x`, `smart_app_update_flutter`, `billing_country`, `persistencestore` |
| `google play link` | #3 p1 | `app_device_integrity`, `flutter_install_app_plugin`, `deeplink_x`, `flutter_update_checker`, `iconify_flutter_plus` |
| `google play redirect` | #7 p1 | `store_redirect`, `store_redirect2`, `iconify_flutter_plus`, `iconify_flutter`, `ubicons` |
| `open app store` | #3 p1 | `open_appstore`, `app_review`, `deeplink_x`, `app_review_plus`, `flutter_store_listing` |
| `open play store` | #9 p1 | `flutter_app_store`, `in_app_update_flutter`, `open_appstore`, `store_redirect`, `launch_app_store` |
| `open store` | #4 p1 | `open_store`, `geoflutterfire2`, `app_review`, `deeplink_x`, `geoflutterfire` |
| `play store deeplink` | #1 p1 | DeeplinkX leads |
| `redirect to store` | #17 p2 | `store_redirect`, `store_redirect2`, `simple_auth_flutter`, `dio_redirect_interceptor`, `flutter_app_update_lib` |
| `smart fallback` | #13 p2 | `flutter_smart_cache_manager`, `smart_localize`, `ai_smart_translate`, `smart_image`, `network_or_asset_loader` |
| `store fallback` | #1 p1 | DeeplinkX leads |
| `store redirect` | #4 p1 | `store_redirect`, `flutter_app_update_lib`, `store_redirect2`, `deeplink_x`, `simple_auth_flutter` |
| `web fallback` | #1 p1 | DeeplinkX leads |

### Maps and Navigation

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `apple maps deeplink` | #1 p1 | DeeplinkX leads |
| `apple maps link` | #1 p1 | DeeplinkX leads |
| `directions` | #98 p10 | `map_launcher`, `appinio_swiper`, `marquee`, `custom_rating_bar`, `loop_page_view` |
| `flutter maps launcher` | #8 p1 | `map_launcher`, `maps_launcher`, `launchify`, `mappls_map_launcher`, `launcher_utils` |
| `get directions` | not in top 100 | `google_maps_directions`, `text_gradient_widget`, `address_search_field`, `map_launcher`, `appinio_swiper` |
| `google maps deeplink` | #1 p1 | DeeplinkX leads |
| `google maps link` | #1 p1 | DeeplinkX leads |
| `launch maps` | #12 p2 | `map_launcher`, `maps_launcher`, `launchify`, `mappls_map_launcher`, `launcher_utils` |
| `map` | not in top 100 | `map`, `flutter_map`, `dart_mappable`, `map_launcher`, `maps_toolkit` |
| `map directions` | not in top 100 | `map_launcher`, `google_maps_apis`, `flutter_google_maps_webservices`, `google_maps_routes`, `google_maps_directions` |
| `map launcher` | #46 p5 | `map_launcher`, `maps_launcher`, `flutter_launcher_plus`, `mappls_map_launcher`, `maplauncherplus` |
| `maps` | #39 p4 | `maps`, `map_launcher`, `maps_toolkit`, `google_maps_flutter`, `maplibre_gl` |
| `maps launcher` | #9 p1 | `maps_launcher`, `map_launcher`, `launchify`, `mappls_map_launcher`, `launcher_utils` |
| `navigate` | not in top 100 | `navigate`, `swipeable_page_route`, `animated_bottom_navigation_bar`, `no_context_navigation`, `dpad_container` |
| `navigation` | #69 p7 | `navigation`, `smooth_sheets`, `auto_route_generator`, `curved_navigation_bar`, `go_router` |
| `open map` | #43 p5 | `maps_launcher`, `location_picker_flutter_map`, `open_location_picker`, `open_street_map_search_and_pick`, `flutter_location_search` |
| `open maps` | #3 p1 | `maps_launcher`, `location_picker_flutter_map`, `deeplink_x`, `open_street_map_search_and_pick`, `neom_maps_services` |
| `turn by turn` | not in top 100 | `flutter_mapbox_navigation`, `vietmap_flutter_navigation`, `nb_navigation_flutter`, `situm_flutter`, `arcgis_maps` |
| `turn by turn navigation` | #40 p4 | `flutter_mapbox_navigation`, `vietmap_flutter_navigation`, `nb_navigation_flutter`, `situm_flutter`, `flutter_mapbox` |
| `waze deeplink` | #1 p1 | DeeplinkX leads |
| `waze link` | #1 p1 | DeeplinkX leads |

### Social Deeplink Terms

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `launch social app` | not in top 100 | `launchify`, `iconify_flutter_plus`, `iconify_flutter`, `community_material_icon`, `stac` |
| `open social app` | not in top 100 | `serverpod`, `appinio_social_share`, `authentication_buttons`, `custom_social_share`, `flutter_social_share_plus` |
| `social app` | not in top 100 | `appinio_social_share`, `authentication_buttons`, `flutter_feed_reaction`, `custom_social_share`, `flutter_social_share_plus` |
| `social app launcher` | not in top 100 | `launchify`, `iconify_flutter_plus`, `iconify_flutter`, `jaspr_icons_pack`, `icons_plus` |
| `social apps` | not in top 100 | `social_share`, `k_auth`, `getsocial_flutter_sdk`, `sharesdk_plugin`, `main_auth` |
| `social deep link` | not in top 100 | `chottu_link`, `app_linkster`, `flutter_tabler_icons`, `colorful_iconify_flutter`, `uicons_pro` |
| `social deeplink` | not in top 100 | `sojo_link`, `archipelago_cli`, `firebase_dynamic_links_fixed`, `bit_2_connect_sdk`, `keeplist_social` |
| `social link` | not in top 100 | `social_link`, `appinio_social_share`, `social_sharing_plus`, `social_links_generator`, `social_share` |
| `social media link` | not in top 100 | `social_link`, `appinio_social_share`, `social_sharing_plus`, `social_links_generator`, `custom_social_share` |

### Competitor and Alternative Intent

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `app links alternative` | not in top 100 | `appsonair_flutter_applink`, `sojo_link`, `win32`, `media_link_generator`, `gpt_markdown` |
| `external app launcher alternative` | not in top 100 | `android_native`, `flutter_intent_forzzh`, `intent_plus`, `hzfinger_fingerprint_sdk` |
| `flutter launcher` | not in top 100 | `url_launcher`, `icons_launcher`, `map_launcher`, `flutter_launcher_icons`, `maps_launcher` |
| `map launcher alternative` | not in top 100 | `sojo_link`, `android_native` |
| `url launcher` | not in top 100 | `url_launcher`, `url_launcher_android`, `url_launcher_windows`, `url_launcher_ios`, `fwfh_url_launcher` |
| `url launcher alternative` | not in top 100 | `sojo_link`, `simple_html_css`, `mailto`, `carp_webservices`, `linkzly_flutter_sdk` |
| `url_launcher` | not in top 100 | `url_launcher`, `url_launcher_android`, `url_launcher_windows`, `url_launcher_ios`, `fwfh_url_launcher` |
| `url_launcher alternative` | not in top 100 | `sojo_link`, `simple_html_css`, `mailto`, `carp_webservices`, `linkzly_flutter_sdk` |

## Human Search Query Expansion

### Human App Action Searches

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `open instagram flutter` | #1 p1 | DeeplinkX leads |
| `open instagram profile flutter` | #1 p1 | DeeplinkX leads |
| `open Instagram profile from Flutter` | #1 p1 | DeeplinkX leads |
| `open linkedin profile flutter` | #10 p1 | `linkedin_oauth2`, `signin_with_linkedin`, `iconify_flutter_plus`, `iconify_flutter`, `remixicon` |
| `open slack flutter` | #1 p1 | DeeplinkX leads |
| `open telegram flutter` | #2 p1 | `photo_opener`, `deeplink_x`, `telegram`, `flutter_telegram_miniapp`, `flutterando_analysis` |
| `open telegram from flutter` | #1 p1 | DeeplinkX leads |
| `open telegram profile flutter` | #1 p1 | DeeplinkX leads |
| `open Telegram profile from Flutter` | #1 p1 | DeeplinkX leads |
| `open tiktok flutter` | #2 p1 | `flutter_tiktoken`, `deeplink_x`, `apphud`, `sharex`, `tiktok_scraper` |
| `open whatsapp chat flutter` | #1 p1 | DeeplinkX leads |
| `open WhatsApp directly from Flutter` | #2 p1 | `whatsapp`, `deeplink_x`, `whatsapp_direct_send`, `native_social_share`, `media_launcher_plugin` |
| `open whatsapp flutter` | #2 p1 | `open_share_plus`, `deeplink_x`, `flutter_open_whatsapp`, `flutter_plugin_openwhatsapp`, `flutter_plugin_openwhatsapp_dome` |
| `open whatsapp from flutter` | #2 p1 | `whatsapp`, `deeplink_x`, `iconify_flutter_plus`, `iconify_flutter`, `flutter_boxicons` |
| `open youtube flutter` | #1 p1 | DeeplinkX leads |
| `open youtube video flutter` | #2 p1 | `adaptive_video_player`, `deeplink_x`, `floatube_player`, `video_thumbnail_gen`, `flutter_ytdlp_plugin` |
| `open YouTube video from Flutter` | #8 p1 | `iconify_flutter_plus`, `iconify_flutter`, `flutter_boxicons`, `flutter_tabler_icons`, `stac` |
| `send whatsapp message flutter` | not in top 100 | `flutter_open_whatsapp`, `whatsapp`, `flutter_chatflow`, `whatsapp_sender_flutter`, `waapi_flutter` |
| `whatsapp chat link flutter` | #3 p1 | `chat_bubbles`, `whatsapp_unilink`, `deeplink_x`, `iconify_flutter_plus`, `iconify_flutter` |

### Human Map Searches

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `flutter map directions app` | #21 p3 | `mappls_map_launcher`, `flutter_google_maps_webservices`, `flutter_mapbox_navigation`, `mappls_direction_plugin`, `googlemaps_flutter_webservices` |
| `flutter open navigation app` | #1 p1 | DeeplinkX leads |
| `google maps directions flutter` | #10 p1 | `flutter_google_maps_webservices`, `google_routes_flutter`, `googlemaps_flutter_webservices`, `google_map_service`, `google_map_with_direction_indicator` |
| `Google Maps URL Launcher Flutter` | #5 p1 | `launchify`, `maps_launcher`, `map_launcher`, `url_launcher_utils`, `deeplink_x` |
| `launch google maps flutter` | #3 p1 | `map_launcher`, `maps_launcher`, `deeplink_x`, `launchify`, `mappls_map_launcher` |
| `launch waze flutter` | #2 p1 | `map_launcher`, `deeplink_x`, `launchify`, `mappls_map_launcher`, `icons_plus` |
| `open apple maps flutter` | #2 p1 | `maps_launcher`, `deeplink_x`, `apple_maps_place_picker`, `iconify_flutter_plus`, `iconify_flutter` |
| `open Google Maps and show navigation Flutter` | not in top 100 | `iconify_flutter_plus`, `iconify_flutter`, `flutter_tabler_icons`, `ubicons`, `jaspr_icons_pack` |
| `open google maps flutter` | #1 p1 | DeeplinkX leads |
| `open google maps from flutter` | #2 p1 | `google_maps_widget`, `deeplink_x`, `place_picker_google`, `google_maps_place_picker_mb`, `iconify_flutter_plus` |
| `open location in google maps flutter` | #2 p1 | `place_picker_google`, `deeplink_x`, `google_maps_widget`, `google_maps_marker_widgets`, `iconify_flutter_plus` |
| `open map app flutter` | #4 p1 | `map_picker_free`, `maps_launcher`, `location_picker_flutter_map`, `deeplink_x`, `flutter_mapbox_navigation` |
| `open maps app flutter` | #1 p1 | DeeplinkX leads |
| `open maps directions flutter` | #1 p1 | DeeplinkX leads |
| `open waze flutter` | #1 p1 | DeeplinkX leads |

### Human External App Searches

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `flutter app to app launch` | not in top 100 | `appcheck`, `external_app_launcher`, `launch_app_store`, `launcher_icon_switcher`, `open_mail_launcher` |
| `flutter check app installed` | #48 p5 | `appcheck`, `check_app_version`, `device_apps_plus`, `app_data_usage`, `flutter_appavailability` |
| `flutter check if app installed` | #53 p6 | `appcheck`, `device_apps_plus`, `flutter_appavailability`, `package_install_checker`, `scrumlab_flutter_appavailability` |
| `flutter is app installed` | #83 p9 | `appcheck`, `check_app_version`, `mappls_map_launcher`, `flutter_appstore_detection`, `flutter_appavailability` |
| `flutter launch another app` | #11 p2 | `external_app_launcher`, `external_app_launcher_plus`, `jitsi_meet_wrapper`, `store_launcher_plus`, `flutter_applaunch` |
| `flutter launch app by package name` | not in top 100 | `app_launcher_packagename`, `jitsi_meet_wrapper`, `store_launcher_plus`, `screen_launch_by_notfication`, `plug_location_map` |
| `flutter launch external app` | #13 p2 | `external_app_launcher`, `external_app_launcher_plus`, `launchify`, `app_activity_launcher`, `app_launcher_packagename` |
| `flutter launch installed app` | #35 p4 | `appcheck`, `app_launcher`, `open_mail_launcher`, `mappls_map_launcher`, `apps_utils` |
| `flutter open another app` | #9 p1 | `external_app_launcher`, `external_app_launcher_plus`, `device_preview_plus`, `device_preview`, `iconify_flutter_plus` |
| `flutter open app by package name` | not in top 100 | `openapp_by_package`, `folder_file_saver`, `tabby_flutter_inapp_sdk`, `openpanel_flutter`, `developer_app_list` |
| `flutter open app if installed` | #16 p2 | `open_mail`, `open_mail_launcher`, `device_apps_plus`, `is_pirated`, `flutter_appavailability` |
| `flutter open app with package name` | not in top 100 | `admob_kit_x`, `change_app_package_name_plus`, `openapp_by_package`, `open_file`, `open_filex` |
| `flutter open external app` | #9 p1 | `external_app_launcher`, `external_app_launcher_plus`, `flutter_external_app`, `open_file`, `serverpod` |
| `flutter open installed app` | #9 p1 | `open_mail`, `open_mail_launcher`, `installed_apps`, `external_app_launcher`, `app_launcher` |
| `launch other app from Flutter app` | #54 p6 | `bugsee_flutter`, `flutter_alarm_background_trigger`, `android_vlc_player`, `bring_app_to_foreground`, `reclaim_sdk` |

### Human Deep Link and Scheme Searches

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `flutter android intent open app` | #29 p3 | `open_file`, `open_filex`, `better_open_file`, `open_file_plus`, `open_file_safe_plus` |
| `flutter custom scheme` | #67 p7 | `flex_seed_scheme`, `appscheme`, `flutter_dominant_color_container`, `app_links`, `flex_color_scheme` |
| `flutter custom url scheme` | #48 p5 | `appscheme`, `app_links`, `link_bridge`, `flutter_dominant_color_container`, `uni_links3` |
| `flutter deep link to another app` | #1 p1 | DeeplinkX leads |
| `flutter deeplink to another app` | #1 p1 | DeeplinkX leads |
| `flutter external deep link` | #1 p1 | DeeplinkX leads |
| `flutter external deeplink` | #1 p1 | DeeplinkX leads |
| `flutter ios url scheme` | not in top 100 | `appscheme`, `app_links`, `ios_native_utils`, `link_bridge`, `uni_links3` |
| `flutter launch android intent` | not in top 100 | `upi_intent`, `flutter_android_intent`, `android_intent_plus`, `upi_payment_callback_handler`, `open_mail_launcher` |
| `flutter launch url scheme` | #28 p3 | `url_launcher`, `launchify`, `enhanced_url_launcher`, `flutter_applaunch`, `flutter_custom_tabs` |
| `flutter open universal link` | #3 p1 | `app_links`, `whatsapp_unilink`, `deeplink_x`, `link_bridge`, `flutter_link_nav` |
| `flutter open url scheme` | #7 p1 | `app_links`, `maps_launcher`, `url_launcher`, `external_app_launcher`, `open_mail_launcher` |

### Human Store Searches

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `flutter app store fallback` | #1 p1 | DeeplinkX leads |
| `flutter app store link` | #1 p1 | DeeplinkX leads |
| `flutter fallback to app store` | #2 p1 | `flutter_in_store_app_version_checker`, `deeplink_x`, `smart_app_update_flutter`, `billing_country`, `app_updater_flutter` |
| `flutter fallback to play store` | #7 p1 | `smart_app_update_flutter`, `billing_country`, `app_updater_flutter`, `multi_updater`, `version_check_updater` |
| `flutter open app page in store` | #3 p1 | `store_redirect`, `app_review`, `deeplink_x`, `serverpod`, `in_app_update_flutter` |
| `flutter open app store` | #3 p1 | `flutter_open_app_store`, `app_review`, `deeplink_x`, `app_review_plus`, `flutter_store_listing` |
| `flutter open play store` | #8 p1 | `flutter_app_store`, `in_app_update_flutter`, `open_appstore`, `store_redirect`, `launch_app_store` |
| `flutter open store listing` | #4 p1 | `app_review`, `app_review_plus`, `flutter_store_listing`, `deeplink_x`, `is_pirated` |
| `flutter play store link` | #3 p1 | `multi_updater`, `in_app_update_flutter`, `deeplink_x`, `flutter_update_checker`, `verify_local_purchase` |
| `flutter redirect to app store` | #9 p1 | `store_redirect`, `store_redirect2`, `flutter_app_update_lib`, `update_checker`, `web_platform_detector` |
| `flutter redirect to play store` | #9 p1 | `store_redirect`, `store_redirect2`, `flutter_app_update_lib`, `update_checker`, `smart_app_update_flutter` |
| `flutter store redirect` | #4 p1 | `store_redirect`, `flutter_app_update_lib`, `store_redirect2`, `deeplink_x`, `simple_auth_flutter` |

### Human Alternative Searches

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `app links alternative flutter` | not in top 100 | `appsonair_flutter_applink`, `gpt_markdown`, `mailto`, `sojo_link`, `link_bridge` |
| `external app launcher alternative flutter` | not in top 100 | `hzfinger_fingerprint_sdk` |
| `flutter app links alternative` | not in top 100 | `appsonair_flutter_applink`, `gpt_markdown`, `mailto`, `sojo_link`, `link_bridge` |
| `flutter deeplink without url_launcher` | not in top 100 | `rgb_cli` |
| `flutter open app without url launcher` | not in top 100 | `launchify`, `url_launcher`, `fluwx_no_pay`, `route_pilot`, `enhanced_url_launcher` |
| `flutter url launcher alternative` | not in top 100 | `simple_html_css`, `mailto`, `sojo_link`, `carp_webservices`, `linkzly_flutter_sdk` |
| `map launcher alternative flutter` | not in top 100 | `sojo_link` |
| `url launcher alternative flutter` | not in top 100 | `simple_html_css`, `mailto`, `sojo_link`, `carp_webservices`, `linkzly_flutter_sdk` |

### Supported App Action Searches

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `create Threads post Flutter` | not in top 100 | `flutter_angle`, `super_icons`, `flutter_web_gl`, `vad`, `lm_video_download` |
| `join Zoom meeting Flutter` | not in top 100 | `flutter_zoom_meeting_wrapper`, `flutter_zoom_integration`, `zoom_meeting_flutter_sdk`, `gr_zoom`, `flutter_zoom_meeting` |
| `open Facebook event Flutter` | not in top 100 | `facebook_app_events`, `iconify_flutter_plus`, `iconify_flutter`, `remixicon`, `flutter_boxicons` |
| `open Facebook group Flutter` | not in top 100 | `iconify_flutter_plus`, `iconify_flutter`, `remixicon`, `flutter_boxicons`, `flutter_remix` |
| `open Facebook page Flutter` | #18 p2 | `iconify_flutter_plus`, `iconify_flutter`, `remixicon`, `flutter_boxicons`, `flutter_remix` |
| `open Facebook profile Flutter` | #9 p1 | `flutter_login_facebook`, `iconify_flutter_plus`, `iconify_flutter`, `remixicon`, `flutter_remix` |
| `open instagram profile flutter` | #1 p1 | DeeplinkX leads |
| `open LinkedIn company Flutter` | not in top 100 | `getwidget`, `icons_plus`, `iconsx_plus`, `icon_plus`, `icons_plus_pro` |
| `open linkedin profile flutter` | #10 p1 | `linkedin_oauth2`, `signin_with_linkedin`, `iconify_flutter_plus`, `iconify_flutter`, `remixicon` |
| `open Pinterest board Flutter` | not in top 100 | `iconify_flutter_plus`, `iconify_flutter`, `flutter_tabler_icons`, `amicons`, `tabler_icons_flutter` |
| `open Pinterest pin Flutter` | not in top 100 | `iconify_flutter_plus`, `iconify_flutter`, `remixicon`, `flutter_boxicons`, `flutter_remix` |
| `open Pinterest profile Flutter` | #8 p1 | `iconify_flutter_plus`, `iconify_flutter`, `remixicon`, `flutter_remix`, `amicons` |
| `open Slack channel Flutter` | not in top 100 | `icons_plus`, `iconsx_plus`, `icon_plus`, `icons_plus_pro`, `crash_reporter` |
| `open Slack team Flutter` | not in top 100 | `iconify_flutter_plus`, `iconify_flutter`, `remixicon`, `flutter_remix`, `amicons` |
| `open Slack user Flutter` | #14 p2 | `iconify_flutter_plus`, `iconify_flutter`, `remixicon`, `flutter_boxicons`, `flutter_remix` |
| `open telegram profile flutter` | #1 p1 | DeeplinkX leads |
| `open Threads comments Flutter` | not in top 100 | `docudart`, `flutter_web_gl`, `gvl_comments`, `font_awesome_flutter`, `opticore` |
| `open Threads post Flutter` | not in top 100 | `flutter_tabler_icons`, `super_icons`, `jaspr_icons_pack`, `jaspr_icons`, `flutter_pas_tabler_icons` |
| `open Threads profile Flutter` | #3 p1 | `remixicon`, `remixicon_updated`, `deeplink_x`, `super_icons`, `ensemble_icons` |
| `open TikTok profile Flutter` | #3 p1 | `remixicon`, `remixicon_updated`, `deeplink_x`, `super_icons`, `tiktok_scraper` |
| `open TikTok tag Flutter` | not in top 100 | `iconify_flutter_plus`, `iconify_flutter`, `remixicon`, `flutter_boxicons`, `flutter_tabler_icons` |
| `open TikTok video Flutter` | #14 p2 | `snap_reels`, `iconify_flutter_plus`, `iconify_flutter`, `remixicon`, `flutter_boxicons` |
| `open Twitter profile Flutter` | #8 p1 | `iconify_flutter_plus`, `iconify_flutter`, `remixicon`, `flutter_remix`, `amicons` |
| `open Twitter tweet Flutter` | not in top 100 | `twitter_intent`, `flutter_social_embeds`, `twitter_openapi_dart_generated`, `twitter_openapi_dart` |
| `open whatsapp chat flutter` | #1 p1 | DeeplinkX leads |
| `open YouTube channel Flutter` | not in top 100 | `iconify_flutter_plus`, `iconify_flutter`, `stac`, `stac_core`, `flutterando_analysis` |
| `open YouTube playlist Flutter` | not in top 100 | `iconify_flutter_plus`, `iconify_flutter`, `flutter_boxicons`, `flutter_tabler_icons`, `stac` |
| `open youtube video flutter` | #2 p1 | `adaptive_video_player`, `deeplink_x`, `floatube_player`, `video_thumbnail_gen`, `flutter_ytdlp_plugin` |
| `search Pinterest Flutter` | #27 p3 | `pinterest_nav_bar`, `iconify_flutter_plus`, `iconify_flutter`, `remixicon`, `font_awesome_flutter` |
| `search Twitter Flutter` | #37 p4 | `canopas_country_picker`, `twitter_api_v2`, `iconify_flutter_plus`, `iconify_flutter`, `search_bar_animated` |
| `search YouTube Flutter` | #6 p1 | `youtube_scrape_api`, `yt_flutter_musicapi`, `youtube_data_api`, `youtube_results`, `newpipeextractor_dart` |
| `send Telegram message Flutter` | not in top 100 | `flutter_chatflow`, `sreporter`, `iconify_flutter_plus`, `iconify_flutter`, `remixicon` |
| `share text to WhatsApp Flutter` | not in top 100 | `flutter_social_share_plugin`, `flutter_share_me`, `whatsapp_share_plus`, `whatsapp_file_share`, `social_sharing_plus` |
| `Telegram username link Flutter` | #1 p1 | DeeplinkX leads |
| `WhatsApp phone number Flutter` | #77 p8 | `otp_phone_verify`, `app_contact_checker`, `flutter_dialpad_plus`, `smart_phone_number`, `social_sender_whatsapp` |

### Supported Navigation Action Searches

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `2GIS coordinates Flutter` | not in top 100 | `mapmyindia_flutter`, `google_map_utils`, `osm_path_tracker`, `h3_core`, `turf` |
| `2GIS directions Flutter` | #4 p1 | `map_launcher`, `dgis_flutter`, `mappls_map_launcher`, `deeplink_x` |
| `2GIS search Flutter` | #1 p1 | DeeplinkX leads |
| `Amap coordinates Flutter` | not in top 100 | `qorvia_maps_sdk`, `scoova_maps`, `flutter_heat_map`, `google_maps_extractor`, `flutter_google_map_polyline_point` |
| `Amap directions Flutter` | #5 p1 | `map_launcher`, `ola_maps_flutter`, `mappls_map_launcher`, `flutter_google_maps_webservices`, `deeplink_x` |
| `Amap search Flutter` | #21 p3 | `xue_hua_gaode_map`, `kw_amap_search`, `amap_flutter_search`, `csp_amap_flutter_base`, `ai_amap` |
| `Apple Maps coordinates Flutter` | not in top 100 | `mapkit_flutter`, `in_app_location_kit`, `maps_launcher`, `location_webview`, `apple_map_snapshotter` |
| `Apple Maps directions Flutter` | #8 p1 | `map_launcher`, `mappls_map_launcher`, `iconify_flutter_plus`, `iconify_flutter`, `flutter_tabler_icons` |
| `Apple Maps search Flutter` | #8 p1 | `apple_maps_place_picker`, `iconify_flutter_plus`, `iconify_flutter`, `flutter_tabler_icons`, `stac` |
| `Baidu Maps coordinates Flutter` | not in top 100 | no pub.dev API results in scan |
| `Baidu Maps directions Flutter` | #4 p1 | `map_launcher`, `mappls_map_launcher`, `flutter_tabler_icons`, `deeplink_x`, `jaspr_icons_pack` |
| `Baidu Maps search Flutter` | #2 p1 | `flutter_tabler_icons`, `deeplink_x`, `jaspr_icons_pack`, `jaspr_icons`, `flutter_baidu_mapapi_search` |
| `Google Maps coordinates Flutter` | not in top 100 | `google_places_for_flutter`, `google_maps_extractor`, `flutter_google_map_polyline_point`, `google_geocoder_krutus`, `google_places_for_flutter_plus` |
| `google maps directions flutter` | #10 p1 | `flutter_google_maps_webservices`, `google_routes_flutter`, `googlemaps_flutter_webservices`, `google_map_service`, `google_map_with_direction_indicator` |
| `Google Maps search Flutter` | #6 p1 | `google_maps_helper`, `maps_place_picker`, `search_map`, `google_maps_places_autocomplete_widgets`, `flutter_google_maps_webservices` |
| `Moovit coordinates Flutter` | not in top 100 | no pub.dev API results in scan |
| `Moovit directions Flutter` | #2 p1 | `map_launcher`, `deeplink_x` |
| `Moovit search Flutter` | #1 p1 | DeeplinkX leads |
| `Neshan coordinates Flutter` | not in top 100 | `neshan_maps_flutter` |
| `Neshan directions Flutter` | #2 p1 | `map_launcher`, `deeplink_x`, `firebase_notifications_handler`, `easy_firebase_notifications_handler` |
| `Neshan search Flutter` | #3 p1 | `neshan_maps_flutter`, `neshanmap_flutter`, `deeplink_x`, `opensubtitles_hasher`, `flutter_wechate_share_plugin` |
| `Sygic coordinates Flutter` | not in top 100 | no pub.dev API results in scan |
| `Sygic directions Flutter` | #3 p1 | `map_launcher`, `mappls_map_launcher`, `deeplink_x` |
| `Sygic search Flutter` | #1 p1 | DeeplinkX leads |
| `view location 2GIS Flutter` | not in top 100 | `arcgis_maps_toolkit`, `arcgis_maps`, `gis_mapping`, `mappls_map_launcher`, `flutter_osm_plugin` |
| `view location Amap Flutter` | not in top 100 | `ola_map_flutter`, `flutter_tamap_location`, `amap_location`, `xbr_gaode_navi_amap`, `ola_maps_flutter` |
| `view location Apple Maps Flutter` | not in top 100 | `apple_maps_flutter`, `apple_maps_place_picker`, `xgh_location_picker_ios`, `iconify_flutter_plus`, `iconify_flutter` |
| `view location Baidu Maps Flutter` | not in top 100 | `flutter_tabler_icons`, `jaspr_icons_pack`, `jaspr_icons`, `tabler_icons_for_flutter`, `flutter_pas_tabler_icons` |
| `view location Google Maps Flutter` | not in top 100 | `webview_location`, `map_location_picker`, `map_flutter`, `flutter_google_maps_widget_cluster_markers`, `apple_maps_flutter` |
| `view location Moovit Flutter` | not in top 100 | no pub.dev API results in scan |
| `view location Neshan Flutter` | not in top 100 | `neshan_maps_flutter`, `neshanmap_flutter`, `flash_animation` |
| `view location Sygic Flutter` | not in top 100 | `mappls_map_launcher` |
| `view location Waze Flutter` | not in top 100 | `flutter_tabler_icons`, `tabler_icons_flutter`, `jaspr_icons_pack`, `jaspr_icons`, `tabler_icons_for_flutter` |
| `view location Yandex Maps Flutter` | not in top 100 | `flutter_tabler_icons`, `jaspr_icons_pack`, `jaspr_icons`, `flutter_pas_tabler_icons`, `yandex_map_desktop` |
| `Waze coordinates Flutter` | not in top 100 | no pub.dev API results in scan |
| `Waze directions Flutter` | #2 p1 | `map_launcher`, `deeplink_x`, `mappls_map_launcher`, `font_awesome_flutter`, `flutter_tabler_icons` |
| `Waze search Flutter` | #1 p1 | DeeplinkX leads |
| `Yandex Maps coordinates Flutter` | not in top 100 | `yandex_map_desktop`, `route_spatial_index` |
| `Yandex Maps directions Flutter` | #4 p1 | `map_launcher`, `mappls_map_launcher`, `flutter_tabler_icons`, `deeplink_x`, `jaspr_icons_pack` |
| `Yandex Maps search Flutter` | #6 p1 | `yandex_maps_mapkit`, `yandex_maps_navikit`, `flutter_tabler_icons`, `yandex_mapkit`, `colorful_iconify_flutter` |

### Provider-Specific Navigation Searches

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `2GIS coordinate route Flutter` | not in top 100 | `osm_path_tracker`, `map_utils_core` |
| `2GIS marker Flutter` | not in top 100 | `map_launcher`, `dgis_map_kit`, `mappls_map_launcher`, `flutter_map_sld_flutter_map`, `syncfusion_flutter_maps` |
| `2GIS route Flutter` | not in top 100 | `mapmyindia_flutter`, `osm_path_tracker`, `map_utils_core`, `aegis_hybrid_stack_manager`, `zpoint_connect` |
| `Amap current location Flutter` | #10 p1 | `ola_map_flutter`, `ultra_map_place_picker`, `flutter_map_location_marker`, `ola_maps_flutter`, `amap_location_plugin` |
| `Amap route Flutter` | not in top 100 | `ola_maps_flutter`, `qorvia_maps_sdk`, `google_maps_widget`, `vietmap_flutter_navigation`, `flutter_google_map_polyline_point` |
| `Baidu Maps navigation Flutter` | #1 p1 | DeeplinkX leads |
| `Baidu Maps nearby search Flutter` | not in top 100 | `nanc_icons`, `tdtxle_icons`, `icons_flutter`, `flutter_icons_null_safety`, `flutter_icons_fix` |
| `Baidu Maps route Flutter` | not in top 100 | `flutter_tabler_icons`, `jaspr_icons_pack`, `jaspr_icons`, `tabler_icons_for_flutter`, `flutter_pas_tabler_icons` |
| `Gaode Maps navigation Flutter` | not in top 100 | `map_launcher`, `mappls_map_launcher` |
| `Moovit navigation Flutter` | #1 p1 | DeeplinkX leads |
| `Moovit transit Flutter` | not in top 100 | no pub.dev API results in scan |
| `Neshan navigation Flutter` | #1 p1 | DeeplinkX leads |
| `Sygic navigation Flutter` | #1 p1 | DeeplinkX leads |
| `Waze marker Flutter` | not in top 100 | `map_launcher`, `mappls_map_launcher`, `font_awesome_flutter`, `opticore`, `font_awesome_icon_class` |
| `Waze navigation Flutter` | #1 p1 | DeeplinkX leads |
| `Yandex Maps organization Flutter` | not in top 100 | `icons_flutter`, `flutter_icons_null_safety`, `flutter_icons_fix`, `flutter_icons_null_safe`, `flutter_null_safety_icons` |
| `Yandex Maps panorama Flutter` | not in top 100 | `flutter_tabler_icons`, `jaspr_icons_pack`, `jaspr_icons`, `flutter_pas_tabler_icons`, `docudart` |
| `Yandex Maps route Flutter` | not in top 100 | `yandex_maps_mapkit`, `flutter_yandex_navikit`, `yandex_maps_navikit`, `yandex_map_desktop`, `flutter_tabler_icons` |
| `Yandex Maps what is here Flutter` | not in top 100 | no pub.dev API results in scan |

## Related Keyword Discovery

These phrases come from documented DeeplinkX actions, public API spellings, pub.dev competitor wording, current Medium article language, and real developer-question titles. They are separated from the stable baseline so future comparisons can distinguish newly added coverage from ranking movement.

Case-only variants share one normalized pub.dev request. In particular, the public API spelling `YandexMaps` uses the displayed `yandexmaps` result.

### App Aliases And Developer Spellings

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `2 GIS` | #46 p5 | `win32_registry`, `geoengine`, `arcgis_maps`, `arcgis_map_sdk`, `flutter_form_registry` |
| `2 GIS deeplink` | #2 p1 | `push_message_register`, `deeplink_x` |
| `2 GIS Flutter` | #31 p4 | `arcgis_maps`, `arcgis_map_sdk`, `flutter_form_registry`, `flutter_map_arcgis`, `mapmyindia_flutter` |
| `2 GIS link` | #3 p1 | `gisila_studio`, `gis_mapping`, `deeplink_x` |
| `baidumap` | not in top 100 | `baidu_map`, `flutter_baidu_mapapi_search`, `flutter_baidu_mapapi_utils`, `flutter_baidu_mapapi_base`, `flutter_baidu_mapapi_map` |
| `baidumap deeplink` | not in top 100 | no pub.dev API results in scan |
| `baidumap Flutter` | not in top 100 | `flutter_baidu_mapapi_search`, `flutter_baidu_mapapi_utils`, `flutter_baidu_mapapi_base`, `flutter_baidu_mapapi_map`, `map_launcher` |
| `baidumap link` | not in top 100 | `dcubo_iconify_arcticons` |
| `BaiduMaps` | #32 p4 | `flutter_baidu_mapapi_search`, `flutter_baidu_mapapi_utils`, `flutter_baidu_mapapi_base`, `flutter_baidu_mapapi_map`, `map_launcher` |
| `BaiduMaps deeplink` | #1 p1 | DeeplinkX leads |
| `BaiduMaps Flutter` | #32 p4 | `flutter_baidu_mapapi_search`, `flutter_baidu_mapapi_utils`, `flutter_baidu_mapapi_base`, `flutter_baidu_mapapi_map`, `map_launcher` |
| `BaiduMaps link` | #1 p1 | DeeplinkX leads |
| `dgis` | not in top 100 | `dgis_mobile_sdk_full`, `dgis_mobile_sdk_map`, `dgis_map_kit`, `dgis_flutter`, `dgis_map_platform_interface` |
| `dgis deeplink` | not in top 100 | `push_message_register` |
| `dgis Flutter` | not in top 100 | `dgis_flutter`, `dgis_mobile_sdk_full`, `dgis_mobile_sdk_map`, `dgis_map_kit`, `map_launcher` |
| `dgis link` | not in top 100 | `gisila_studio`, `gis_mapping` |
| `Gaode Maps` | not in top 100 | `map_launcher`, `mappls_map_launcher`, `xue_hua_gaode_map`, `coord_convert`, `xbr_gaode_navi_amap` |
| `Gaode Maps deeplink` | not in top 100 | no pub.dev API results in scan |
| `Gaode Maps Flutter` | not in top 100 | `map_launcher`, `mappls_map_launcher`, `xue_hua_gaode_map`, `gmm_amap_flutter_map`, `gmm_amap_flutter_location` |
| `Gaode Maps link` | not in top 100 | `xue_hua_gaode_map` |
| `open 2 GIS Flutter` | #4 p1 | `sqflite_spatial`, `yls_agi_sdk_dart`, `flutter_osm_plugin`, `deeplink_x`, `zpoint_connect` |
| `open baidumap Flutter` | not in top 100 | `baidu_speech_recognition`, `mappls_map_launcher`, `jm_baidu_stt_plugin` |
| `open BaiduMaps Flutter` | #3 p1 | `maps_launcher`, `location_picker_flutter_map`, `deeplink_x`, `mhj_maps`, `any_map_osm` |
| `open dgis Flutter` | not in top 100 | `longshort_register_io`, `mappls_map_launcher`, `yls_agi_sdk_dart`, `login_and_register_page` |
| `open Gaode Maps Flutter` | not in top 100 | `mappls_map_launcher` |
| `open TwoGis Flutter` | #30 p3 | `iconify_flutter_plus`, `iconify_flutter`, `external_app_launcher`, `flutter_to_airplay`, `location_picker_flutter_map` |
| `open yandexmaps Flutter` | not in top 100 | `yandex_map_desktop`, `flutter_login_yandex`, `flutter_yandex_games`, `yandex_login_sdk`, `mappls_map_launcher` |
| `TwoGis` | #55 p6 | `pinput`, `diffutil_dart`, `string_similarity`, `two_dimensional_scrollables`, `geocode` |
| `TwoGis deeplink` | #3 p1 | `iconify_flutter_plus`, `iconify_flutter`, `deeplink_x`, `djangoflow_deep_link_interface`, `colorful_iconify_flutter` |
| `TwoGis Flutter` | not in top 100 | `diffutil_dart`, `card_loading`, `age_calculator`, `drag_and_drop_lists`, `animated_list_plus` |
| `TwoGis link` | #37 p4 | `linked_scroll_controller`, `blinker`, `any_link_connect`, `linkedin_login`, `expandable_text` |
| `yandexmaps` | #9 p1 | `yandex_mapkit`, `yandex_maps_mapkit_lite`, `yandex_maps_mapkit`, `yandex_maps_navikit`, `yandex_mapkit_lite` |
| `yandexmaps deeplink` | not in top 100 | no pub.dev API results in scan |
| `yandexmaps Flutter` | not in top 100 | `yandex_mapkit`, `yandex_maps_mapkit_lite`, `yandex_maps_mapkit`, `yandex_maps_navikit`, `map_launcher` |
| `yandexmaps link` | not in top 100 | `yandex_music` |

### External App Intent

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `app to app deeplink Flutter` | #9 p1 | `app_links`, `flutter_branch_sdk`, `urlynk_flutter`, `google_ads_deferred_deep_link`, `deep_link_orchestrator` |
| `button to open another app Flutter` | not in top 100 | `external_app_launcher`, `external_app_launcher_plus`, `open_mail`, `app_tracking_transparency`, `another_flushbar` |
| `launch app by application ID` | not in top 100 | `iconify_flutter_plus`, `iconify_flutter`, `win32`, `cnativeapi`, `super_icons` |
| `open app by package name` | not in top 100 | `openapp_by_package`, `openfoodfacts`, `flutter_animated_icons`, `folder_file_saver`, `tabby_flutter_inapp_sdk` |
| `open native app Flutter` | #37 p4 | `open_file`, `open_filex`, `square_in_app_payments`, `better_open_file`, `open_file_plus` |
| `open specific app Flutter` | #11 p2 | `sbp_payments`, `flutter_full_screen_intent`, `iconify_flutter_plus`, `iconify_flutter`, `flutter_document_picker` |

### Installation And Fallback Intent

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `check if app installed then open Flutter` | #6 p1 | `flutter_appavailability`, `scrumlab_flutter_appavailability`, `app_avaliability`, `open_mail_launcher`, `external_app_launcher` |
| `deep link fallback URL` | #1 p1 | DeeplinkX leads |
| `native app store web fallback` | #1 p1 | DeeplinkX leads |
| `open app if installed otherwise store` | #1 p1 | DeeplinkX leads |
| `open app if installed otherwise web` | #1 p1 | DeeplinkX leads |

### Map Intent

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `available maps installed device Flutter` | not in top 100 | `map_launcher`, `mappls_map_launcher`, `map_launcher_ohos`, `installed_apps`, `device_safety_info` |
| `choose map app Flutter` | not in top 100 | `flutter_map_polywidget`, `ultra_map_place_picker`, `safe_json_mapper`, `geomap_package`, `plug_location_map` |
| `choose map between available maps Flutter` | not in top 100 | `place_picker_google`, `ola_maps_autofill`, `maplauncherplus`, `nominatim_location_picker`, `contribution_heatmap` |
| `default map app Flutter` | not in top 100 | `map_picker`, `mapsindoors_mapbox`, `google_places_autocomplete`, `mapsindoors_googlemaps`, `flutter_map_polywidget` |
| `find installed maps Flutter` | not in top 100 | `map_launcher`, `mappls_map_launcher`, `map_launcher_ohos`, `arcgis_maps_toolkit`, `egyptid_extractor` |
| `geo URI Flutter` | not in top 100 | `fintech_security`, `flutter_image_optimizer`, `snowplow_tracker`, `apptive_grid_form`, `flutter_web_gl` |
| `marker direction given coordinates Flutter` | not in top 100 | no pub.dev API results in scan |
| `open coordinates in maps Flutter` | not in top 100 | `in_app_location_kit`, `polyline_animation_v1`, `flutter_nominatim`, `flutter_simple_map`, `university_locations` |
| `show marker in maps app` | not in top 100 | `mappls_map_launcher`, `iconify_flutter_plus`, `iconify_flutter`, `map_polyline_draw`, `jaspr_icons_pack` |
| `start navigation to coordinates Flutter` | not in top 100 | `flutter_web_gl`, `magiclane_maps_flutter`, `maps_tracking_toolbox`, `sakura_epub`, `flutter_left_right_container` |

### WhatsApp Intent

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `open WhatsApp chat with phone number` | #23 p3 | `iconify_flutter_plus`, `iconify_flutter`, `ubicons`, `jaspr_icons_pack`, `jaspr_icons` |
| `share text to WhatsApp Flutter` | not in top 100 | `flutter_social_share_plugin`, `flutter_share_me`, `whatsapp_share_plus`, `whatsapp_file_share`, `social_sharing_plus` |
| `wa.me link Flutter` | not in top 100 | `wa_me`, `watermelon_mediator`, `payment_gateway_flutter`, `flutter_web_gl`, `awareframework_core` |
| `WhatsApp Click to Chat Flutter` | not in top 100 | `iconify_flutter_plus`, `iconify_flutter`, `ubicons`, `super_icons`, `jaspr_icons_pack` |
| `WhatsApp direct send Flutter` | not in top 100 | `whatsapp_direct_send`, `social_sender_whatsapp`, `amicons`, `super_icons`, `universal_share` |
| `WhatsApp prefilled message` | not in top 100 | no pub.dev API results in scan |

### Developer Syntax

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `Android intent open app Flutter` | #29 p3 | `open_file`, `open_filex`, `better_open_file`, `open_file_plus`, `open_file_safe_plus` |
| `geo intent Flutter` | not in top 100 | `native_geofence`, `flutter_vonage_opentok_platform_interface`, `maps_launcher`, `geofence`, `flutter_web_gl` |
| `iOS URL scheme open app Flutter` | #13 p2 | `app_links`, `open_mail_launcher`, `flutter_zalopay_sdk`, `uni_links3`, `uni_links5` |
| `LaunchMode.externalApplication` | not in top 100 | `app_runner`, `bubble_head`, `ussd_launcher`, `vwo_insights_flutter_sdk`, `flutter_app_icon_changer` |
| `market details Flutter` | not in top 100 | `whatsapp_otp`, `flutter_bubble_chart`, `cafebazaar_market`, `flutter_map_dragmarker`, `animate_map_markers` |

### Typed API Intent

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `deep link package with fallback` | #1 p1 | DeeplinkX leads |
| `type safe app launcher` | #1 p1 | DeeplinkX leads |
| `typed external app links` | #1 p1 | DeeplinkX leads |
| `typed URL launcher Flutter` | #5 p1 | `route_pilot`, `url_launcher_utils`, `geniuslink_design_system`, `flutter_local_ai`, `deeplink_x` |

### Competitor Intent

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `app_links alternative` | not in top 100 | `appsonair_flutter_applink`, `sojo_link`, `win32`, `media_link_generator`, `gpt_markdown` |
| `deeplink_x vs app_links` | not in top 100 | no pub.dev API results in scan |
| `deeplink_x vs external_app_launcher` | not in top 100 | no pub.dev API results in scan |
| `deeplink_x vs map_launcher` | not in top 100 | no pub.dev API results in scan |
| `deeplink_x vs maps_launcher` | not in top 100 | no pub.dev API results in scan |
| `deeplink_x vs url_launcher` | not in top 100 | no pub.dev API results in scan |
| `deeplink_x vs whatsapp_unilink` | not in top 100 | no pub.dev API results in scan |
| `external_app_launcher alternative` | not in top 100 | `android_native`, `flutter_intent_forzzh`, `intent_plus`, `hzfinger_fingerprint_sdk` |
| `map_launcher alternative` | not in top 100 | `sojo_link`, `android_native` |
| `maps_launcher alternative` | not in top 100 | `android_native`, `flutter_intent_forzzh`, `intent_plus`, `flutter_app_transmuter`, `flutter_env_native` |
| `whatsapp_unilink alternative` | not in top 100 | no pub.dev API results in scan |

### Store Provider Intent

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `App Store deeplink Flutter` | #1 p1 | DeeplinkX leads |
| `App Store link Flutter` | #1 p1 | DeeplinkX leads |
| `Cafe Bazaar deeplink Flutter` | #1 p1 | DeeplinkX leads |
| `Cafe Bazaar link Flutter` | #1 p1 | DeeplinkX leads |
| `Google Play deeplink Flutter` | #1 p1 | DeeplinkX leads |
| `Google Play link Flutter` | #2 p1 | `flutter_install_app_plugin`, `deeplink_x`, `flutter_update_checker`, `flutter_update_checker_plus`, `verify_local_purchase` |
| `Huawei AppGallery deeplink Flutter` | #1 p1 | DeeplinkX leads |
| `Huawei AppGallery link Flutter` | #1 p1 | DeeplinkX leads |
| `Mac App Store deeplink Flutter` | #1 p1 | DeeplinkX leads |
| `Mac App Store link Flutter` | #1 p1 | DeeplinkX leads |
| `Microsoft Store deeplink Flutter` | #1 p1 | DeeplinkX leads |
| `Microsoft Store link Flutter` | #1 p1 | DeeplinkX leads |
| `Myket deeplink Flutter` | #1 p1 | DeeplinkX leads |
| `Myket link Flutter` | #1 p1 | DeeplinkX leads |
| `open App Store app page Flutter` | #4 p1 | `store_redirect`, `app_review`, `open_the_store`, `deeplink_x`, `web_platform_detector` |
| `open Cafe Bazaar app page Flutter` | #3 p1 | `cafebazaar_flutter`, `iran_appmarket`, `deeplink_x`, `cafebazaar_market`, `flutter_bazaar` |
| `open Google Play app page Flutter` | #5 p1 | `store_redirect`, `open_appstore`, `launch_app_store`, `flutter_install_app_plugin`, `deeplink_x` |
| `open Huawei AppGallery app page Flutter` | #1 p1 | DeeplinkX leads |
| `open Mac App Store app page Flutter` | #1 p1 | DeeplinkX leads |
| `open Microsoft Store app page Flutter` | #1 p1 | DeeplinkX leads |
| `open Myket app page Flutter` | #2 p1 | `iran_appmarket`, `deeplink_x`, `myket_updater`, `zeba_academy_keyboard_manager`, `zeba_academy_keyboard_shortcuts` |
| `rate app App Store Flutter` | not in top 100 | `in_app_review`, `app_review`, `app_review_plus`, `app_rating`, `is_pirated` |
| `rate app Mac App Store Flutter` | not in top 100 | `in_app_review`, `iconify_flutter_plus`, `iconify_flutter`, `flutter_in_app_review`, `stac` |
| `rate app Myket Flutter` | not in top 100 | `myket_updater` |

## Medium Article Search Signals

The July 6 Medium-derived phrases were preserved. New phrases were added only when they appeared in current article titles or article wording relevant to external app launching, fallback, maps, coordinates, or provider aliases.

### Medium Sources Reviewed

| Article | Search language used |
| --- | --- |
| [The Complete Guide to Deep Linking in Flutter](https://medium.com/easy-flutter/the-complete-guide-to-deep-linking-in-flutter-0d7518443ad8) | open directly inside the app, custom URL schemes, app links |
| [Deeplinking in Flutter](https://medium.com/nammaflutter/deeplinking-in-flutter-ad5a40759ef3) | store fallback, app not installed, Android/iOS links |
| [Using Google Maps in Flutter application Using Url Launcher](https://aayushbajaj505.medium.com/using-google-maps-in-flutter-application-using-url-launcher-4514f055b684) | latitude/longitude, directions, map query, URL Launcher |
| [Flutter Map Launcher](https://maneesha-erandi.medium.com/flutter-map-launcher-55449161fea8) | available maps, marker, direction to coordinates, user map choice, Baidu/Amap/Yandex/2GIS schemes |
| [Deep Linking in Flutter: A Complete Guide to Navigation Beyond the App](https://medium.com/%40aadil.ansari8/deep-linking-in-flutter-a-complete-guide-to-navigation-beyond-the-app-b546bf2c40e6) | navigation beyond the app, custom URI scheme, browser fallback |
| [Yandex Mapkit Light](https://medium.com/%40flutternewshub/yandex-mapkit-light-a-lightweight-map-solution-for-flutter-apps-d4264468beba) | Yandex Maps, marker, routing, panorama |

### Pub.dev Positions for Medium-Derived Phrases

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `add marker direction given coordinates Flutter` | not in top 100 | no pub.dev API results in scan |
| `app not installed redirect to store Flutter` | #4 p1 | `flutter_web_gl`, `in_app_review`, `external_app_launcher`, `deeplink_x`, `appsonair_flutter_sdk` |
| `available maps in mobile device Flutter` | not in top 100 | `iconify_flutter_plus`, `iconify_flutter`, `stac`, `stac_core`, `ubicons` |
| `choose map according to user preference Flutter` | not in top 100 | no pub.dev API results in scan |
| `custom scheme deep link Flutter` | #13 p2 | `app_links`, `link_bridge`, `uni_links3`, `screen_launch_by_notfication`, `uni_links5` |
| `deep link without package Flutter` | not in top 100 | `my_deep_link_sdk`, `flutter_facebook_app_links_spm`, `deep_link_manager`, `smart_deeplink_router`, `stack_deferred_link` |
| `DeepLinkX vs url_launcher` | not in top 100 | no pub.dev API results in scan |
| `fallback to App Store Play Store web Flutter` | #1 p1 | DeeplinkX leads |
| `Flutter deep linking and universal linking` | not in top 100 | `deeplink_sdk`, `wildlinks_flutter_sdk`, `deep_link_orchestrator`, `flutter_deep_linker`, `flutter_linkme_sdk` |
| `Flutter Map Launcher` | #26 p3 | `map_launcher`, `maps_launcher`, `flutter_launcher_plus`, `mappls_map_launcher`, `url_launcher` |
| `Flutter redirect users to app store` | #12 p2 | `store_redirect`, `store_redirect2`, `in_app_review`, `simple_auth_flutter`, `flutter_in_app_review` |
| `given coordinates` | not in top 100 | `proximity_hash`, `latlong_to_osgrid`, `draw_on`, `solar_calculator`, `svg_to_paint` |
| `given coordinates Flutter maps` | not in top 100 | `flutter_simple_map`, `open_route_service`, `mapwize`, `fl_geocoder`, `stl` |
| `Google Maps & URL Launcher in Flutter` | #1 p1 | DeeplinkX leads |
| `Google Maps and URL Launcher in Flutter` | #1 p1 | DeeplinkX leads |
| `Google Maps URL Launcher Flutter` | #5 p1 | `launchify`, `maps_launcher`, `map_launcher`, `url_launcher_utils`, `deeplink_x` |
| `iOS URL scheme Android intent Flutter` | #91 p10 | `appscheme`, `link_bridge`, `uni_links3`, `upi_intent`, `uni_links5` |
| `launch Google Maps directions Flutter` | #5 p1 | `map_launcher`, `mappls_map_launcher`, `iconify_flutter_plus`, `iconify_flutter`, `deeplink_x` |
| `launch Google Maps or Apple Maps with coordinates` | not in top 100 | `maps_launcher`, `casa_google_map` |
| `launch maps with given coordinates Flutter` | not in top 100 | no pub.dev API results in scan |
| `launch other app from Flutter app` | #54 p6 | `bugsee_flutter`, `flutter_alarm_background_trigger`, `android_vlc_player`, `bring_app_to_foreground`, `reclaim_sdk` |
| `navigation beyond the app Flutter` | not in top 100 | `bouncy_background`, `sint`, `idto_flutter`, `ui_commenter`, `apptomate_custom_appbar` |
| `open another app without url_launcher Flutter` | not in top 100 | `dynamic_ui_renderer`, `flutter_quill_syncme` |
| `open directly inside app not browser Flutter` | #1 p1 | DeeplinkX leads |
| `open Google Map and show navigation` | not in top 100 | `iconify_flutter_plus`, `iconify_flutter`, `flutter_tabler_icons`, `ubicons`, `tabler_icons_flutter` |
| `open Google Maps and show navigation Flutter` | not in top 100 | `iconify_flutter_plus`, `iconify_flutter`, `flutter_tabler_icons`, `ubicons`, `jaspr_icons_pack` |
| `open Instagram profile from Flutter` | #1 p1 | DeeplinkX leads |
| `open map latitude longitude Flutter` | not in top 100 | `iconify_flutter_plus`, `iconify_flutter`, `flutter_tabler_icons`, `open_street_map_search_and_pick`, `osm_search_and_pick` |
| `open Telegram profile from Flutter` | #1 p1 | DeeplinkX leads |
| `open WhatsApp directly from Flutter` | #2 p1 | `whatsapp`, `deeplink_x`, `whatsapp_direct_send`, `native_social_share`, `media_launcher_plugin` |
| `open YouTube video from Flutter` | #8 p1 | `iconify_flutter_plus`, `iconify_flutter`, `flutter_boxicons`, `flutter_tabler_icons`, `stac` |
| `pre-filled WhatsApp message Flutter` | not in top 100 | `preferred_upi_launcher`, `social_sender_whatsapp`, `whatsapp_direct_send`, `launcher_utils`, `universal_share` |
| `redirect users to App Store Play Store` | #12 p2 | `store_redirect`, `store_redirect2`, `win32`, `flutter_app_update_lib`, `win32_gui` |
| `send whatsapp message flutter` | not in top 100 | `flutter_open_whatsapp`, `whatsapp`, `flutter_chatflow`, `whatsapp_sender_flutter`, `waapi_flutter` |
| `show navigation Flutter Google Maps` | not in top 100 | `map_launcher`, `google_maps_flutter`, `google_maps_widget`, `iconify_flutter_plus`, `iconify_flutter` |
| `store fallback Flutter` | #1 p1 | DeeplinkX leads |
| `using Google Maps in Flutter application using URL Launcher` | not in top 100 | `webf_deeplink` |
| `WhatsApp phone number and message` | not in top 100 | `smart_phone_number`, `iconify_flutter_plus`, `iconify_flutter`, `flutter_tabler_icons`, `tabler_icons_flutter` |
| `WhatsApp phone number pre-filled message` | not in top 100 | `social_sender_whatsapp`, `whatsapp_direct_send`, `whatsapp_launcher` |
| `without url_launcher Flutter deeplink` | not in top 100 | `rgb_cli` |

## Recommendations

- Preserve the provider-rich description and fallback wording; exact deeplink, typed API, store fallback, and store-provider searches are the strongest areas.
- Add natural metadata or documentation wording for the newest providers when space allows. Exact Baidu Maps, 2GIS, and Yandex Maps link/deeplink intent is excellent, but plain 2GIS and Yandex Maps still trail provider SDK packages.
- Add explicit map-choice and coordinate language such as "find installed maps", "choose map app", "open coordinates in maps", "show marker", and "start navigation"; all ten generic related map phrases are currently outside the top 100.
- Strengthen WhatsApp task wording around Click to Chat, `wa.me`, pre-filled messages, sharing text, and direct send. Only `open WhatsApp chat with phone number` currently ranks among the six new task phrases.
- Restore exact "without url_launcher" comparison language in durable docs or articles. Five previously ranked alternative phrases disappeared after the new publish.
- Improve LinkedIn wording if plain-app discoverability matters; `linkedin` dropped ten positions and `linkedin link` dropped two.
- Keep regional store pages prominent. Huawei AppGallery, Cafe Bazaar, Myket, Microsoft Store, and Mac App Store phrases produced many #1 positions.
- Treat competitor-alternative searches as content opportunities rather than pubspec-only targets; none of the eleven new competitor comparison phrases rank yet.
