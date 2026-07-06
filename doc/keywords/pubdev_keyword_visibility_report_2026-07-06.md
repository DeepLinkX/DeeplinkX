# pub.dev Keyword Visibility Report

Generated: 2026-07-06

Package audited: `deeplink_x`

## Scope

This report checks where `deeplink_x` appears in pub.dev search results for app-specific, deeplink, external-app, store fallback, map/navigation, URL scheme, human-style, Medium-derived, and competitor-style keywords.

The goal is to understand which searches `deeplink_x` currently owns after the 2026-07-06 publish, which searches are controlled by app-specific competitors, and which metadata/content terms still need work.

## Method

- Source: pub.dev package search API and pub.dev package pages.
- Ranking mode: pub.dev default search ranking.
- Page size assumption: 10 results per page.
- Rank format: `#position pPage`.
- All keyword queries in this refresh were scanned up to top 100 unless the result set ended earlier.
- Rate limits were waited out with retry/backoff rather than skipped.
- Search results are time-sensitive and can change as pub.dev reindexes, downloads change, likes change, or package metadata changes.
- Supported-app keyword coverage was cross-checked against the current README app list and `doc/apps/*.md`; the app-specific matrix covers all current app docs, including newer map/navigation providers such as Amap, Moovit, and Neshan.

Sources:

- <https://pub.dev/packages/deeplink_x>
- <https://pub.dev/api/packages/deeplink_x>
- <https://pub.dev/api/packages/deeplink_x/score>
- <https://pub.dev/help/search#ranking>
- Medium article search results for Flutter deeplinks, WhatsApp, Google Maps, universal links, and `url_launcher`

Download count note: the rendered pub.dev package and score pages reported `787` downloads during the 2026-07-06 recheck; the score API still returned `695`, so this report uses the visible pub.dev page value.

## Current Published Package Signals

pub.dev currently reports `deeplink_x` latest as `1.3.5+2`, published on `2026-07-04T10:10:55.716454Z`.

Current published description:

```yaml
description: Type-safe Flutter deeplinks for WhatsApp, Telegram, Instagram, YouTube, Google Maps, Waze and app stores, with automatic store and web fallback.
```

Current visible score signals from pub.dev:

| Signal | Value |
| --- | ---: |
| Pub points | 160 / 160 |
| Likes | 12 |
| 30-day downloads | 787 |
| Topics | `deeplink`, `app-links`, `maps`, `navigation`, `open-store` |

## Executive Summary

`deeplink_x` still owns the high-intent deeplink searches and now has much better app-name and app-link discoverability for providers named in the published description. The biggest improvements are WhatsApp, Telegram, Instagram, YouTube, and Amap intent queries.

Strong current categories:

- App/provider intent: `whatsapp link`, `telegram link`, `instagram link`, `youtube link`, `amap link`, `amap deeplink`
- Human task searches: `open WhatsApp directly from Flutter`, `open Telegram profile from Flutter`, `open Instagram profile from Flutter`, `open YouTube video from Flutter`
- Maps: `google maps link`, `google maps deeplink`, `waze link`, `open amap flutter`
- Fallback/store: `store fallback`, `app store link`, `google play link`

Remaining weak categories:

- Exact scheme terms: `url scheme`
- Some generic social terms: `social app`, `social deeplink`
- Some article-style map phrasing: `open Google Maps and show navigation Flutter`
- WhatsApp message phrasing: `send WhatsApp message Flutter`

## App-Specific Competitor Matrix

| App | Plain app query | App link query | App deeplink query | Main packages above DeeplinkX / notes |
| --- | ---: | ---: | ---: | --- |
| WhatsApp | #17 p2 | #2 p1 | #1 p1 | `whatsapp`, `whatsapp_unilink` |
| Telegram | #12 p2 | #2 p1 | #1 p1 | `telegram`, `telegram_link` |
| Instagram | #11 p2 | #1 p1 | #1 p1 | `instagram` |
| Facebook | not in top 100 | #11 p2 | #4 p1 | `flutter_facebook_app_links`, `flutter_facebook_deeplinks`, `facebook_deeplinks` |
| LinkedIn | #64 p7 | #12 p2 | #1 p1 | `linkedin_login` |
| Twitter | not in top 100 | #11 p2 | #2 p1 | `twitter`, `twitter_login` |
| Threads | #42 p5 | #2 p1 | #1 p1 | `threads_client_grpc` on plain query |
| YouTube | #14 p2 | #1 p1 | #1 p1 | `youtube`, `youtube_validator`, player/API packages |
| TikTok | #54 p6 | #3 p1 | #1 p1 | `tiktok_events_sdk`, `tiktok_api` |
| Pinterest | #11 p2 | #1 p1 | #1 p1 | `pinterest_nav_bar` on plain query |
| Zoom | not in top 100 | #5 p1 | #1 p1 | `zoom`, `gr_zoom` |
| Slack | #31 p4 | #2 p1 | #1 p1 | `slack`, `slack_logger` |
| Google Maps | #24 p3 | #1 p1 | #1 p1 | `google_maps`, `google_maps_flutter` |
| Apple Maps | #16 p2 | #1 p1 | #1 p1 | `apple_maps`, `apple_maps_flutter` |
| Waze | #1 p1 | #1 p1 | #1 p1 | none above DeeplinkX |
| Sygic | #2 p1 | #1 p1 | #1 p1 | `map_launcher` on plain query |
| Neshan | #5 p1 | #1 p1 | #1 p1 | `neshan_maps_flutter`, `neshanmap_flutter`, `map_launcher` |
| Amap | #83 p9 | #1 p1 | #1 p1 | local support exists, but current pub.dev latest is `1.3.3` |
| Moovit | #2 p1 | #1 p1 | #1 p1 | post-publish app |

