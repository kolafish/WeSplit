//
//  proj9NavigationTest2.swift
//  WeSplit
//
//  Created by Kola on 2024/7/3.
//

import SwiftUI

struct proj9NavigationTest2: View {
    //TODO: can no use PathStore2
    @State private var path = PathStore()


    var body: some View {
        NavigationStack(path: $path.path) {
            DetailView(number: 0, path: $path.path)
                .navigationDestination(for: Int.self) { i in
                    DetailView(number: i,path: $path.path)
                }
        }
    }
    
    
    struct DetailView: View {
        var number: Int
        @Binding var path: [Int]


        var body: some View {
            NavigationLink("Go to Random Number", value: Int.random(in: 1...1000))
                .navigationTitle("Number: \(number)")
                .toolbar {
                    Button("Home") {
//                        path = PathStore()
                        path.removeAll()
                    }
                }
        }
    }
}

@Observable
class PathStore {
    var path: [Int] {
        didSet {
            save()
        }
    }

    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")

    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode([Int].self, from: data) {
                path = decoded
                return
            }
        }

        // Still here? Start with an empty path.
        path = []
    }

    func save() {
        do {
            let data = try JSONEncoder().encode(path)
            try data.write(to: savePath)
        } catch {
            print("Failed to save navigation data")
        }
    }
}
@Observable
class PathStore2 {
    var path: NavigationPath {
        didSet {
            save()
        }
    }

    private let savePath = URL.documentsDirectory.appending(path: "SavedPath2")

    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) {
                path = NavigationPath(decoded)
                return
            }
        }

        // Still here? Start with an empty path.
        path = NavigationPath()
    }

    func save() {
        guard let representation = path.codable else { return }

        do {
            let data = try JSONEncoder().encode(representation)
            try data.write(to: savePath)
        } catch {
            print("Failed to save navigation data")
        }
    }
}

#Preview {
    proj9NavigationTest2()
}
