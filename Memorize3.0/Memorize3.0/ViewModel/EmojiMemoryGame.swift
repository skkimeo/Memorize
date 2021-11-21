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
    var chosenTheme: Theme
//    Theme(name: "Hearts", emojis: "❤️🧡💛💚💙💜", numberOfPairsOfCards: 4, cardColor: "orange")
    
    static func createMemoryGame(of theme: Theme) -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: theme.numberOfPairsOfCards) { index in
            theme.emojis.map {String($0)}[index]
        }
    }
    
    init() {
        chosenTheme = Theme(name: "Hearts", emojis: "❤️🧡💛💚💙💜", numberOfPairsOfCards: 4, cardColor: "orange")
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

//class EmojiMemoryGame: ObservableObject {
////    static private var vehicleEmojis = ["🚗", "🛴", "✈️", "🛵", "⛵️", "🚎", "🚐", "🚛", "🛻", "🏎", "🚂", "🚊", "🚀", "🚁", "🚢", "🛶", "🛥", "🚞", "🚟", "🚃"]
////    static private var animalEmojis = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐵"]
////    static private var foodEmojis = ["🍔", "🥐", "🍕", "🥗", "🥟", "🍣", "🍪", "🍚", "🍝", "🥙", "🍭", "🍤", "🥞", "🍦", "🍛", "🍗"]
////    static private var heartEmojis = ["❤️", "🧡", "💛", "💚", "💙", "💜"]
////    static private var sportsEmojis = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏉", "🥏", "🏐", "🎱", "🏓", "🏸", "🏒", "🥊", "🚴‍♂️", "🏊", "🧗‍♀️", "🤺", "🏇", "🏋️‍♀️", "⛸", "⛷", "🏄", "🤼"]
////    static private var weatherEmojis = ["☀️", "🌪", "☁️", "☔️", "❄️"]
////
////    static private let colors = ["black", "gray", "red", "green", "blue", "orange",
////    "yellow", "pink", "purple", "fushia", "beige", "gold"]
////
//    static func getColor(_ chosenColor: String) -> Color {
//        switch chosenColor {
//        case "black":
//            return .black
//        case "gray":
//            return .gray
//        case "red":
//            return .red
//        case "green":
//            return .green
//        case "blue":
//            return .blue
//        case "orange":
//            return .orange
//        case "yellow":
//            return .yellow
//        case "pink":
//            return .pink
//        case "purple":
//            return .purple
//        default:
//            return .red
//        }
//    }
////    static func createTheme(_ name: String, _ emojis: [String], _ defaultPairsOfCards: Int) -> Theme {
////        let color = colors.randomElement()!
////        var numberOfParisOfCards = defaultPairsOfCards
////
////        if emojis.count < defaultPairsOfCards {
////            numberOfParisOfCards = emojis.count
////        }
////
////        return Theme(name: name, emojis: reduce( emojis.shuffled(), numberOfPairsOfCards: numberOfParisOfCards, cardColor:
//
//    func arrayToString(_ emojis: [String]) {
//        emojis.reduce(into: "") { sofar, element in
//            sofar.append(element)
//        }
//    }
//
//
//    static func createMemoryGame(of chosenTheme: Theme) -> MemoryGame<String> {
//        var numberOfPairsOfCards = chosenTheme.numberOfPairsOfCards
//        return MemoryGame(numberOfPairsOfCards: numberOfPairsOfCards) {
//            chosenTheme.emojis.map { String($0) }
//    }
//
//    var chosenTheme: Theme
//    private(set) var chosenColor: Color?
//    @Published private var model: MemoryGame<String>
//
//
//    init() {
//        MemoryGame(
//        chosenTheme = EmojiMemoryGame.chosenTheme()
//        model = EmojiMemoryGame.createMemoryGame(of: chosenTheme)
//        chosenColor = EmojiMemoryGame.getColor(chosenTheme.cardColor)
//    }
//
//    var cards: [MemoryGame<String>.Card] {
//        model.cards
//    }
//
//    var score: Int {
//        model.score
//    }
//    // MARK: - Intent(s)
//
//    func choose(_ card: MemoryGame<String>.Card) {
//        model.choose(card)
//    }
//
//    func startNewGame() {
//        chosenTheme = EmojiMemoryGame.choseTheme()
//        chosenColor = EmojiMemoryGame.getColor(chosenTheme.cardColor)
//        model = EmojiMemoryGame.createMemoryGame(of: chosenTheme)
//    }
//}

