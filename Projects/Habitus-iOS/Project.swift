// Habitus
// Copyright Ladislas de Toldi
// SPDX-License-Identifier: Apache-2.0

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.app(
    name: "Habitus-iOS",
    bundleId: "\(Habitus.bundlePrefix)",
    destinations: [.iPhone],
    dependencies: [
        .helloWorld,
    ]
)
