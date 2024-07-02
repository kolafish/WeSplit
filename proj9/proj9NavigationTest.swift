//
//  proj9NavigationTest.swift
//  WeSplit
//
//  Created by Kola on 2024/7/2.
//

import SwiftUI

struct proj9NavigationTest: View {
    @State private var path = [Int]()
    @State private var path2 = NavigationPath()


    var body: some View {
        NavigationStack {
            List(0..<3) { i in
                NavigationLink("Tap Me\(i)") {
                    DetailView22(number: i)
                }
            }
        }
        NavigationStack(path: $path) {
            VStack {
                Button("Show 32") {
                    path = [32]
                }
                Button("Show 64") {
                    path.append(640)
                }
                Button("Show 32 then 64") {
                    path = [32, 64]
                }
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected 2 \(selection)")
            }
        }
        NavigationStack {
            List {
                ForEach(0..<2) { i in
                    NavigationLink("Select Number: \(i)", value: i)
                }

                ForEach(0..<2) { i in
                    NavigationLink("Select String: \(i)", value: String(i))
                }
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected the number \(selection)")
            }
            .navigationDestination(for: String.self) { selection in
                Text("You selected the string \(selection)")
            }
        }
        NavigationStack(path: $path2) {
            Text("try me")
                .toolbar {
                    Button("Push 556") {
                        path2.append(556)
                    }

                    Button("Push Hello") {
                        path2.append("Hello")
                    }
                }
        }
        .navigationDestination(for: Int.self) { selection in
            Text("You selected the number \(selection)")
        }
        .navigationDestination(for: String.self) { selection in
            Text("You selected the string \(selection)")
        }
    }
}
struct DetailView22: View {
    var number: Int

    var body: some View {
        Text("Detail View \(number)")
    }

    init(number: Int) {
        self.number = number
//        print("Creating detail view \(number)")
    }
}
#Preview {
    proj9NavigationTest()
}
