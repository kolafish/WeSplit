//
//  EditMapView.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/12.
//

import SwiftUI

struct EditMapView: View {
    enum LoadingState {
        case loading, loaded, failed
    }
    
    @Environment(\.dismiss) var dismiss
     var location: Location

     @State private var name: String
     @State private var description: String
     var onSave: (Location) -> Void
    
    @State private var loadingState = LoadingState.loading
    @State private var pages = [MapPage]()

    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave

        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }

     var body: some View {
         NavigationStack {
             Form {
                 Section {
                     TextField("Place name", text: $name)
                     TextField("Description", text: $description)
                 }
                 Section("Nearby…") {
                     switch loadingState {
                     case .loaded:
                         ForEach(pages, id: \.pageid) { page in
                             Text(page.title)
                                 .font(.headline)
                             + Text(": ") +
                             Text(page.description)
                                 .italic()
                         }
                     case .loading:
                         Text("Loading…")
                     case .failed:
                         Text("Please try again later.")
                     }
                 }
             }
             .navigationTitle("Place details")
             .toolbar {
                 Button("Save") {
                     var newLocation = location
                     newLocation.id = UUID()
                     newLocation.name = name
                     newLocation.description = description

                     onSave(newLocation)
                     dismiss()
                 }

             }
             .task {
                 await fetchNearbyPlaces()
             }
         }
     }
    
    
    func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            // we got some data back!
            let items = try JSONDecoder().decode(MapResult.self, from: data)

            // success – convert the array values to our pages array
//            pages = items.query.pages.values.sorted { $0.title < $1.title }
            pages = items.query.pages.values.sorted()
            loadingState = .loaded
        } catch {
            // if we're still here it means the request failed somehow
            loadingState = .failed
        }
    }
    
    
}

#Preview {
    
//    EditMapView(location: .example)
    EditMapView(location: .example) { _ in }


}
