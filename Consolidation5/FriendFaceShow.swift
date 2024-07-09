//
//  FriendFaceShow.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/9.
//

import SwiftUI
import SwiftData

struct FriendFaceShow: View {
    var body: some View {
        NavigationStack() {
            UserC15View()
                .navigationTitle("Users")
        }
    }
}

#Preview {
    FriendFaceShow()
        .modelContainer(for: UserC5.self, inMemory: false)
}