## Expanded Keyword Audit

### Core Deeplink Terms

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `deeplink` | #3 p1 | `app_links`, `flutter_branch_sdk`, `deeplink_x`, `zenrouter_devtools`, `flutter_link_nav` |
| `deep link` | #4 p1 | `app_links`, `flutter_branch_sdk`, `flutter_facebook_app_links`, `deeplink_x`, `chottu_link` |
| `deep links` | #5 p1 | `deep_links`, `app_links`, `flutter_branch_sdk`, `flutter_facebook_app_links`, `deeplink_x` |
| `deep linking` | not in top 100 | `go_router`, `auto_route`, `kiwi`, `go_router_builder`, `zenrouter` |
| `flutter deeplink` | #3 p1 | `app_links`, `flutter_branch_sdk`, `deeplink_x`, `flutter_link_nav`, `deeplink_sdk` |
| `flutter deep link` | #4 p1 | `app_links`, `flutter_branch_sdk`, `flutter_facebook_app_links`, `deeplink_x`, `stack_deferred_link` |
| `flutter deep linking` | not in top 100 | `flutter_deep_linking`, `go_router`, `kiwi`, `zenrouter`, `protocol_handler` |
| `deeplink package` | #8 p1 | `override_api_endpoint`, `toropass_client`, `djangoflow_deep_link_interface`, `my_deep_link_sdk`, `deep_link_manager` |
| `deeplink plugin` | #21 p3 | `flutter_branch_sdk`, `urlynk_flutter`, `flutter_deep_links`, `google_ads_deferred_deep_link`, `xy_umeng` |
| `deeplink flutter package` | #7 p1 | `toropass_client`, `djangoflow_deep_link_interface`, `my_deep_link_sdk`, `deep_link_manager`, `smart_deeplink_router` |
| `deep link plugin` | #28 p3 | `flutter_branch_sdk`, `flutter_facebook_app_links`, `stack_deferred_link`, `eimzo_flutter`, `link_bridge` |
| `deep link package` | #10 p1 | `djangoflow_deep_link_interface`, `flutter_facebook_app_links_spm`, `app_wide_search`, `djangoflow_app_links`, `my_deep_link_sdk` |
| `external deeplink` | #1 p1 | DeeplinkX leads |
| `external deep link` | #1 p1 | DeeplinkX leads |
| `type safe deeplink` | #1 p1 | DeeplinkX leads |
| `typed deeplink` | #1 p1 | DeeplinkX leads |
| `deeplink launcher` | #1 p1 | DeeplinkX leads |

### App Links and URL Scheme Terms

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `app links` | #8 p1 | `app_links`, `whatsapp_unilink`, `flutter_branch_sdk`, `flutter_share`, `flutter_facebook_app_links` |
| `app link` | #5 p1 | `app_links`, `whatsapp_unilink`, `flutter_branch_sdk`, `flutter_facebook_app_links`, `deeplink_x` |
| `app-links` | #8 p1 | `app_links`, `whatsapp_unilink`, `flutter_branch_sdk`, `flutter_share`, `flutter_facebook_app_links` |
| `universal links` | #28 p3 | `universal_links`, `app_links`, `whatsapp_unilink`, `flutter_branch_sdk`, `link_bridge` |
| `universal link` | #26 p3 | `app_links`, `whatsapp_unilink`, `flutter_branch_sdk`, `link_bridge`, `flutter_link_nav` |
| `custom url scheme` | #69 p7 | `appscheme`, `app_links`, `link_bridge`, `flutter_dominant_color_container`, `uni_links3` |
| `custom url schemes` | #35 p4 | `app_links`, `flutter_branch_sdk`, `link_bridge`, `appscheme`, `flutter_deep_links` |
| `url scheme` | not in top 100 | `appscheme`, `android_scheme_search`, `app_links`, `url_launcher`, `ios_native_utils` |
| `url schemes` | #53 p6 | `url_launcher`, `app_links`, `flutter_branch_sdk`, `telegram`, `link_bridge` |
| `scheme launcher` | #21 p3 | `url_launcher`, `maps_launcher`, `external_app_launcher`, `open_mail_launcher`, `launchify` |
| `intent launcher` | #51 p6 | `intent_launcher`, `url_launcher`, `android_intent_plus`, `maps_launcher`, `external_app_launcher` |
| `android intent` | not in top 100 | `android_intent`, `open_file`, `android_intent_plus`, `share_plus`, `open_filex` |
| `ios url scheme` | not in top 100 | `appscheme`, `app_links`, `ios_native_utils`, `link_bridge`, `uni_links3` |

