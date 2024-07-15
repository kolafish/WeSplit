//
//  Prospect.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/15.
//

import Foundation
import SwiftData

@Model
class Prospect {
    var name: String
    var emailAddress: String
    var isContacted: Bool
    var jionDate : Date?
    
    init(name: String, emailAddress: String, isContacted: Bool) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
        self.jionDate = Date()
    }
}
