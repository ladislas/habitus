## ADDED Requirements

### Requirement: Greeting API with optional first name

The `HelloWorld` module SHALL expose a public function `greeting(firstName: String?) -> String` that returns a personalized greeting.

#### Scenario: No first name provided

- **WHEN** `greeting(firstName: nil)` is called
- **THEN** the return value is `"Hello, world!"`

#### Scenario: Empty first name provided

- **WHEN** `greeting(firstName: "")` is called
- **THEN** the return value is `"Hello, world!"`

#### Scenario: First name provided

- **WHEN** `greeting(firstName: "Ladislas")` is called
- **THEN** the return value is `"Hello, Ladislas!"`

### Requirement: Public API defined in interface target

The `greeting` function signature SHALL be declared in `HelloWorldInterface` and implemented in `HelloWorld`.

#### Scenario: Interface target compiles independently

- **WHEN** `HelloWorldInterface` is built in isolation
- **THEN** the build succeeds without depending on `HelloWorld` implementation

### Requirement: Full TMA 5-target shape

The `HelloWorld` module SHALL include all five TMA targets: `HelloWorld`, `HelloWorldInterface`, `HelloWorldTests`, `HelloWorldTesting`, `HelloWorldExample`.

#### Scenario: All five targets exist after generation

- **WHEN** the workspace is generated
- **THEN** schemes for `HelloWorld`, `HelloWorldInterface`, `HelloWorldTests`, `HelloWorldTesting`, and `HelloWorldExample` are available

### Requirement: Tests cover greeting behavior

`HelloWorldTests` SHALL contain unit tests verifying the greeting function for nil, empty, and non-empty first name inputs.

#### Scenario: Tests pass

- **WHEN** tests for the `HelloWorld` module are run
- **THEN** all tests pass

### Requirement: Testing target provides sample data

`HelloWorldTesting` SHALL provide at least one sample fixture (e.g., a sample first name) that `HelloWorldTests` and `HelloWorldExample` can use.

#### Scenario: Tests use shared fixture

- **WHEN** `HelloWorldTests` references a sample name from `HelloWorldTesting`
- **THEN** the test compiles and uses the shared fixture

### Requirement: Example app displays greeting

`HelloWorldExample` SHALL be a minimal SwiftUI app that displays the greeting from the `HelloWorld` module.

#### Scenario: Example app launches and shows greeting

- **WHEN** the `HelloWorldExample` app is built and launched
- **THEN** it displays a greeting string from the `HelloWorld` module

### Requirement: Both apps display the greeting

Both `Habitus-iOS` and `Habitus-macOS` SHALL import `HelloWorld` and display the greeting on their main screen.

#### Scenario: iOS app shows greeting

- **WHEN** the iOS app launches
- **THEN** it displays a greeting from the `HelloWorld` module

#### Scenario: macOS app shows greeting

- **WHEN** the macOS app launches
- **THEN** it displays a greeting from the `HelloWorld` module
