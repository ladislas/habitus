// Habitus
// Copyright Ladislas de Toldi
// SPDX-License-Identifier: Apache-2.0

import HelloWorld
import HelloWorldTesting
import Testing

struct GreetingTests {
    @Test("returns default greeting when firstName is nil")
    func greetingWithNil() {
        #expect(greeting(firstName: nil) == "Hello, world!")
    }

    @Test("returns default greeting when firstName is empty")
    func greetingWithEmpty() {
        #expect(greeting(firstName: HelloWorldFixtures.emptyFirstName) == "Hello, world!")
    }

    @Test("returns personalized greeting when firstName is provided")
    func greetingWithName() {
        #expect(greeting(firstName: HelloWorldFixtures.sampleFirstName) == "Hello, Ladislas!")
    }
}
