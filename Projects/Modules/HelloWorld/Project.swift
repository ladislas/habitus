// Habitus
// Copyright Ladislas de Toldi
// SPDX-License-Identifier: Apache-2.0

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: "HelloWorld",
    destinations: [.iPhone, .mac],
    hasTests: true,
    hasTesting: true,
    hasExample: true
)
