//
//  button.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/6/27.
//

import SwiftUI

struct button: View {
    var body: some View {
        VStack {
            Button("Button 1") { }
                .buttonStyle(.bordered)
            Button("Button 2", role: .destructive) { }
                .buttonStyle(.bordered)
            Button("Button 3") { }
                .buttonStyle(.borderedProminent)
                .tint(.mint)
            Button("Button 4", role: .destructive) { }
                .buttonStyle(.borderedProminent)
        }
        Button("Delete selection", action: executeDelete)
        Button("Delete selection", role: .destructive, action: executeDelete22)
        Button {
            print("Button was tapped")
        } label: {
            Text("Tap me!")
                .padding()
                .foregroundStyle(.white)
                .background(.red)
        }
        Button {
            print("Edit button was tapped")
        } label: {
            Image(systemName : "pencil")
        }
        Button("Edit", systemImage: "pencil") {
            print("Edit button was tapped")
        }
    }

    func executeDelete() {
        print("deleting…")
    }
    func executeDelete22() {
        print("deleting  222222…")
    }
}

#Preview {
    button()
}
