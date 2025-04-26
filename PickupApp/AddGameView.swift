//
//  AddGameView.swift
//  PickupApp
//
//  Created by Christian Kim on 4/25/25.
//

import SwiftUI

struct AddGameView: View {
    let courtId: UUID
    @EnvironmentObject var gameStore: GameStore
    @Environment(\.dismiss) var dismiss

    @AppStorage("username") private var currentUsername: String = "Unknown User"

    @State private var gameDate: Date = Date()
    @State private var timeDescription: String = ""
    @State private var notes: String = ""
    @State private var numberOfPeople: Int = 1

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Game Details")) {
                    DatePicker("Date & Time", selection: $gameDate, displayedComponents: [.date, .hourAndMinute])
                    TextField("Time Description (Optional, e.g., '5 PM Sharp')", text: $timeDescription)

                    Stepper("People Attending: \(numberOfPeople)", value: $numberOfPeople, in: 1...20)
                }

                Section(header: Text("Optional Notes")) {
                    TextEditor(text: $notes)
                        .frame(height: 100)
                }
            }
            .navigationTitle("Schedule New Game")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveGame()
                        dismiss()
                    }
                }
            }
        }
    }

    func saveGame() {
        let trimmedTimeDesc = timeDescription.trimmingCharacters(in: .whitespaces)
        let trimmedNotes = notes.trimmingCharacters(in: .whitespaces)

        let newGame = ScheduledGame(
            id: UUID(),
            courtId: courtId,
            date: gameDate,
            timeDescription: trimmedTimeDesc.isEmpty ? nil : trimmedTimeDesc,
            notes: trimmedNotes.isEmpty ? nil : trimmedNotes,
            schedulerName: currentUsername,
            numberOfPeople: numberOfPeople
        )
        gameStore.addGame(newGame)
    }
}

#Preview {
    AddGameView(courtId: UUID())
        .environmentObject(GameStore())
}

