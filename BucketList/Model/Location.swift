//
//  Location.swift
//  BucketList
//
//  Created by Jiaming Guo on 2022-10-09.
//

import Foundation
import MapKit

struct Location: Codable, Identifiable, Equatable {
    let id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longtitude: Double
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        return lhs.id == rhs.id
    }
    
    static let example = Location(id: UUID(), name: "Buckingham Palace", description: "Where King lives", latitude: 51.501, longtitude: -0.141)
}
