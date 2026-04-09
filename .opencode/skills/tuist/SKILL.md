---
name: tuist
description: Guides day-to-day work in Tuist-generated Xcode workspaces, including generation, build and test commands, TMA module conventions, and troubleshooting. Use when working with Tuist manifests, generating projects, or building/testing with xcodebuild.
metadata:
  author: habitus
  version: "1.0"
---

# Using Tuist in this project

## Quick start

```bash
# Install dependencies (run when Package.swift or dependency graph changes)
tuist install

# Generate workspace without opening Xcode
tuist generate --no-open

# Generate only specific targets or tags
tuist generate tag:feature:payments
tuist generate PaymentsUI PaymentsTests
```

## Build with xcodebuild

Use `xcodebuild build` against the generated workspace and scheme:

```bash
xcodebuild build \
  -workspace App.xcworkspace \
  -scheme App \
  -destination "generic/platform=iOS Simulator"
```

## Test with xcodebuild

Prefer `xcodebuild test` over `tuist test` — `tuist test` regenerates the project on each invocation, which slows down iteration.

To optimize test run time:

- Use `--only-testing` to run only the specific test suite or case you're working on
- Pick the scheme with the fewest compilation targets that still includes your test target

```bash
# Run a specific test suite
xcodebuild test \
  -workspace App.xcworkspace \
  -scheme AppTests \
  -only-testing AppTests/MyTestSuite

# Run a single test case
xcodebuild test \
  -workspace App.xcworkspace \
  -scheme AppTests \
  -only-testing AppTests/MyTestSuite/testMyFunction
```

## TMA module structure

Each feature module can have up to 5 targets:

| Target             | Dependencies                | Content                           |
| ------------------ | --------------------------- | --------------------------------- |
| `Feature`          | `FeatureInterface`          | Source code and resources          |
| `FeatureInterface` | —                           | Public interface and models        |
| `FeatureTests`     | `Feature`, `FeatureTesting` | Unit and integration tests         |
| `FeatureTesting`   | `FeatureInterface`          | Testing data and mocks             |
| `FeatureExample`   | `FeatureTesting`, `Feature` | Example app for trying the feature |

Key rules:

- Modules depend on other modules via their **Interface** target only
- This decouples implementations and speeds up clean builds
- Apps wire the implementation graph at runtime via dependency injection

## Project definition conventions

- **Prefer `buildableFolders`** over `sources`/`resources` globs — they stay in sync with the filesystem without regeneration
- **Use target tags** for focused generation: `tag:team:*`, `tag:feature:*`, `tag:layer:*`
- **Align build configurations** between the project and external dependencies using `PackageSettings`

## Directory structure

```text
Tuist.swift                          # Shared Tuist configuration
Tuist/
  Package.swift                      # Swift Package dependencies
  ProjectDescriptionHelpers/         # Shared Swift code for manifests
Projects/
  App/
    Project.swift                    # App target manifest
  Feature/
    Project.swift                    # Feature module manifest
Workspace.swift                      # Workspace definition (optional)
```

## Troubleshooting

- **Generation fails with missing products**: Run `tuist install` first, then retry `tuist generate`
- **Static side effects warnings**: Adjust product types deliberately. Prefer static products when they don't introduce side effects. Use `Target.product` for local targets, `PackageSettings(productTypes:)` for external ones
- **Objective-C dependency crashes**: Add `-ObjC` or `-force_load` via `OTHER_LDFLAGS` on consuming targets

## References

- Full docs: https://docs.tuist.dev/en/guides/features/projects
- TMA architecture: https://docs.tuist.dev/en/guides/features/projects/tma-architecture
- Directory structure: https://docs.tuist.dev/en/guides/features/projects/directory-structure
- Dependencies: https://docs.tuist.dev/en/guides/features/projects/dependencies
- Manifests: https://docs.tuist.dev/en/guides/features/projects/manifests
