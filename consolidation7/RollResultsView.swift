//
//  RollResultsView.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/20.
//

import SwiftUI

struct RollResultsView: View {
    let savePath = FileManager.documentsDirectory.appendingPathComponent("diceroll.json")
        @State private var gameResults = [GameResults]()
        
        
        var body: some View {
            VStack {
                if gameResults.count > 0 {
                    List (gameResults) { result in
                        Text("You rolled: \(result.rollResult)")
                        
                    }
                } else {
                    Text("No Results Found")
                        .font(.headline)
                }
            }
            .onAppear {
                loadResults()
            }
            .navigationBarTitle("Your rolls", displayMode: .inline)

        }
        
        
        func loadResults() {
            do {
                let data = try Data(contentsOf: savePath)
                gameResults = try JSONDecoder().decode([GameResults].self, from: data)
                
            } catch {
                gameResults = []
            }
        }
        
}

#Preview {
    RollResultsView()
}
