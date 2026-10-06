# DeeplinkX Roadmap

Apps and features have separate implementation queues. Complete pending entries in each queue in numbered order. Add future entries to the end of the relevant queue.

Status describes repository progress: **Implemented** means the API is present in this checkout, **Draft** means work still needs validation, and **Pending** means work remains to be integrated or implemented. Checked actions track implementation; device verification and release readiness follow each app's documentation.

App categories follow the README groups: **Social**, **Navigation**, and **Stores**. Feature categories describe the capability area.

## 1. Apps and actions

### Pending app queue

These apps have existing PR implementations. Actions remain unchecked until their integration into the main package is complete.

1. **App:** Citymapper
   - **Category:** Navigation
   - **Status:** Pending
   - **PR:** [#34](https://github.com/DeepLinkX/DeeplinkX/pull/34)
   - **Actions:**
     - [ ] Open app (`Citymapper.open`)
     - [ ] View map (`Citymapper.view`)
     - [ ] Directions with coordinates (`Citymapper.directionsWithCoords`)

2. **App:** OsmAnd
   - **Category:** Navigation
   - **Status:** Pending
   - **PR:** [#35](https://github.com/DeepLinkX/DeeplinkX/pull/35)
   - **Actions:**
     - [ ] Open app (`OsmAnd.open`)
     - [ ] View map (`OsmAnd.view`)
     - [ ] Directions with coordinates (`OsmAnd.directionsWithCoords`)

3. **App:** HERE WeGo
   - **Category:** Navigation
   - **Status:** Pending
   - **PR:** [#38](https://github.com/DeepLinkX/DeeplinkX/pull/38)
   - **Actions:**
     - [ ] Open app (`HereWeGo.open`)
     - [ ] View map (`HereWeGo.view`)
     - [ ] Directions with coordinates (`HereWeGo.directionsWithCoords`)

### Existing baseline

The baseline contains 39 apps (including one draft) and 7 stores.

#### Apps

- **App:** ChatGPT
  - **Category:** Social
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`ChatGPT.open`)
    - [x] Open shared conversation (`ChatGPT.openSharedConversation`)
    - [x] Open GPT (`ChatGPT.openGpt`)

- **App:** Netflix
  - **Category:** Social
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`Netflix.open`)
    - [x] Open title (`Netflix.openTitle`)
    - [x] Watch title (`Netflix.watchTitle`)

- **App:** Temu
  - **Category:** Social
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`Temu.open`)
    - [x] Open link (`Temu.openLink`)
    - [x] Search (`Temu.search`)

- **App:** Snapchat
  - **Category:** Social
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`Snapchat.open`)
    - [x] Open profile by username (`Snapchat.openProfile`)

- **App:** CapCut
  - **Category:** Social
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`CapCut.open`)
    - [x] Open template link (`CapCut.openTemplate`)

- **App:** Facebook
  - **Category:** Social
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`Facebook.open`)
    - [x] Open profile by ID (`Facebook.openProfileById`)
    - [x] Open profile by username (`Facebook.openProfileByUsername`)
    - [x] Open page (`Facebook.openPage`)
    - [x] Open group (`Facebook.openGroup`)
    - [x] Open event (`Facebook.openEvent`)

- **App:** Instagram
  - **Category:** Social
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`Instagram.open`)
    - [x] Open profile by username (`Instagram.openProfile`)

- **App:** LinkedIn
  - **Category:** Social
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`LinkedIn.open`)
    - [x] Open profile page (`LinkedIn.openProfile`)
    - [x] Open company page (`LinkedIn.openCompany`)

- **App:** WhatsApp
  - **Category:** Social
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`WhatsApp.open`)
    - [x] Chat with phone number (`WhatsApp.chat`)
    - [x] Share text content (`WhatsApp.shareText`)