### Open and Launch External Apps

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `open app` | #24 p3 | `open_app`, `open_file`, `serverpod`, `iconify_flutter_plus`, `iconify_flutter` |
| `launch app` | not in top 100 | `launchapp`, `icons_launcher`, `flutter_launcher_icons`, `appcheck`, `external_app_launcher` |
| `open external app` | #11 p2 | `external_app_launcher`, `app_activity_launcher`, `external_app_launcher_plus`, `flutter_external_app`, `open_file` |
| `launch external app` | #26 p3 | `launchexternalapp`, `external_app_launcher`, `app_activity_launcher`, `external_app_launcher_plus`, `app_launcher_packagename` |
| `external app` | #46 p5 | `external_app_launcher`, `dropbox_client`, `app_activity_launcher`, `ensemble_ts_interpreter`, `external_app_launcher_plus` |
| `external app launcher` | #9 p1 | `external_app_launcher`, `app_activity_launcher`, `external_app_launcher_plus`, `app_launcher_packagename`, `launchify` |
| `flutter open app` | #19 p2 | `flutter_open_app`, `open_file`, `serverpod`, `iconify_flutter_plus`, `iconify_flutter` |
| `flutter launch app` | #85 p9 | `icons_launcher`, `flutter_launcher_icons`, `appcheck`, `external_app_launcher`, `launch_app_store` |
| `flutter app launcher` | #56 p6 | `icons_launcher`, `flutter_launcher_icons`, `dynamic_app_icon_flutter_plus`, `external_app_launcher`, `flutter_app_badge` |
| `open installed app` | #12 p2 | `open_mail`, `open_mail_launcher`, `open_mail_app`, `open_mail_app_plus`, `is_pirated` |
| `launch installed app` | #41 p5 | `appcheck`, `app_launcher`, `open_mail_launcher`, `mappls_map_launcher`, `apps_utils` |
| `is app installed` | not in top 100 | `is_app_installed`, `appcheck`, `check_app_version`, `new_device_apps`, `app_install_checker` |
| `check app installed` | #62 p7 | `appcheck`, `check_app_version`, `device_apps_plus`, `app_install_checker`, `is_pirated` |
| `app installed flutter` | #58 p6 | `appcheck`, `installed_apps`, `app_launcher`, `open_mail`, `flutter_install_referrer` |

### Store Fallback and Redirect

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `store fallback` | #1 p1 | DeeplinkX leads |
| `app fallback` | #1 p1 | DeeplinkX leads |
| `web fallback` | #1 p1 | DeeplinkX leads |
| `smart fallback` | #12 p2 | `flutter_smart_cache_manager`, `smart_localize`, `ai_smart_translate`, `network_or_asset_loader`, `smart_image` |
| `fallback to store` | #2 p1 | `flutter_in_store_app_version_checker`, `deeplink_x`, `smart_app_update_flutter`, `billing_country`, `app_updater_flutter` |
| `fallback app store` | #1 p1 | DeeplinkX leads |
| `store redirect` | #4 p1 | `store_redirect`, `flutter_app_update_lib`, `store_redirect2`, `deeplink_x`, `simple_auth_flutter` |
| `app store redirect` | #4 p1 | `store_redirect`, `flutter_app_update_lib`, `store_redirect2`, `deeplink_x`, `update_checker` |
| `open store` | #4 p1 | `open_store`, `geoflutterfire2`, `app_review`, `deeplink_x`, `geoflutterfire` |
| `open app store` | #3 p1 | `open_appstore`, `app_review`, `deeplink_x`, `app_review_plus`, `flutter_store_listing` |
| `open play store` | #9 p1 | `flutter_app_store`, `in_app_update_flutter`, `open_appstore`, `store_redirect`, `launch_app_store` |
| `google play redirect` | #7 p1 | `store_redirect`, `store_redirect2`, `iconify_flutter_plus`, `iconify_flutter`, `ubicons` |
| `play store deeplink` | #1 p1 | DeeplinkX leads |
| `app store deeplink` | #1 p1 | DeeplinkX leads |
| `app store link` | #1 p1 | DeeplinkX leads |
| `google play link` | #3 p1 | `app_device_integrity`, `flutter_install_app_plugin`, `deeplink_x`, `flutter_update_checker`, `iconify_flutter_plus` |
| `redirect to store` | #17 p2 | `store_redirect`, `store_redirect2`, `simple_auth_flutter`, `dio_redirect_interceptor`, `flutter_app_update_lib` |

