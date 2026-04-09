## ADDED Requirements

### Requirement: Root workspace includes all projects

The workspace SHALL include all projects under `Projects/` so that a single `tuist generate` produces a unified `.xcworkspace`.

#### Scenario: Generation produces a workspace

- **WHEN** `tuist generate --no-open` is run from the repo root
- **THEN** an Xcode workspace is generated containing `Habitus-iOS`, `Habitus-macOS`, and `HelloWorld` projects

### Requirement: Shared Tuist configuration

`Tuist/Config.swift` SHALL set Swift 6 language version, strict concurrency (`complete`), and deployment targets of iOS 26.0 and macOS 26.0 for all projects.

#### Scenario: All targets inherit Swift 6 strict concurrency

- **WHEN** the workspace is generated
- **THEN** every target's build settings include `SWIFT_VERSION = 6.0` and `SWIFT_STRICT_CONCURRENCY = complete`

#### Scenario: Deployment targets are set

- **WHEN** the workspace is generated
- **THEN** iOS targets use a minimum deployment target of 26.0 and macOS targets use a minimum deployment target of 26.0

### Requirement: SPM dependency manifest exists

`Tuist/Package.swift` SHALL exist with an empty dependency list so that `tuist install` succeeds and future packages can be added without structural changes.

#### Scenario: tuist install succeeds with no packages

- **WHEN** `tuist install` is run
- **THEN** the command completes without error

### Requirement: ProjectDescriptionHelpers provide TMA factories

`Tuist/ProjectDescriptionHelpers/` SHALL contain helper functions for creating module and app projects following TMA conventions.

#### Scenario: Module factory creates standard TMA targets

- **WHEN** a `Project.swift` calls the module factory with a name and dependencies
- **THEN** it produces up to 5 targets (implementation, interface, tests, testing, example) using `buildableFolders`

#### Scenario: App factory creates an app target

- **WHEN** a `Project.swift` calls the app factory with a name, bundle ID, and dependencies
- **THEN** it produces an `.app` target using `buildableFolders`

### Requirement: Typed dependency constants

`Tuist/ProjectDescriptionHelpers/TargetDependency+Modules.swift` SHALL provide typed constants for every module, encoding the TMA rule that modules depend on interfaces.

#### Scenario: Feature depends on module interface

- **WHEN** a target declares a dependency using the typed constant
- **THEN** the dependency resolves to the module's interface target, not its implementation

### Requirement: All targets use buildableFolders

Every target in the workspace SHALL use `buildableFolders` instead of `sources` or `resources` globs.

#### Scenario: No sources/resources globs in manifests

- **WHEN** any `Project.swift` is inspected
- **THEN** no target uses `sources:` or `resources:` parameters; all use `buildableFolders:`

### Requirement: iOS app target

`Projects/Habitus-iOS/` SHALL define an iOS SwiftUI app target with bundle ID `me.detoldi.ladislas.app.habitus`.

#### Scenario: iOS app builds for simulator

- **WHEN** the iOS app is built targeting the iOS Simulator
- **THEN** the build succeeds

### Requirement: macOS app target

`Projects/Habitus-macOS/` SHALL define a macOS SwiftUI app target with bundle ID `me.detoldi.ladislas.app.habitus.mac`.

#### Scenario: macOS app builds for host

- **WHEN** the macOS app is built targeting the local Mac
- **THEN** the build succeeds

### Requirement: .gitignore updated for Tuist artifacts

The `.gitignore` SHALL include entries for Tuist-generated artifacts (`*.xcodeproj`, `*.xcworkspace`, `Derived/`).

#### Scenario: Generated Xcode artifacts are ignored

- **WHEN** `tuist generate` creates `.xcodeproj` and `.xcworkspace` files
- **THEN** `git status` does not show them as untracked
