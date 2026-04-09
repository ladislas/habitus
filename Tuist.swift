// Habitus
// Copyright Ladislas de Toldi
// SPDX-License-Identifier: Apache-2.0

import ProjectDescription

let tuist = Tuist(
    project: .tuist(
        generationOptions: .options(
            enforceExplicitDependencies: true
        )
    )
)
