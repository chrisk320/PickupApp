//
//  Models.swift
//  PickupApp
//
//  Created by Christian Kim on 4/25/25.
//

import Foundation
import CoreLocation


struct Court: Identifiable, Codable {
    let id: UUID
    var name: String
    var address: String
    var notes: String?
    var latitude: Double
    var longitude: Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct ScheduledGame: Identifiable, Codable {
    let id: UUID
    var courtId: UUID
    var date: Date
    var timeDescription: String?
    var notes: String?
    var schedulerName: String 
    var numberOfPeople: Int
}
