//
//  PhotoShareTest.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/10.
//

import SwiftUI
import StoreKit


struct PhotoShareTest: View {
    @Environment(\.requestReview) var requestReview

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        ShareLink(item: URL(string: "https://www.hackingwithswift.com")!)
        ShareLink(item: URL(string: "https://www.hackingwithswift.com")!, subject: Text("Learn Swift here"), message: Text("Check out the 100 Days of SwiftUI!"))
        ShareLink(item: URL(string: "https://www.hackingwithswift.com")!) {
            Label("Spread the word about Swift", systemImage: "swift")
        }
        
        let example = Image(.example)

        ShareLink(item: example, preview: SharePreview("Singapore Airport", image: example)) {
            Label("Click to share", systemImage: "airplane")
        }
        
        Button("Leave a review") {
            requestReview()
        }

    }
}

#Preview {
    PhotoShareTest()
}
