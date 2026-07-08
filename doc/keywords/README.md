# Keyword Reports

This directory tracks pub.dev keyword visibility snapshots for `deeplink_x`.

## Report Index

| Date or range | Report | Purpose |
| --- | --- | --- |
| 2026-07-01 | [pubdev_keyword_visibility_report_2026-07-01.md](pubdev_keyword_visibility_report_2026-07-01.md) | Baseline keyword visibility snapshot before the refreshed publish. |
| 2026-07-06 | [pubdev_keyword_visibility_report_2026-07-06.md](pubdev_keyword_visibility_report_2026-07-06.md) | Current keyword visibility snapshot after the refreshed publish. |
| 2026-07-01 to 2026-07-06 | [pubdev_keyword_comparison_2026-07-01_to_2026-07-06.md](pubdev_keyword_comparison_2026-07-01_to_2026-07-06.md) | Ranking movement, wins, regressions, and net assessment. |

## Refresh Checklist

- Use date-stamped filenames with `YYYY-MM-DD`.
- Fetch current pub.dev package metadata, score data, rendered package page, and rendered score page before writing a new snapshot.
- Re-scan the same keyword groups from the previous report so comparisons stay meaningful.
- Derive app-specific keywords from the current supported app list in `README.md` and every `doc/apps/*.md` page before scanning.
- Include newly added apps and navigation providers in the app matrix, even when their pub.dev publish is still pending.
- For each supported app, scan at least `{app}`, `{app} link`, `{app} deeplink`, and human-style phrases such as `open {app} from Flutter`.
- For map and navigation providers, also scan search, directions, coordinates, and provider-specific navigation phrases.
- When new provider support lands after a dated report, add the provider to this index immediately and capture rankings in the next snapshot.
- Include expanded human-search phrases and Medium-derived article phrases.
- Wait through pub.dev rate limits with retry/backoff; do not mark queries skipped only because of rate limiting.
- Create a comparison report whenever a prior snapshot exists.

Current supported app keyword coverage baseline: Facebook, Instagram, Telegram, WhatsApp, LinkedIn, YouTube, Twitter, Threads, Pinterest, TikTok, Zoom, Slack, Google Maps, Amap, Baidu Maps, Waze, Apple Maps, Sygic, Moovit, and Neshan.

Next snapshot note: include Baidu Maps plain-name, link, deeplink, search, directions, coordinates, nearby search, transit line, and native navigation queries.
