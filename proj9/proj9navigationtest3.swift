//
//  proj9navigationtest3.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/3.
//

import SwiftUI

struct proj9navigationtest3: View {
    @State private var title = "SwiftUI"

    var body: some View {
        NavigationStack {
            Text("Hello, world!")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) //better to choose the semantic options
                    {
                        Button("Me1") {
                            // button action here
                        }
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Me2") {
                            // button action here
                        }
                    }
                    ToolbarItemGroup(placement: .topBarLeading) {
                         Button("Me3") {
                             // button action here
                         }

                         Button("Me4") {
                             // button action here
                         }
                     }
                }
                .navigationBarBackButtonHidden()


            
            List(0..<100) { i in
                Text("Row \(i)")
            }
            .navigationTitle($title) // using the biding enble user to edit it
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.blue)
            .toolbarColorScheme(.dark)
            // to hide the bar
//            .toolbar(.hidden, for: .navigationBar)


        }  
    }
}

#Preview {
    proj9navigationtest3()
}
