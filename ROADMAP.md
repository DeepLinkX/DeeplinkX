# DeeplinkX Roadmap

Complete each queue in numbered order. Expand entries for actions and completion criteria.

## 1. Apps and actions

### App queue and research

<details>
<summary>1. Citymapper · Navigation · Pending</summary>

**PR:** [#34](https://github.com/DeepLinkX/DeeplinkX/pull/34)

- [ ] Open app (`Citymapper.open`)
- [ ] View map (`Citymapper.view`)
- [ ] Directions with coordinates (`Citymapper.directionsWithCoords`)

</details>

<details>
<summary>2. OsmAnd · Navigation · Pending</summary>

**PR:** [#35](https://github.com/DeepLinkX/DeeplinkX/pull/35)

- [ ] Open app (`OsmAnd.open`)
- [ ] View map (`OsmAnd.view`)
- [ ] Directions with coordinates (`OsmAnd.directionsWithCoords`)

</details>

<details>
<summary>3. HERE WeGo · Navigation · Implemented</summary>

**PR:** [#38](https://github.com/DeepLinkX/DeeplinkX/pull/38)

- [x] Open app (`HereWeGo.open`)
- [x] View map (`HereWeGo.view`)
- [x] Directions with coordinates (`HereWeGo.directionsWithCoords`)

</details>

### Email research — 33 candidates, zero implemented

Documentation-only queue tracked by [PR #89](https://github.com/DeepLinkX/DeeplinkX/pull/89). Read the [review findings](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fmail-compose-launcher/doc/plans/email/review_report.md), [matrix/legend](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fmail-compose-launcher/doc/plans/email/matrix.md) and [source register](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fmail-compose-launcher/doc/plans/email/sources.md). Status letters describe invocation evidence/prerequisites, not implementation. All runtime checks remain unperformed. Missing platform evidence does not mean unsupported.

<details>
<summary>4. Gmail · Email · Research</summary>

**Existing draft:** [#72](https://github.com/DeepLinkX/DeeplinkX/pull/72) · [Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fgmail-actions/doc/plans/email/gmail.md)

| Platform | Open | Compose | Inbox / Search / Message |
| --- | --- | --- | --- |
| Android | C | C | B / B / B |
| iOS | E | E | B / B / B |
| macOS | U | U | U / U / U |
| Windows | U | U | U / U / U |
| Linux | U | U | U / U / U |
| Web | W | B | B / B / B |

- [ ] Verify source/release, identifiers and all supplied fields
- [ ] Resolve adapter blockers and record device results
- [ ] Implement only evidenced actions after separate authorization

</details>

<details>
<summary>5. Outlook · Email · Research</summary>

**Existing draft:** [#73](https://github.com/DeepLinkX/DeeplinkX/pull/73) · [Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Foutlook-actions/doc/plans/email/outlook.md)

| Platform | Open | Compose | Inbox / Search / Message |
| --- | --- | --- | --- |
| Android | C | C | B / B / B |
| iOS | E | E | B / B / B |
| macOS | B | B | B / B / B |
| Windows | B | B | B / B / B |
| Linux | U | U | U / U / U |
| Web | W | D | B / B / B |

- [ ] Verify source/release, identifiers and all supplied fields
- [ ] Resolve adapter blockers and record device results
- [ ] Implement only evidenced actions after separate authorization

</details>

<details>
<summary>6. Yahoo Mail · Email · Research</summary>

**Existing draft:** [#74](https://github.com/DeepLinkX/DeeplinkX/pull/74) · [Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fyahoo_mail-actions/doc/plans/email/yahoo_mail.md)

| Platform | Open | Compose | Inbox / Search / Message |
| --- | --- | --- | --- |
| Android | C | C | B / B / B |
| iOS | E | E | B / B / B |
| macOS | U | U | U / U / U |
| Windows | U | U | U / U / U |
| Linux | U | U | U / U / U |
| Web | W | B | B / B / B |

- [ ] Verify source/release, identifiers and all supplied fields
- [ ] Resolve adapter blockers and record device results
- [ ] Implement only evidenced actions after separate authorization

</details>

<details>
<summary>7. Spark · Email · Research</summary>

**Existing draft:** [#75](https://github.com/DeepLinkX/DeeplinkX/pull/75) · [Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fspark-actions/doc/plans/email/spark.md)

| Platform | Open | Compose | Inbox / Search / Message |
| --- | --- | --- | --- |
| Android | C | C | B / B / B |
| iOS | E | E | B / B / B |
| macOS | B | B | B / B / B |
| Windows | B | B | B / B / B |
| Linux | U | U | U / U / U |
| Web | W | B | B / B / B |

- [ ] Verify source/release, identifiers and all supplied fields
- [ ] Resolve adapter blockers and record device results
- [ ] Implement only evidenced actions after separate authorization

</details>

<details>
<summary>8. Airmail · Email · Research</summary>

**Existing draft:** [#76](https://github.com/DeepLinkX/DeeplinkX/pull/76) · [Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fairmail-actions/doc/plans/email/airmail.md)

| Platform | Open | Compose | Inbox / Search / Message |
| --- | --- | --- | --- |
| Android | U | U | U / U / U |
| iOS | E | D | B / B / B |
| macOS | B | B | B / B / B |
| Windows | U | U | U / U / U |
| Linux | U | U | U / U / U |
| Web | W | B | B / B / B |

- [ ] Verify source/release, identifiers and all supplied fields
- [ ] Resolve adapter blockers and record device results
- [ ] Implement only evidenced actions after separate authorization

</details>

<details>
<summary>9. Fastmail · Email · Research</summary>

**Existing draft:** [#77](https://github.com/DeepLinkX/DeeplinkX/pull/77) · [Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Ffastmail-actions/doc/plans/email/fastmail.md)

| Platform | Open | Compose | Inbox / Search / Message |
| --- | --- | --- | --- |
| Android | C | C | B / B / B |
| iOS | E | E | B / B / B |
| macOS | B | B | B / B / B |
| Windows | B | B | B / B / B |
| Linux | B | B | B / B / B |
| Web | W | B | B / B / B |

- [ ] Verify source/release, identifiers and all supplied fields
- [ ] Resolve adapter blockers and record device results
- [ ] Implement only evidenced actions after separate authorization

</details>

<details>
<summary>10. Proton Mail · Email · Research</summary>

**Existing draft:** [#78](https://github.com/DeepLinkX/DeeplinkX/pull/78) · [Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fproton_mail-actions/doc/plans/email/proton_mail.md)

| Platform | Open | Compose | Inbox / Search / Message |
| --- | --- | --- | --- |
| Android | C | S | B / B / B |
| iOS | S | B | B / B / B |
| macOS | B | B | B / B / B |
| Windows | B | B | B / B / B |
| Linux | B | B | B / B / B |
| Web | W | B | B / B / B |

- [ ] Verify source/release, identifiers and all supplied fields
- [ ] Resolve adapter blockers and record device results
- [ ] Implement only evidenced actions after separate authorization

</details>

<details>
<summary>11. Superhuman · Email · Research</summary>

**Existing draft:** [#79](https://github.com/DeepLinkX/DeeplinkX/pull/79) · [Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fsuperhuman-actions/doc/plans/email/superhuman.md)

| Platform | Open | Compose | Inbox / Search / Message |
| --- | --- | --- | --- |
| Android | C | C | B / B / B |
| iOS | B | B | B / B / B |
| macOS | B | B | B / B / B |
| Windows | B | B | B / B / B |
| Linux | U | U | U / U / U |
| Web | W | B | B / B / B |

- [ ] Verify source/release, identifiers and all supplied fields
- [ ] Resolve adapter blockers and record device results
- [ ] Implement only evidenced actions after separate authorization

</details>

<details>
<summary>12. HEY · Email · Research</summary>

**Existing draft:** [#80](https://github.com/DeepLinkX/DeeplinkX/pull/80) · [Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fhey-actions/doc/plans/email/hey.md)

| Platform | Open | Compose | Inbox / Search / Message |
| --- | --- | --- | --- |
| Android | C | C | B / B / B |
| iOS | B | B | B / B / B |
| macOS | B | B | B / B / B |
| Windows | B | B | B / B / B |
| Linux | B | B | B / B / B |
| Web | W | B | B / B / B |

- [ ] Verify source/release, identifiers and all supplied fields
- [ ] Resolve adapter blockers and record device results
- [ ] Implement only evidenced actions after separate authorization

</details>

<details>
<summary>13. Canary Mail · Email · Research</summary>

**Existing draft:** [#81](https://github.com/DeepLinkX/DeeplinkX/pull/81) · [Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fcanary_mail-actions/doc/plans/email/canary_mail.md)

| Platform | Open | Compose | Inbox / Search / Message |
| --- | --- | --- | --- |
| Android | C | C | B / B / B |
| iOS | B | B | B / B / B |
| macOS | B | B | B / B / B |
| Windows | B | B | B / B / B |
| Linux | U | U | U / U / U |
| Web | W | B | B / B / B |

- [ ] Verify source/release, identifiers and all supplied fields
- [ ] Resolve adapter blockers and record device results
- [ ] Implement only evidenced actions after separate authorization

</details>

<details>
<summary>14. Spike · Email · Research</summary>

**Existing draft:** [#82](https://github.com/DeepLinkX/DeeplinkX/pull/82) · [Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fspike-actions/doc/plans/email/spike.md)

| Platform | Open | Compose | Inbox / Search / Message |
| --- | --- | --- | --- |
| Android | C | C | B / B / B |
| iOS | B | B | B / B / B |
| macOS | B | B | B / B / B |
| Windows | B | B | B / B / B |
| Linux | U | U | U / U / U |
| Web | W | B | B / B / B |

- [ ] Verify source/release, identifiers and all supplied fields
- [ ] Resolve adapter blockers and record device results
- [ ] Implement only evidenced actions after separate authorization

</details>

<details>
<summary>15. Polymail · Email · Research</summary>

**Existing draft:** [#83](https://github.com/DeepLinkX/DeeplinkX/pull/83) · [Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fpolymail-actions/doc/plans/email/polymail.md)

| Platform | Open | Compose | Inbox / Search / Message |
| --- | --- | --- | --- |
| Android | U | U | U / U / U |
| iOS | B | B | B / B / B |
| macOS | B | B | B / B / B |
| Windows | B | B | B / B / B |
| Linux | U | U | U / U / U |
| Web | W | B | B / B / B |

- [ ] Verify source/release, identifiers and all supplied fields
- [ ] Resolve adapter blockers and record device results
- [ ] Implement only evidenced actions after separate authorization

</details>

<details>
<summary>16. BlueMail · Email · Research</summary>

**Existing draft:** [#84](https://github.com/DeepLinkX/DeeplinkX/pull/84) · [Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fblue_mail-actions/doc/plans/email/blue_mail.md)

| Platform | Open | Compose | Inbox / Search / Message |
| --- | --- | --- | --- |
| Android | C | C | B / B / B |
| iOS | B | B | B / B / B |
| macOS | B | B | B / B / B |
| Windows | B | B | B / B / B |
| Linux | B | B | B / B / B |
| Web | W | B | B / B / B |

- [ ] Verify source/release, identifiers and all supplied fields
- [ ] Resolve adapter blockers and record device results
- [ ] Implement only evidenced actions after separate authorization

</details>

<details>
<summary>17. Edison Mail · Email · Research</summary>

**Existing draft:** [#85](https://github.com/DeepLinkX/DeeplinkX/pull/85) · [Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fedison_mail-actions/doc/plans/email/edison_mail.md)

| Platform | Open | Compose | Inbox / Search / Message |
| --- | --- | --- | --- |
| Android | C | C | B / B / B |
| iOS | B | B | B / B / B |
| macOS | B | B | B / B / B |
| Windows | B | B | B / B / B |
| Linux | U | U | U / U / U |
| Web | W | B | B / B / B |

- [ ] Verify source/release, identifiers and all supplied fields
- [ ] Resolve adapter blockers and record device results
- [ ] Implement only evidenced actions after separate authorization

</details>

<details>
<summary>18. Samsung Email · Email · Research</summary>

**Existing draft:** [#86](https://github.com/DeepLinkX/DeeplinkX/pull/86) · [Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fsamsung_email-actions/doc/plans/email/samsung_email.md)

| Platform | Open | Compose | Inbox / Search / Message |
| --- | --- | --- | --- |
| Android | C | C | B / B / B |
| iOS | U | U | U / U / U |
| macOS | U | U | U / U / U |
| Windows | U | U | U / U / U |
| Linux | U | U | U / U / U |
| Web | W | B | B / B / B |

- [ ] Verify source/release, identifiers and all supplied fields
- [ ] Resolve adapter blockers and record device results
- [ ] Implement only evidenced actions after separate authorization

</details>

<details>
<summary>19. Apple Mail · Email · Research</summary>

**Existing draft:** [#87](https://github.com/DeepLinkX/DeeplinkX/pull/87) · [Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fapple_mail-actions/doc/plans/email/apple_mail.md)

| Platform | Open | Compose | Inbox / Search / Message |
| --- | --- | --- | --- |
| Android | U | U | U / U / U |
| iOS | E | B | B / B / B |
| macOS | E | B | B / B / B |
| Windows | U | U | U / U / U |
| Linux | U | U | U / U / U |
| Web | W | B | B / B / B |

- [ ] Verify source/release, identifiers and all supplied fields
- [ ] Resolve adapter blockers and record device results
- [ ] Implement only evidenced actions after separate authorization

</details>

<details>
<summary>20. Thunderbird · Email · Research</summary>

**Planning draft:** [Draft #91](https://github.com/DeepLinkX/DeeplinkX/pull/91) · [Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-thunderbird-actions/doc/plans/email/thunderbird.md)

| Platform | Open | Compose | Inbox / Search / Message |
| --- | --- | --- | --- |
| Android | C | S | B / B / B |
| iOS | U | U | U / U / U |
| macOS | S+A | S+A | B / B / S+A |
| Windows | S+A | S+A | B / B / S+A |
| Linux | S+A | S+A | B / B / S+A |
| Web | W | B | B / B / B |

- [ ] Verify source/release, identifiers and all supplied fields
- [ ] Resolve adapter blockers and record device results
- [ ] Implement only evidenced actions after separate authorization

</details>

<details>
<summary>21. Betterbird · Email · Research</summary>

**Planning draft:** [Draft #92](https://github.com/DeepLinkX/DeeplinkX/pull/92) · [Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-betterbird-actions/doc/plans/email/betterbird.md)

| Platform | Open | Compose | Inbox / Search / Message |
| --- | --- | --- | --- |
| Android | U | U | U / U / U |
| iOS | U | U | U / U / U |
| macOS | B | B | B / B / B |
| Windows | B | B | B / B / B |
| Linux | B | B | B / B / B |
| Web | W | B | B / B / B |

- [ ] Verify source/release, identifiers and all supplied fields
- [ ] Resolve adapter blockers and record device results
- [ ] Implement only evidenced actions after separate authorization

</details>

<details>
<summary>22. Mailspring · Email · Research</summary>

**Planning draft:** [Draft #93](https://github.com/DeepLinkX/DeeplinkX/pull/93) · [Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-mailspring-actions/doc/plans/email/mailspring.md)

| Platform | Open | Compose | Inbox / Search / Message |
| --- | --- | --- | --- |
| Android | U | U | U / U / U |
| iOS | U | U | U / U / U |
| macOS | B | S+A | B / B / B |
| Windows | B | S+A | B / B / B |
| Linux | B | S+A | B / B / B |
| Web | W | B | B / B / B |

- [ ] Verify source/release, identifiers and all supplied fields
- [ ] Resolve adapter blockers and record device results
- [ ] Implement only evidenced actions after separate authorization

</details>

<details>
<summary>23. Evolution · Email · Research</summary>

**Planning draft:** [Draft #94](https://github.com/DeepLinkX/DeeplinkX/pull/94) · [Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-evolution-actions/doc/plans/email/evolution.md)

| Platform | Open | Compose | Inbox / Search / Message |
| --- | --- | --- | --- |
| Android | U | U | U / U / U |
| iOS | U | U | U / U / U |
| macOS | U | U | U / U / U |
| Windows | U | U | U / U / U |
| Linux | D+A | D+A | D+A / B / B |
| Web | W | B | B / B / B |

- [ ] Verify source/release, identifiers and all supplied fields
- [ ] Resolve adapter blockers and record device results
- [ ] Implement only evidenced actions after separate authorization

</details>

<details>
<summary>24. Geary · Email · Research</summary>

**Planning draft:** [Draft #95](https://github.com/DeepLinkX/DeeplinkX/pull/95) · [Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-geary-actions/doc/plans/email/geary.md)

| Platform | Open | Compose | Inbox / Search / Message |
| --- | --- | --- | --- |
| Android | U | U | U / U / U |
| iOS | U | U | U / U / U |
| macOS | U | U | U / U / U |
| Windows | U | U | U / U / U |
| Linux | B | E+A | B / B / B |
| Web | W | B | B / B / B |

- [ ] Verify source/release, identifiers and all supplied fields
- [ ] Resolve adapter blockers and record device results
- [ ] Implement only evidenced actions after separate authorization

</details>

<details>
<summary>25. KMail · Email · Research</summary>

**Planning draft:** [Draft #96](https://github.com/DeepLinkX/DeeplinkX/pull/96) · [Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-kmail-actions/doc/plans/email/kmail.md)

| Platform | Open | Compose | Inbox / Search / Message |
| --- | --- | --- | --- |
| Android | U | U | U / U / U |
| iOS | U | U | U / U / U |
| macOS | U | U | U / U / U |
| Windows | U | U | U / U / U |
| Linux | B | E+A | B / B / B |
| Web | W | B | B / B / B |

- [ ] Verify source/release, identifiers and all supplied fields
- [ ] Resolve adapter blockers and record device results
- [ ] Implement only evidenced actions after separate authorization

</details>

<details>
<summary>26. eM Client · Email · Research</summary>

**Planning draft:** [Draft #97](https://github.com/DeepLinkX/DeeplinkX/pull/97) · [Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-em-client-actions/doc/plans/email/em_client.md)

| Platform | Open | Compose | Inbox / Search / Message |
| --- | --- | --- | --- |
| Android | C | C | B / B / B |
| iOS | B | B | B / B / B |
| macOS | B | B | B / B / B |
| Windows | B | B | B / B / B |
| Linux | U | U | U / U / U |
| Web | W | B | B / B / B |

- [ ] Verify source/release, identifiers and all supplied fields
- [ ] Resolve adapter blockers and record device results
- [ ] Implement only evidenced actions after separate authorization

</details>

<details>
<summary>27. Mailbird · Email · Research</summary>

**Planning draft:** [Draft #98](https://github.com/DeepLinkX/DeeplinkX/pull/98) · [Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-mailbird-actions/doc/plans/email/mailbird.md)

| Platform | Open | Compose | Inbox / Search / Message |
| --- | --- | --- | --- |
| Android | U | U | U / U / U |
| iOS | U | U | U / U / U |
| macOS | B | B | B / B / B |
| Windows | B | B | B / B / B |
| Linux | U | U | U / U / U |
| Web | W | B | B / B / B |

- [ ] Verify source/release, identifiers and all supplied fields
- [ ] Resolve adapter blockers and record device results
- [ ] Implement only evidenced actions after separate authorization

</details>

<details>
<summary>28. FairEmail · Email · Research</summary>

**Planning draft:** [Draft #99](https://github.com/DeepLinkX/DeeplinkX/pull/99) · [Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-fairemail-actions/doc/plans/email/fairemail.md)

| Platform | Open | Compose | Inbox / Search / Message |
| --- | --- | --- | --- |
| Android | C | S | B / B / B |
| iOS | U | U | U / U / U |
| macOS | U | U | U / U / U |
| Windows | U | U | U / U / U |
| Linux | U | U | U / U / U |
| Web | W | B | B / B / B |

- [ ] Verify source/release, identifiers and all supplied fields
- [ ] Resolve adapter blockers and record device results
- [ ] Implement only evidenced actions after separate authorization

</details>

<details>
<summary>29. K-9 Mail · Email · Research</summary>

**Planning draft:** [Draft #100](https://github.com/DeepLinkX/DeeplinkX/pull/100) · [Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-k9-mail-actions/doc/plans/email/k9_mail.md)

| Platform | Open | Compose | Inbox / Search / Message |
| --- | --- | --- | --- |
| Android | C | S | B / B / B |
| iOS | U | U | U / U / U |
| macOS | U | U | U / U / U |
| Windows | U | U | U / U / U |
| Linux | U | U | U / U / U |
| Web | W | B | B / B / B |

- [ ] Verify source/release, identifiers and all supplied fields
- [ ] Resolve adapter blockers and record device results
- [ ] Implement only evidenced actions after separate authorization

</details>

<details>
<summary>30. Aqua Mail · Email · Research</summary>

**Planning draft:** [Draft #101](https://github.com/DeepLinkX/DeeplinkX/pull/101) · [Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-aqua-mail-actions/doc/plans/email/aqua_mail.md)

| Platform | Open | Compose | Inbox / Search / Message |
| --- | --- | --- | --- |
| Android | C | C | B / B / B |
| iOS | B | B | B / B / B |
| macOS | U | U | U / U / U |
| Windows | U | U | U / U / U |
| Linux | U | U | U / U / U |
| Web | W | B | B / B / B |

- [ ] Verify source/release, identifiers and all supplied fields
- [ ] Resolve adapter blockers and record device results
- [ ] Implement only evidenced actions after separate authorization

</details>

<details>
<summary>31. Nine · Email · Research</summary>

**Planning draft:** [Draft #102](https://github.com/DeepLinkX/DeeplinkX/pull/102) · [Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-nine-actions/doc/plans/email/nine.md)

| Platform | Open | Compose | Inbox / Search / Message |
| --- | --- | --- | --- |
| Android | C | C | B / B / B |
| iOS | U | U | U / U / U |
| macOS | U | U | U / U / U |
| Windows | U | U | U / U / U |
| Linux | U | U | U / U / U |
| Web | W | B | B / B / B |

- [ ] Verify source/release, identifiers and all supplied fields
- [ ] Resolve adapter blockers and record device results
- [ ] Implement only evidenced actions after separate authorization

</details>

<details>
<summary>32. Tuta Mail · Email · Research</summary>

**Planning draft:** [Draft #103](https://github.com/DeepLinkX/DeeplinkX/pull/103) · [Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-tuta-mail-actions/doc/plans/email/tuta_mail.md)

| Platform | Open | Compose | Inbox / Search / Message |
| --- | --- | --- | --- |
| Android | C | C | B / B / B |
| iOS | B | B | B / B / B |
| macOS | B | B | B / B / B |
| Windows | B | B | B / B / B |
| Linux | B | B | B / B / B |
| Web | W | B | B / B / B |

- [ ] Verify source/release, identifiers and all supplied fields
- [ ] Resolve adapter blockers and record device results
- [ ] Implement only evidenced actions after separate authorization

</details>

<details>
<summary>33. Zoho Mail · Email · Research</summary>

**Planning draft:** [Draft #104](https://github.com/DeepLinkX/DeeplinkX/pull/104) · [Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-zoho-mail-actions/doc/plans/email/zoho_mail.md)

| Platform | Open | Compose | Inbox / Search / Message |
| --- | --- | --- | --- |
| Android | C | C | B / B / B |
| iOS | B | B | B / B / B |
| macOS | B | B | B / B / B |
| Windows | B | B | B / B / B |
| Linux | B | B | B / B / B |
| Web | W | B | B / B / B |

- [ ] Verify source/release, identifiers and all supplied fields
- [ ] Resolve adapter blockers and record device results
- [ ] Implement only evidenced actions after separate authorization

</details>

<details>
<summary>34. Yandex Mail · Email · Research</summary>

**Planning draft:** [Draft #105](https://github.com/DeepLinkX/DeeplinkX/pull/105) · [Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-yandex-mail-actions/doc/plans/email/yandex_mail.md)

| Platform | Open | Compose | Inbox / Search / Message |
| --- | --- | --- | --- |
| Android | C | C | B / B / B |
| iOS | B | B | B / B / B |
| macOS | U | U | U / U / U |
| Windows | U | U | U / U / U |
| Linux | U | U | U / U / U |
| Web | W | B | B / B / B |

- [ ] Verify source/release, identifiers and all supplied fields
- [ ] Resolve adapter blockers and record device results
- [ ] Implement only evidenced actions after separate authorization

</details>

<details>
<summary>35. GMX Mail · Email · Research</summary>

**Planning draft:** [Draft #106](https://github.com/DeepLinkX/DeeplinkX/pull/106) · [Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-gmx-mail-actions/doc/plans/email/gmx_mail.md)

| Platform | Open | Compose | Inbox / Search / Message |
| --- | --- | --- | --- |
| Android | B | B | B / B / B |
| iOS | B | B | B / B / B |
| macOS | U | U | U / U / U |
| Windows | U | U | U / U / U |
| Linux | U | U | U / U / U |
| Web | W | B | B / B / B |

- [ ] Verify source/release, identifiers and all supplied fields
- [ ] Resolve adapter blockers and record device results
- [ ] Implement only evidenced actions after separate authorization

</details>

<details>
<summary>36. WEB.DE Mail · Email · Research</summary>

**Planning draft:** [Draft #107](https://github.com/DeepLinkX/DeeplinkX/pull/107) · [Brief](https://github.com/DeepLinkX/DeeplinkX/blob/codex%2Fplan-web-de-mail-actions/doc/plans/email/web_de_mail.md)

| Platform | Open | Compose | Inbox / Search / Message |
| --- | --- | --- | --- |
| Android | C | C | B / B / B |
| iOS | B | B | B / B / B |
| macOS | U | U | U / U / U |
| Windows | U | U | U / U / U |
| Linux | U | U | U / U / U |
| Web | W | B | B / B / B |

- [ ] Verify source/release, identifiers and all supplied fields
- [ ] Resolve adapter blockers and record device results
- [ ] Implement only evidenced actions after separate authorization

</details>

### Existing apps and stores

40 app exports (including one draft) and 7 stores in the current repository. Email research candidates are excluded.

<details>
<summary>Social (17 apps)</summary>

<details>
<summary>ChatGPT · Implemented</summary>

- [x] Open app (`ChatGPT.open`)
- [x] Open shared conversation (`ChatGPT.openSharedConversation`)
- [x] Open GPT (`ChatGPT.openGpt`)

</details>

<details>
<summary>Netflix · Implemented</summary>

- [x] Open app (`Netflix.open`)
- [x] Open title (`Netflix.openTitle`)
- [x] Watch title (`Netflix.watchTitle`)

</details>

<details>
<summary>Temu · Implemented</summary>

- [x] Open app (`Temu.open`)
- [x] Open link (`Temu.openLink`)
- [x] Search (`Temu.search`)

</details>

<details>
<summary>Snapchat · Implemented</summary>

- [x] Open app (`Snapchat.open`)
- [x] Open profile by username (`Snapchat.openProfile`)

</details>

<details>
<summary>CapCut · Implemented</summary>

- [x] Open app (`CapCut.open`)
- [x] Open template link (`CapCut.openTemplate`)

</details>

<details>
<summary>Facebook · Implemented</summary>

- [x] Open app (`Facebook.open`)
- [x] Open profile by ID (`Facebook.openProfileById`)
- [x] Open profile by username (`Facebook.openProfileByUsername`)
- [x] Open page (`Facebook.openPage`)
- [x] Open group (`Facebook.openGroup`)
- [x] Open event (`Facebook.openEvent`)

</details>

<details>
<summary>Instagram · Implemented</summary>

- [x] Open app (`Instagram.open`)
- [x] Open profile by username (`Instagram.openProfile`)

</details>

<details>
<summary>LinkedIn · Implemented</summary>

- [x] Open app (`LinkedIn.open`)
- [x] Open profile page (`LinkedIn.openProfile`)
- [x] Open company page (`LinkedIn.openCompany`)

</details>

<details>
<summary>WhatsApp · Implemented</summary>

- [x] Open app (`WhatsApp.open`)
- [x] Chat with phone number (`WhatsApp.chat`)
- [x] Share text content (`WhatsApp.shareText`)

</details>

<details>
<summary>Telegram · Implemented</summary>

- [x] Open app (`Telegram.open`)
- [x] Open profile by username (`Telegram.openProfile`)
- [x] Open profile by phone number (`Telegram.openProfileByPhoneNumber`)
- [x] Send message by username (`Telegram.sendMessage`)
- [x] Send message by phone number (`Telegram.sendMessageByPhoneNumber`)

</details>

<details>
<summary>Twitter · Implemented</summary>

- [x] Open app (`Twitter.open`)
- [x] Open profile by username (`Twitter.openProfile`)
- [x] Open tweet by ID (`Twitter.openTweet`)
- [x] Search (`Twitter.search`)

</details>

<details>
<summary>Threads · Implemented</summary>

- [x] Open app (`Threads.open`)
- [x] Open profile by username (`Threads.openProfile`)
- [x] Open post (`Threads.openPost`)
- [x] Open comments (`Threads.openComments`)
- [x] Create post (`Threads.createPost`)
- [x] Search (`Threads.search`)
- [x] Open topic tag (`Threads.openTag`)

</details>

<details>
<summary>YouTube · Implemented</summary>

- [x] Open app (`YouTube.open`)
- [x] Open video (`YouTube.openVideo`)
- [x] Open channel (`YouTube.openChannel`)
- [x] Open playlist (`YouTube.openPlaylist`)
- [x] Search (`YouTube.search`)

</details>

<details>
<summary>TikTok · Implemented</summary>

- [x] Open app (`TikTok.open`)
- [x] Open profile by username (`TikTok.openProfile`)
- [x] Open video (`TikTok.openVideo`)
- [x] Open tag (`TikTok.openTag`)

</details>

<details>
<summary>Pinterest · Implemented</summary>

- [x] Open app (`Pinterest.open`)
- [x] Open profile by username (`Pinterest.openProfile`)
- [x] Open pin (`Pinterest.openPin`)
- [x] Open board by ID (`Pinterest.openBoard`)
- [x] Search (`Pinterest.search`)

</details>

<details>
<summary>Zoom · Implemented</summary>

- [x] Open app (`Zoom.open`)
- [x] Join meeting by ID (`Zoom.joinMeeting`)

</details>

<details>
<summary>Slack · Implemented</summary>

- [x] Open app (`Slack.open`)
- [x] Open team (`Slack.openTeam`)
- [x] Open channel (`Slack.openChannel`)
- [x] Open user (`Slack.openUser`)

</details>

</details>

<details>
<summary>Navigation (23 apps) · includes 1 draft</summary>

<details>
<summary>HERE WeGo · Implemented</summary>

- [x] Open app (`HereWeGo.open`)
- [x] View map (`HereWeGo.view`)
- [x] Directions with coordinates (`HereWeGo.directionsWithCoords`)

</details>

<details>
<summary>Google Maps · Implemented</summary>

- [x] Open app (`GoogleMaps.open`)
- [x] View map (`GoogleMaps.view`)
- [x] Search (`GoogleMaps.search`)
- [x] Directions (`GoogleMaps.directions`)
- [x] Directions with coordinates (`GoogleMaps.directionsWithCoords`)

</details>

<details>
<summary>Amap · Implemented</summary>

- [x] Open app (`Amap.open`)
- [x] Open current location (`Amap.myLocation`)
- [x] View map (`Amap.view`)
- [x] Search (`Amap.search`)
- [x] Directions (`Amap.directions`)
- [x] Directions with coordinates (`Amap.directionsWithCoords`)

</details>

<details>
<summary>Baidu Maps · Implemented</summary>

- [x] Open app (`BaiduMaps.open`)
- [x] View map (`BaiduMaps.view`)
- [x] Search (`BaiduMaps.search`)
- [x] Nearby search (`BaiduMaps.nearbySearch`)
- [x] Open transit line (`BaiduMaps.line`)
- [x] Directions (`BaiduMaps.directions`)
- [x] Directions with coordinates (`BaiduMaps.directionsWithCoords`)
- [x] Navigation (`BaiduMaps.navigate`)

</details>

<details>
<summary>NAVER Map · Implemented</summary>

- [x] Open app (`NaverMap.open`)
- [x] View map (`NaverMap.view`)
- [x] Search (`NaverMap.search`)
- [x] Bus search (`NaverMap.busSearch`)
- [x] Directions with coordinates (`NaverMap.directionsWithCoords`)
- [x] Navigation (`NaverMap.navigate`)
- [x] Safe driving (`NaverMap.safeDriving`)

</details>

<details>
<summary>Apple Maps · Implemented</summary>

- [x] Open app (`AppleMaps.open`)
- [x] View map (`AppleMaps.view`)
- [x] Search (`AppleMaps.search`)
- [x] Directions (`AppleMaps.directions`)
- [x] Directions with coordinates (`AppleMaps.directionsWithCoords`)

</details>

<details>
<summary>2GIS · Implemented</summary>

- [x] Open app (`TwoGis.open`)
- [x] View map (`TwoGis.view`)
- [x] Directions with coordinates (`TwoGis.directionsWithCoords`)

</details>

<details>
<summary>Waze · Implemented</summary>

- [x] Open app (`Waze.open`)
- [x] View map (`Waze.view`)
- [x] Search (`Waze.search`)
- [x] Directions (`Waze.directions`)
- [x] Directions with coordinates (`Waze.directionsWithCoords`)

</details>

<details>
<summary>Sygic · Implemented</summary>

- [x] Open app (`Sygic.open`)
- [x] View map (`Sygic.view`)
- [x] Directions with coordinates (`Sygic.directionsWithCoords`)

</details>

<details>
<summary>Sygic Truck · Implemented</summary>

- [x] Open app (`SygicTruck.open`)
- [x] View map (`SygicTruck.view`)
- [x] Directions with coordinates (`SygicTruck.directionsWithCoords`)

</details>

<details>
<summary>CoPilot · Implemented</summary>

- [x] Open app (`Copilot.open`)
- [x] View map (`Copilot.view`)
- [x] Directions with coordinates (`Copilot.directionsWithCoords`)

</details>

<details>
<summary>TomTom GO Fleet · Implemented</summary>

- [x] Open app (`TomTomGoFleet.open`)
- [x] View map (`TomTomGoFleet.view`)
- [x] Directions with coordinates (`TomTomGoFleet.directionsWithCoords`)

</details>

<details>
<summary>TomTom GO Expert · Draft</summary>

- [ ] Open app (`TomTomGoExpert.open`)
- [ ] View map (`TomTomGoExpert.view`)
- [ ] Directions with coordinates (`TomTomGoExpert.directionsWithCoords`)

Unpublished draft. Native iOS opening and navigation links remain unverified; see [the draft documentation](doc/apps/tomtom_go_expert.md).

</details>

<details>
<summary>Moovit · Implemented</summary>

- [x] Open app (`Moovit.open`)
- [x] View map (`Moovit.view`)
- [x] Directions with coordinates (`Moovit.directionsWithCoords`)

</details>

<details>
<summary>Air Navigation Pro · Implemented</summary>

- [x] Open app (`AirNavigationPro.open`)
- [x] View map (`AirNavigationPro.view`)
- [x] Direct-to navigation (`AirNavigationPro.directTo`)
- [x] Directions with coordinates (`AirNavigationPro.directionsWithCoords`)

</details>

<details>
<summary>Mappls · Implemented</summary>

- [x] Open app (`Mappls.open`)
- [x] View map (`Mappls.view`)
- [x] Directions with coordinates (`Mappls.directionsWithCoords`)

</details>

<details>
<summary>Mapy.com · Implemented</summary>

- [x] Open app (`MapyCz.open`)
- [x] View map (`MapyCz.view`)
- [x] Search (`MapyCz.search`)
- [x] Directions with coordinates (`MapyCz.directionsWithCoords`)

</details>

<details>
<summary>TMAP · Implemented</summary>

- [x] Open app (`TMap.open`)
- [x] View map (`TMap.view`)
- [x] Directions with coordinates (`TMap.directionsWithCoords`)

</details>

<details>
<summary>KakaoMap · Implemented</summary>

- [x] Open app (`KakaoMap.open`)
- [x] View map (`KakaoMap.view`)
- [x] Directions with coordinates (`KakaoMap.directionsWithCoords`)

</details>

<details>
<summary>Neshan · Implemented</summary>

- [x] Open app (`Neshan.open`)
- [x] View map (`Neshan.view`)
- [x] Directions with coordinates (`Neshan.directionsWithCoords`)

</details>

<details>
<summary>Yandex Maps · Implemented</summary>

- [x] Open app (`YandexMaps.open`)
- [x] Open map (`YandexMaps.openMap`)
- [x] View map (`YandexMaps.view`)
- [x] Search (`YandexMaps.search`)
- [x] Open organization card (`YandexMaps.organization`)
- [x] What is here (`YandexMaps.whatIsHere`)
- [x] Directions with coordinates (`YandexMaps.directionsWithCoords`)
- [x] Panorama (`YandexMaps.panorama`)

</details>

<details>
<summary>Yandex Navigator · Implemented</summary>

- [x] Open app (`YandexNavigator.open`)
- [x] View map (`YandexNavigator.view`)
- [x] Search (`YandexNavigator.search`)
- [x] Directions with coordinates (`YandexNavigator.directionsWithCoords`)

</details>

<details>
<summary>Tencent Maps · Implemented</summary>

- [x] Open app (`TencentMaps.open`)
- [x] View map (`TencentMaps.view`)
- [x] Search (`TencentMaps.search`)
- [x] Nearby search (`TencentMaps.nearbySearch`)
- [x] Directions with coordinates (`TencentMaps.directionsWithCoords`)

</details>

</details>

<details>
<summary>Stores (7 stores)</summary>

<details>
<summary>iOS App Store · Implemented</summary>

- [x] Open store (`IOSAppStore.open`)
- [x] Open app page (`IOSAppStore.openAppPage`)
- [x] Rate app (`IOSAppStore.rateApp`)

</details>

<details>
<summary>Mac App Store · Implemented</summary>

- [x] Open store (`MacAppStore.open`)
- [x] Open app page (`MacAppStore.openAppPage`)
- [x] Rate app (`MacAppStore.rateApp`)

</details>

<details>
<summary>Microsoft Store · Implemented</summary>

- [x] Open store (`MicrosoftStore.open`)
- [x] Open app page (`MicrosoftStore.openAppPage`)
- [x] Rate app (`MicrosoftStore.rateApp`)

</details>

<details>
<summary>Google Play Store · Implemented</summary>

- [x] Open store (`PlayStore.open`)
- [x] Open app page (`PlayStore.openAppPage`)

</details>

<details>
<summary>Huawei AppGallery · Implemented</summary>

- [x] Open store (`HuaweiAppGalleryStore.open`)
- [x] Open app page (`HuaweiAppGalleryStore.openAppPage`)

</details>

<details>
<summary>Cafe Bazaar · Implemented</summary>

- [x] Open store (`CafeBazaarStore.open`)
- [x] Open app page (`CafeBazaarStore.openAppPage`)

</details>

<details>
<summary>Myket · Implemented</summary>

- [x] Open store (`MyketStore.open`)
- [x] Open app page (`MyketStore.openAppPage`)
- [x] Rate app (`MyketStore.rateApp`)

</details>

</details>

## 2. Features

<details>
<summary>1. Query installed applications · App discovery · Pending</summary>

List applications installed on the device, including apps outside DeeplinkX's supported catalog. Platform feasibility remains to be assessed.

**Completion criteria:**

- [ ] Assess and document platform feasibility and restrictions.
- [ ] List installed applications on supported platforms, including apps outside DeeplinkX's supported catalog where permitted.

</details>

<details>
<summary>2. Query one supported application · App discovery · Pending</summary>

Look up a supported app and check installation status, building on the existing `isAppInstalled()` capability.

**Completion criteria:**

- [ ] Look up an application in DeeplinkX's supported catalog.
- [ ] Report its installation status using the existing `isAppInstalled()` capability.

</details>

<details>
<summary>3. Launch mail compose · Email · Research</summary>

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fmail-compose-launcher/doc/plans/email/mail_compose_launcher.md) · [Existing draft #88](https://github.com/DeepLinkX/DeeplinkX/pull/88)

Try native actions in caller order, then normal fallbacks; true means a route opened, including stores/sites.

- [ ] Verify platform/source evidence and blockers
- [ ] Run future acceptance scenarios after implementation is authorized

</details>

<details>
<summary>4. Default-mail compose · Email · Research</summary>

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fmail-compose-launcher/doc/plans/email/default_mail_compose.md)

Invoke the configured handler explicitly; keep it separate from named-provider priority lists.

- [ ] Verify platform/source evidence and blockers
- [ ] Run future acceptance scenarios after implementation is authorized

</details>

<details>
<summary>5. Installed mail app discovery/open selection · Email · Research</summary>

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fmail-compose-launcher/doc/plans/email/installed_mail_apps.md)

Research bounded app discovery and opening the chosen provider; do not infer a universal installed-app inventory.

- [ ] Verify platform/source evidence and blockers
- [ ] Run future acceptance scenarios after implementation is authorized

</details>

<details>
<summary>6. Compose with attachments · Email · Research</summary>

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fmail-compose-launcher/doc/plans/email/attachments.md)

Research file transport, grants and lifetime separately from the text-compose contract.

- [ ] Verify platform/source evidence and blockers
- [ ] Run future acceptance scenarios after implementation is authorized

</details>

<details>
<summary>7. Desktop mail launch prerequisites · Email · Research</summary>

[Brief](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fmail-compose-launcher/doc/plans/email/desktop_launch_prerequisites.md)

Verify desktop identity, route and adapter together before enabling a named provider.

- [ ] Verify platform/source evidence and blockers
- [ ] Run future acceptance scenarios after implementation is authorized

</details>

<details>
<summary>Roadmap notes</summary>

**Implemented:** API present in this repository. **Draft:** validation remains. **Pending:** awaiting integration or implementation. **Research:** documentation-only candidate; evidence/adapter/runtime gates remain, and it is excluded from implemented counts.

Checked actions track implementation. Device verification and release readiness follow each app's documentation.

Append new entries to the appropriate queue. Keep the name, category, status, optional PR, and action checklist for apps; use a description and completion criteria for features. App categories follow the README groups.

</details>
