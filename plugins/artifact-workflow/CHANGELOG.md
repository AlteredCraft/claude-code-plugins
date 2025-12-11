# Changelog

All notable changes to the artifact-workflow plugin will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.1] - 2025-12-11

### Added
- **Phase 3.5: ADR Review Gate** - Mandatory systematic review for architectural decisions before build completion
- **Example scenarios** in adr-manager skill with ✅/❌ indicators for decision criteria

### Changed
- Simplified build command by consolidating ADR guidance in adr-manager skill (~40 lines removed)
- Made context links mandatory in all ADR entries
- Updated Key Principles to emphasize mandatory ADR review

[Full details in commit 0c66070](https://github.com/AlteredCraft/claude-code-plugins/commit/0c66070)

## [1.0.0] - Initial Release

Initial release of artifact-workflow plugin with:
- `/build` command for artifact-driven development workflow
- Four-phase workflow: Interrogation, Planning, Execution, Completion
- Three per-build artifacts: todo.md, implementation-plan.md, walkthrough.md
- Shared ADR.md for architecture decision records
- Skills: task-list-creator, implementation-plan-creator, walkthrough-creator, adr-manager
- Mandatory approval gates between phases
