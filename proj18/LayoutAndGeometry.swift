//
//  LayoutAndGeometry.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/20.
//

import SwiftUI

struct LayoutAndGeometry: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    @State private var myhue = 1.0
    
       var body: some View {
           GeometryReader { fullView in
               ScrollView(.vertical) {
                   ForEach(0..<50) { index in
                       GeometryReader { proxy in
                           Text("Row #\(index)")
                               .font(.title)
                               .frame(maxWidth: .infinity)
                               .background(Color(hue:(proxy.frame(in: .global).midY)/(proxy.frame(in: .global).maxY),saturation: (proxy.frame(in: .global).midY)/(proxy.frame(in: .global).maxY), brightness: (proxy.frame(in: .global).midY)/(proxy.frame(in: .global).maxY),opacity: 1))
//                               .background(colors[index % 7])
                               .opacity((proxy.frame(in: .global).midY)<300.0 ? (proxy.frame(in: .global).midY)/300 : 1)
                               .rotation3DEffect(.degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                               .scaleEffect((((proxy.frame(in: .global).midY)-400.0 )/400.0 + 1.0))

                       }
                       .frame(height: 40)
                   }
               }
           }
       }
}


#Preview {
    LayoutAndGeometry()
}
