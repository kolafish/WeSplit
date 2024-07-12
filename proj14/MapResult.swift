//
//  MapResult.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/12.
//

import Foundation

struct MapResult: Codable {
    let query: MapQuery
}

struct MapQuery: Codable {
    let pages: [Int: MapPage]
}

struct MapPage: Codable , Comparable{
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    var description: String {
        terms?["description"]?.first ?? "No further information"
    }
    
    static func <(lhs: MapPage, rhs: MapPage) -> Bool {
        lhs.title < rhs.title
    }
}

