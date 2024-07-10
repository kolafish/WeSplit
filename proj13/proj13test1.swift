//
//  proj13test1.swift
//  WeSplit
//
//  Created by Kola on 2024/7/10.
//

import SwiftUI

struct proj13test1: View {
    @State private var blurAmount = 0.0 {
        didSet {
            print("New value is \(blurAmount)")
        }
    }
    @State private var showingConfirmation = false
    @State private var backgroundColor = Color.white

     var body: some View {
         VStack {
             Text("Hello, World!")
                 .blur(radius: blurAmount)

             Slider(value: $blurAmount, in: 0...20)
                 .onChange(of: blurAmount) { oldValue, newValue in
                     print("Now New value is \(newValue)")
                 }

             Button("Random Blur") {
                 blurAmount = Double.random(in: 0...20)
             }
             
             Button("Hello, World!") {
                 showingConfirmation = true
             }
             .frame(width: 300, height: 300)
             .background(backgroundColor)
             .confirmationDialog("Change background", isPresented: $showingConfirmation) {
                 Button("Red") { backgroundColor = .red }
                 Button("Green") { backgroundColor = .green }
                 Button("Blue") { backgroundColor = .blue }
                 Button("Cancel", role: .cancel) { }
             } message: {
                 Text("Select a new color")
             }
         }
     }
}

#Preview {
    proj13test1()
}