### Maps and Navigation

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `maps` | #39 p4 | `maps`, `map_launcher`, `maps_toolkit`, `google_maps_flutter`, `maplibre_gl` |
| `map` | not in top 100 | `map`, `flutter_map`, `dart_mappable`, `map_launcher`, `maps_toolkit` |
| `map launcher` | #45 p5 | `map_launcher`, `maps_launcher`, `mappls_map_launcher`, `flutter_launcher_plus`, `maplauncherplus` |
| `maps launcher` | #9 p1 | `maps_launcher`, `map_launcher`, `mappls_map_launcher`, `launchify`, `launcher_utils` |
| `open map` | #44 p5 | `maps_launcher`, `location_picker_flutter_map`, `open_location_picker`, `open_street_map_search_and_pick`, `flutter_location_search` |
| `open maps` | #3 p1 | `maps_launcher`, `location_picker_flutter_map`, `deeplink_x`, `open_street_map_search_and_pick`, `neom_maps_services` |
| `launch maps` | #12 p2 | `map_launcher`, `maps_launcher`, `mappls_map_launcher`, `launchify`, `launcher_utils` |
| `flutter maps launcher` | #8 p1 | `map_launcher`, `maps_launcher`, `mappls_map_launcher`, `launchify`, `launcher_utils` |
| `navigation` | #71 p8 | `navigation`, `smooth_sheets`, `auto_route_generator`, `curved_navigation_bar`, `go_router` |
| `navigate` | not in top 100 | `navigate`, `swipeable_page_route`, `animated_bottom_navigation_bar`, `no_context_navigation`, `dpad_container` |
| `directions` | not in top 100 | `map_launcher`, `appinio_swiper`, `marquee`, `custom_rating_bar`, `loop_page_view` |
| `get directions` | not in top 100 | `google_maps_directions`, `text_gradient_widget`, `address_search_field`, `map_launcher`, `appinio_swiper` |
| `map directions` | not in top 100 | `map_launcher`, `google_maps_apis`, `flutter_google_maps_webservices`, `google_maps_routes`, `google_maps_directions` |
| `turn by turn` | not in top 100 | `flutter_mapbox_navigation`, `vietmap_flutter_navigation`, `nb_navigation_flutter`, `situm_flutter`, `arcgis_maps` |
| `turn by turn navigation` | #40 p4 | `flutter_mapbox_navigation`, `vietmap_flutter_navigation`, `nb_navigation_flutter`, `situm_flutter`, `flutter_mapbox` |
| `google maps link` | #1 p1 | DeeplinkX leads |
| `google maps deeplink` | #1 p1 | DeeplinkX leads |
| `apple maps link` | #1 p1 | DeeplinkX leads |
| `apple maps deeplink` | #1 p1 | DeeplinkX leads |
| `waze link` | #1 p1 | DeeplinkX leads |
| `waze deeplink` | #1 p1 | DeeplinkX leads |

### Social Deeplink Terms

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `social app` | not in top 100 | `appinio_social_share`, `authentication_buttons`, `flutter_feed_reaction`, `custom_social_share`, `flutter_social_share_plus` |
| `social apps` | not in top 100 | `social_share`, `k_auth`, `sharesdk_plugin`, `getsocial_flutter_sdk`, `main_auth` |
| `social deeplink` | not in top 100 | `sojo_link`, `archipelago_cli`, `firebase_dynamic_links_fixed`, `bit_2_connect_sdk`, `keeplist_social` |
| `social deep link` | not in top 100 | `chottu_link`, `app_linkster`, `flutter_tabler_icons`, `colorful_iconify_flutter`, `bit_2_connect_sdk` |
| `social link` | not in top 100 | `social_link`, `appinio_social_share`, `social_sharing_plus`, `social_links_generator`, `social_share` |
| `social media link` | not in top 100 | `social_link`, `appinio_social_share`, `social_sharing_plus`, `social_links_generator`, `custom_social_share` |
| `open social app` | not in top 100 | `serverpod`, `appinio_social_share`, `authentication_buttons`, `custom_social_share`, `flutter_social_share_plus` |
| `launch social app` | not in top 100 | `launchify`, `iconify_flutter_plus`, `iconify_flutter`, `community_material_icon`, `stac` |
| `social app launcher` | not in top 100 | `launchify`, `iconify_flutter_plus`, `iconify_flutter`, `jaspr_icons_pack`, `ubicons` |

