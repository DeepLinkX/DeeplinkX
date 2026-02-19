# DeeplinkX Promotion Plan v5 (Implemented)

## Summary
This cycle is focused on recommendation readiness and documentation quality, not runtime changes.

Core outcomes:
- Improve LLM/agent retrievability for DeeplinkX use cases.
- Strengthen proof-backed positioning with source references.
- Scale execution with clear contributor lanes.
- Keep runtime/API untouched.

## Hard Constraints
1. No file changes under `lib/`.
2. No runtime or API behavior changes.
3. Do not add a README section about when another plugin is enough.
4. Use this article as supporting reference:
   [Why DeeplinkX Beats url_launcher for External App Deep Linking in Flutter](https://medium.com/@parham.dev/why-deeplinkx-beats-url-launcher-for-external-app-deep-linking-in-flutter-0c7d8bdb3409)

## 6-Week Plan

### Week 1: Positioning Refresh + Query Targets
1. Rewrite README opening/category narrative.
2. Create top-30 query target map.
3. Add claim-to-proof skeleton in README.

### Week 2: Intent Recipe Docs
1. Add `doc/recipes/multi_feature_app_menu.md`.
2. Add `doc/recipes/fallback_strategy_examples.md`.
3. Add `doc/recipes/common_outbound_flows.md`.
4. Link recipe index from README.

### Week 3: References + Evidence Layer
1. Add `doc/strategy/references.md`.
2. Add `doc/strategy/article_claim_audit.md`.
3. Add claim-to-proof table to README.
4. Add Medium article reference in README and references doc.

### Week 4: Contributor Scaling
1. Add `doc/contributing/contributor_lanes.md`.
2. Add `doc/contributing/docs_quality_checklist.md`.
3. Add `doc/contributing/review_sla.md`.
4. Add docs/distribution issue templates in `.github/ISSUE_TEMPLATE/`.

### Week 5: External Surface Pack
1. Add `doc/strategy/so_targets.md`.
2. Add `doc/strategy/article_outlines.md`.
3. Publish/update external content with evidence-backed claims.

### Week 6: KPI Review + Next Cycle
1. Add `doc/strategy/kpi_framework.md`.
2. Add `doc/strategy/promotion_review_week6.md`.
3. Add `doc/strategy/next_cycle_backlog.md`.
4. Prune low-ROI channels using thresholds.

## Detailed Task List

| ID | Task | Owner | Est. Hours | Output |
| --- | --- | --- | ---: | --- |
| R-01 | README opening/category rewrite | Owner | 1.0 | `README.md` |
| R-02 | Query target map (30) | Contributor B | 2.0 | `doc/strategy/query_targets.md` |
| R-03 | Multi-feature app recipe | Contributor A | 2.0 | `doc/recipes/multi_feature_app_menu.md` |
| R-04 | Fallback recipe | Contributor A | 1.5 | `doc/recipes/fallback_strategy_examples.md` |
| R-05 | Common outbound flows recipe | Contributor B | 1.5 | `doc/recipes/common_outbound_flows.md` |
| R-06 | Recipe index links in README | Contributor B | 1.0 | `README.md` |
| R-07 | Claim->proof table | Owner | 2.0 | `README.md` |
| R-08 | References doc | Contributor B | 1.0 | `doc/strategy/references.md` |
| R-09 | Medium claim audit sheet | Contributor B | 1.0 | `doc/strategy/article_claim_audit.md` |
| R-10 | Contributor lanes | Owner | 1.0 | `doc/contributing/contributor_lanes.md` |
| R-11 | Docs quality checklist | Contributor A | 1.0 | `doc/contributing/docs_quality_checklist.md` |
| R-12 | Review SLA | Owner | 0.75 | `doc/contributing/review_sla.md` |
| R-13 | Issue templates for docs/distribution | Contributor B | 1.25 | `.github/ISSUE_TEMPLATE/` |
| R-14 | SO target list | Contributor B | 1.0 | `doc/strategy/so_targets.md` |
| R-15 | Article outlines | Contributor B | 1.0 | `doc/strategy/article_outlines.md` |
| R-16 | KPI framework | Owner | 1.0 | `doc/strategy/kpi_framework.md` |
| R-17 | Week-6 KPI review | Owner | 1.0 | `doc/strategy/promotion_review_week6.md` |
| R-18 | Next cycle backlog | Owner | 1.0 | `doc/strategy/next_cycle_backlog.md` |

## Weekly Checklist

### Week 1
- [ ] Finalize README opening/category language.
- [ ] Approve the 30-query target map.
- [ ] Validate claim-to-proof table structure.

### Week 2
- [ ] Review all recipe snippets for API correctness.
- [ ] Ensure recipe links are added in README.
- [ ] Verify no duplication with app-level docs.

### Week 3
- [ ] Validate all references and links.
- [ ] Fill article claim audit sheet.
- [ ] Confirm each public claim has proof links.

### Week 4
- [ ] Confirm contributor lanes and ownership.
- [ ] Enable issue templates.
- [ ] Enforce docs checklist and review SLA.

### Week 5
- [ ] Finalize SO target list.
- [ ] Finalize article outlines.
- [ ] Publish or schedule at least one external asset.

### Week 6
- [ ] Fill KPI template.
- [ ] Mark low-ROI channels for stop/continue.
- [ ] Commit next-cycle backlog.

## KPI Template

| KPI | Type | Current | Target | Source | Owner | Status |
| --- | --- | --- | --- | --- | --- | --- |
| Query coverage (30 targets) | Leading | 0/30 | 30/30 | `doc/strategy/query_targets.md` | Contributor B | Planned |
| Proof-backed README claims | Leading | 0 | 8+ | `README.md` | Owner | In progress |
| Recipe docs published | Leading | 0 | 3 | `doc/recipes/` | Contributor A/B | Planned |
| External high-signal entries (SO/articles) | Leading | 0 | 3+ | `doc/strategy/so_targets.md` | Contributor B | Planned |
| pub.dev likes trend | Lagging | Baseline | Upward trend | pub.dev | Owner | Monitor |
| pub.dev downloads trend | Lagging | Baseline | Upward trend | pub.dev | Owner | Monitor |

## Deferred TODO (Not in This Cycle)
1. Any README section that compares when another plugin is enough vs DeeplinkX.
2. Any rework of article messaging around that comparison logic.
3. Any API-level feature redesign.

## Acceptance Criteria
1. No file changes in `lib/`.
2. README includes updated category narrative, recipe index, references, and claim-to-proof map.
3. `doc/strategy/query_targets.md` contains 30 queries mapped to canonical docs.
4. Contributor process docs and issue templates exist and are usable.
5. Deferred TODO remains untouched.