- **App:** Telegram
  - **Category:** Social
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`Telegram.open`)
    - [x] Open profile by username (`Telegram.openProfile`)
    - [x] Open profile by phone number (`Telegram.openProfileByPhoneNumber`)
    - [x] Send message by username (`Telegram.sendMessage`)
    - [x] Send message by phone number (`Telegram.sendMessageByPhoneNumber`)

- **App:** Twitter
  - **Category:** Social
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`Twitter.open`)
    - [x] Open profile by username (`Twitter.openProfile`)
    - [x] Open tweet by ID (`Twitter.openTweet`)
    - [x] Search (`Twitter.search`)

- **App:** Threads
  - **Category:** Social
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`Threads.open`)
    - [x] Open profile by username (`Threads.openProfile`)
    - [x] Open post (`Threads.openPost`)
    - [x] Open comments (`Threads.openComments`)
    - [x] Create post (`Threads.createPost`)
    - [x] Search (`Threads.search`)
    - [x] Open topic tag (`Threads.openTag`)

- **App:** YouTube
  - **Category:** Social
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`YouTube.open`)
    - [x] Open video (`YouTube.openVideo`)
    - [x] Open channel (`YouTube.openChannel`)
    - [x] Open playlist (`YouTube.openPlaylist`)
    - [x] Search (`YouTube.search`)

- **App:** TikTok
  - **Category:** Social
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`TikTok.open`)
    - [x] Open profile by username (`TikTok.openProfile`)
    - [x] Open video (`TikTok.openVideo`)
    - [x] Open tag (`TikTok.openTag`)

- **App:** Pinterest
  - **Category:** Social
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`Pinterest.open`)
    - [x] Open profile by username (`Pinterest.openProfile`)
    - [x] Open pin (`Pinterest.openPin`)
    - [x] Open board by ID (`Pinterest.openBoard`)
    - [x] Search (`Pinterest.search`)

- **App:** Zoom
  - **Category:** Social
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`Zoom.open`)
    - [x] Join meeting by ID (`Zoom.joinMeeting`)

- **App:** Slack
  - **Category:** Social
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`Slack.open`)
    - [x] Open team (`Slack.openTeam`)
    - [x] Open channel (`Slack.openChannel`)
    - [x] Open user (`Slack.openUser`)

#### Navigation apps

- **App:** Google Maps
  - **Category:** Navigation
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`GoogleMaps.open`)
    - [x] View map (`GoogleMaps.view`)
    - [x] Search (`GoogleMaps.search`)
    - [x] Directions (`GoogleMaps.directions`)
    - [x] Directions with coordinates (`GoogleMaps.directionsWithCoords`)

- **App:** Amap
  - **Category:** Navigation
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`Amap.open`)
    - [x] Open current location (`Amap.myLocation`)
    - [x] View map (`Amap.view`)
    - [x] Search (`Amap.search`)
    - [x] Directions (`Amap.directions`)
    - [x] Directions with coordinates (`Amap.directionsWithCoords`)

- **App:** Baidu Maps
  - **Category:** Navigation
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`BaiduMaps.open`)
    - [x] View map (`BaiduMaps.view`)
    - [x] Search (`BaiduMaps.search`)
    - [x] Nearby search (`BaiduMaps.nearbySearch`)
    - [x] Open transit line (`BaiduMaps.line`)
    - [x] Directions (`BaiduMaps.directions`)
    - [x] Directions with coordinates (`BaiduMaps.directionsWithCoords`)
    - [x] Navigation (`BaiduMaps.navigate`)

- **App:** NAVER Map
  - **Category:** Navigation
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`NaverMap.open`)
    - [x] View map (`NaverMap.view`)
    - [x] Search (`NaverMap.search`)
    - [x] Bus search (`NaverMap.busSearch`)
    - [x] Directions with coordinates (`NaverMap.directionsWithCoords`)
    - [x] Navigation (`NaverMap.navigate`)
    - [x] Safe driving (`NaverMap.safeDriving`)

- **App:** Apple Maps
  - **Category:** Navigation
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`AppleMaps.open`)
    - [x] View map (`AppleMaps.view`)
    - [x] Search (`AppleMaps.search`)
    - [x] Directions (`AppleMaps.directions`)
    - [x] Directions with coordinates (`AppleMaps.directionsWithCoords`)

