// Habitus
// Copyright Ladislas de Toldi
// SPDX-License-Identifier: Apache-2.0

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.app(
    name: "Habitus-macOS",
    bundleId: "\(Habitus.bundlePrefix).mac",
    destinations: [.mac],
    dependencies: [
        .helloWorld,
    ]
)
