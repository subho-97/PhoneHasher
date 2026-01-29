//
//  PhoneHasherApp.swift
//  PhoneHasher
//
//  Native macOS app for phone number hashing
//  Built with SwiftUI
//

import SwiftUI

@main
struct PhoneHasherApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 700, idealWidth: 900, maxWidth: 1400,
                       minHeight: 800, idealHeight: 1000, maxHeight: 1600)
        }
        .windowResizability(.contentSize)
        .commands {
            CommandGroup(replacing: .newItem) {}
        }
    }
}
