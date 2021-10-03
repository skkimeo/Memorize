//
//  EmojiMemoryGame.swift
//  Memorize2
//
//  Created by sun on 2021/10/03.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    static var vehicleEmojis = ["🚗", "🛴", "✈️", "🛵", "⛵️", "🚎", "🚐", "🚛", "🛻", "🏎", "🚂", "🚊", "🚀", "🚁", "🚢", "🛶", "🛥", "🚞", "🚟", "🚃"]
    static var animalEmojis = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐵"]
    static var foodEmojis = ["🍔", "🥐", "🍕", "🥗", "🥟", "🍣", "🍪", "🍚", "🍝", "🥙", "🍭", "🍤", "🥞", "🍦", "🍛", "🍗"]
    static var heartEmojis = ["❤️", "🧡", "💛", "💚", "💙", "💜", "🖤", "🤍", "🤎"]
    static var sportsEmojis = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏉", "🥏", "🏐", "🎱", "🏓", "🏸", "🏒", "🥊", "🚴‍♂️", "🏊", "🧗‍♀️", "🤺", "🏇", "🏋️‍♀️", "⛸", "⛷", "🏄", "🤼"]
    static var weatherEmojis = ["☀️", "🌪", "☁️", "☔️", "❄️", "💨", "🌤", "⛈", "🌫"]

    static var themes: [Theme] {
        var themes = [Theme]()
        var numberOfPairsOfCards = 9
        var color = "red"
        themes.append(Theme(name: "Vehicles", emojis: vehicleEmojis.shuffled(), numberOfPairsOfCards: numberOfPairsOfCards, cardColor: color))
        themes.append(Theme(name: "Animals", emojis: animalEmojis.shuffled(), numberOfPairsOfCards: numberOfPairsOfCards, cardColor: color))
        themes.append(Theme(name: "Food", emojis: foodEmojis.shuffled(), numberOfPairsOfCards: numberOfPairsOfCards, cardColor: color))
        themes.append(Theme(name: "Hearts", emojis: heartEmojis.shuffled(), numberOfPairsOfCards: numberOfPairsOfCards, cardColor: color))
        themes.append(Theme(name: "Sports", emojis: sportsEmojis.shuffled(), numberOfPairsOfCards: numberOfPairsOfCards, cardColor: color))
        themes.append(Theme(name: "Weather", emojis: weatherEmojis.shuffled(), numberOfPairsOfCards: numberOfPairsOfCards, cardColor: color))
        return themes
    }
    
    static func createMemoryGame() -> MemoryGame<String> {
        let chosenTheme = themes.randomElement()!
        return MemoryGame(numberOfPairsOfCards: chosenTheme.numberOfPairsOfCards) { chosenTheme.emojis[$0] }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func startNewGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
