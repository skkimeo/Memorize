//
//  Theme.swift
//  Memorize3.0
//
//  Created by sun on 2021/11/21.
//

import Foundation

struct Theme: Codable, Identifiable, Hashable {
    var name: String
    var emojis: String
    var numberOfPairsOfCards: Int
    var color: RGBAColor
//    var color: RGBAColor
    let id: Int
    
    init(name: String, emojis: String, numberOfPairsOfCards: Int, color: RGBAColor, id: Int) {
        self.name = name
        self.emojis = emojis
        self.numberOfPairsOfCards = max(2, min(numberOfPairsOfCards, emojis.count))
        self.color = color
        self.id = id
    }
}

struct RGBAColor: Codable, Equatable, Hashable {
    let red: Double
    let green: Double
    let blue: Double
    let alpha: Double
}