### Competitor and Alternative Intent

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `url launcher` | not in top 100 | `url_launcher`, `url_launcher_android`, `url_launcher_windows`, `url_launcher_ios`, `fwfh_url_launcher` |
| `url_launcher` | not in top 100 | `url_launcher`, `url_launcher_android`, `url_launcher_windows`, `url_launcher_ios`, `fwfh_url_launcher` |
| `url launcher alternative` | not in top 100 | `sojo_link`, `simple_html_css`, `mailto`, `carp_webservices`, `linkzly_flutter_sdk` |
| `url_launcher alternative` | not in top 100 | `sojo_link`, `simple_html_css`, `mailto`, `carp_webservices`, `linkzly_flutter_sdk` |
| `app links alternative` | not in top 100 | `appsonair_flutter_applink`, `sojo_link`, `win32`, `media_link_generator`, `gpt_markdown` |
| `map launcher alternative` | not in top 100 | `sojo_link`, `android_native` |
| `external app launcher alternative` | not in top 100 | `android_native`, `flutter_intent_forzzh`, `intent_plus`, `hzfinger_fingerprint_sdk` |
| `flutter launcher` | not in top 100 | `url_launcher`, `icons_launcher`, `map_launcher`, `flutter_launcher_icons`, `maps_launcher` |

## Human Search Query Expansion

### Human App Action Searches

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `open whatsapp flutter` | #2 p1 | `open_share_plus`, `deeplink_x`, `flutter_plugin_openwhatsapp`, `flutter_open_whatsapp`, `flutter_plugin_openwhatsapp_dome` |
| `open whatsapp from flutter` | #2 p1 | `whatsapp`, `deeplink_x`, `iconify_flutter_plus`, `iconify_flutter`, `flutter_boxicons` |
| `open whatsapp chat flutter` | #1 p1 | DeeplinkX leads |
| `send whatsapp message flutter` | not in top 100 | `flutter_open_whatsapp`, `whatsapp`, `flutter_chatflow`, `whatsapp_sender_flutter`, `waapi_flutter` |
| `whatsapp chat link flutter` | #3 p1 | `chat_bubbles`, `whatsapp_unilink`, `deeplink_x`, `iconify_flutter_plus`, `iconify_flutter` |
| `open telegram flutter` | #2 p1 | `photo_opener`, `deeplink_x`, `telegram`, `flutter_telegram_miniapp`, `flutterando_analysis` |
| `open telegram from flutter` | #1 p1 | DeeplinkX leads |
| `open telegram profile flutter` | #1 p1 | DeeplinkX leads |
| `open instagram flutter` | #1 p1 | DeeplinkX leads |
| `open instagram profile flutter` | #1 p1 | DeeplinkX leads |
| `open youtube flutter` | #1 p1 | DeeplinkX leads |
| `open youtube video flutter` | #2 p1 | `adaptive_video_player`, `deeplink_x`, `floatube_player`, `flutter_ytdlp_plugin`, `video_thumbnail_gen` |
| `open tiktok flutter` | #2 p1 | `flutter_tiktoken`, `deeplink_x`, `apphud`, `sharex`, `tiktok_scraper` |
| `open linkedin profile flutter` | #11 p2 | `linkedin_oauth2`, `signin_with_linkedin`, `iconify_flutter_plus`, `iconify_flutter`, `remixicon` |
| `open slack flutter` | #1 p1 | DeeplinkX leads |
| `open WhatsApp directly from Flutter` | #2 p1 | `whatsapp`, `deeplink_x`, `whatsapp_direct_send`, `native_social_share`, `media_launcher_plugin` |
| `send WhatsApp message Flutter` | not in top 100 | `flutter_open_whatsapp`, `whatsapp`, `flutter_chatflow`, `whatsapp_sender_flutter`, `waapi_flutter` |
| `open Telegram profile from Flutter` | #1 p1 | DeeplinkX leads |
| `open Instagram profile from Flutter` | #1 p1 | DeeplinkX leads |
| `open YouTube video from Flutter` | #8 p1 | `iconify_flutter_plus`, `iconify_flutter`, `flutter_boxicons`, `flutter_tabler_icons`, `stac` |

