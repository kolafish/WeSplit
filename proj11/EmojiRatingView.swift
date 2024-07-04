//
//  EmojiRatingView.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/4.
//

import SwiftUI

struct EmojiRatingView: View {
    let rating: Int

       var body: some View {
           switch rating {
           case 1:
               Text("①")
           case 2:
               Text("②")
           case 3:
               Text("③")
           case 4:
               Text("④")
           default:
               Text("⑤")
           }
       }
}

#Preview {
    EmojiRatingView(rating: 3)
}
