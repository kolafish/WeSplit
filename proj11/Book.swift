//
//  Book.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/4.
//

import Foundation
import SwiftData

@Model
class Book {
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    var addDate : Date?
    
    
    init(title: String, author: String, genre: String, review: String, rating: Int) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
        addDate = Date.now
    }
    
//    var hasValidBook: Bool {
//        if author.isEmpty || title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty  {
//            return false
//        }
//
//        return true
//    }
    
    var formattedLaunchDate2: String {
        addDate?.formatted(date: .complete, time: .standard) ?? "N/A"
    }
    var formattedLaunchDate1: String {
        addDate?.formatted(date: .abbreviated, time: .shortened) ?? "N/A"
    }
}