### Human Map Searches

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `open google maps flutter` | #1 p1 | DeeplinkX leads |
| `open google maps from flutter` | #2 p1 | `google_maps_widget`, `deeplink_x`, `place_picker_google`, `google_maps_place_picker_mb`, `iconify_flutter_plus` |
| `launch google maps flutter` | #3 p1 | `map_launcher`, `maps_launcher`, `deeplink_x`, `mappls_map_launcher`, `plug_location_map` |
| `google maps directions flutter` | #10 p1 | `flutter_google_maps_webservices`, `google_routes_flutter`, `googlemaps_flutter_webservices`, `google_map_service`, `google_map_with_direction_indicator` |
| `open location in google maps flutter` | #2 p1 | `place_picker_google`, `deeplink_x`, `google_maps_widget`, `google_maps_marker_widgets`, `iconify_flutter_plus` |
| `open maps directions flutter` | #1 p1 | DeeplinkX leads |
| `open apple maps flutter` | #2 p1 | `maps_launcher`, `deeplink_x`, `apple_maps_place_picker`, `iconify_flutter_plus`, `iconify_flutter` |
| `open waze flutter` | #1 p1 | DeeplinkX leads |
| `launch waze flutter` | #2 p1 | `map_launcher`, `deeplink_x`, `mappls_map_launcher`, `icons_plus`, `iconsx_plus` |
| `open map app flutter` | #4 p1 | `map_picker_free`, `maps_launcher`, `location_picker_flutter_map`, `deeplink_x`, `flutter_mapbox_navigation` |
| `open maps app flutter` | #1 p1 | DeeplinkX leads |
| `flutter open navigation app` | #1 p1 | DeeplinkX leads |
| `flutter map directions app` | #22 p3 | `mappls_map_launcher`, `flutter_google_maps_webservices`, `flutter_mapbox_navigation`, `mappls_direction_plugin`, `googlemaps_flutter_webservices` |
| `Google Maps URL Launcher Flutter` | #4 p1 | `maps_launcher`, `map_launcher`, `url_launcher_utils`, `deeplink_x`, `mappls_map_launcher` |
| `open Google Maps and show navigation Flutter` | not in top 100 | `iconify_flutter_plus`, `iconify_flutter`, `flutter_tabler_icons`, `ubicons`, `jaspr_icons_pack` |

### Human External App Searches

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `flutter open another app` | #9 p1 | `external_app_launcher`, `external_app_launcher_plus`, `device_preview_plus`, `device_preview`, `iconify_flutter_plus` |
| `flutter launch another app` | #11 p2 | `external_app_launcher`, `external_app_launcher_plus`, `jitsi_meet_wrapper`, `store_launcher_plus`, `flutter_applaunch` |
| `flutter open external app` | #9 p1 | `external_app_launcher`, `external_app_launcher_plus`, `flutter_external_app`, `open_file`, `serverpod` |
| `flutter launch external app` | #14 p2 | `external_app_launcher`, `external_app_launcher_plus`, `app_activity_launcher`, `launchify`, `app_launcher_packagename` |
| `flutter open installed app` | #9 p1 | `open_mail`, `open_mail_launcher`, `installed_apps`, `external_app_launcher`, `app_launcher` |
| `flutter launch installed app` | #33 p4 | `appcheck`, `app_launcher`, `open_mail_launcher`, `mappls_map_launcher`, `apps_utils` |
| `flutter check app installed` | #46 p5 | `appcheck`, `check_app_version`, `device_apps_plus`, `app_data_usage`, `flutter_appavailability` |
| `flutter check if app installed` | #51 p6 | `appcheck`, `device_apps_plus`, `flutter_appavailability`, `package_install_checker`, `scrumlab_flutter_appavailability` |
| `flutter is app installed` | #81 p9 | `appcheck`, `check_app_version`, `mappls_map_launcher`, `flutter_appstore_detection`, `flutter_appavailability` |
| `flutter open app by package name` | not in top 100 | `openapp_by_package`, `folder_file_saver`, `tabby_flutter_inapp_sdk`, `openpanel_flutter`, `developer_app_list` |
| `flutter open app with package name` | not in top 100 | `admob_kit_x`, `change_app_package_name_plus`, `openapp_by_package`, `open_file`, `open_filex` |
| `flutter app to app launch` | not in top 100 | `appcheck`, `external_app_launcher`, `launch_app_store`, `launcher_icon_switcher`, `open_mail_launcher` |
| `flutter launch app by package name` | not in top 100 | `app_launcher_packagename`, `jitsi_meet_wrapper`, `store_launcher_plus`, `screen_launch_by_notfication`, `plug_location_map` |
| `flutter open app if installed` | #17 p2 | `open_mail`, `open_mail_launcher`, `device_apps_plus`, `is_pirated`, `flutter_appavailability` |
| `launch other app from Flutter app` | #55 p6 | `bugsee_flutter`, `flutter_alarm_background_trigger`, `android_vlc_player`, `bring_app_to_foreground`, `reclaim_sdk` |

