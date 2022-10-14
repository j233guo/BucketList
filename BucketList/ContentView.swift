//
//  ContentView.swift
//  BucketList
//
//  Created by Jiaming Guo on 2022-10-09.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @State private var authState = AuthState.fail
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    @State private var locations = [Location]()
    @State private var selectedPlace: Location?
    
    func addNewLocation() {
        let newLocation = Location(id: UUID(), name: "New Location", description: "A new location", latitude: mapRegion.center.latitude, longtitude: mapRegion.center.longitude)
        locations.append(newLocation)
    }
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapRegion, annotationItems: locations, annotationContent: { location in
                MapAnnotation(coordinate: location.coordinate, content: {
                    CustomMapAnnotation(name: location.name)
                        .onTapGesture {
                            selectedPlace = location
                        }
                })
            })
                .ignoresSafeArea()
            Circle()
                .fill(.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    AddLocationBtn(action: {
                        addNewLocation()
                    })
                }
            }
        }
        .sheet(item: $selectedPlace, content: { place in
            EditView(location: place, onSave: { newLocation in
                if let index = locations.firstIndex(of: place) {
                    locations[index] = newLocation
                }
            })
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
