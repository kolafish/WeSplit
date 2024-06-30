//
//  AnimationTest.swift
//  WeSplit
//
//  Created by Kola on 2024/6/29.
//

import SwiftUI

struct AnimationTest: View {
    @State private var animationAmount = 1.0

    @State private var enabled = false
    @State private var enabled3 = false


    var body: some View {
        print(animationAmount)

       return VStack {
//            Stepper("Scale amount", value: $animationAmount.animation(
//                .easeInOut(duration: 1)
//                        .repeatCount(3, autoreverses: true)            ), in: 1...10)
//
//            Spacer()

            Button("Tap Me") {
//                animationAmount += 360
                withAnimation(.spring(duration: 1, bounce: 0.5)) {
                    animationAmount += 360
                }
            }
            .padding(40)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
//            .scaleEffect(animationAmount)
            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))

           Button("Tap Me 2") {
               enabled.toggle()

               }
           .padding(40)
           .background(enabled ? .blue : .red)
           .clipShape(.rect(cornerRadius: enabled ? 60 : 0))
           .animation(.default, value: enabled)
           
           Button("Tap Me3") {
               enabled3.toggle()
           }
           .frame(width: 200, height: 200)
           .background(enabled3 ? .blue : .red)
           .animation(.default, value: enabled3)
//           .animation(nil, value: enabled3)
           .foregroundStyle(.white)
           .clipShape(.rect(cornerRadius: enabled3 ? 60 : 0))
           .animation(.spring(duration: 1, bounce: 0.6), value: enabled3)

        }
//        Button("Tap Me") {
//            // do nothing
////            animationAmount += 1
//        }
//        .padding(50)
//        .background(.red)
//        .foregroundStyle(.white)
//        .clipShape(.circle)
////        .scaleEffect(animationAmount)
////        .blur(radius: (animationAmount - 1) * 3)
////        .animation(.default, value: animationAmount)
////        .animation(.linear, value: animationAmount)
////        .animation(.spring(duration: 1, bounce: 0.9), value: animationAmount)
////        .animation(.easeInOut(duration: 2), value: animationAmount)
//        .overlay(
//            Circle()
//                .stroke(.red)
//                .scaleEffect(animationAmount)
//                .opacity(2 - animationAmount)
//                .animation(
//                    .easeOut(duration: 1)
//                        .repeatForever(autoreverses: false),
//                    value: animationAmount
//                )
//        )
//        .onAppear {
//            animationAmount = 2
//        }
////        .animation(
////            .easeInOut(duration: 1)
////                .repeatCount(3, autoreverses: true),
////            value: animationAmount
////        )
//



    }

}

#Preview {
    AnimationTest()
}
