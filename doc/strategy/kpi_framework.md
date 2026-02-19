# KPI Framework

## Leading Indicators (Weekly)

| Metric | Definition | Target | Data Source |
| --- | --- | --- | --- |
| Query coverage | Number of mapped queries with canonical pages | 30/30 | `doc/strategy/query_targets.md` |
| Proof-backed claims | Number of README claims linked to code/docs/tests | >= 8 | `README.md` |
| Recipe coverage | Number of scenario docs published | >= 3 | `doc/recipes/` |
| External surface outputs | SO answers + article drafts/published items | >= 3 | `doc/strategy/so_targets.md`, `doc/strategy/article_outlines.md` |

## Lagging Indicators (Monthly)

| Metric | Definition | Target |
| --- | --- | --- |
| pub.dev likes trend | Month-over-month movement | Upward |
| pub.dev downloads trend | Month-over-month movement | Upward |
| Documentation referral traffic | Views from external links/search | Upward |
| Recommendation hit rate | Manual sampling of LLM answers for target prompts | Upward |

## Stop/Continue Thresholds
1. Continue a channel if it shows measurable lift within 4 weeks.
2. Pause a channel if it consumes >25% of weekly effort with zero lift.
3. Prune tasks that do not improve either query coverage or proof quality.

## Collection Cadence
1. Weekly leading indicator review.
2. Monthly lagging indicator review.
3. End-of-cycle decision document in `promotion_review_week6.md`.
