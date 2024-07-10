//
//  UserP14.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/10.
//

import SwiftUI

struct UserP14: Identifiable, Comparable {
    static func < (lhs: UserP14, rhs: UserP14) -> Bool {
        lhs.lastName < rhs.lastName
    }
    
    let id = UUID()
    var firstName: String
    var lastName: String
}


struct UserP14View: View {
        let users = [
            UserP14(firstName: "Arnold", lastName: "Rimmer"),
            UserP14(firstName: "Kristine", lastName: "Kochanski"),
            UserP14(firstName: "David", lastName: "Lister"),
        ].sorted()

    var body: some View {
        List(users) { user in
            Text("\(user.lastName), \(user.firstName)")
        }
        Text(URL.documentsDirectory.absoluteString)
        Button("Read and Write") {
            FileManager.writeK(d:"test data", fileName : "text.txt")
        }
    }
}

#Preview {
    UserP14View()
}
