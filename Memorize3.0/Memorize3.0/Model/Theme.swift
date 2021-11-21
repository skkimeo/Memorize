//
//  Theme.swift
//  Memorize3.0
//
//  Created by sun on 2021/11/21.
//

import Foundation

struct Theme: Codable, Identifiable {
    var name: String
    var emojis: String
    var numberOfPairsOfCards: Int
    var cardColor: String // type of color?
    let id: UUID
    
    init(name: String, emojis: String, numberOfPairsOfCards: Int, cardColor: String) {
        self.name = name
        self.emojis = emojis
        self.numberOfPairsOfCards = max(2, min(numberOfPairsOfCards, emojis.count))
        self.cardColor = cardColor
        self.id = UUID()
    }
}
