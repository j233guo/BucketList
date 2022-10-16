//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Jiaming Guo on 2022-10-13.
//

import Foundation
import MapKit

class ViewModel: ObservableObject {
    
}

extension ContentView {
    class ViewModel: ObservableObject {
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        @Published private(set) var locations = [Location]()
        @Published var selectedPlace: Location?
        
        func addNewLocation() {
            let newLocation = Location(id: UUID(), name: "New Location", description: "A new location", latitude: mapRegion.center.latitude, longtitude: mapRegion.center.longitude)
            locations.append(newLocation)
        }
        
        func update(location: Location) {
            guard let selectedPlace = selectedPlace else { return }
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
            }
        }
    }
}
