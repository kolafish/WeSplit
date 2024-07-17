//
//  Flashzilla.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/15.
//

import SwiftUI

struct Flashzilla: View {
    @State private var cards = Array<Card>(repeating: .example, count: 10)

    var body: some View {
        ZStack {
            Image(.background)
                .resizable()
                .ignoresSafeArea()
                VStack {
                    ZStack {
                        ForEach(0..<cards.count, id: \.self) { index in
                            CardView(card: cards[index]) {
                               withAnimation {
                                   removeCard(at: index)
                               }
                            }
                            .stacked(at: index, in: cards.count)
                        }
                    }
                }
            }
    }
    func removeCard(at index: Int) {
        cards.remove(at: index)
    }
}
extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(y: offset * 10)
    }
}

#Preview {
    Flashzilla()
}
