//
//  EditMapViewModel.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/13.
//

import Foundation
import SwiftUI

extension EditMapView {
    @Observable
    class ViewModel {
        var location: Location
        var name: String
        var description: String
        var onSave: (Location) -> Void

        
//        init() {}
  
        init(location: Location,onSave: @escaping (Location) -> Void) {
            self.location = location
            name = location.name
            description = location.description

//            _name = State(initialValue: location.name)
//            _description = State(initialValue: location.description)
            
            self.onSave = onSave

        }
        func save() {
            var newLocation = location
            newLocation.id = UUID()
            newLocation.name = name
            newLocation.description = description

            onSave(newLocation)
        }
    }
}
