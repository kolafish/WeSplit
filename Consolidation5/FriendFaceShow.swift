//
//  FriendFaceShow.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/9.
//

import SwiftUI
import SwiftData

struct FriendFaceShow: View {
    @Environment(\.modelContext) var modelContext
    @Query() var uses: [UserC5]

    
    @State private var path = [UserP12]()
    @Query(filter: #Predicate<UserP12> { user in
        user.name.localizedStandardContains("R") &&
        user.city == "London"
    }, sort: \UserP12.name) var users: [UserP12]

    @State private var showingUpcomingOnly = false
    @State private var sortOrder = [
        SortDescriptor(\UserP12.name),
        SortDescriptor(\UserP12.joinDate),
    ]

    
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    FriendFaceShow()
        .modelContainer(for: UserC5.self, inMemory: false)
}
