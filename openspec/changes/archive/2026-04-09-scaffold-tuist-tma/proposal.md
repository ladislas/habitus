## Why

Habitus has no Xcode project structure yet. Before building any product features, we need a Tuist-managed workspace following The Modular Architecture (TMA) so that modules can be developed, tested, and composed independently.

This change scaffolds a minimal but complete TMA setup — two app targets plus one shared validation module — to prove the toolchain end to end before committing to the full module graph.

## What Changes

- Add root `Workspace.swift` including all projects
- Add `Tuist/Config.swift` with Swift 6 strict concurrency and iOS 26.0 / macOS 26.0 deployment targets
- Add `Tuist/Package.swift` with an empty dependency list, ready for future SPM packages
- Add `Tuist/ProjectDescriptionHelpers/` with reusable TMA factory helpers and typed dependency constants
- Scaffold `Projects/Habitus-iOS` — iOS SwiftUI app target (`me.detoldi.ladislas.app.habitus`)
- Scaffold `Projects/Habitus-macOS` — macOS SwiftUI app target (`me.detoldi.ladislas.app.habitus.mac`)
- Scaffold `Projects/Modules/HelloWorld` — shared validation module with full 5-target TMA shape (implementation, interface, tests, testing, example)
- Wire both apps to depend on `HelloWorld` and display its output
- Use `buildableFolders` instead of `sources`/`resources` globs in all targets

## Capabilities

### New Capabilities

- `tuist-workspace`: Root workspace configuration, shared Tuist config, SPM dependency manifest, and ProjectDescriptionHelpers with TMA factory methods and typed dependency constants
- `hello-world-module`: Shared validation module exposing a greeting API, with full TMA target set (implementation, interface, tests, testing, example) to validate the toolchain and TDD workflow

### Modified Capabilities

_None — this is a greenfield scaffold._

## Impact

- **New files**: ~20 manifest and source files across `Tuist/`, `Projects/`, and root `Workspace.swift`
- **Build system**: Tuist becomes the project generation layer; `.xcodeproj`/`.xcworkspace` files are generated artifacts
- **Dependencies**: Both app targets gain a dependency on the `HelloWorld` module
- **No runtime or API changes**: This is infrastructure-only; no product behavior is introduced
- **`.gitignore`**: May need updates for Tuist-generated artifacts (`.xcodeproj`, `.xcworkspace`, `Derived/`)
