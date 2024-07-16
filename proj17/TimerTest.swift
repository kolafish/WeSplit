//
//  TimerTest.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/16.
//

import SwiftUI

struct TimerTest: View {
//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    
    @Environment(\.scenePhase) var scenePhase

       @State private var counter = 0
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var scale = 1.0
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency


       var body: some View {
           Text("Hello, World!")
               .onReceive(timer) { time in
                   if counter >= 5 {
                       timer.upstream.connect().cancel()
                   } else {
                       print("The time2 is now \(time)")
                   }

                   counter += 1
               }
           Text("Hello, world!")
                       .onChange(of: scenePhase) { oldPhase, newPhase in
                           if newPhase == .active {
                               print("Active")
                           } else if newPhase == .inactive {
                               print("Inactive")
                           } else if newPhase == .background {
                               print("Background")
                           }
                       }
           HStack {
                       if differentiateWithoutColor {
                           Image(systemName: "checkmark.circle")
                       }

                       Text("Success")
                   }
                   .padding()
                   .background(differentiateWithoutColor ? .black : .green)
                   .foregroundStyle(.white)
                   .clipShape(.capsule)
           Button("Hello, World!") {
                      if reduceMotion {
                          scale *= 1.5
                      } else {
                          withAnimation {
                              scale *= 1.5
                          }
                      }

                  }
                  .scaleEffect(scale)
           Button("Hello, World!") {
               withOptionalAnimation {
                   scale *= 1.5
               }

           }
           .scaleEffect(scale)
           
           Text("Hello, World!")
                       .padding()
                       .background(reduceTransparency ? .black : .black.opacity(0.5))
                       .foregroundStyle(.white)
                       .clipShape(.capsule)
       }
    
    func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
        if UIAccessibility.isReduceMotionEnabled {
            return try body()
        } else {
            return try withAnimation(animation, body)
        }
    }
}

#Preview {
    TimerTest()
}