### Human Deep Link and Scheme Searches

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `flutter deep link to another app` | #1 p1 | DeeplinkX leads |
| `flutter deeplink to another app` | #1 p1 | DeeplinkX leads |
| `flutter external deep link` | #1 p1 | DeeplinkX leads |
| `flutter external deeplink` | #1 p1 | DeeplinkX leads |
| `flutter open url scheme` | #8 p1 | `app_links`, `maps_launcher`, `url_launcher`, `external_app_launcher`, `open_mail_launcher` |
| `flutter launch url scheme` | #29 p3 | `url_launcher`, `launchify`, `enhanced_url_launcher`, `flutter_applaunch`, `flutter_custom_tabs` |
| `flutter custom url scheme` | #49 p5 | `appscheme`, `app_links`, `link_bridge`, `flutter_dominant_color_container`, `uni_links3` |
| `flutter custom scheme` | #68 p7 | `flex_seed_scheme`, `appscheme`, `flutter_dominant_color_container`, `app_links`, `flex_color_scheme` |
| `flutter android intent open app` | #29 p3 | `open_file`, `open_filex`, `better_open_file`, `open_file_plus`, `open_file_safe_plus` |
| `flutter launch android intent` | not in top 100 | `upi_intent`, `flutter_android_intent`, `android_intent_plus`, `upi_payment_callback_handler`, `open_mail_launcher` |
| `flutter ios url scheme` | not in top 100 | `appscheme`, `app_links`, `ios_native_utils`, `link_bridge`, `uni_links3` |
| `flutter open universal link` | #3 p1 | `app_links`, `whatsapp_unilink`, `deeplink_x`, `link_bridge`, `flutter_link_nav` |

### Human Store Searches

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `flutter open app store` | #3 p1 | `flutter_open_app_store`, `app_review`, `deeplink_x`, `app_review_plus`, `flutter_store_listing` |
| `flutter open play store` | #8 p1 | `flutter_app_store`, `in_app_update_flutter`, `open_appstore`, `store_redirect`, `launch_app_store` |
| `flutter redirect to app store` | #9 p1 | `store_redirect`, `store_redirect2`, `flutter_app_update_lib`, `update_checker`, `web_platform_detector` |
| `flutter redirect to play store` | #9 p1 | `store_redirect`, `store_redirect2`, `flutter_app_update_lib`, `update_checker`, `smart_app_update_flutter` |
| `flutter store redirect` | #4 p1 | `store_redirect`, `flutter_app_update_lib`, `store_redirect2`, `deeplink_x`, `simple_auth_flutter` |
| `flutter fallback to app store` | #2 p1 | `flutter_in_store_app_version_checker`, `deeplink_x`, `smart_app_update_flutter`, `billing_country`, `app_updater_flutter` |
| `flutter fallback to play store` | #7 p1 | `smart_app_update_flutter`, `billing_country`, `app_updater_flutter`, `multi_updater`, `version_check_updater` |
| `flutter app store fallback` | #1 p1 | DeeplinkX leads |
| `flutter play store link` | #3 p1 | `multi_updater`, `in_app_update_flutter`, `deeplink_x`, `flutter_update_checker`, `verify_local_purchase` |
| `flutter app store link` | #1 p1 | DeeplinkX leads |
| `flutter open store listing` | #4 p1 | `app_review`, `app_review_plus`, `flutter_store_listing`, `deeplink_x`, `is_pirated` |
| `flutter open app page in store` | #3 p1 | `store_redirect`, `app_review`, `deeplink_x`, `serverpod`, `in_app_update_flutter` |

### Human Alternative Searches

| Keyword | Rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `url launcher alternative flutter` | not in top 100 | `simple_html_css`, `mailto`, `sojo_link`, `carp_webservices`, `linkzly_flutter_sdk` |
| `flutter url launcher alternative` | not in top 100 | `simple_html_css`, `mailto`, `sojo_link`, `carp_webservices`, `linkzly_flutter_sdk` |
| `map launcher alternative flutter` | not in top 100 | `sojo_link` |
| `external app launcher alternative flutter` | not in top 100 | `hzfinger_fingerprint_sdk` |
| `app links alternative flutter` | not in top 100 | `appsonair_flutter_applink`, `gpt_markdown`, `mailto`, `sojo_link`, `link_bridge` |
| `flutter app links alternative` | not in top 100 | `appsonair_flutter_applink`, `gpt_markdown`, `mailto`, `sojo_link`, `link_bridge` |
| `flutter open app without url launcher` | #2 p1 | `url_launcher`, `deeplink_x`, `route_pilot`, `enhanced_url_launcher`, `url_launcher2` |
| `flutter deeplink without url_launcher` | #1 p1 | DeeplinkX leads |

## Medium Article Search Signals

This section keeps the Medium/article-intent phrases from the baseline report and updates their pub.dev positions.

### Pub.dev Positions for Medium-Derived Phrases

