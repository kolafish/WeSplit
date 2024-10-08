//
//  WeSplitApp.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/6/26.
//

import SwiftUI
import SwiftData


@main
struct WeSplitApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
//            Student.self,
//            Book.self,
//            UserP12.self,
            ExpensesSD.self,
            UserC5.self,
            Prospect.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            Flashzilla()
        }
        .modelContainer(sharedModelContainer)

    }
}
