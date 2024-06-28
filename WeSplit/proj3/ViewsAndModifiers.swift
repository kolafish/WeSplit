//
//  ViewsAndModifiers.swift
//  WeSplit
//
//  Created by Kola on 2024/6/28.
//

import SwiftUI

struct ViewsAndModifiers: View {
    @State private var useRedText = false

    var body: some View {
        Button("Hello World") {
            // flip the Boolean between true and false
            useRedText.toggle()
        }
        .foregroundStyle(useRedText ? .white : .yellow)
        .padding()
        .background(.red)
        .padding()
        .background(.blue)
        .padding()
        .background(.green)
        .padding()
        .background(.yellow)
        
        VStack {
            Text("Gryffindor")
                .font(.largeTitle)
            Text("Hufflepuff")
            Text("Ravenclaw")
        }
        .font(.title)
        
        VStack {
            Text("Gryffindor")
                .blur(radius: 0)
            Text("Hufflepuff")
            Text("Ravenclaw")
        }
        .blur(radius: 5)
        
        VStack(spacing: 10) {
            CapsuleText(text: "First")
            CapsuleText(text: "Second")
                .foregroundStyle(.yellow)
                }
        Text("test modifier")
            .modifier(Title())
        Text("modifier with extension func")
            .titleStyle()
        
        Color.blue
            .frame(width: 250, height: 100)
            .watermarked(with: "Hacking with Swift")
    }
    
    struct CapsuleText: View {
        var text: String

        var body: some View {
            Text(text)
//                .font(.largeTitle)
                .padding()
//                .foregroundStyle(.white)
                .background(.blue)
                .clipShape(.capsule)
        }
    }


}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .clipShape(.rect(cornerRadius: 10))
    }
}
extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}


struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

#Preview {
    ViewsAndModifiers()
}
