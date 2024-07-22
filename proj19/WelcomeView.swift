//
//  WelcomeView.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/22.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to SnowSeeker!")
                .font(.largeTitle)

            Text("Please select a resort from the left-hand menu; swipe from the left edge to show it.")
                .foregroundStyle(.secondary)
        }    }
}

#Preview {
    WelcomeView()
}
