//
//  proj6ch.swift
//  WeSplit
//
//  Created by Kola on 2024/6/30.
//

import SwiftUI

struct proj6ch: View {
//    @State private var animationAmount = 0.0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var totalScore = 0
    @State private var goingReset = false
    @State private var totalCount = 0
    @State private var animationAmount = [0.0,0.0,0.0]
    @State private var scaleAmount = [1.0,1.0,1.0]
    @State private var opacityAmount = [1.0,1.0,1.0]



    let  upperTime = 5
    
    
    
    
    
    
    var body: some View {
        ZStack {
            //            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
            //                .ignoresSafeArea()
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                        //                            .foregroundStyle(.white)
                            .font(.largeTitle.weight(.semibold))
                        
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            withAnimation(.easeInOut(duration: 1)) {
                                animationAmount[number] += 360
                                for i in 0..<scaleAmount.count {
                                    scaleAmount[i] = i == number ? 1.0 : 0.5
                                    opacityAmount[i] = i == number ? 1.0 : 0.4
                                }
                            }
                        } label: {
                            FlagImage(text:countries[number])
                        }
                        .rotation3DEffect( .degrees(animationAmount[number]) , axis: (x: 0, y: 1, z: 0))
                        .scaleEffect(scaleAmount[number])
                        .opacity(opacityAmount[number])
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Spacer()
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
        if number == correctAnswer {
            scoreTitle = "Correct"
            totalScore += 1
        } else {
            scoreTitle = "Wrong!\nThat's the flag of \(countries[number])"
        }
        showingScore = true


    }
    func askQuestion() {
        
        totalCount += 1
        if (totalCount >= upperTime) {
            goingReset = true
            return
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        for i in 0..<scaleAmount.count {
            scaleAmount[i] =  1.0
            opacityAmount[i] = 1.0
        }
    }
    func reset() {
        totalCount = 0
        totalScore = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        for i in 0..<scaleAmount.count {
            scaleAmount[i] =  1.0
            opacityAmount[i] = 1.0
        }
    }
    
    struct FlagImage: View {
        var text: String
        var body: some View {
            Image(text)
                .clipShape(.capsule)
                .shadow(radius: 5)
        }
    }
}




#Preview {
    proj6ch()
}