//
//  AlertSheetTest.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/21.
//

import SwiftUI

struct User19: Identifiable {
    var id = "Taylor Swift"
}

struct User19View: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna and Arya")
        }
        .font(.subheadline)
    }
}

struct AlertSheetTest: View {
    @State private var selectedUser: User19? = nil
    @State private var isShowingUser = false
    @State private var layoutVertically = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var searchText = ""
    @State private var searchText2 = ""

    let allNames = ["Subh", "Vina", "Melvin", "Stefanie"]


    var filteredNames: [String] {
            if searchText2.isEmpty {
                allNames
            } else {
                allNames.filter { $0.localizedStandardContains(searchText2) }
            }
        }

    var body: some View {
        Button("Tap Me") {
            selectedUser = User19()
        }
        .sheet(item: $selectedUser) { user in
            Text(user.id)
                .presentationDetents([.medium, .large])

        }
        
        Button("Tap Me2") {
            isShowingUser = true
        }
        .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) { user in
            Button(user.id) { }
        }
        
        Button {
                  layoutVertically.toggle()
        } label: {
            if layoutVertically {
                VStack {
                    User19View()
                }
            } else {
                HStack {
                    User19View()
                }
            }
        }
        
        if horizontalSizeClass == .compact {
            VStack {
                User19View()
            }
        } else {
            HStack {
                User19View()
            }
        }
        if horizontalSizeClass == .compact {
            VStack(content: User19View.init)
        } else {
            HStack(content: User19View.init)
        }
        ViewThatFits {
            Rectangle()
                .frame(width: 500, height: 200)
            Circle()
                .frame(width: 100, height: 100)
        }
        NavigationStack {
            Text("Searching for \(searchText)")
//                .searchable(text: $searchText, prompt: "Look for something")
                .navigationTitle("Searching")
        }
        NavigationStack {
                   List(filteredNames, id: \.self) { name in
                       Text(name)
                   }
                   .searchable(text: $searchText2, prompt: "Look for something2")
                   .navigationTitle("Searching2")
               }
    }
}

#Preview {
    AlertSheetTest()
}
