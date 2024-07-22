//
//  ObservableTest.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/21.
//

import SwiftUI

@Observable
class Player {
    var name = "Anonymous"
    var highScore = 0
}
struct HighScoreView: View {
    @Environment(Player.self) var player  // use the environment variable

    var body: some View {
        @Bindable var player = player // a workaround to write the environment

        Text("Your high score: \(player.highScore)")
        Stepper("High score: \(player.highScore)", value: $player.highScore)
            
    }
}

struct ObservableTest: View {
    @State private var player = Player()
    
    var body: some View {
        VStack {
            Text("Welcome!")
            HighScoreView()
        }
        .environment(player)  // register the variable, then other view can use it
    }
}

#Preview {
    ObservableTest()
}
