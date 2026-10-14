# Email action and platform matrix

Checked **2026-10-11** against 16 existing app drafts and 17 added candidates: **33 research candidates**, zero implemented email APIs. This does not increase supported-app counts. The six platform columns cover every app/action combination; platform identifiers, native routes, fields, fallback/store entries and prerequisites are in the linked briefs.

## Status legend

- **D:** provider-documented invocation candidate; runtime not tested.
- **S:** first-party source candidate; release/manifest/handler verification still required.
- **C:** OS-contract candidate (Android package open or package-targeted SENDTO); app behavior/fields unverified.
- **E:** experimental, undocumented/community/historical route; never enable as stable support without evidence.
- **A:** adapter prerequisite; current DeeplinkX path cannot perform the proposed explicit CLI/application invocation.
- **B:** availability established but action route, identity or required fields remain blocked/unresolved.
- **U:** platform distribution/action not established in inspected evidence; does not mean unsupported.
- **W:** a website/store/product route can open; no particular inbox, draft, search or message is promised.

Every cell is research status, not implemented support. All runtime statuses are **not tested**. Open means launch the named app; Inbox is a separately addressed folder; Message is an existing message, not sending. Web Open is explicitly the exception: it can be a product/store page.

## App/action coverage

### Gmail

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fgmail-actions/doc/plans/email/gmail.md) · [PR #72](https://github.com/DeepLinkX/DeeplinkX/pull/72)

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | C | E | U | U | U | W |
| Compose | C | E | U | U | U | B |
| Inbox | B | B | U | U | U | B |
| Search | B | B | U | U | U | B |
| Message | B | B | U | U | U | B |

### Outlook

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Foutlook-actions/doc/plans/email/outlook.md) · [PR #73](https://github.com/DeepLinkX/DeeplinkX/pull/73)

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | C | E | B | B | U | W |
| Compose | C | E | B | B | U | D |
| Inbox | B | B | B | B | U | B |
| Search | B | B | B | B | U | B |
| Message | B | B | B | B | U | B |

### Yahoo Mail

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fyahoo_mail-actions/doc/plans/email/yahoo_mail.md) · [PR #74](https://github.com/DeepLinkX/DeeplinkX/pull/74)

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | C | E | U | U | U | W |
| Compose | C | E | U | U | U | B |
| Inbox | B | B | U | U | U | B |
| Search | B | B | U | U | U | B |
| Message | B | B | U | U | U | B |

### Spark

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fspark-actions/doc/plans/email/spark.md) · [PR #75](https://github.com/DeepLinkX/DeeplinkX/pull/75)

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | C | E | B | B | U | W |
| Compose | C | E | B | B | U | B |
| Inbox | B | B | B | B | U | B |
| Search | B | B | B | B | U | B |
| Message | B | B | B | B | U | B |

### Airmail

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fairmail-actions/doc/plans/email/airmail.md) · [PR #76](https://github.com/DeepLinkX/DeeplinkX/pull/76)

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | U | E | B | U | U | W |
| Compose | U | D | B | U | U | B |
| Inbox | U | B | B | U | U | B |
| Search | U | B | B | U | U | B |
| Message | U | B | B | U | U | B |

### Fastmail

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Ffastmail-actions/doc/plans/email/fastmail.md) · [PR #77](https://github.com/DeepLinkX/DeeplinkX/pull/77)

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | C | E | B | B | B | W |
| Compose | C | E | B | B | B | B |
| Inbox | B | B | B | B | B | B |
| Search | B | B | B | B | B | B |
| Message | B | B | B | B | B | B |

### Proton Mail

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fproton_mail-actions/doc/plans/email/proton_mail.md) · [PR #78](https://github.com/DeepLinkX/DeeplinkX/pull/78)

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | C | S | B | B | B | W |
| Compose | S | B | B | B | B | B |
| Inbox | B | B | B | B | B | B |
| Search | B | B | B | B | B | B |
| Message | B | B | B | B | B | B |

### Superhuman

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fsuperhuman-actions/doc/plans/email/superhuman.md) · [PR #79](https://github.com/DeepLinkX/DeeplinkX/pull/79)

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | C | B | B | B | U | W |
| Compose | C | B | B | B | U | B |
| Inbox | B | B | B | B | U | B |
| Search | B | B | B | B | U | B |
| Message | B | B | B | B | U | B |

### HEY

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fhey-actions/doc/plans/email/hey.md) · [PR #80](https://github.com/DeepLinkX/DeeplinkX/pull/80)

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | C | B | B | B | B | W |
| Compose | C | B | B | B | B | B |
| Inbox | B | B | B | B | B | B |
| Search | B | B | B | B | B | B |
| Message | B | B | B | B | B | B |

### Canary Mail

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fcanary_mail-actions/doc/plans/email/canary_mail.md) · [PR #81](https://github.com/DeepLinkX/DeeplinkX/pull/81)

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | C | B | B | B | U | W |
| Compose | C | B | B | B | U | B |
| Inbox | B | B | B | B | U | B |
| Search | B | B | B | B | U | B |
| Message | B | B | B | B | U | B |

### Spike

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fspike-actions/doc/plans/email/spike.md) · [PR #82](https://github.com/DeepLinkX/DeeplinkX/pull/82)

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | C | B | B | B | U | W |
| Compose | C | B | B | B | U | B |
| Inbox | B | B | B | B | U | B |
| Search | B | B | B | B | U | B |
| Message | B | B | B | B | U | B |

### Polymail

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fpolymail-actions/doc/plans/email/polymail.md) · [PR #83](https://github.com/DeepLinkX/DeeplinkX/pull/83)

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | U | B | B | B | U | W |
| Compose | U | B | B | B | U | B |
| Inbox | U | B | B | B | U | B |
| Search | U | B | B | B | U | B |
| Message | U | B | B | B | U | B |

### BlueMail

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fblue_mail-actions/doc/plans/email/blue_mail.md) · [PR #84](https://github.com/DeepLinkX/DeeplinkX/pull/84)

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | C | B | B | B | B | W |
| Compose | C | B | B | B | B | B |
| Inbox | B | B | B | B | B | B |
| Search | B | B | B | B | B | B |
| Message | B | B | B | B | B | B |

### Edison Mail

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fedison_mail-actions/doc/plans/email/edison_mail.md) · [PR #85](https://github.com/DeepLinkX/DeeplinkX/pull/85)

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | C | B | B | B | U | W |
| Compose | C | B | B | B | U | B |
| Inbox | B | B | B | B | U | B |
| Search | B | B | B | B | U | B |
| Message | B | B | B | B | U | B |

### Samsung Email

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fsamsung_email-actions/doc/plans/email/samsung_email.md) · [PR #86](https://github.com/DeepLinkX/DeeplinkX/pull/86)

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | C | U | U | U | U | W |
| Compose | C | U | U | U | U | B |
| Inbox | B | U | U | U | U | B |
| Search | B | U | U | U | U | B |
| Message | B | U | U | U | U | B |

### Apple Mail

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fapple_mail-actions/doc/plans/email/apple_mail.md) · [PR #87](https://github.com/DeepLinkX/DeeplinkX/pull/87)

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | U | E | E | U | U | W |
| Compose | U | B | B | U | U | B |
| Inbox | U | B | B | U | U | B |
| Search | U | B | B | U | U | B |
| Message | U | B | B | U | U | B |

### Thunderbird

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-thunderbird-actions/doc/plans/email/thunderbird.md) · [Draft #91](https://github.com/DeepLinkX/DeeplinkX/pull/91)

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | C | U | S+A | S+A | S+A | W |
| Compose | S | U | S+A | S+A | S+A | B |
| Inbox | B | U | B | B | B | B |
| Search | B | U | B | B | B | B |
| Message | B | U | S+A | S+A | S+A | B |

### Betterbird

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-betterbird-actions/doc/plans/email/betterbird.md) · [Draft #92](https://github.com/DeepLinkX/DeeplinkX/pull/92)

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | U | U | B | B | B | W |
| Compose | U | U | B | B | B | B |
| Inbox | U | U | B | B | B | B |
| Search | U | U | B | B | B | B |
| Message | U | U | B | B | B | B |

### Mailspring

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-mailspring-actions/doc/plans/email/mailspring.md) · [Draft #93](https://github.com/DeepLinkX/DeeplinkX/pull/93)

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | U | U | B | B | B | W |
| Compose | U | U | S+A | S+A | S+A | B |
| Inbox | U | U | B | B | B | B |
| Search | U | U | B | B | B | B |
| Message | U | U | B | B | B | B |

### Evolution

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-evolution-actions/doc/plans/email/evolution.md) · [Draft #94](https://github.com/DeepLinkX/DeeplinkX/pull/94)

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | U | U | U | U | D+A | W |
| Compose | U | U | U | U | D+A | B |
| Inbox | U | U | U | U | D+A | B |
| Search | U | U | U | U | B | B |
| Message | U | U | U | U | B | B |

### Geary

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-geary-actions/doc/plans/email/geary.md) · [Draft #95](https://github.com/DeepLinkX/DeeplinkX/pull/95)

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | U | U | U | U | B | W |
| Compose | U | U | U | U | E+A | B |
| Inbox | U | U | U | U | B | B |
| Search | U | U | U | U | B | B |
| Message | U | U | U | U | B | B |

### KMail

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-kmail-actions/doc/plans/email/kmail.md) · [Draft #96](https://github.com/DeepLinkX/DeeplinkX/pull/96)

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | U | U | U | U | B | W |
| Compose | U | U | U | U | E+A | B |
| Inbox | U | U | U | U | B | B |
| Search | U | U | U | U | B | B |
| Message | U | U | U | U | B | B |

### eM Client

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-em-client-actions/doc/plans/email/em_client.md) · [Draft #97](https://github.com/DeepLinkX/DeeplinkX/pull/97)

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | C | B | B | B | U | W |
| Compose | C | B | B | B | U | B |
| Inbox | B | B | B | B | U | B |
| Search | B | B | B | B | U | B |
| Message | B | B | B | B | U | B |

### Mailbird

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-mailbird-actions/doc/plans/email/mailbird.md) · [Draft #98](https://github.com/DeepLinkX/DeeplinkX/pull/98)

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | U | U | B | B | U | W |
| Compose | U | U | B | B | U | B |
| Inbox | U | U | B | B | U | B |
| Search | U | U | B | B | U | B |
| Message | U | U | B | B | U | B |

### FairEmail

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-fairemail-actions/doc/plans/email/fairemail.md) · [Draft #99](https://github.com/DeepLinkX/DeeplinkX/pull/99)

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | C | U | U | U | U | W |
| Compose | S | U | U | U | U | B |
| Inbox | B | U | U | U | U | B |
| Search | B | U | U | U | U | B |
| Message | B | U | U | U | U | B |

### K-9 Mail

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-k9-mail-actions/doc/plans/email/k9_mail.md) · [Draft #100](https://github.com/DeepLinkX/DeeplinkX/pull/100)

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | C | U | U | U | U | W |
| Compose | S | U | U | U | U | B |
| Inbox | B | U | U | U | U | B |
| Search | B | U | U | U | U | B |
| Message | B | U | U | U | U | B |

### Aqua Mail

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-aqua-mail-actions/doc/plans/email/aqua_mail.md) · [Draft #101](https://github.com/DeepLinkX/DeeplinkX/pull/101)

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | C | B | U | U | U | W |
| Compose | C | B | U | U | U | B |
| Inbox | B | B | U | U | U | B |
| Search | B | B | U | U | U | B |
| Message | B | B | U | U | U | B |

### Nine

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-nine-actions/doc/plans/email/nine.md) · [Draft #102](https://github.com/DeepLinkX/DeeplinkX/pull/102)

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | C | U | U | U | U | W |
| Compose | C | U | U | U | U | B |
| Inbox | B | U | U | U | U | B |
| Search | B | U | U | U | U | B |
| Message | B | U | U | U | U | B |

### Tuta Mail

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-tuta-mail-actions/doc/plans/email/tuta_mail.md) · [Draft #103](https://github.com/DeepLinkX/DeeplinkX/pull/103)

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | C | B | B | B | B | W |
| Compose | C | B | B | B | B | B |
| Inbox | B | B | B | B | B | B |
| Search | B | B | B | B | B | B |
| Message | B | B | B | B | B | B |

### Zoho Mail

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-zoho-mail-actions/doc/plans/email/zoho_mail.md) · [Draft #104](https://github.com/DeepLinkX/DeeplinkX/pull/104)

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | C | B | B | B | B | W |
| Compose | C | B | B | B | B | B |
| Inbox | B | B | B | B | B | B |
| Search | B | B | B | B | B | B |
| Message | B | B | B | B | B | B |

### Yandex Mail

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-yandex-mail-actions/doc/plans/email/yandex_mail.md) · [Draft #105](https://github.com/DeepLinkX/DeeplinkX/pull/105)

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | C | B | U | U | U | W |
| Compose | C | B | U | U | U | B |
| Inbox | B | B | U | U | U | B |
| Search | B | B | U | U | U | B |
| Message | B | B | U | U | U | B |

### GMX Mail

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-gmx-mail-actions/doc/plans/email/gmx_mail.md) · [Draft #106](https://github.com/DeepLinkX/DeeplinkX/pull/106)

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | B | B | U | U | U | W |
| Compose | B | B | U | U | U | B |
| Inbox | B | B | U | U | U | B |
| Search | B | B | U | U | U | B |
| Message | B | B | U | U | U | B |

### WEB.DE Mail

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-web-de-mail-actions/doc/plans/email/web_de_mail.md) · [Draft #107](https://github.com/DeepLinkX/DeeplinkX/pull/107)

| Action | Android | iOS | macOS | Windows | Linux | Web |
| --- | --- | --- | --- | --- | --- | --- |
| Open | C | B | U | U | U | W |
| Compose | C | B | U | U | U | B |
| Inbox | B | B | U | U | U | B |
| Search | B | B | U | U | U | B |
| Message | B | B | U | U | U | B |

## Shared capabilities

Named providers and default handlers are separate. Research briefs: [priority launcher](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fmail-compose-launcher/doc/plans/email/mail_compose_launcher.md), [default-mail compose](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fmail-compose-launcher/doc/plans/email/default_mail_compose.md), [installed app selection](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fmail-compose-launcher/doc/plans/email/installed_mail_apps.md), [attachments](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fmail-compose-launcher/doc/plans/email/attachments.md), [desktop prerequisites](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fmail-compose-launcher/doc/plans/email/desktop_launch_prerequisites.md).

Search/inbox/message remain blocked where no external invocation is evidenced. Evolution's local Inbox and Thunderbird's desktop message-ID handler are bounded exceptions requiring adapters and account-specific runtime tests. No send/archive/delete/snooze method is proposed from in-app feature descriptions.
