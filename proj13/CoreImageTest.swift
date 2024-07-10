//
//  CoreImageTest.swift
//  WeSplit
//
//  Created by Kola on 2024/7/10.
//

import SwiftUI

struct CoreImageTest: View {
    @State private var image: Image?

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }

    func loadImage() {
        image = Image(.example)
    }
}

#Preview {
    CoreImageTest()
}
