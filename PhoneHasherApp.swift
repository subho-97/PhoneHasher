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
                .frame(minWidth: 800, minHeight: 950)
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
    }
}
