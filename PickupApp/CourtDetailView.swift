//
//  CourtDetailView.swift
//  PickupApp
//
//  Created by Christian Kim on 4/25/25.
//

import SwiftUI
import MapKit

struct CourtDetailView: View {
    let court: Court
    @EnvironmentObject var gameStore: GameStore
    @State private var showingAddGameSheet = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text(court.address)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 5)

                if let notes = court.notes, !notes.isEmpty {
                    Text("Notes: \(notes)")
                        .font(.body)
                        .padding(.bottom, 5)
                }

                Map(initialPosition: MapCameraPosition.region(MKCoordinateRegion(
                    center: court.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                ))) {
                    Marker(court.name, coordinate: court.coordinate)
                }
                .frame(height: 250)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )

                Divider()
                    .padding(.vertical, 5)

                HStack {
                    Text("Scheduled Games")
                        .font(.title2)
                    Spacer()
                    Button {
                        showingAddGameSheet = true
                    } label: {
                        Label("Add Game", systemImage: "plus.circle.fill")
                            .labelStyle(.iconOnly)
                            .imageScale(.large)
                    }
                }

                let gamesForThisCourt = gameStore.scheduledGames.filter { $0.courtId == court.id }.sorted { $0.date < $1.date }

                if gamesForThisCourt.isEmpty {
                    Text("No games scheduled here yet by you.")
                        .foregroundColor(.gray)
                        .italic()
                        .padding(.top, 10)
                } else {
                    LazyVStack(alignment: .leading, spacing: 10) {
                        ForEach(gamesForThisCourt) { game in
                            VStack(alignment: .leading, spacing: 3) {
                                HStack {
                                    Text("\(game.date, style: .date), \(game.date, style: .time)")
                                        .font(.headline)
                                    Spacer()
                                    Label("\(game.numberOfPeople)", systemImage: "person.2.fill")
                                        .font(.subheadline)
                                        .foregroundColor(.blue)
                                }
                                if let timeDesc = game.timeDescription, !timeDesc.isEmpty {
                                    Text("Time: \(timeDesc)")
                                        .font(.subheadline)
                                }
                                Text("Scheduled by: \(game.schedulerName)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                if let notes = game.notes, !notes.isEmpty {
                                    Text("Notes: \(notes)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                        .lineLimit(2)
                                        .padding(.top, 1)
                                }
                            }
                            .padding(.vertical, 8)
                            Divider().padding(.leading)
                        }
                    }
                }

            }
            .padding()
        }
        .navigationTitle(court.name)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingAddGameSheet) {
            AddGameView(courtId: court.id)
                .environmentObject(gameStore)
        }
    }
}

#Preview {
    let sampleCourt = Court(id: UUID(), name: "Preview Court", address: "123 Preview Lane", notes: "Sample notes", latitude: 42.33, longitude: -71.2)
    let previewGameStore = GameStore()
    previewGameStore.addGame(ScheduledGame(id: UUID(), courtId: sampleCourt.id, date: Date(), timeDescription: "Around 5 PM", notes: "Casual run", schedulerName: "PreviewUser", numberOfPeople: 4))
    previewGameStore.addGame(ScheduledGame(id: UUID(), courtId: sampleCourt.id, date: Date().addingTimeInterval(3600*24), timeDescription: nil, notes: "No time desc", schedulerName: "PreviewUser2", numberOfPeople: 2))

    return NavigationView {
        CourtDetailView(court: sampleCourt)
            .environmentObject(previewGameStore)
    }
}


