//
//  EditUserP12View.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/5.
//

import SwiftUI
import SwiftData

struct EditUserP12View: View {
    @Bindable var user: UserP12
    
    var body: some View {
        Form {
            TextField("Name", text: $user.name)
            TextField("City", text: $user.city)
            DatePicker("Join Date", selection: $user.joinDate)
        }
        .navigationTitle("Edit User")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: UserP12.self, configurations: config)
        let user = UserP12(name: "Taylor Swift", city: "Nashville", joinDate: .now)
        return EditUserP12View(user: user)
            .modelContainer(container)
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
}
