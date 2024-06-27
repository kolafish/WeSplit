//
//  GuessTheFlag.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/6/27.
//

import SwiftUI

struct GuessTheFlag: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                Text("X")
                Text("X")
                Text("X")
            }
            VStack(alignment: .leading){
                Text("X")
                Text("X")
                Text("X")
            }
            VStack(alignment: .leading){
                Text("X")
                    .background(Color(red: 1, green: 0.8, blue: 0))
                Text("X")
                    .background(Color.secondary)
                Text("X")
                    .background(.ultraThinMaterial)
            }
        }
        ZStack {
            Text("Your content")
                .background(.red)
        }
        ZStack {
            Color.indigo
                .frame(width: 200, height: 200)
            Text("Your content")
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
