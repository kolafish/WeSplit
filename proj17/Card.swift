//
//  Card.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/17.
//

import Foundation

struct Card : Codable{
    var prompt: String
    var answer: String

    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
