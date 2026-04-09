// Habitus
// Copyright Ladislas de Toldi
// SPDX-License-Identifier: Apache-2.0

import ProjectDescription

// MARK: - Habitus

public enum Habitus {
    public static let bundlePrefix = "me.detoldi.ladislas.app.habitus"
    public static let iOSVersion = "26.0"
    public static let macOSVersion = "26.0"

    public static let baseSettings: SettingsDictionary = [
        "SWIFT_VERSION": "6.0",
        "SWIFT_STRICT_CONCURRENCY": "complete",
    ]
}

// MARK: - App factory

public extension Project {
    static func app(
        name: String,
        bundleId: String,
        destinations: Destinations,
        dependencies: [TargetDependency] = [],
        additionalTargets: [Target] = []
    )
        -> Project
    {
        let deploymentTargets: DeploymentTargets = .multiplatform(
            iOS: destinations.contains(.iPhone) ? Habitus.iOSVersion : nil,
            macOS: destinations.contains(.mac) ? Habitus.macOSVersion : nil
        )

        var targets: [Target] = [
            .target(
                name: name,
                destinations: destinations,
                product: .app,
                bundleId: bundleId,
                deploymentTargets: deploymentTargets,
                infoPlist: .default,
                buildableFolders: [
                    .folder("Sources"),
                    .folder("Resources"),
                ],
                dependencies: dependencies
            ),
        ]
        targets.append(contentsOf: additionalTargets)

        return Project(
            name: name,
            settings: .settings(base: Habitus.baseSettings),
            targets: targets
        )
    }
}

// MARK: - Module factory

public extension Project {
    static func module(
        name: String,
        destinations: Destinations = [.iPhone, .mac],
        dependencies: [TargetDependency] = [],
        hasTests: Bool = true,
        hasTesting: Bool = true,
        hasExample: Bool = true
    )
        -> Project
    {
        let bundlePrefix = "\(Habitus.bundlePrefix).modules.\(name.lowercased())"
        let deploymentTargets: DeploymentTargets = .multiplatform(
            iOS: destinations.contains(.iPhone) ? Habitus.iOSVersion : nil,
            macOS: destinations.contains(.mac) ? Habitus.macOSVersion : nil
        )

        var targets: [Target] = []

        // Interface target
        targets.append(
            .target(
                name: "\(name)Interface",
                destinations: destinations,
                product: .framework,
                bundleId: "\(bundlePrefix).interface",
                deploymentTargets: deploymentTargets,
                infoPlist: .default,
                buildableFolders: [
                    .folder("Interface/Sources"),
                ]
            )
        )

        // Implementation target
        targets.append(
            .target(
                name: name,
                destinations: destinations,
                product: .staticFramework,
                bundleId: bundlePrefix,
                deploymentTargets: deploymentTargets,
                infoPlist: .default,
                buildableFolders: [
                    .folder("Sources"),
                ],
                dependencies: [
                    .target(name: "\(name)Interface"),
                ] + dependencies
            )
        )

        // Testing target
        if hasTesting {
            targets.append(
                .target(
                    name: "\(name)Testing",
                    destinations: destinations,
                    product: .staticFramework,
                    bundleId: "\(bundlePrefix).testing",
                    deploymentTargets: deploymentTargets,
                    infoPlist: .default,
                    buildableFolders: [
                        .folder("Testing/Sources"),
                    ],
                    dependencies: [
                        .target(name: "\(name)Interface"),
                    ]
                )
            )
        }

        // Tests target
        if hasTests {
            var testDependencies: [TargetDependency] = [
                .target(name: name),
            ]
            if hasTesting {
                testDependencies.append(.target(name: "\(name)Testing"))
            }

            targets.append(
                .target(
                    name: "\(name)Tests",
                    destinations: destinations,
                    product: .unitTests,
                    bundleId: "\(bundlePrefix).tests",
                    deploymentTargets: deploymentTargets,
                    infoPlist: .default,
                    buildableFolders: [
                        .folder("Tests/Sources"),
                    ],
                    dependencies: testDependencies
                )
            )
        }

        // Example app target
        if hasExample {
            var exampleDependencies: [TargetDependency] = [
                .target(name: name),
            ]
            if hasTesting {
                exampleDependencies.append(.target(name: "\(name)Testing"))
            }

            targets.append(
                .target(
                    name: "\(name)Example",
                    destinations: destinations,
                    product: .app,
                    bundleId: "\(bundlePrefix).example",
                    deploymentTargets: deploymentTargets,
                    infoPlist: .default,
                    buildableFolders: [
                        .folder("Example/Sources"),
                    ],
                    dependencies: exampleDependencies
                )
            )
        }

        return Project(
            name: name,
            settings: .settings(base: Habitus.baseSettings),
            targets: targets
        )
    }
}
