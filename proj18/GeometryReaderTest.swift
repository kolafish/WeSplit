//
//  GeometryReaderTest.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/20.
//

import SwiftUI
// containerRelativeFrame modifier also works
struct GeometryReaderTest: View {
    var body: some View {
//        GeometryReader { proxy in
//            Image(.example)
//                .resizable()
//                .scaledToFit()
//                .frame(width: proxy.size.width * 0.6)
//        }
        
        HStack {
            Text("IMPORTANT")
                .frame(width: 200)
                .background(.blue)
            GeometryReader { proxy in
                Image(.example)
                    .resizable()
                    .scaledToFit()
                    .frame(width: proxy.size.width * 0.8)
                    .frame(width: proxy.size.width, height: proxy.size.height)

            }

        }
        HStack {
            Text("IMPORTANT")
                .frame(width: 200)
                .background(.blue)
            Image(.example)
                .resizable()
                .scaledToFit()
                .containerRelativeFrame(.horizontal) { size, axis in
                    size * 0.8
                }
        }
        VStack {
            GeometryReader { proxy in
                Text("Hello, World!")
                    .frame(width: proxy.size.width * 0.9, height: 40)
                    .background(.red)
            }
            .background(.green)
            
            Text("More text")
                .background(.blue)
        }
    }
}

#Preview {
    GeometryReaderTest()
}
