//
//  Gamestore.swift
//  PickupApp
//
//  Created by Christian Kim on 4/25/25.
//

import Foundation
import Combine
import SwiftUI

class GameStore: ObservableObject {
    @Published var scheduledGames: [ScheduledGame] = []

    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
            .appendingPathComponent("scheduledGames.data")
    }

    init() {
        print("GameStore initializing...")
        loadGames()
        print("GameStore initialized. Current game count: \(scheduledGames.count)")
    }

    func games(for courtId: UUID) -> [ScheduledGame] {
        scheduledGames
            .filter { $0.courtId == courtId }
            .sorted { $0.date < $1.date }
    }

    func addGame(_ game: ScheduledGame) {
         print("Attempting to add game for court \(game.courtId) scheduled by \(game.schedulerName)")
         scheduledGames.append(game)
         print("Game appended locally. Total games now: \(scheduledGames.count)")
         saveGames()
         print("saveGames() called after adding game.")
    }

    func loadGames() {
        do {
            let fileURL = try Self.fileURL()
            print("Attempting to load games from: \(fileURL.path)")
            guard FileManager.default.fileExists(atPath: fileURL.path) else {
                print("Save file not found. Starting with empty schedule.")
                return
            }
            let data = try Data(contentsOf: fileURL)
            let loadedGames = try JSONDecoder().decode([ScheduledGame].self, from: data)
            print("Successfully decoded \(loadedGames.count) games from file.")
            self.scheduledGames = loadedGames
            print("Games loaded successfully.")
        } catch {
            print("!!! Error loading games: \(error)")
            print("!!! Error Description: \(error.localizedDescription)")
        }
    }

    func saveGames() {
        print("Attempting to save \(scheduledGames.count) games.")
        do {
            let fileURL = try Self.fileURL()
            print("Encoding data...")
            let data = try JSONEncoder().encode(scheduledGames)
            print("Writing data to: \(fileURL.path)")
            try data.write(to: fileURL, options: [.atomicWrite, .completeFileProtection])
            print("Games saved successfully.")
        } catch {
            print("!!! Error saving games: \(error)")
            print("!!! Error Description: \(error.localizedDescription)")
            if let encodingError = error as? EncodingError {
                print("!!! Encoding Error Details: \(encodingError)")
            }
        }
    }

}



