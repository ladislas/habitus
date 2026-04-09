// Habitus
// Copyright Ladislas de Toldi
// SPDX-License-Identifier: Apache-2.0

import HelloWorld
import SwiftUI

// MARK: - HabitusApp

@main
struct HabitusApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// MARK: - ContentView

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.teal
                .ignoresSafeArea()

            VStack(spacing: 16) {
                Text(greeting(firstName: nil))
                    .font(.title)
                Text(greeting(firstName: "from Habitus iOS app!"))
                    .font(.title2)
            }
        }
    }
}

#Preview {
    ContentView()
}
