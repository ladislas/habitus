// Habitus
// Copyright Ladislas de Toldi
// SPDX-License-Identifier: Apache-2.0

import HelloWorld
import HelloWorldTesting
import SwiftUI

@main
struct HelloWorldExampleApp: App {
    var body: some Scene {
        WindowGroup {
            VStack(spacing: 16) {
                Text(greeting(firstName: nil))
                    .font(.title)
                Text(greeting(firstName: HelloWorldFixtures.sampleFirstName))
                    .font(.title2)
            }
            .padding()
        }
    }
}
