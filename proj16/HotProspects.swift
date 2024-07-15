//
//  HotProspects.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/14.
//

import SwiftUI

struct HotProspects: View {
    var body: some View {
        TabView {
            ProspectsView(filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            ProspectsView(filter : .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            ProspectsView(filter : .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
    }
}

#Preview {
    HotProspects()
        .modelContainer(for: Prospect.self, inMemory: false)

}
