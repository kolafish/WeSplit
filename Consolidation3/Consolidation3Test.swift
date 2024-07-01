//
//  Consolidation3Test.swift
//  WeSplit
//
//  Created by Kola on 2024/6/30.
//

import SwiftUI


struct Consolidation3Test: View {
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    @State private var maxNum = 5
    @State private var questions = Array(repeating: "", count: 5)
    @State private var realAnswers = Array(repeating: 0, count:5)
    @State private var totalScore = 0
    @State private var tempText0 = ""
    @State private var tempText1 = ""

    @State private var tempText2 = ""

    @State private var tempText3 = ""

    @State private var tempText4 = ""


        
        var body: some View {


            NavigationStack {
                List {
                    Picker("Max Number", selection: $maxNum) {
                        ForEach(5..<12) {
                            Text("\($0) ")
                        }
                    }
                    HStack {
                            Text(questions[0])
                            TextField("answer", text: $tempText0)
                    }
                    HStack {
                            Text(questions[1])
                            TextField("answer", text: $tempText1)
                    }
                    HStack {
                            Text(questions[2])
                            TextField("answer", text: $tempText2)
                    }
                    HStack {
                            Text(questions[3])
                            TextField("answer", text: $tempText3)
                    }
                    HStack {
                            Text(questions[4])
                            TextField("answer", text: $tempText4)
                    }
                }
                .navigationTitle("MultiplicationEr")
                .onAppear(perform: prepare)
                .alert(alertTitle, isPresented: $showingAlert) {
                    Button("OK") { }
                } message: {
                    Text("Score:\(totalScore)")
                }
                .toolbar {
                    Button("Check", action: calculateScore)

                }
            }

        }
    func prepare() {
        let l = Int.random(in: 2...(maxNum+5))
        let r = Int.random(in: 2...(maxNum+5))
        realAnswers[0] = l * r
        questions[0] = "\(l) * \(r) = "
        
        let l1 = Int.random(in: 2...(maxNum+5))
        let r1 = Int.random(in: 2...(maxNum+5))
        realAnswers[1] = l1 * r1
        questions[1] = "\(l1) * \(r1) = "
        
        let l2 = Int.random(in: 2...(maxNum+5))
        let r2 = Int.random(in: 2...(maxNum+5))
        realAnswers[2] = l2 * r2
        questions[2] = "\(l2) * \(r2) = "
        
        let l3 = Int.random(in: 2...(maxNum+5))
        let r3 = Int.random(in: 2...(maxNum+5))
        realAnswers[3] = l3 * r3
        questions[3] = "\(l3) * \(r3) = "
        
        let l4 = Int.random(in: 2...(maxNum+5))
        let r4 = Int.random(in: 2...(maxNum+5))
        realAnswers[4] = l4 * r4
        questions[4] = "\(l4) * \(r4) = "

        
    }
    func calculateScore() {
        totalScore = 0
        totalScore += String(realAnswers[0]) == tempText0 ? 1: 0

        showingAlert = true
        prepare()

    }
}

#Preview {
    Consolidation3Test()
}
