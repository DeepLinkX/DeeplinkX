# Email evidence register

Research checked **2026-10-11**. Provider/OS pages and selected first-party source are behavior evidence. Store listings establish distribution/identifiers only. Source-level candidates are not device results; moving branches must be pinned and matched to releases before implementation. A page-fetch failure is a missing observation, never proof of unsupported behavior.

Inherited secondary references were read in the original briefs, observed **2026-10-10**, and retained only as experimental leads. They were not treated as current first-party contracts. Local Mail metadata was read without launching the app. All runtime status remains **not tested**.

<a id="android"></a>

## android

[Android email intents](https://developer.android.com/guide/components/intents-common#Email) · Primary · checked 2026-10-11.

SENDTO/mailto and standard recipient arrays/subject/text; each app must resolve and preserve fields.

<a id="android-open"></a>

## android-open

[Android package root launch](https://developer.android.com/reference/android/content/pm/PackageManager#getLaunchIntentForPackage(java.lang.String)) · Primary · checked 2026-10-11.

Package root launch intent; does not select Inbox or Compose.

<a id="android-visibility"></a>

## android-visibility

[Android package visibility](https://developer.android.com/training/package-visibility/declaring) · Primary · checked 2026-10-11.

Bounded package/intent queries; querying visibility is separate from launch success.

<a id="ios-query"></a>

## ios-query

[Apple URL handler queries](https://developer.apple.com/documentation/uikit/uiapplication/canopenurl(_:)) · Primary · checked 2026-10-11.

canOpenURL and scheme query configuration; does not enumerate installed mail apps.

<a id="desktop-entry"></a>

## desktop-entry

[freedesktop desktop entry specification](https://specifications.freedesktop.org/desktop-entry-spec/latest/) · Primary · checked 2026-10-11.

Linux desktop entries/Exec identity research; not proof of installed provider or compose handling.

<a id="mailto"></a>

## mailto

[RFC 6068](https://www.rfc-editor.org/rfc/rfc6068) · Primary · checked 2026-10-11.

URI encoding and text compose; no portable attachment parameter.

<a id="apple-default"></a>

## apple-default

[Apple mail links](https://developer.apple.com/library/archive/featuredarticles/iPhoneURLScheme_Reference/MailLinks/MailLinks.html) · Primary · checked 2026-10-11.

Archived mailto contract, not guaranteed named-provider selection.

<a id="mac-open"></a>

## mac-open

[NSWorkspace targeted URL opening](https://developer.apple.com/documentation/appkit/nsworkspace/open(_:withapplicationat:configuration:completionhandler:)) · Primary · checked 2026-10-11.

OS API candidate for selecting an application; current launcher lacks this adapter.

<a id="windows-default"></a>

## windows-default

[Windows URI launching](https://learn.microsoft.com/en-us/windows/apps/develop/launch/launch-default-app) · Primary · checked 2026-10-11.

Configured default URI handler; not named mail-app selection.

<a id="outlook-web"></a>

## outlook-web

[Microsoft OWA protocol-handler example](https://learn.microsoft.com/en-us/deployedge/microsoft-edge-browser-policies/registeredprotocolhandlers) · Primary · checked 2026-10-11.

Edge policy example uses outlook.office.com/mail/deeplink/compose?to=%s for Exchange Online; %s represents handled URL. Not proof of independent cc/bcc/subject/body parameters or consumer live.com equivalence.

<a id="xdg"></a>

## xdg

[freedesktop xdg-email](https://portland.freedesktop.org/doc/xdg-email.html) · Primary · checked 2026-10-11.

Default composer and attachment options; not named-provider selection.

<a id="airmail-route"></a>

## airmail-route

[Airmail iOS URL scheme](https://help.airmailapp.com/en-us/article/airmail-ios-url-scheme-1q060gy/) · Primary · checked 2026-10-11.

iOS compose to/cc/bcc/subject/plainBody; recipient separators need tests.

<a id="proton-android"></a>

## proton-android

[Proton Android share mapper](https://github.com/ProtonMail/android-mail/blob/1bf2e1058bbe637562cded858d7cd460e064977e/mail-common/data/src/main/kotlin/ch/protonmail/android/mailcommon/data/file/IntentShareExtensions.kt) · Primary · checked 2026-10-11.

getShareInfo handles SENDTO and reads EXTRA_EMAIL/CC/BCC arrays plus EXTRA_SUBJECT/TEXT. Helper alone does not prove exported entry or mailto query parsing.

<a id="proton-ios"></a>

## proton-ios

[Proton iOS project](https://github.com/ProtonMail/ios-mail/blob/main/project.yml) · Primary · checked 2026-10-11.

mailto/protonmail URL registration; no compose query contract. Moving source must be pinned before implementation.

<a id="proton-desktop"></a>

## proton-desktop

[Proton desktop package identity](https://github.com/ProtonMail/WebClients/blob/main/applications/desktop/package.json) · Primary · checked 2026-10-11.

Bundle ch.protonmail.desktop; verify installed release, not the iOS bundle.

<a id="proton-protocol"></a>

## proton-protocol

[Proton desktop protocol registration](https://github.com/ProtonMail/WebClients/blob/main/applications/desktop/forge.config.ts) · Primary · checked 2026-10-11.

mailto registration is default-handler infrastructure, not a named route through current adapters.

<a id="tb-android"></a>

## tb-android

[Thunderbird/K-9 Android mapper](https://github.com/thunderbird/thunderbird-android/blob/e3fb7f3341827eb756327e26198f97b7c3f1821e/legacy/ui/legacy/src/main/java/com/fsck/k9/ui/compose/IntentDataMapper.kt) · Primary · checked 2026-10-11.

SENDTO handling records mailToUri and subject/text extras; recipient parsing is delegated and must be reviewed. Verify release, exported activity and URI/extras precedence.

<a id="tb-desktop"></a>

## tb-desktop

[Thunderbird command handler](https://searchfox.org/comm-central/source/mail/components/MessengerContentHandler.sys.mjs) · Primary · checked 2026-10-11.

handle: -compose and mailto; mid invokes openMessageForMessageId. -mail selects mail tab, not necessarily Inbox. Pin moving source before implementation.

<a id="fair-manifest"></a>

## fair-manifest

[FairEmail manifest](https://github.com/M66B/FairEmail/blob/14853e8b454cac8aff81d7f19f2bb09fa6c9768a/app/src/main/AndroidManifest.xml) · Primary · checked 2026-10-11.

Exported compose SENDTO/mailto filter.

<a id="fair-compose"></a>

## fair-compose

[FairEmail compose parser](https://github.com/M66B/FairEmail/blob/14853e8b454cac8aff81d7f19f2bb09fa6c9768a/app/src/main/java/eu/faircode/email/ActivityCompose.java) · Primary · checked 2026-10-11.

Field parsing candidate; match installed release and test recipient preservation.

<a id="mailspring-cli"></a>

## mailspring-cli

[Mailspring CLI handler](https://github.com/Foundry376/Mailspring/blob/5e9cf917d072fe3b8e3b2df0ace0bbf2953581b6/app/src/browser/main.js) · Primary · checked 2026-10-11.

CLI accepts mailto and attachment file arguments; proprietary compose URL grammar unresolved.

<a id="mailspring-protocol"></a>

## mailspring-protocol

[Mailspring build registrations](https://github.com/Foundry376/Mailspring/blob/5e9cf917d072fe3b8e3b2df0ace0bbf2953581b6/app/build/build.js) · Primary · checked 2026-10-11.

mailspring/mailto registration does not prove a compose path or all fields.

<a id="evolution-cli"></a>

## evolution-cli

[Evolution command parameters](https://gnome.pages.gitlab.gnome.org/evolution/help/te/start-command-line-parameters.html) · Primary · checked 2026-10-11.

--component=mail, folder://local/Inbox, mailto to/cc/subject/body/attach; bcc not established here.

<a id="geary-history"></a>

## geary-history

[GNOME Geary desktop registration](https://mail.gnome.org/archives/commits-list/2016-September/msg01178.html) · Primary, historical · checked 2026-10-11.

Historical Exec=geary mailto:; current entry and field mapping must be checked.

<a id="kmail-history"></a>

## kmail-history

[KDE legacy command options](https://api.kde.org/legacy/3.5-api/kdepim-apidocs/kmail/html/kmail__options_8h_source.html) · Primary, historical · checked 2026-10-11.

Legacy address/cc/bcc/subject/body/attach options; not a current KMail contract.

<a id="apple-store"></a>

## apple-store

[Apple Mail store listing](https://apps.apple.com/us/app/mail/id1108187098) · Primary · checked 2026-10-11.

iOS listing ID 1108187098, independent of native launch support.

<a id="apple-local"></a>

## apple-local

Local macOS Mail metadata · Local observation · checked 2026-10-11.

/System/Applications/Mail.app/Contents/Info.plist: com.apple.mail; mailto, message, mail-pref-pane URL registration. Metadata read on macOS 27.0.1; no launch.

<a id="gmail-store-0"></a>

## gmail-store-0

[Gmail store listing](https://play.google.com/store/apps/details?id=com.google.android.gm) · Primary · checked 2026-10-11.

Store identifier/platform availability only; no external compose or scheme evidence.

<a id="gmail-store-1"></a>

## gmail-store-1

[Gmail store listing](https://apps.apple.com/us/app/gmail-email-by-google/id422689480) · Primary · checked 2026-10-11.

Store identifier/platform availability only; no external compose or scheme evidence.

<a id="gmail-historical-0"></a>

## gmail-historical-0

[Gmail historical research lead](https://stackoverflow.com/questions/3470042/intent-uri-to-launch-gmail-app) · Secondary, inherited · checked 2026-10-10.

Inherited from original brief; undocumented routes remain experimental. Not a current provider contract.

<a id="gmail-historical-1"></a>

## gmail-historical-1

[Gmail historical research lead](https://tom.scogland.com/blog/2013/01/29/gmail-url-scheme/) · Secondary, inherited · checked 2026-10-10.

Inherited from original brief; undocumented routes remain experimental. Not a current provider contract.

<a id="gmail-historical-2"></a>

## gmail-historical-2

[Gmail historical research lead](https://www.macstories.net/links/gmail-for-ios-url-scheme/) · Secondary, inherited · checked 2026-10-10.

Inherited from original brief; undocumented routes remain experimental. Not a current provider contract.

<a id="gmail-historical-3"></a>

## gmail-historical-3

[Gmail historical research lead](https://stackoverflow.com/questions/6548570/url-to-compose-a-message-in-gmail-with-full-gmail-interface-and-specified-to-bcc-subject-etc) · Secondary, inherited · checked 2026-10-10.

Inherited from original brief; undocumented routes remain experimental. Not a current provider contract.

<a id="outlook-store-0"></a>

## outlook-store-0

[Outlook store listing](https://play.google.com/store/apps/details?id=com.microsoft.office.outlook) · Primary · checked 2026-10-11.

Store identifier/platform availability only; no external compose or scheme evidence.

<a id="outlook-store-1"></a>

## outlook-store-1

[Outlook store listing](https://apps.apple.com/us/app/microsoft-outlook/id951937596) · Primary · checked 2026-10-11.

Store identifier/platform availability only; no external compose or scheme evidence.

<a id="outlook-historical-0"></a>

## outlook-historical-0

[Outlook historical research lead](https://stackoverflow.com/questions/33190891/ios-url-scheme-microsoft-outlook-app) · Secondary, inherited · checked 2026-10-10.

Inherited from original brief; undocumented routes remain experimental. Not a current provider contract.

<a id="outlook-historical-1"></a>

## outlook-historical-1

[Outlook historical research lead](https://stackoverflow.com/questions/32369198/i-just-want-to-open-ms-outlook-app-and-see-mailto-screen-using-url-scheme-at-ios) · Secondary, inherited · checked 2026-10-10.

Inherited from original brief; undocumented routes remain experimental. Not a current provider contract.

<a id="outlook-historical-2"></a>

## outlook-historical-2

[Outlook historical research lead](https://stackoverflow.com/questions/57205554/ms-outlook-uri-scheme-no-longer-working-for-xamarin-android) · Secondary, inherited · checked 2026-10-10.

Inherited from original brief; undocumented routes remain experimental. Not a current provider contract.

<a id="outlook-vendor"></a>

## outlook-vendor

[Outlook official platform/download evidence](https://www.microsoft.com/en-us/microsoft-365/outlook/email-and-calendar-software-microsoft-outlook) · Primary · checked 2026-10-11.

Listed app availability and official download entry points; actions require separate evidence.

<a id="yahoo_mail-store-0"></a>

## yahoo_mail-store-0

[Yahoo Mail store listing](https://play.google.com/store/apps/details?id=com.yahoo.mobile.client.android.mail) · Primary · checked 2026-10-11.

Store identifier/platform availability only; no external compose or scheme evidence.

<a id="yahoo_mail-store-1"></a>

## yahoo_mail-store-1

[Yahoo Mail store listing](https://apps.apple.com/us/app/yahoo-mail-your-email-inbox/id577586159) · Primary · checked 2026-10-11.

Store identifier/platform availability only; no external compose or scheme evidence.

<a id="yahoo_mail-historical-0"></a>

## yahoo_mail-historical-0

[Yahoo Mail historical research lead](https://stackoverflow.com/questions/43453852/using-openurl-to-send-an-email-from-yahoo-mail-client) · Secondary, inherited · checked 2026-10-10.

Inherited from original brief; undocumented routes remain experimental. Not a current provider contract.

<a id="yahoo_mail-historical-1"></a>

## yahoo_mail-historical-1

[Yahoo Mail historical research lead](https://stackoverflow.com/questions/24073982/launch-yahoo-mail-from-another-app) · Secondary, inherited · checked 2026-10-10.

Inherited from original brief; undocumented routes remain experimental. Not a current provider contract.

<a id="spark-store-0"></a>

## spark-store-0

[Spark store listing](https://play.google.com/store/apps/details?id=com.readdle.spark) · Primary · checked 2026-10-11.

Store identifier/platform availability only; no external compose or scheme evidence.

<a id="spark-store-1"></a>

## spark-store-1

[Spark store listing](https://apps.apple.com/us/app/spark-mail-ai-email-assistant/id997102246) · Primary · checked 2026-10-11.

Store identifier/platform availability only; no external compose or scheme evidence.

<a id="spark-historical-0"></a>

## spark-historical-0

[Spark historical research lead](https://talk.automators.fm/t/which-ios-email-apps-support-automation-shortcuts-url-schemes-x-callback-url/3552) · Secondary, inherited · checked 2026-10-10.

Inherited from original brief; undocumented routes remain experimental. Not a current provider contract.

<a id="spark-vendor"></a>

## spark-vendor

[Spark official platform/download evidence](https://sparkmailapp.com/download) · Primary · checked 2026-10-11.

Listed app availability and official download entry points; actions require separate evidence.

<a id="airmail-store-0"></a>

## airmail-store-0

[Airmail store listing](https://apps.apple.com/us/app/airmail-for-gmail-outlook-mail/id993160329) · Primary · checked 2026-10-11.

Store identifier/platform availability only; no external compose or scheme evidence.

<a id="airmail-store-1"></a>

## airmail-store-1

[Airmail store listing](https://apps.apple.com/us/app/airmail-lightning-fast-email/id918858936) · Primary · checked 2026-10-11.

Store identifier/platform availability only; no external compose or scheme evidence.

<a id="airmail-vendor"></a>

## airmail-vendor

[Airmail official platform/download evidence](https://airmailapp.com) · Primary · checked 2026-10-11.

Listed app availability and official download entry points; actions require separate evidence.

<a id="fastmail-store-0"></a>

## fastmail-store-0

[Fastmail store listing](https://play.google.com/store/apps/details?id=com.fastmail.app) · Primary · checked 2026-10-11.

Store identifier/platform availability only; no external compose or scheme evidence.

<a id="fastmail-store-1"></a>

## fastmail-store-1

[Fastmail store listing](https://apps.apple.com/us/app/fastmail-email-calendar/id931370077) · Primary · checked 2026-10-11.

Store identifier/platform availability only; no external compose or scheme evidence.

<a id="fastmail-historical-0"></a>

## fastmail-historical-0

[Fastmail historical research lead](https://azorychta.medium.com/composing-email-on-ios-via-custom-url-schemes-7d408ae5b0aa) · Secondary, inherited · checked 2026-10-10.

Inherited from original brief; undocumented routes remain experimental. Not a current provider contract.

<a id="fastmail-vendor"></a>

## fastmail-vendor

[Fastmail official platform/download evidence](https://www.fastmail.help/hc/en-us/articles/14026270682511-The-Fastmail-desktop-app) · Primary · checked 2026-10-11.

Listed app availability and official download entry points; actions require separate evidence.

<a id="proton_mail-store-0"></a>

## proton_mail-store-0

[Proton Mail store listing](https://play.google.com/store/apps/details?id=ch.protonmail.android) · Primary · checked 2026-10-11.

Store identifier/platform availability only; no external compose or scheme evidence.

<a id="proton_mail-store-1"></a>

## proton_mail-store-1

[Proton Mail store listing](https://apps.apple.com/us/app/proton-mail-encrypted-email/id979659905) · Primary · checked 2026-10-11.

Store identifier/platform availability only; no external compose or scheme evidence.

<a id="proton_mail-vendor"></a>

## proton_mail-vendor

[Proton Mail official platform/download evidence](https://proton.me/mail/download) · Primary · checked 2026-10-11.

Listed app availability and official download entry points; actions require separate evidence.

<a id="superhuman-store-0"></a>

## superhuman-store-0

[Superhuman store listing](https://play.google.com/store/apps/details?id=com.superhuman.mail) · Primary · checked 2026-10-11.

Store identifier/platform availability only; no external compose or scheme evidence.

<a id="superhuman-store-1"></a>

## superhuman-store-1

[Superhuman store listing](https://apps.apple.com/us/app/superhuman-mail/id1120837655) · Primary · checked 2026-10-11.

Store identifier/platform availability only; no external compose or scheme evidence.

<a id="superhuman-vendor"></a>

## superhuman-vendor

[Superhuman official platform/download evidence](https://help.superhuman.com/hc/en-us/articles/46005778798605-Download-Superhuman-Mail) · Primary · checked 2026-10-11.

Listed app availability and official download entry points; actions require separate evidence.

<a id="hey-store-0"></a>

## hey-store-0

[HEY store listing](https://play.google.com/store/apps/details?id=com.basecamp.hey) · Primary · checked 2026-10-11.

Store identifier/platform availability only; no external compose or scheme evidence.

<a id="hey-store-1"></a>

## hey-store-1

[HEY store listing](https://apps.apple.com/us/app/hey-email/id1506603805) · Primary · checked 2026-10-11.

Store identifier/platform availability only; no external compose or scheme evidence.

<a id="hey-vendor"></a>

## hey-vendor

[HEY official platform/download evidence](https://www.hey.com/apps/) · Primary · checked 2026-10-11.

Listed app availability and official download entry points; actions require separate evidence.

<a id="canary_mail-store-0"></a>

## canary_mail-store-0

[Canary Mail store listing](https://play.google.com/store/apps/details?id=io.canarymail.android) · Primary · checked 2026-10-11.

Store identifier/platform availability only; no external compose or scheme evidence.

<a id="canary_mail-store-1"></a>

## canary_mail-store-1

[Canary Mail store listing](https://apps.apple.com/gb/app/canary-mail/id1155470386) · Primary · checked 2026-10-11.

Store identifier/platform availability only; no external compose or scheme evidence.

<a id="canary_mail-vendor"></a>

## canary_mail-vendor

[Canary Mail official platform/download evidence](https://canarymail.io/downloads) · Primary · checked 2026-10-11.

Listed app availability and official download entry points; actions require separate evidence.

<a id="spike-store-0"></a>

## spike-store-0

[Spike store listing](https://play.google.com/store/apps/details?id=com.pingapp.app) · Primary · checked 2026-10-11.

Store identifier/platform availability only; no external compose or scheme evidence.

<a id="spike-store-1"></a>

## spike-store-1

[Spike store listing](https://apps.apple.com/us/app/spike-ai-email-team-chat/id707452888) · Primary · checked 2026-10-11.

Store identifier/platform availability only; no external compose or scheme evidence.

<a id="spike-vendor"></a>

## spike-vendor

[Spike official platform/download evidence](https://www.spikenow.com/help/setting-up-your-spike-account/) · Primary · checked 2026-10-11.

Listed app availability and official download entry points; actions require separate evidence.

<a id="polymail-store-0"></a>

## polymail-store-0

[Polymail store listing](https://apps.apple.com/us/app/polymail-email-inbox/id1082058386) · Primary · checked 2026-10-11.

Store identifier/platform availability only; no external compose or scheme evidence.

<a id="polymail-vendor"></a>

## polymail-vendor

[Polymail official platform/download evidence](https://polymail.io/download) · Primary · checked 2026-10-11.

Listed app availability and official download entry points; actions require separate evidence.

<a id="blue_mail-store-0"></a>

## blue_mail-store-0

[BlueMail store listing](https://play.google.com/store/apps/details?id=me.bluemail.mail) · Primary · checked 2026-10-11.

Store identifier/platform availability only; no external compose or scheme evidence.

<a id="blue_mail-store-1"></a>

## blue_mail-store-1

[BlueMail store listing](https://apps.apple.com/us/app/blue-mail-email-calendar/id1063729305) · Primary · checked 2026-10-11.

Store identifier/platform availability only; no external compose or scheme evidence.

<a id="blue_mail-vendor"></a>

## blue_mail-vendor

[BlueMail official platform/download evidence](https://bluemail.me/download/) · Primary · checked 2026-10-11.

Listed app availability and official download entry points; actions require separate evidence.

<a id="edison_mail-store-0"></a>

## edison_mail-store-0

[Edison Mail store listing](https://play.google.com/store/apps/details?id=com.easilydo.mail) · Primary · checked 2026-10-11.

Store identifier/platform availability only; no external compose or scheme evidence.

<a id="edison_mail-store-1"></a>

## edison_mail-store-1

[Edison Mail store listing](https://apps.apple.com/ng/app/email-edison-mail/id922793622) · Primary · checked 2026-10-11.

Store identifier/platform availability only; no external compose or scheme evidence.

<a id="edison_mail-vendor"></a>

## edison_mail-vendor

[Edison Mail official platform/download evidence](https://www.edisonmail.com/mac) · Primary · checked 2026-10-11.

Listed app availability and official download entry points; actions require separate evidence.

<a id="samsung_email-store-0"></a>

## samsung_email-store-0

[Samsung Email store listing](https://play.google.com/store/apps/details?id=com.samsung.android.email.provider) · Primary · checked 2026-10-11.

Store identifier/platform availability only; no external compose or scheme evidence.

<a id="apple_mail-historical-0"></a>

## apple_mail-historical-0

[Apple Mail historical research lead](https://stackoverflow.com/questions/8821934/launch-apple-mail-app-from-within-my-own-app) · Secondary, inherited · checked 2026-10-10.

Inherited from original brief; undocumented routes remain experimental. Not a current provider contract.

<a id="thunderbird-android"></a>

## thunderbird-android

[Thunderbird Android listing](https://play.google.com/store/apps/details?id=net.thunderbird.android) · Primary · checked 2026-10-11.

Verified package ID and Android availability only.

<a id="thunderbird-vendor"></a>

## thunderbird-vendor

[Thunderbird official platform/download evidence](https://www.thunderbird.net/en-US/thunderbird/all/) · Primary · checked 2026-10-11.

Listed app availability and official download entry points; actions require separate evidence.

<a id="betterbird-vendor"></a>

## betterbird-vendor

[Betterbird official platform/download evidence](https://www.betterbird.eu/downloads/) · Primary · checked 2026-10-11.

Listed app availability and official download entry points; actions require separate evidence.

<a id="mailspring-vendor"></a>

## mailspring-vendor

[Mailspring official platform/download evidence](https://www.getmailspring.com/) · Primary · checked 2026-10-11.

Listed app availability and official download entry points; actions require separate evidence.

<a id="evolution-vendor"></a>

## evolution-vendor

[Evolution official platform/download evidence](https://wiki.gnome.org/Apps/Evolution) · Primary · checked 2026-10-11.

Listed app availability and official download entry points; actions require separate evidence.

<a id="geary-vendor"></a>

## geary-vendor

[Geary official platform/download evidence](https://wiki.gnome.org/Apps/Geary) · Primary · checked 2026-10-11.

Listed app availability and official download entry points; actions require separate evidence.

<a id="kmail-vendor"></a>

## kmail-vendor

[KMail official platform/download evidence](https://apps.kde.org/kmail2/) · Primary · checked 2026-10-11.

Listed app availability and official download entry points; actions require separate evidence.

<a id="em_client-android"></a>

## em_client-android

[eM Client Android listing](https://play.google.com/store/apps/details?id=com.emclient.mailclient) · Primary · checked 2026-10-11.

Verified package ID and Android availability only.

<a id="em_client-ios"></a>

## em_client-ios

[eM Client iOS listing](https://apps.apple.com/app/id1561166404) · Primary · checked 2026-10-11.

Listing ID and iOS availability only; platform compatibility is not native route support.

<a id="em_client-vendor"></a>

## em_client-vendor

[eM Client official platform/download evidence](https://www.emclient.com/mobile-features) · Primary · checked 2026-10-11.

Listed app availability and official download entry points; actions require separate evidence.

<a id="mailbird-vendor"></a>

## mailbird-vendor

[Mailbird official platform/download evidence](https://www.getmailbird.com/download/) · Primary · checked 2026-10-11.

Listed app availability and official download entry points; actions require separate evidence.

<a id="fairemail-android"></a>

## fairemail-android

[FairEmail Android listing](https://play.google.com/store/apps/details?id=eu.faircode.email) · Primary · checked 2026-10-11.

Verified package ID and Android availability only.

<a id="fairemail-vendor"></a>

## fairemail-vendor

[FairEmail official platform/download evidence](https://email.faircode.eu/) · Primary · checked 2026-10-11.

Listed app availability and official download entry points; actions require separate evidence.

<a id="k9_mail-android"></a>

## k9_mail-android

[K-9 Mail Android listing](https://play.google.com/store/apps/details?id=com.fsck.k9) · Primary · checked 2026-10-11.

Verified package ID and Android availability only.

<a id="k9_mail-vendor"></a>

## k9_mail-vendor

[K-9 Mail official platform/download evidence](https://k9mail.app/) · Primary · checked 2026-10-11.

Listed app availability and official download entry points; actions require separate evidence.

<a id="aqua_mail-android"></a>

## aqua_mail-android

[Aqua Mail Android listing](https://play.google.com/store/apps/details?id=org.kman.AquaMail) · Primary · checked 2026-10-11.

Verified package ID and Android availability only.

<a id="aqua_mail-ios"></a>

## aqua_mail-ios

[Aqua Mail iOS listing](https://apps.apple.com/app/id1633468505) · Primary · checked 2026-10-11.

Listing ID and iOS availability only; platform compatibility is not native route support.

<a id="aqua_mail-vendor"></a>

## aqua_mail-vendor

[Aqua Mail official platform/download evidence](https://www.aqua-mail.com/) · Primary · checked 2026-10-11.

Listed app availability and official download entry points; actions require separate evidence.

<a id="nine-android"></a>

## nine-android

[Nine Android listing](https://play.google.com/store/apps/details?id=com.ninefolders.hd3) · Primary · checked 2026-10-11.

Verified package ID and Android availability only.

<a id="nine-vendor"></a>

## nine-vendor

[Nine official platform/download evidence](https://www.9folders.com/en/index.html) · Primary · checked 2026-10-11.

Listed app availability and official download entry points; actions require separate evidence.

<a id="tuta_mail-android"></a>

## tuta_mail-android

[Tuta Mail Android listing](https://play.google.com/store/apps/details?id=de.tutao.tutanota) · Primary · checked 2026-10-11.

Verified package ID and Android availability only.

<a id="tuta_mail-vendor"></a>

## tuta_mail-vendor

[Tuta Mail official platform/download evidence](https://tuta.com/#download) · Primary · checked 2026-10-11.

Listed app availability and official download entry points; actions require separate evidence.

<a id="zoho_mail-android"></a>

## zoho_mail-android

[Zoho Mail Android listing](https://play.google.com/store/apps/details?id=com.zoho.mail) · Primary · checked 2026-10-11.

Verified package ID and Android availability only.

<a id="zoho_mail-vendor"></a>

## zoho_mail-vendor

[Zoho Mail official platform/download evidence](https://www.zoho.com/mail/desktop/) · Primary · checked 2026-10-11.

Listed app availability and official download entry points; actions require separate evidence.

<a id="yandex_mail-android"></a>

## yandex_mail-android

[Yandex Mail Android listing](https://play.google.com/store/apps/details?id=ru.yandex.mail) · Primary · checked 2026-10-11.

Verified package ID and Android availability only.

<a id="yandex_mail-vendor"></a>

## yandex_mail-vendor

[Yandex Mail official platform/download evidence](https://yandex.ru/support/yandex-360/customers/mail/ru/mobile/mail-app) · Primary · checked 2026-10-11.

Listed app availability and official download entry points; actions require separate evidence.

<a id="gmx_mail-ios"></a>

## gmx_mail-ios

[GMX Mail iOS listing](https://apps.apple.com/app/id417352269) · Primary · checked 2026-10-11.

Listing ID and iOS availability only; platform compatibility is not native route support.

<a id="gmx_mail-vendor"></a>

## gmx_mail-vendor

[GMX Mail official platform/download evidence](https://www.gmx.com/mail/app/) · Primary · checked 2026-10-11.

Listed app availability and official download entry points; actions require separate evidence.

<a id="web_de_mail-android"></a>

## web_de_mail-android

[WEB.DE Mail Android listing](https://play.google.com/store/apps/details?id=de.web.mobile.android.mail) · Primary · checked 2026-10-11.

Verified package ID and Android availability only.

<a id="web_de_mail-vendor"></a>

## web_de_mail-vendor

[WEB.DE Mail official platform/download evidence](https://web.de/email/app/) · Primary · checked 2026-10-11.

Listed app availability and official download entry points; actions require separate evidence.

<a id="superhuman-additional"></a>

## superhuman-additional

[superhuman additional platform evidence](https://new.superhuman.com/superhuman-for-windows-265431) · Primary · checked 2026-10-11.

Additional vendor app/platform availability, not an external action contract.

<a id="edison_mail-additional"></a>

## edison_mail-additional

[edison_mail additional platform evidence](https://www.edisonmail.com/blog/draft-windows-app) · Primary · checked 2026-10-11.

Additional vendor app/platform availability, not an external action contract.

<a id="zoho_mail-additional"></a>

## zoho_mail-additional

[zoho_mail additional platform evidence](https://www.zoho.com/mail/mobile/) · Primary · checked 2026-10-11.

Additional vendor app/platform availability, not an external action contract.

<a id="fastmail-additional"></a>

## fastmail-additional

[fastmail additional platform evidence](https://www.fastmail.help/hc/en-us/articles/360060590873-The-Fastmail-mobile-app) · Primary · checked 2026-10-11.

Additional vendor app/platform availability, not an external action contract.

## Access limitations and bounded claims

- Fastmail download page could not initially be fetched; indexed vendor download text and official desktop/mobile help supplied platform evidence.
- GMX Android vendor-linked store page could not be read; its package ID stays unverified.
- The Yandex product page returned a browser-version notice; official mobile help and Play listing supplied mobile evidence.
- Evolution's English help URL could not be read; the official translated-path page has English command content. Geary and KMail historical first-party entries are leads, not current executable contracts.
- Mailbird download controls and a stale Mac footer conflict; installer/version validation remains a blocker.
- Some desktop source/identifiers were inspected from moving first-party branches. Their release match and immutable pin remain prerequisites; no platform is enabled from them in this phase.
- Store IDs still absent for some new iOS candidates and desktop distributions are explicitly unverified. Their official download entry points are recorded instead of guessed listing IDs.

## Product execution evidence

Local product baseline: `f8225e3` on master, package version 1.5.5. [launchAction](https://github.com/DeepLinkX/DeeplinkX/blob/f8225e35158d4b69c9ddb7e8128418e9b278d33c/lib/src/core/deeplink_x.dart) gates native actions on installation, attempts Android intents/app links, then stores (when requested) and Fallbackable URLs. [_launchMapActions](https://github.com/DeepLinkX/DeeplinkX/blob/f8225e35158d4b69c9ddb7e8128418e9b278d33c/lib/src/core/deeplink_x.dart) uses two passes and retries normal launchAction in the second pass. [LauncherUtil](https://github.com/DeepLinkX/DeeplinkX/blob/f8225e35158d4b69c9ddb7e8128418e9b278d33c/lib/src/utils/launcher_util.dart) uses Android packages for root launch and custom schemes elsewhere; macOS installation requires a bundle ID. Windows/Linux generic scheme checks do not prove named-provider identity. Full commit is recorded in the local revision packet manifest.