- **App:** 2GIS
  - **Category:** Navigation
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`TwoGis.open`)
    - [x] View map (`TwoGis.view`)
    - [x] Directions with coordinates (`TwoGis.directionsWithCoords`)

- **App:** Waze
  - **Category:** Navigation
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`Waze.open`)
    - [x] View map (`Waze.view`)
    - [x] Search (`Waze.search`)
    - [x] Directions (`Waze.directions`)
    - [x] Directions with coordinates (`Waze.directionsWithCoords`)

- **App:** Sygic
  - **Category:** Navigation
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`Sygic.open`)
    - [x] View map (`Sygic.view`)
    - [x] Directions with coordinates (`Sygic.directionsWithCoords`)

- **App:** Sygic Truck
  - **Category:** Navigation
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`SygicTruck.open`)
    - [x] View map (`SygicTruck.view`)
    - [x] Directions with coordinates (`SygicTruck.directionsWithCoords`)

- **App:** CoPilot
  - **Category:** Navigation
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`Copilot.open`)
    - [x] View map (`Copilot.view`)
    - [x] Directions with coordinates (`Copilot.directionsWithCoords`)

- **App:** TomTom GO Fleet
  - **Category:** Navigation
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`TomTomGoFleet.open`)
    - [x] View map (`TomTomGoFleet.view`)
    - [x] Directions with coordinates (`TomTomGoFleet.directionsWithCoords`)

- **App:** TomTom GO Expert
  - **Category:** Navigation
  - **Status:** Draft
  - **Actions:**
    - [ ] Open app (`TomTomGoExpert.open`)
    - [ ] View map (`TomTomGoExpert.view`)
    - [ ] Directions with coordinates (`TomTomGoExpert.directionsWithCoords`)
  - **Note:** Unpublished draft. Native iOS opening and navigation links remain unverified; see [the draft documentation](doc/apps/tomtom_go_expert.md).

- **App:** Moovit
  - **Category:** Navigation
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`Moovit.open`)
    - [x] View map (`Moovit.view`)
    - [x] Directions with coordinates (`Moovit.directionsWithCoords`)

- **App:** Air Navigation Pro
  - **Category:** Navigation
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`AirNavigationPro.open`)
    - [x] View map (`AirNavigationPro.view`)
    - [x] Direct-to navigation (`AirNavigationPro.directTo`)
    - [x] Directions with coordinates (`AirNavigationPro.directionsWithCoords`)

- **App:** Mappls
  - **Category:** Navigation
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`Mappls.open`)
    - [x] View map (`Mappls.view`)
    - [x] Directions with coordinates (`Mappls.directionsWithCoords`)

- **App:** Mapy.com
  - **Category:** Navigation
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`MapyCz.open`)
    - [x] View map (`MapyCz.view`)
    - [x] Search (`MapyCz.search`)
    - [x] Directions with coordinates (`MapyCz.directionsWithCoords`)

- **App:** TMAP
  - **Category:** Navigation
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`TMap.open`)
    - [x] View map (`TMap.view`)
    - [x] Directions with coordinates (`TMap.directionsWithCoords`)

- **App:** KakaoMap
  - **Category:** Navigation
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`KakaoMap.open`)
    - [x] View map (`KakaoMap.view`)
    - [x] Directions with coordinates (`KakaoMap.directionsWithCoords`)

- **App:** Neshan
  - **Category:** Navigation
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`Neshan.open`)
    - [x] View map (`Neshan.view`)
    - [x] Directions with coordinates (`Neshan.directionsWithCoords`)

- **App:** Yandex Maps
  - **Category:** Navigation
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`YandexMaps.open`)
    - [x] Open map (`YandexMaps.openMap`)
    - [x] View map (`YandexMaps.view`)
    - [x] Search (`YandexMaps.search`)
    - [x] Open organization card (`YandexMaps.organization`)
    - [x] What is here (`YandexMaps.whatIsHere`)
    - [x] Directions with coordinates (`YandexMaps.directionsWithCoords`)
    - [x] Panorama (`YandexMaps.panorama`)

