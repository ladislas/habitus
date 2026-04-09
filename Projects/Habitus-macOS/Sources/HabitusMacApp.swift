// Habitus
// Copyright Ladislas de Toldi
// SPDX-License-Identifier: Apache-2.0

import HelloWorld
import SwiftUI

// MARK: - HabitusMacApp

@main
struct HabitusMacApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// MARK: - ContentView

struct ContentView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text(greeting(firstName: nil))
                .font(.title)
            Text(greeting(firstName: "from Habitus macOS app!"))
                .font(.title2)
        }
        .padding()
    }
}
