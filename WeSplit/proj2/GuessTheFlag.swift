//
//  GuessTheFlag.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/6/27.
//

import SwiftUI

struct GuessTheFlag: View {
    var body: some View {
        LinearGradient(colors: [.white, .black], startPoint: .top, endPoint: .bottom)
        Spacer()
        LinearGradient(stops: [
            Gradient.Stop(color: .white, location: 0.45),
            Gradient.Stop(color: .black, location: 0.55),
        ], startPoint: .top, endPoint: .bottom)
        RadialGradient(colors: [.blue, .black], center: .center, startRadius: 20, endRadius: 200)
        AngularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red], center: .center)
        Text("Your content")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundStyle(.white)
            .background(.red.gradient)
        HStack {
            VStack(alignment: .leading){
                Text("X")
                Text("X")
            }
            VStack(alignment: .leading){
                Text("X")
                    .background(Color(red: 1, green: 0.8, blue: 0))
                Text("X")
                    .background(Color.secondary)
            }
        }
        ZStack {
            Text("Your content")
                .background(.red)
        }
        ZStack {
            Color.indigo
                .frame(width: 50, height: 50)
            Text("Your ")
        }
//        .ignoresSafeArea()

        ZStack {
            VStack(spacing: 0) {
                Color.red
                Color.blue
            }
            Text("Your content")
                    .foregroundStyle(.secondary)
                    .padding(50)
                    .background(.ultraThinMaterial)
        }
        .ignoresSafeArea()


        
    }

}

#Preview {
    GuessTheFlag()
}
