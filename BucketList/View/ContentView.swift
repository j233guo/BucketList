//
//  ContentView.swift
//  BucketList
//
//  Created by Jiaming Guo on 2022-10-09.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.isUnlocked {
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
            } else {
                Button("Unlock Places") {
                    viewModel.authenticate()
                }
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            
        }
        .sheet(item: $viewModel.selectedPlace, content: { place in
            EditView(location: place, onSave: { newLocation in
                viewModel.update(location: newLocation)
            })
        })
        .alert("Authentication Failed", isPresented: $viewModel.authErrorAlert, actions: {
            Button("Retry") {
                viewModel.authenticate()
            }
        }, message: {
            Text("We are unable to authenticate you. Please try again.")
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
