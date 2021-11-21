//
//  EmojiMemoryGame.swift
//  Memorize3.0
//
//  Created by sun on 2021/11/21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    @Published private var model: MemoryGame<String>

    // link this with PaletteChooser later
    // do i need to make this published..?
    var chosenTheme: Theme
    
    static func createMemoryGame(of theme: Theme) -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: theme.numberOfPairsOfCards) { index in
            theme.emojis.map {String($0)}[index]
        }
    }
    
    init(theme: Theme) {
        chosenTheme = theme
        chosenTheme.emojis = chosenTheme.emojis.shuffled().reduce(into: "") { sofar, element in
            sofar.append(element)
        }
        model = EmojiMemoryGame.createMemoryGame(of: chosenTheme)
    }
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func startNewGame() {
        model = EmojiMemoryGame.createMemoryGame(of: chosenTheme)
    }
}
