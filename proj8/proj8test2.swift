//
//  proj8test2.swift
//  WeSplit
//
//  Created by Kola on 2024/7/1.
//

import SwiftUI
struct User1: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}

struct proj8test2: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button("Decode JSON") {
            let input = """
            {
                "name": "Taylor Swift",
                "address": {
                    "street": "555, Taylor Swift Avenue",
                    "city": "Nashville"
                }
            }
            """

            let data = Data(input.utf8)
            let decoder = JSONDecoder()
            if let user1 = try? decoder.decode(User1.self, from: data) {
                print(user1.address.street)
            }
        }
        
        let layout = [
            GridItem(.fixed(80)),
            GridItem(.fixed(80)),
            GridItem(.fixed(80))
        ]
        ScrollView {
            LazyVGrid(columns: layout) {
                ForEach(0..<1000) {
                    Text("Item \($0)")
                }
            }
        }
        let layout2 = [
            GridItem(.adaptive(minimum: 80, maximum: 120)),
        ]
        ScrollView(.horizontal) {
            LazyHGrid(rows: layout2) {
                ForEach(0..<1000) {
                    Text("Item \($0)")
                }
            }
        }
    }
}

#Preview {
    proj8test2()
}
