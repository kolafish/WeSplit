//
//  Student.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/4.
//

import Foundation
import SwiftData

@Model
class Student {
    var id: UUID
    var name: String

    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
