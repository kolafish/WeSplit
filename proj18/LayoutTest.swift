//
//  LayoutTest.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/20.
//

import SwiftUI

struct LayoutTest: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hello, world!")
                .alignmentGuide(.leading) { d in d[.trailing] }
            Text("This is a longer line of text")
        }
        .background(.red)
        .frame(width: 300, height: 300)
        .background(.blue)
        Color.red

        Text("Hello, World!\nHello World")
            .padding(20)
            .background(.red)
            .padding(30)
            .background(.gray)
        Text("Hello, World!\nHello World")
            .frame(width: 100, height: 100, alignment: .topLeading)
        HStack(alignment: .lastTextBaseline) {
            Text("Live")
                .font(.caption)
            Text("long")
            Text("and")
                .font(.title)
            Text("prosper")
                .font(.largeTitle)
        }
        VStack(alignment: .leading) {
            ForEach(0..<6) { position in
                Text("Number \(position)")
                    .alignmentGuide(.leading) { _ in Double(position) * -10 }
            }
        }
        .background(.red)
        .frame(width: 300, height: 300)
        .background(.blue)

    }
}

#Preview {
    LayoutTest()
}
