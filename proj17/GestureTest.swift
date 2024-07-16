//
//  GestureTest.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/15.
//

import SwiftUI

struct GestureTest: View {
    @State private var currentAmount = 0.0
    @State private var finalAmount = 1.0
    @State private var currentAmount2 = Angle.zero
    @State private var finalAmount2 = Angle.zero
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    
    var body: some View {
        Text("Hello, World!1")
            .onTapGesture(count: 2) {
                print("Double tapped!")
            }
        Text("Hello, World!2")
            .onLongPressGesture {
                print("Long pressed!")
            }
        Text("Hello, World!3")
            .onLongPressGesture(minimumDuration: 2) {
                print("Long pressed for 2 !")
            }
        Text("Hello, World!4")
            .onLongPressGesture(minimumDuration: 1) {
                print("Long pressed for 3!")
            } onPressingChanged: { inProgress in
                print("In progress: \(inProgress)!")
            }
        
        Text("Hello, World! 5")
                    .scaleEffect(finalAmount + currentAmount)
                    .gesture(
                        MagnifyGesture()
                            .onChanged { value in
                                currentAmount = value.magnification - 1
                            }
                            .onEnded { value in
                                finalAmount += currentAmount
                                currentAmount = 0
                            }
                    )
        Text("Hello, World!6")
                    .rotationEffect(currentAmount2 + finalAmount2)
                    .gesture(
                        RotateGesture()
                            .onChanged { value in
                                currentAmount2 = value.rotation
                            }
                            .onEnded { value in
                                finalAmount2 += currentAmount2
                                currentAmount2 = .zero
                            }
                    )
        VStack {
                    Text("Hello, World!7")
                        .onTapGesture {
                            print("Text tapped")
                        }
                }
                .onTapGesture {
                    print("VStack tapped")
                }
        VStack {
                  Text("Hello, World!8")
                      .onTapGesture {
                          print("Text tapped")
                      }
              }
              .highPriorityGesture(
                  TapGesture()
                      .onEnded {
                          print("VStack tapped")
                      }
              )
        VStack {
                   Text("Hello, World!9")
                       .onTapGesture {
                           print("Text tapped")
                       }
               }
               .simultaneousGesture(
                   TapGesture()
                       .onEnded {
                           print("VStack tapped")
                       }
               )
        
        let dragGesture = DragGesture()
                   .onChanged { value in offset = value.translation }
                   .onEnded { _ in
                       withAnimation {
                           offset = .zero
                           isDragging = false
                       }
                   }

               // a long press gesture that enables isDragging
               let pressGesture = LongPressGesture()
                   .onEnded { value in
                       withAnimation {
                           isDragging = true
                       }
                   }

               // a combined gesture that forces the user to long press then drag
               let combined = pressGesture.sequenced(before: dragGesture)

               // a 64x64 circle that scales up when it's dragged, sets its offset to whatever we had back from the drag gesture, and uses our combined gesture
               Circle()
                   .fill(.red)
                   .frame(width: 64, height: 64)
                   .scaleEffect(isDragging ? 1.5 : 1)
                   .offset(offset)
                   .gesture(combined)
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 160, height: 160)
                .onTapGesture {
                    print("Rectangle tapped!")
                }

            Circle()
                .fill(.red)
                .frame(width: 160, height: 160)
                .onTapGesture {
                    print("Circle tapped!")
                }
        }
        Circle()
            .fill(.red)
            .frame(width: 150, height: 150)
            .onTapGesture {
                print("Circle tapped!")
            }
            .allowsHitTesting(false)
        Circle()
            .fill(.red)
            .frame(width: 150, height: 150)
            .contentShape(.rect)
            .onTapGesture {
                print("Circle tapped!")
            }
        VStack {
            Text("Hello")
            Spacer().frame(height: 100) // no gesture on the space
            Text("World")
        }
        .onTapGesture {
            print("VStack tapped!")
        }
        VStack {
            Text("Hello")
            Spacer().frame(height: 100)
            Text("World")
        }
        .contentShape(.rect)
        .onTapGesture {
            print("VStack tapped!")
        }
    }
}

#Preview {
    GestureTest()
}
