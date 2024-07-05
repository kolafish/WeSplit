//
//  SwiftDataProject.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/5.
//

import SwiftUI
import SwiftData

struct SwiftDataProject: View {
    @Environment(\.modelContext) var modelContext
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
        NavigationStack(path: $path) { 
            UsersView(minimumJoinDate: showingUpcomingOnly ? .now : .distantPast, sortOrder: sortOrder)
            .navigationTitle("Users")
            .navigationDestination(for: UserP12.self) { user in
                EditUserP12View(user: user)
            }
            .toolbar {
                Button("Add User", systemImage: "plus") {
                    let user = UserP12(name: "", city: "", joinDate: .now)
                    modelContext.insert(user)
                    path = [user]
                }
                Button(showingUpcomingOnly ? "Show Everyone" : "Show Upcoming") {
                    showingUpcomingOnly.toggle()
                }
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Name")
                            .tag([
                                SortDescriptor(\UserP12.name),
                                SortDescriptor(\UserP12.joinDate),
                            ])
                        
                        Text("Sort by Join Date")
                            .tag([
                                SortDescriptor(\UserP12.joinDate),
                                SortDescriptor(\UserP12.name)
                            ])
                    }
                }
            }
        }
        
        NavigationStack {
            List(users) { user in
                Text(user.name)
            }
            .navigationTitle("Users")
            .toolbar {
                Button("Add Samples", systemImage: "plus") {
                    try? modelContext.delete(model: UserP12.self)
                    let first = UserP12(name: "Ed Sheeran", city: "London", joinDate: .now.addingTimeInterval(86400 * -10))
                    let second = UserP12(name: "Rosa Diaz", city: "New York", joinDate: .now.addingTimeInterval(86400 * -5))
                    let third = UserP12(name: "Roy Kent", city: "London", joinDate: .now.addingTimeInterval(86400 * 5))
                    let fourth = UserP12(name: "Johnny English", city: "London", joinDate: .now.addingTimeInterval(86400 * 10))

                    modelContext.insert(first)
                    modelContext.insert(second)
                    modelContext.insert(third)
                    modelContext.insert(fourth)
                }
            }
        }
    }
    
    func addSample() {
        let user1 = UserP12(name: "Piper Chapman", city: "New York", joinDate: .now)
        let job1 = Job(name: "Organize sock drawer", priority: 3)
        let job2 = Job(name: "Make plans with Alex", priority: 4)

        modelContext.insert(user1)

        user1.jobs.append(job1)
        user1.jobs.append(job2)
    }
    
}

#Preview {
    SwiftDataProject()
        .modelContainer(for: UserP12.self, inMemory: false)

}