- **App:** Yandex Navigator
  - **Category:** Navigation
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`YandexNavigator.open`)
    - [x] View map (`YandexNavigator.view`)
    - [x] Search (`YandexNavigator.search`)
    - [x] Directions with coordinates (`YandexNavigator.directionsWithCoords`)

- **App:** Tencent Maps
  - **Category:** Navigation
  - **Status:** Implemented
  - **Actions:**
    - [x] Open app (`TencentMaps.open`)
    - [x] View map (`TencentMaps.view`)
    - [x] Search (`TencentMaps.search`)
    - [x] Nearby search (`TencentMaps.nearbySearch`)
    - [x] Directions with coordinates (`TencentMaps.directionsWithCoords`)

#### Stores

- **App:** iOS App Store
  - **Category:** Stores
  - **Status:** Implemented
  - **Actions:**
    - [x] Open store (`IOSAppStore.open`)
    - [x] Open app page (`IOSAppStore.openAppPage`)
    - [x] Rate app (`IOSAppStore.rateApp`)

- **App:** Mac App Store
  - **Category:** Stores
  - **Status:** Implemented
  - **Actions:**
    - [x] Open store (`MacAppStore.open`)
    - [x] Open app page (`MacAppStore.openAppPage`)
    - [x] Rate app (`MacAppStore.rateApp`)

- **App:** Microsoft Store
  - **Category:** Stores
  - **Status:** Implemented
  - **Actions:**
    - [x] Open store (`MicrosoftStore.open`)
    - [x] Open app page (`MicrosoftStore.openAppPage`)
    - [x] Rate app (`MicrosoftStore.rateApp`)

- **App:** Google Play Store
  - **Category:** Stores
  - **Status:** Implemented
  - **Actions:**
    - [x] Open store (`PlayStore.open`)
    - [x] Open app page (`PlayStore.openAppPage`)

- **App:** Huawei AppGallery
  - **Category:** Stores
  - **Status:** Implemented
  - **Actions:**
    - [x] Open store (`HuaweiAppGalleryStore.open`)
    - [x] Open app page (`HuaweiAppGalleryStore.openAppPage`)

- **App:** Cafe Bazaar
  - **Category:** Stores
  - **Status:** Implemented
  - **Actions:**
    - [x] Open store (`CafeBazaarStore.open`)
    - [x] Open app page (`CafeBazaarStore.openAppPage`)

- **App:** Myket
  - **Category:** Stores
  - **Status:** Implemented
  - **Actions:**
    - [x] Open store (`MyketStore.open`)
    - [x] Open app page (`MyketStore.openAppPage`)
    - [x] Rate app (`MyketStore.rateApp`)

For future app entries, use **App**, **Category**, **Status**, optional **PR**, and a nested **Actions** checklist. Keep public API names alongside action labels.

## 2. Features

1. **Feature:** Query installed applications
   - **Category:** App discovery
   - **Status:** Pending
   - **Description:** List applications installed on the device, including apps outside DeeplinkX's supported catalog. Platform feasibility remains to be assessed.
   - **Completion criteria:**
     - [ ] Assess and document platform feasibility and restrictions.
     - [ ] List installed applications on supported platforms, including apps outside DeeplinkX's supported catalog where permitted.

2. **Feature:** Query one supported application
   - **Category:** App discovery
   - **Status:** Pending
   - **Description:** Look up a supported app and check installation status, building on the existing `isAppInstalled()` capability.
   - **Completion criteria:**
     - [ ] Look up an application in DeeplinkX's supported catalog.
     - [ ] Report its installation status using the existing `isAppInstalled()` capability.

For future feature entries, use **Feature**, **Category**, **Status**, **Description**, and a nested **Completion criteria** checklist.
