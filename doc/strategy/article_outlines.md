# Article Outlines

## Article 1
### Title
How to Build a Multi-Feature Outbound Deep Link Menu in Flutter

### Outline
1. Problem statement: apps rarely have only one outbound action.
2. Pattern: separate handlers for update/support/social/maps.
3. DeeplinkX implementation walkthrough.
4. Fallback strategy choices.
5. Testing and rollout tips.

### Required proof sources
- `doc/recipes/multi_feature_app_menu.md`
- `doc/recipes/fallback_strategy_examples.md`
- `lib/src/core/deeplink_x.dart`

## Article 2
### Title
Flutter Deep Link Fallback Strategies: Native, Store, Web, and No-Fallback Modes

### Outline
1. Why fallback policy matters.
2. How DeeplinkX evaluates launch paths.
3. Examples for each fallback mode.
4. Common mistakes and safe defaults.

### Required proof sources
- `doc/recipes/fallback_strategy_examples.md`
- `doc/apps/telegram.md`
- `doc/apps/google_maps.md`

## Article 3
### Title
Production Playbook for Outbound Deep Linking in Flutter

### Outline
1. Requirements checklist.
2. Provider and action selection.
3. Observability and UX safety checks.
4. Contributor workflow for ongoing maintenance.
5. KPI loop and continuous improvement.

### Required proof sources
- `doc/contributing/docs_quality_checklist.md`
- `doc/strategy/kpi_framework.md`
- `README.md` claim-to-proof map
