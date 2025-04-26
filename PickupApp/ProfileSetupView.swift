//
//  ProfileSetupView.swift
//  PickupApp
//
//  Created by Christian Kim on 4/25/25.
//

import SwiftUI

struct ProfileSetupView: View {
    @AppStorage("username") private var username: String = ""
    @AppStorage("hasCompletedSetup") private var hasCompletedSetup: Bool = false

    @State private var enteredUsername: String = ""

    var body: some View {
        
        NavigationView {
            VStack(spacing: 20) {
                Spacer()

                Text("Welcome to Eagle PickUp!")
                    .font(.largeTitle)
                    .padding(.bottom, 5)

                Text("Let's get your profile set up.")
                    .font(.headline)
                    .foregroundColor(.gray)

                Image(systemName: "figure.basketball")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding()
                    .foregroundColor(.orange)

                
                TextField("What is your name?", text: $enteredUsername)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.words)

                Button("Get Started") {
                    saveProfileAndCompleteSetup()
                }
                .buttonStyle(.borderedProminent)
                .disabled(enteredUsername.trimmingCharacters(in: .whitespaces).isEmpty)

                Spacer()
                Spacer()
            }
            .padding()
             .navigationBarHidden(true)
        }
        .onAppear {
             enteredUsername = username
        }
        .interactiveDismissDisabled()
    }

    func saveProfileAndCompleteSetup() {
        username = enteredUsername.trimmingCharacters(in: .whitespaces)
        hasCompletedSetup = true
    }
}

// Preview Provider
#Preview {
    ProfileSetupView()
}
