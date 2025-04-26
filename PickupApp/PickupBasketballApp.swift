//
//  PickupAppApp.swift
//  PickupApp
//
//  Created by Christian Kim on 4/25/25.
//

import SwiftUI

@main
struct PickupBasketballApp: App { // Rename YourAppNameApp to match your project
    // Create the GameStore once using @StateObject so it persists
    @StateObject private var gameStore = GameStore()
    // Read the setup completion flag from UserDefaults using @AppStorage
    @AppStorage("hasCompletedSetup") private var hasCompletedSetup: Bool = false

    // Removed Firebase AppDelegate setup

    var body: some Scene {
        WindowGroup {
            // The main view of your app
            CourtListView()
                // Inject the GameStore into the SwiftUI environment
                .environmentObject(gameStore)
                // Use a full screen cover that appears ONLY if setup isn't complete
                .fullScreenCover(isPresented: .constant(!hasCompletedSetup)) {
                    // Present the profile setup view
                    ProfileSetupView()
                        // Prevent interactive dismissal; must complete setup
                        .interactiveDismissDisabled()
                }
        }
    }
}

