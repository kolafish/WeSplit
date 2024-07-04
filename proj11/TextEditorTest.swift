//
//  TextEditorTest.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/4.
//

import SwiftUI

struct TextEditorTest: View {
    @AppStorage("notes") private var notes = ""

    var body: some View {
        NavigationStack {
            TextEditor(text: $notes)
                .navigationTitle("Notes")
                .padding()
        }
    }
}

#Preview {
    TextEditorTest()
}
