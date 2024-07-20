//
//  GameResults.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/20.
//

import Foundation
struct GameResults: Identifiable, Codable {
    let id: UUID
    let rollResult: Int
    
    static let example = GameResults(id: UUID(), rollResult: 1)
    static let example2 = GameResults(id: UUID(), rollResult: 6)
}
