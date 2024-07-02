//
//  Mission.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/2.
//

import Foundation



struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    var image: String {
        "apollo\(id)"
    }
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    var formattedLaunchDate2: String {
        launchDate?.formatted(date: .complete, time: .standard) ?? "N/A"
    }
}