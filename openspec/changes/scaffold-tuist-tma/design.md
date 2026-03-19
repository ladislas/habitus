## Context

Habitus is a greenfield Swift 6 / SwiftUI project with no Xcode project structure yet. The repo contains tooling config (mise, swiftlint, swiftformat) and OpenSpec planning artifacts, but no build manifests or source code.

Tuist 4.161.0 is pinned via mise. The local toolchain is Xcode 26.3 with iOS 26.2 and macOS 26.2 SDKs, so iOS 26.0 / macOS 26.0 deployment targets are supported.

## Goals / Non-Goals

**Goals:**

- Establish a Tuist-managed workspace with TMA conventions from day one
- Validate the full toolchain: generation, build, test, and run
- Prove the TMA 5-target module pattern works (implementation, interface, tests, testing, example)
- Create reusable ProjectDescriptionHelpers that future modules and features will use
- Use `buildableFolders` exclusively — no `sources`/`resources` globs

**Non-Goals:**

- Scaffold any product modules or features beyond the validation `HelloWorld` module
- Implement menu-bar-only behavior for the macOS app
- Add any SPM dependencies
- Set up CI pipelines or caching

## Decisions

### 1. Directory layout

```
Workspace.swift
Tuist/
  Config.swift
  Package.swift
  ProjectDescriptionHelpers/
    Project+Templates.swift
    TargetDependency+Modules.swift
Projects/
  Habitus-iOS/
    Project.swift
    Sources/
      HabitusApp.swift
    Resources/
      Assets.xcassets/
  Habitus-macOS/
    Project.swift
    Sources/
      HabitusMacApp.swift
  Modules/
    HelloWorld/
      Project.swift
      Sources/
      Interface/Sources/
      Tests/Sources/
      Testing/Sources/
      Example/Sources/
```

**Rationale:** Follows Tuist's recommended directory structure with `Projects/` for per-module manifests and `Tuist/` for shared config. App targets get their own top-level project directories. Modules live under `Projects/Modules/`. Features will later live under `Projects/Features/`.

### 2. Hyphenated project and target names

Use `Habitus-iOS` and `Habitus-macOS` for both folder names and target/scheme names.

**Rationale:** Clear, explicit naming. If Tuist or Xcode has issues with hyphens in generated schemes, we adjust during implementation — not preemptively.

### 3. Config.swift for shared settings

Centralize Swift 6, strict concurrency, and deployment targets in `Tuist/Config.swift`. Individual `Project.swift` files inherit these via the helper templates.

**Rationale:** Single source of truth. Prevents drift as more modules are added.

**Alternative considered:** Per-project settings only. Rejected because it creates duplication and drift risk as the module count grows.

### 4. ProjectDescriptionHelpers with factory methods

Two helper files:

- `Project+Templates.swift` — `module()` and `app()` factory methods that produce standard target sets
- `TargetDependency+Modules.swift` — typed constants for every module, encoding the TMA dependency rules (depend on interfaces, not implementations)

**Rationale:** Enforces TMA conventions at the manifest level. Adding a new module means adding one constant and calling one factory method.

**Alternative considered:** Inline target definitions per `Project.swift`. Rejected because it makes the TMA pattern easy to violate accidentally.

### 5. buildableFolders everywhere

All targets use `buildableFolders` instead of `sources`/`resources` globs.

**Rationale:** Stays in sync with the filesystem without regeneration. This is Tuist's recommended approach for Xcode 16+ synced folders.

### 6. HelloWorld as a full 5-target TMA module

Even though the module is trivial, it exercises all five TMA targets to validate:

- Interface/implementation separation
- Test target depending on implementation + testing support
- Testing target providing shared fixtures
- Example app consuming the module in isolation

**Rationale:** Proves the helper templates and dependency graph work correctly before committing to real product modules.

### 7. Both apps as regular SwiftUI apps

`Habitus-iOS` targets `.iPhone` destination. `Habitus-macOS` targets `.mac` destination. Both are `.app` product type. No menu-bar-only (`LSUIElement`) behavior yet.

**Rationale:** Keep the scaffold simple. Menu-bar behavior is a product decision deferred to a later change.

## Risks / Trade-offs

- **[Hyphenated names may cause Xcode scheme issues]** → If schemes break with hyphens, rename targets to camelCase while keeping folder names hyphenated. Low risk — Tuist generally handles this fine.
- **[iOS/macOS 26.0 deployment targets are bleeding-edge]** → Local SDKs support 26.2, so generation and build should work. CI may need matching Xcode. Mitigation: this change is local-only validation.
- **[buildableFolders requires Xcode 16+]** → We are on Xcode 26.3, so this is not a concern.
- **[Empty Package.swift may cause tuist install warnings]** → Acceptable for now; the file establishes the pattern for adding packages later.
