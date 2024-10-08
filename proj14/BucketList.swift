//
//  BucketList.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/10.
//

import SwiftUI
import MapKit


struct BucketList: View {
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    @State private var viewModel = ViewModel()
    
    
    var body: some View {
        NavigationStack {
            
            if viewModel.isUnlocked {
                MapReader { proxy in
                    Map(initialPosition: startPosition)
                    {
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .onLongPressGesture {
                                        viewModel.selectedPlace = location
                                    }
                            }
                            
                        }
                    }
                    .mapStyle(viewModel.toggleMapStyle ? .standard : .hybrid)
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                    .sheet(item: $viewModel.selectedPlace) { place in
                        EditMapView(location: place) {
                            viewModel.update(location: $0)
                            
                        }
                    }
                    .toolbar {
                        Button("MapStypeSwitch") {
                            viewModel.toggleStyle()
                        }
                    
                    }
                    .alert("Opps...FaceID Fail!", isPresented: $viewModel.authFailAlert) {
                        Text("auth failed, please trye again")
                    }
                    .alert("Opps...No biometrics!", isPresented: $viewModel.authUnableAlert) {
                        Text("No biometrics! Please update your iPhone!")
                    }                }
            } else {
                Button("Unlock Places", action: viewModel.authenticate)
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
            }
        }
        
    }
}


#Preview {
    BucketList()
}
