//
//  UsersView.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/5.
//

import SwiftUI
import SwiftData

struct UsersView: View {
    @Query var users: [UserP12]

    var body: some View {
        List(users) { user in
            Text(user.name)
        }
    }
    init(minimumJoinDate: Date) {
        _users = Query(filter: #Predicate<UserP12> { user in
            user.joinDate >= minimumJoinDate
        }, sort: \UserP12.name)
    }
    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<UserP12>]) {
        _users = Query(filter: #Predicate<UserP12> { user in
            user.joinDate >= minimumJoinDate
        }, sort: sortOrder)
    }
}

#Preview {
    UsersView(minimumJoinDate: .now.addingTimeInterval(86400 * -10))
        .modelContainer(for: UserP12.self, inMemory: false)
}
