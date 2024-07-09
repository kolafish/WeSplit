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
//    @Binding var path : [UserC5]


    var body: some View {
        List(users) { user in
            NavigationLink(value: user) {
                LazyVStack(alignment: .leading)  {
                    Text(user.name)
                    Text(user.id.uuidString).font(.footnote).foregroundStyle(.secondary)
                }
            }
        }
        .task {
            await loadData()
        }
        .navigationDestination(for: UserC5.self) { user in
            EditUserC5View(user: user)
        }
    }
 
    func loadData() async {
        if users.count > 0 {
            print("get from swiftdata count\(users.count)")
            return
        }
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode([UserC5].self, from: data) {
                for e in decodedResponse {
                    modelContext.insert(e)
                }
            }
        } catch {
            print("Invalid data")
        }
    }
}



struct EditUserC5View: View {
    let user: UserC5
    
    var body: some View {
        ScrollView{
            Text("name:" + user.name)
            Text("id:" + user.id.uuidString)
            Text("age:\(user.age)")
            
        }
        .navigationTitle("User Detail")
    }
}


#Preview {
    UserC15View()
        .modelContainer(for: UserC5.self, inMemory: false)
}
