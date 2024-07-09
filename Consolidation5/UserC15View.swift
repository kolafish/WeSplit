//
//  UserC15View.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/9.
//

import SwiftUI
import SwiftData

struct UserC15View: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [UserC5]
    @State var getCount  = 0

    var body: some View {
        Text("Hi \(getCount)")
        List(users) { user in
            VStack {
                Text(user.name)
                Text(user.id.uuidString)
            }
        }
        .task {
            await loadData()
        }
    }
 
    func loadData() async {
        getCount = 1
        if users.count > 0 {
            getCount = 2
            print("get from swiftdata count\(users.count)")
            return
        }
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            getCount = 3
            print("Invalid URL")
            return
        }
        getCount = 4
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            getCount = 6
            print(data)
            if let decodedResponse = try? JSONDecoder().decode([UserC5].self, from: data) {
                getCount = 5
                print("get from web count \(decodedResponse.count)")
            
                for e in decodedResponse {
//                    modelContext.insert(e)
                }
//                users = decodedResponse.users
            }
        } catch {
            getCount = 7
            print("Invalid data")
        }
    }
}


struct ResponseC5: Codable {
    var users: [UserC5]
}



#Preview {
    UserC15View()
        .modelContainer(for: UserC5.self, inMemory: false)
}
