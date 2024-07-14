//
//  resulttest.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/14.
//

import SwiftUI

struct resulttest: View {
    @State private var output = ""
    @State private var backgroundColor = Color.red


     var body: some View {
         Text(output)
             .task {
                 await fetchReadings()
             }
         Image(.example1)
             .resizable()
             .scaledToFit()
             .background(.black)
         Image(.example1)
             .interpolation(.none)
             .resizable()
             .scaledToFit()
             .background(.black)
         VStack {
                    Text("Hello, World!")
                        .padding()
                        .background(backgroundColor)

                    Text("Change Color")
                        .padding()
                        .contextMenu {
                            Button("Red", systemImage: "checkmark.circle.fill", role: .destructive) {
                                backgroundColor = .red
                            }

                            Button("Green") {
                                backgroundColor = .green
                            }

                            Button("Blue") {
                                backgroundColor = .blue
                            }
                        }
                }

     }

    func fetchReadings() async {
        let fetchTask = Task {
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings"
        }
        let result = await fetchTask.result
        switch result {
            case .success(let str):
                output = str
            case .failure(let error):
                output = "Error: \(error.localizedDescription)"
        }
        do {
            output = try result.get()
        } catch {
            output = "Error: \(error.localizedDescription)"
        }
    }
}

#Preview {
    resulttest()
}
