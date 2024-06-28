//
//  CustomContainer.swift
//  WeSplit
//
//  Created by Kola on 2024/6/28.
//

import SwiftUI

struct CustomContainer: View {
    var body: some View {
        GridStack(rows: 4, columns: 4) { row, col in
            HStack {
                Image(systemName: "\(row * 4 + col).circle")
                Text("R\(row) C\(col)").MyProminentTitle()
            }
        }
    }
}


struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content

    var body: some View {
        VStack {
               ForEach(0..<rows, id: \.self) { row in
                   HStack {
                       ForEach(0..<columns, id: \.self) { column in
                           content(row, column)
                       }
                   }
               }
           }    }
}

#Preview {
    CustomContainer()
}


struct  ProminentTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .foregroundStyle(.blue)
    }
}
extension View {
    func MyProminentTitle() -> some View {
        modifier(ProminentTitle())
    }
}
