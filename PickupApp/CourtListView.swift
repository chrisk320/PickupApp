//
//  ContentView.swift
//  PickupApp
//
//  Created by Christian Kim on 4/25/25.
//

import SwiftUI

struct CourtListView: View {
    @EnvironmentObject var gameStore: GameStore
    let courts: [Court] = Bundle.main.decode("courts.json")

    @AppStorage("username") private var username: String = "User"

    var body: some View {
        NavigationView {
            List {
                ForEach(courts) { court in
                    NavigationLink(destination: CourtDetailView(court: court)
                                                .environmentObject(gameStore)) {
                       
                        VStack(alignment: .leading) {
                            Text(court.name).font(.headline)
                            Text(court.address).font(.subheadline).foregroundColor(.gray)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Nearby Courts")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Hi, \(username)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

#Preview {
    CourtListView()
        .environmentObject(GameStore())
}




