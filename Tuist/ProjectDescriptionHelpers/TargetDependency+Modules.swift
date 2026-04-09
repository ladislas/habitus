// Habitus
// Copyright Ladislas de Toldi
// SPDX-License-Identifier: Apache-2.0

import ProjectDescription

// MARK: - Module

public enum Module {
    public enum Modules {
        public static let helloWorld = "HelloWorld"
    }
}

// MARK: - Typed dependency helpers

public extension TargetDependency {
    /// Depend on a module's implementation target (use from app targets)
    static func module(_ name: String, path: Path) -> Self {
        .project(target: name, path: path)
    }

    /// Depend on a module's interface target (use from other modules)
    static func moduleInterface(_ name: String, path: Path) -> Self {
        .project(target: "\(name)Interface", path: path)
    }

    /// Depend on a module's testing target (use from test targets)
    static func moduleTesting(_ name: String, path: Path) -> Self {
        .project(target: "\(name)Testing", path: path)
    }
}

// MARK: - HelloWorld convenience

public extension TargetDependency {
    static let helloWorld: Self = .module(
        Module.Modules.helloWorld,
        path: .relativeToRoot("Projects/Modules/HelloWorld")
    )

    static let helloWorldInterface: Self = .moduleInterface(
        Module.Modules.helloWorld,
        path: .relativeToRoot("Projects/Modules/HelloWorld")
    )
}
