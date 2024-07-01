//
//  proj8test.swift
//  WeSplit
//
//  Created by Kola on 2024/7/1.
//

import SwiftUI

struct proj8test: View {
    var body: some View {
        Image(.germany)
            .resizable()
            .scaledToFit()
//            .frame(width: 150, height: 200)
            .containerRelativeFrame(.horizontal) { size, axis in
                 size * 0.5
             }
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                ForEach(0..<100) {
                    Text("Item \($0)")
                        .font(.title)
                }
            }
            .frame(maxWidth: .infinity)
        }
        ScrollView {
            VStack(spacing: 10) {
                ForEach(0..<100) {
                    Text("Item \($0)")
                        .font(.title)
                }
            }
            .frame(maxWidth: .infinity)
        }
        NavigationStack {
            Text("Tap Me")
                .navigationTitle("SwiftUI")
        }
        NavigationStack {
            NavigationLink("Tap Me") {
                Text("Detail View")
            }
            .navigationTitle("SwiftUI")
        }
        NavigationStack {
            NavigationLink {
                Text("Detail View")
            } label: {
                VStack {
                    Text("This is the label")
                    Text("So is this")
                    Image(systemName: "face.smiling")
                }
                .font(.largeTitle)
            }
            .navigationTitle("SwiftUI")

        }
        NavigationStack {
            
            List(0..<100) { row in
                NavigationLink("Row \(row)") {
                    Text("Detail \(row)")
                }
            }
            .navigationTitle("SwiftUI")
        }
    }
}

#Preview {
    proj8test()
}
