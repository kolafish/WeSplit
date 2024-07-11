//
//  MapTest.swift
//  WeSplit
//
//  Created by Kola on 2024/7/10.
//

import SwiftUI
import MapKit


struct MapTest: View {
    struct Location: Identifiable {
        let id = UUID()
        var name: String
        var coordinate: CLLocationCoordinate2D
    }
    
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    let locations = [
        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]
    
    
    var body: some View {
        Map()
            .mapStyle(.imagery)
            .mapStyle(.hybrid)
            .mapStyle(.hybrid(elevation: .realistic))
        Map(interactionModes: [.rotate, .zoom])
        Map(interactionModes: [])

        Map(position: $position)
            .onMapCameraChange(frequency: .continuous) { context in
                print(context.region)
            }
        HStack(spacing: 50) {
            Button("Paris") {
                position = MapCameraPosition.region(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522),
                        span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                    )
                )
            }

            Button("Tokyo") {
                position = MapCameraPosition.region(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: 35.6897, longitude: 139.6922),
                        span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                    )
                )
            }
        }
        Map {
            ForEach(locations) { location in
//                Marker(location.name, coordinate: location.coordinate)
                Annotation(location.name, coordinate: location.coordinate) {
                    Text(location.name)
                        .font(.headline)
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(.capsule)
                }
                .annotationTitles(.hidden)
            }
        }
        
        MapReader { proxy in
            Map()
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        print(coordinate)
                    }
                }
        }
        

    }
}

#Preview {
    MapTest()

    


}
