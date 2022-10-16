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
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations, annotationContent: { location in
                MapAnnotation(coordinate: location.coordinate, content: {
                    CustomMapAnnotation(name: location.name)
                        .onTapGesture {
                            viewModel.selectedPlace = location
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
                        viewModel.addNewLocation()
                    })
                }
            }
        }
        .sheet(item: $viewModel.selectedPlace, content: { place in
            EditView(location: place, onSave: { newLocation in
                viewModel.update(location: newLocation)
            })
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
