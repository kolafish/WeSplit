//
//  AlignmentTest.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/20.
//

import SwiftUI

extension VerticalAlignment {
    struct MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct AlignmentTest: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
                   VStack {
                       Text("@twostraws")
                           .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                       Image(.example)
                           .resizable()
                           .frame(width: 64, height: 64)
                   }
                   VStack {
                       Text("Full name:")
                       Text("PAUL HUDSON")
                           .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                           .font(.largeTitle)
                   }
               }
    }
}

#Preview {
    AlignmentTest()
}
