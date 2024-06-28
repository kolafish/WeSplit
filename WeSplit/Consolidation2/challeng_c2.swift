//
//  challeng_c2.swift
//  WeSplit
//
//  Created by Kola on 2024/6/28.
//

import SwiftUI

struct challeng_c2: View {
    let pos = ["✌️", "✊", "✋"]
    @State private var showPos = Int.random(in: 0...2)
    @State private var winornot = Bool.random()
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var totalScore = 0
    @State private var goingReset = false
    @State private var totalCount = 0
    let  upperTime = 5




    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack {
                Spacer()

                Text("Choose the right")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(.white)
                VStack(spacing: 25) {
                    VStack {
                        Text("the App pos")
                            .foregroundStyle(.secondary)
                            .font(.system(size: 24).weight(.heavy))


                        Text(pos[showPos])
//                            .foregroundStyle(.white)
                            .font(.system(size: 42).weight(.semibold))
                        Text("Try to " + (winornot ? "Win" : "Lose"))
                            .foregroundStyle(.secondary)
                            .font(.title.weight(.heavy))

                    }
                    HStack {
                        ForEach(0..<3) { number in
                            Button {
                                flagTapped(number)
                            } label: {
                                FlagImage2(text:pos[number])
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
            .clipShape(.rect(cornerRadius: 20))
//                Spacer()
//                Spacer()
                Text("Score: \(totalScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()

        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(totalScore)")
        }
        .alert("到达游戏上限", isPresented: $goingReset) {
            Button("再来一次", action: reset)
        } message: {
            Text("Your total Score is \(totalScore)")
            Text("Your total time is \(totalCount)")

        }

    }
    func flagTapped(_ number: Int) {
        var isright = false
        switch showPos{
        case  0:
            isright  = winornot ? (number == 1 ? true : false) : (number == 2 ? true : false)
        case  1:
            isright  = winornot ? (number == 2 ? true : false) : (number == 0 ? true : false)
        case 2:
            isright  = winornot ? (number == 0 ? true : false) : (number == 1 ? true : false)
        default:
            isright = false
        }
        if isright  {
            scoreTitle = "Correct"
            totalScore += 1
        } else {
            scoreTitle = "Oppppps...Wrong!"
        }
        showingScore = true
    }
    func askQuestion() {

        totalCount += 1
        if (totalCount >= upperTime) {
            goingReset = true
            return
        }
        showPos = Int.random(in: 0...2)
        winornot = Bool.random()
        
    }
    func reset() {
        totalCount = 0
        totalScore = 0
        showPos = Int.random(in: 0...2)
        winornot = Bool.random()
    }
}

struct FlagImage2: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.system(size: 50))
    }
}

#Preview {
    challeng_c2()
}


