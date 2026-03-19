## 1. Shared Tuist config, workspace, and helpers

- [ ] 1.1 Create `Tuist/Config.swift` with Swift 6, strict concurrency, and iOS 26.0 / macOS 26.0 deployment targets
- [ ] 1.2 Create `Tuist/Package.swift` with empty dependency list
- [ ] 1.3 Create `Tuist/ProjectDescriptionHelpers/Project+Templates.swift` with `module()` and `app()` factory methods using `buildableFolders`
- [ ] 1.4 Create `Tuist/ProjectDescriptionHelpers/TargetDependency+Modules.swift` with typed `HelloWorld` dependency constants
- [ ] 1.5 Create root `Workspace.swift` including `Projects/Habitus-iOS`, `Projects/Habitus-macOS`, and `Projects/Modules/**`
- [ ] 1.6 Update `.gitignore` to exclude Tuist-generated artifacts (`*.xcodeproj`, `*.xcworkspace`, `Derived/`)

## 2. Scaffold Habitus-iOS and Habitus-macOS app targets

- [ ] 2.1 Create `Projects/Habitus-iOS/Project.swift` using the app factory with bundle ID `me.detoldi.ladislas.app.habitus` and iOS destination
- [ ] 2.2 Create `Projects/Habitus-iOS/Sources/HabitusApp.swift` with a SwiftUI `@main` entry point that displays the `HelloWorld` greeting
- [ ] 2.3 Create `Projects/Habitus-iOS/Resources/Assets.xcassets/Contents.json` with a minimal valid asset catalog
- [ ] 2.4 Create `Projects/Habitus-macOS/Project.swift` using the app factory with bundle ID `me.detoldi.ladislas.app.habitus.mac` and macOS destination
- [ ] 2.5 Create `Projects/Habitus-macOS/Sources/HabitusMacApp.swift` with a SwiftUI `@main` entry point that displays the `HelloWorld` greeting

## 3. Scaffold full HelloWorld TMA module

- [ ] 3.1 Create `Projects/Modules/HelloWorld/Project.swift` using the module factory with all 5 TMA targets
- [ ] 3.2 Create `Projects/Modules/HelloWorld/Interface/Sources/Greeting.swift` with the public `greeting(firstName:)` function signature
- [ ] 3.3 Create `Projects/Modules/HelloWorld/Sources/Greeting.swift` with the implementation
- [ ] 3.4 Create `Projects/Modules/HelloWorld/Testing/Sources/HelloWorldFixtures.swift` with sample test data
- [ ] 3.5 Create `Projects/Modules/HelloWorld/Tests/Sources/GreetingTests.swift` with tests for nil, empty, and non-empty first name
- [ ] 3.6 Create `Projects/Modules/HelloWorld/Example/Sources/HelloWorldExampleApp.swift` with a minimal SwiftUI app displaying the greeting

## 4. Generate, test, and build to validate toolchain

- [ ] 4.1 Run `mise run generate` (which runs `tuist install` then `tuist generate --no-open`) and fix any manifest errors until generation succeeds cleanly
- [ ] 4.2 Run `HelloWorld` tests and confirm all pass
- [ ] 4.3 Build `Habitus-iOS` for the iOS Simulator and confirm success
- [ ] 4.4 Build `Habitus-macOS` for the local Mac and confirm success
- [ ] 4.5 Build `HelloWorldExample` and confirm success
