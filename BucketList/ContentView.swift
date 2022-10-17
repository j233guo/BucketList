//
//  ContentView.swift
//  BucketList
//
//  Created by Jiaming Guo on 2022-10-09.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @StateObject private var vm = ViewModel()
    
    var body: some View {
        ZStack {
            if vm.isUnlocked {
                Map(coordinateRegion: $vm.mapRegion, annotationItems: vm.locations, annotationContent: { location in
                    MapAnnotation(coordinate: location.coordinate, content: {
                        CustomMapAnnotation(name: location.name)
                            .onTapGesture {
                                vm.selectedPlace = location
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
                            vm.addNewLocation()
                        })
                    }
                }
            } else {
                Button("Unlock Places") {
                    vm.authenticate()
                }
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            
        }
        .sheet(item: $vm.selectedPlace, content: { place in
            EditView(location: place, onSave: { newLocation in
                vm.update(location: newLocation)
            })
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
