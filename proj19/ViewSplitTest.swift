//
//  ViewSplitTest.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/20.
//

import SwiftUI

struct ViewSplitTest: View {
    var body: some View {
        NavigationSplitView {
            Text("Primary")
        } detail: {
            Text("Content")
        }
        NavigationSplitView {
            NavigationLink("Primary") {
                Text("New view")
            }
        } detail: {
            Text("Content")
        }
        NavigationSplitView(columnVisibility: .constant(.all)) {
            NavigationLink("Primary") {
                Text("New view")
            }
        } detail: {
            Text("Content")
                .navigationTitle("Content View")
        }
        .navigationSplitViewStyle(.balanced)
//        NavigationSplitView(preferredCompactColumn: .constant(.detail)) {

    }
}


#Preview {
    ViewSplitTest()
}
