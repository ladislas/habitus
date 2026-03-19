# Project Guidelines

## AI Tooling

This project uses [opencode](https://opencode.ai) as the AI coding assistant.

- You are running inside opencode, NOT Claude Code, Cursor, Codex, or any other vendor CLI
- Skills, rules, and workflow configurations live in `.opencode/`
- Do NOT create or suggest `.claude/`, `.cursor/`, or other vendor-specific directories

## OpenSpec

- OpenSpec is available in this repo as the planning layer for meaningful multi-step changes.
- OpenSpec artifacts live under `openspec/` and repo-local commands/skills live under `.opencode/`.
- Use OpenSpec for non-trivial features, refactors, migrations, and ambiguous bugfixes.
- Skip OpenSpec for tiny obvious edits that do not benefit from proposal/spec/task artifacts.
- Commit meaningful OpenSpec artifacts when they preserve rationale, review context, or implementation history.
- Keep the human in the loop: proposal, design, specs, and tasks should guide implementation rather than replace review and manual judgment.

## Tuist

This project uses [Tuist](https://tuist.dev) for Xcode project generation following TMA (The Modular Architecture).

- Each feature module can have up to 5 targets: `Feature`, `FeatureInterface`, `FeatureTests`, `FeatureTesting`, `FeatureExample`
- Modules depend on each other via Interface targets only
- Prefer `buildableFolders` over `sources`/`resources` globs
- Directory convention: `Tuist/` at root for config/helpers/dependencies, `Projects/` for per-module manifests
- Full docs: https://docs.tuist.dev/en/guides/features/projects
- Operational skill with build/test/generation workflows: `.opencode/skills/tuist/SKILL.md`

## Git Commits

This repo uses [gitmoji](https://gitmoji.dev). Commit format:

```text
<emoji> (<topic>): <message>
```

Example: `🎉 (git): Initial commit`

Use the `gitmoji` CLI to find the right emoji: `gitmoji list`

## Git Workflow

### Branch Naming

Branches follow the pattern: `<firstname>/<type>/<topic-more_info>`

- Types: `feature`, `release`, `bugfix`
- Example: `ladislas/feature/dark-mode_ui`

Always create a branch — keep `main` clean.

### Merging

**With a PR** (default for most work):

1. Open a PR for the branch on GitHub
2. From the feature branch, run `git mmnoff`
   - Rebases on the default branch, force-pushes, then merges with `--no-ff`
   - Requires an open PR (command will fail otherwise)

**Without a PR** (small/quick branches):

1. `git checkout main`
2. `git mnoff <branch-name>`
