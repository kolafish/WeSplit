//
//  UserC5.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/9.
//

import Foundation
import SwiftData

@Model
class UserC5  : Codable, Equatable{
    let id : UUID
    let name: String
    let isActive: Bool
    let age : Int
    let registered: Date
    let tags : [String]
    let friends = [FriendC5]()
//    @Relationship(deleteRule: .cascade) var jobs = [Job]()   delete a user would delete all the jobs and all job's relationship

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case isActive
        case age
        case registered
        case tags
        case friends
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let strid = try container.decode(String.self, forKey: .id)
        print("decode 0")

        self.id = UUID(uuidString: strid) ?? UUID()
        self.name = try container.decode(String.self, forKey: .name)
        print("decode 1")
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.age = try container.decode(Int.self, forKey: .age)
        let strreg = try container.decode(String.self, forKey: .registered)
        print("decode 2")

        self.registered = try Date(strreg,strategy:.iso8601)
        self.tags = try container.decode([String].self, forKey: .tags)
        print("decode 3")

        self.friends = try container.decode([FriendC5].self, forKey: .friends)
        print("decode 4")

        
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id.uuidString, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.isActive, forKey: .isActive)
        try container.encode(self.age, forKey: .age)
        try container.encode(self.registered.ISO8601Format(), forKey: .registered)
        try container.encode(self.tags, forKey: .tags)
        try container.encode(self.friends, forKey: .friends)
    }
    
    
 
}



@Model
class FriendC5 : Codable, Equatable {
    let id: UUID
    let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    init(name: String, id: UUID) {
        self.name = name
        self.id = id
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let strid = try container.decode(String.self, forKey: .id)
        self.id = UUID(uuidString: strid) ?? UUID()
        self.name = try container.decode(String.self, forKey: .name)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id.uuidString, forKey: .id)
        try container.encode(self.name, forKey: .name)
    }
    
}