| Phrase | DeeplinkX pub.dev rank | Top visible packages ahead or around it |
| --- | ---: | --- |
| `open WhatsApp directly from Flutter` | #2 p1 | `whatsapp`, `deeplink_x`, `whatsapp_direct_send`, `native_social_share`, `media_launcher_plugin` |
| `WhatsApp phone number and message` | not in top 100 | `smart_phone_number`, `iconify_flutter_plus`, `iconify_flutter`, `flutter_tabler_icons`, `tabler_icons_flutter` |
| `WhatsApp phone number pre-filled message` | not in top 100 | `social_sender_whatsapp`, `whatsapp_direct_send`, `whatsapp_launcher` |
| `pre-filled WhatsApp message Flutter` | not in top 100 | `preferred_upi_launcher`, `social_sender_whatsapp`, `launcher_utils`, `whatsapp_direct_send`, `universal_share` |
| `send WhatsApp message Flutter` | not in top 100 | `flutter_open_whatsapp`, `whatsapp`, `flutter_chatflow`, `whatsapp_sender_flutter`, `waapi_flutter` |
| `open Telegram profile from Flutter` | #1 p1 | DeeplinkX leads |
| `open Instagram profile from Flutter` | #1 p1 | DeeplinkX leads |
| `open YouTube video from Flutter` | #8 p1 | `iconify_flutter_plus`, `iconify_flutter`, `flutter_boxicons`, `flutter_tabler_icons`, `stac` |
| `open Google Map and show navigation` | not in top 100 | `iconify_flutter_plus`, `iconify_flutter`, `flutter_tabler_icons`, `ubicons`, `tabler_icons_flutter` |
| `open Google Maps and show navigation Flutter` | not in top 100 | `iconify_flutter_plus`, `iconify_flutter`, `flutter_tabler_icons`, `ubicons`, `jaspr_icons_pack` |
| `show navigation Flutter Google Maps` | not in top 100 | `map_launcher`, `google_maps_flutter`, `google_maps_widget`, `iconify_flutter_plus`, `iconify_flutter` |
| `launch other app from Flutter app` | #55 p6 | `bugsee_flutter`, `flutter_alarm_background_trigger`, `android_vlc_player`, `bring_app_to_foreground`, `reclaim_sdk` |
| `launch Google Maps or Apple Maps with coordinates` | not in top 100 | `maps_launcher`, `casa_google_map` |
| `launch maps with given coordinates Flutter` | no pub.dev API results in scan | none |
| `given coordinates Flutter maps` | not in top 100 | `flutter_simple_map`, `open_route_service`, `mapwize`, `fl_geocoder`, `stl` |
| `Google Maps URL Launcher Flutter` | #4 p1 | `maps_launcher`, `map_launcher`, `url_launcher_utils`, `deeplink_x`, `mappls_map_launcher` |
| `Google Maps and URL Launcher in Flutter` | #1 p1 | DeeplinkX leads |
| `DeepLinkX vs url_launcher` | no pub.dev API results in scan | none |
| `Flutter deep linking and universal linking` | not in top 100 | `deeplink_sdk`, `deep_link_orchestrator`, `flutter_deep_linker`, `flutter_linkme_sdk`, `traput_dynamic_linking` |
| `custom scheme deep link Flutter` | #12 p2 | `app_links`, `link_bridge`, `uni_links3`, `screen_launch_by_notfication`, `uni_links5` |
| `iOS URL scheme Android intent Flutter` | #92 p10 | `appscheme`, `link_bridge`, `uni_links3`, `uni_links5`, `upi_intent` |
| `redirect users to App Store Play Store` | #12 p2 | `store_redirect`, `store_redirect2`, `win32`, `flutter_app_update_lib`, `win32_gui` |
| `Flutter redirect users to app store` | #11 p2 | `store_redirect`, `store_redirect2`, `in_app_review`, `simple_auth_flutter`, `flutter_in_app_review` |
| `deep link without package Flutter` | #5 p1 | `my_deep_link_sdk`, `flutter_facebook_app_links_spm`, `deep_link_manager`, `smart_deeplink_router`, `deeplink_x` |
| `without url_launcher Flutter deeplink` | #1 p1 | DeeplinkX leads |
| `open another app without url_launcher Flutter` | #1 p1 | DeeplinkX leads |
| `app not installed redirect to store Flutter` | #4 p1 | `flutter_web_gl`, `in_app_review`, `external_app_launcher`, `deeplink_x`, `urlynk_flutter` |
| `fallback to App Store Play Store web Flutter` | #1 p1 | DeeplinkX leads |
| `given coordinates` | not in top 100 | `proximity_hash`, `latlong_to_osgrid`, `draw_on`, `solar_calculator`, `svg_to_paint` |
| `Google Maps & URL Launcher in Flutter` | #1 p1 | DeeplinkX leads |

## Recommendations

- Preserve the current provider-rich description because it significantly improved WhatsApp, Telegram, Instagram, YouTube, and Amap visibility.
- Add more README/docs wording for WhatsApp message intent: `send WhatsApp message Flutter`, phone number, and pre-filled message.
- Add natural headings for `show navigation` and coordinate-based map launching, while keeping `directions` wording.
- Add copy for `social app` and `social deeplink` if those generic social searches still matter.
- Keep publishing Medium/README content around `url_launcher` comparisons; pub.dev itself still does not rank `DeepLinkX vs url_launcher`.
