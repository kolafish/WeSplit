//
//  SelectTest.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/14.
//

import SwiftUI

struct SelectTest: View {
    let users = ["Tohru", "Yuki", "Kyo", "Momiji"]
    @State private var selection = Set<String>()
    @State private var selectedTab = "One"



    
    var body: some View {
        List(users, id: \.self, selection: $selection) { user in
            Text(user)
        }
        if selection.isEmpty == false {
            Text("You selected \(selection.formatted())")
        }
        EditButton()
        TabView {
            Text("Tab 1")
                .tabItem {
                    Label("One", systemImage: "star")
                }

            Text("Tab 2")
                .tabItem {
                    Label("Two", systemImage: "circle")
                }
        }
        
        TabView(selection: $selectedTab) {
                   Button("Show Tab 2") {
                       selectedTab = "Two"
                   }
                   .tabItem {
                       Label("One", systemImage: "star")
                   }
                   .tag("One")

                   Text("Tab 2")
                       .tabItem {
                           Label("Two", systemImage: "circle")
                       }
                       .tag("Two")
               }

    }
}

#Preview {
    SelectTest()
}
