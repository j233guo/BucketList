//
//  EditView.swift
//  BucketList
//
//  Created by Jiaming Guo on 2022-10-13.
//

import SwiftUI

enum LoadingState {
    case loading, loaded, failed
}

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: ViewModel

    var onSave: (Location) -> Void
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        _viewModel = StateObject(wrappedValue: ViewModel(location: location))
        self.onSave = onSave
    }
    
    func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(viewModel.location.coordinate.latitude)%7C\(viewModel.location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let items = try JSONDecoder().decode(Result.self, from: data)
            viewModel.pages = items.query.pages.values.sorted()
            viewModel.loadingState = .loaded
        } catch {
            viewModel.loadingState = .failed
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Place Name") {
                    TextField("Place Name", text: $viewModel.name)
                }
                Section("Description") {
                    TextField("Description", text: $viewModel.description)
                }
                Section("Nearby Places") {
                    switch viewModel.loadingState {
                        case .loaded:
                            ForEach(viewModel.pages, id: \.pageid) { page in
                                Text(page.title)
                                    .font(.headline)
                                + Text(": ") +
                                Text(page.description)
                                    .italic()
                            }
                        case .loading:
                            Text("Loading...")
                        case .failed:
                            Text("Loading failed. Please try again later")
                    }
                }
            }
            .navigationTitle("Place Details")
            .toolbar {
                Button("Save") {
                    var newLocation = viewModel.location
                    newLocation.id = UUID()
                    newLocation.name = viewModel.name
                    newLocation.description = viewModel.description
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await fetchNearbyPlaces()
            }
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example, onSave: { newLocation in })
    }
}
