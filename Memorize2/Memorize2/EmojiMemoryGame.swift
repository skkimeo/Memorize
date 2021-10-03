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
    static var heartEmojis = ["❤️", "🧡", "💛", "💚", "💙", "💜"]
    static var sportsEmojis = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏉", "🥏", "🏐", "🎱", "🏓", "🏸", "🏒", "🥊", "🚴‍♂️", "🏊", "🧗‍♀️", "🤺", "🏇", "🏋️‍♀️", "⛸", "⛷", "🏄", "🤼"]
    static var weatherEmojis = ["☀️", "🌪", "☁️", "☔️", "❄️"]
    
    //color: black, gray, red, green, blue, orange, yellow, pink, purple

    static var themes: [Theme] {
        var themes = [Theme]()
        let numberOfPairsOfCards = 8
        let color = "red"  // need to have random color  mechanism
        themes.append(Theme(name: "Vehicles", emojis: vehicleEmojis.shuffled(), numberOfPairsOfCards: numberOfPairsOfCards, cardColor: color))
        themes.append(Theme(name: "Animals", emojis: animalEmojis.shuffled(), numberOfPairsOfCards: numberOfPairsOfCards, cardColor: color))
        themes.append(Theme(name: "Food", emojis: foodEmojis.shuffled(), numberOfPairsOfCards: numberOfPairsOfCards, cardColor: color))
        themes.append(Theme(name: "Hearts", emojis: heartEmojis.shuffled(), numberOfPairsOfCards: numberOfPairsOfCards, cardColor: color))
        themes.append(Theme(name: "Sports", emojis: sportsEmojis.shuffled(), numberOfPairsOfCards: numberOfPairsOfCards, cardColor: color))
        themes.append(Theme(name: "Weather", emojis: weatherEmojis.shuffled(), numberOfPairsOfCards: numberOfPairsOfCards, cardColor: color))
        return themes
    }
    
    static func createMemoryGame(of chosenTheme: Theme) -> MemoryGame<String> {
        var numberOfPairsOfCards = chosenTheme.numberOfPairsOfCards
        if chosenTheme.emojis.count < chosenTheme.numberOfPairsOfCards {
            numberOfPairsOfCards = chosenTheme.emojis.count
        }
        return MemoryGame(numberOfPairsOfCards: numberOfPairsOfCards) { chosenTheme.emojis[$0] }
    }
    
    var chosenTheme: Theme
    @Published private var model: MemoryGame<String>
    
    static func choseTheme() -> Theme {
        EmojiMemoryGame.themes.randomElement()!
    }
    
    init() {
        chosenTheme = EmojiMemoryGame.choseTheme()
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
        chosenTheme = EmojiMemoryGame.choseTheme()
        model = EmojiMemoryGame.createMemoryGame(of: chosenTheme )
    }
}
