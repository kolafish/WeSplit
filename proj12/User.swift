//
//  User.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/5.
//

import Foundation
import SwiftData

@Model
class UserP12 {
    var name: String
    var city: String
    var joinDate: Date
    var jobs = [Job]()
//    @Relationship(deleteRule: .cascade) var jobs = [Job]()   delete a user would delete all the jobs and all job's relationship



    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}



@Model
class Job {
    var name: String
    var priority: Int
    var owner: UserP12?

    init(name: String, priority: Int, owner: UserP12? = nil) {
        self.name = name
        self.priority = priority
        self.owner = owner
    }
}
