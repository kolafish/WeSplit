//
//  PositionTest.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/20.
//

import SwiftUI

struct PositionTest: View {
    var body: some View {
//        Text("Hello, world!")
//        //            .background(.red)
//            .position(x: 100, y: 100)
////                    .background(.red)
        
        Text("Hello, world!")
//            .background(.red)
            .offset(x: 100, y: 100)
            .background(.red)

    }
}

#Preview {
    PositionTest()
}
