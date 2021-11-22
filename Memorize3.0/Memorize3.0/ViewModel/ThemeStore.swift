//
//  ThemeStore.swift
//  Memorize3.0
//
//  Created by sun on 2021/11/21.
//

import SwiftUI

class ThemeStore: ObservableObject {
    
    let name: String
    
    @Published var themes = [Theme]() {
        didSet {
            print("move in store : \(themes)")
            print("current number of themes: \(themes.count)")
            storeInUserDefaults()
        }
    }
    
    init(named name: String) {
        self.name = name
        restoreFromUserDefaults()
        if themes.isEmpty {
            print("Uh-oh empty themes...inserting defaults...")
            insertTheme(named: "Vehicles", emojis: "🚗🛴✈️🛵⛵️🚎🚐🚛🚂🚊🚀🚁🚢🛶🛥🚞🚟🚃", numberOfPairsOfCards: 5, cardColor: "red")
            insertTheme(named: "AnimalFaces", emojis: "🐶🐱🐭🐹🐰🦊🐻🐼🐻‍❄️🐨🐯🦁🐷🐵", numberOfPairsOfCards: 8, cardColor: "green")
            insertTheme(named: "Food", emojis: "🍔🥐🍕🥗🥟🍣🍪🍚🍝🥙🍭🍤🥞🍦🍛🍗", numberOfPairsOfCards: 10, cardColor: "blue")
            insertTheme(named: "Hearts", emojis: "❤️🧡💛💚💙💜", numberOfPairsOfCards: 4, cardColor: "orange")
            insertTheme(named: "Sports", emojis: "⚽️🏀🏈⚾️🎾🏉🥏🏐🎱🏓🏸🏒🥊🚴‍♂️🏊🧗‍♀️🤺🏇🏋️‍♀️⛸⛷🏄🤼", numberOfPairsOfCards: 12, cardColor: "gray")
            insertTheme(named: "Weather", emojis: "☀️🌪☁️☔️❄️", numberOfPairsOfCards: 3, cardColor: "pink")
        } else {
            print("Themes Successfully retrieved from UserDefaults!")
        }
//        themes = []
    }

    
    // MARK: - Save & Load Themes
    
    private var userDefaultsKey: String {
        "ThemeStore" + name
    }
    
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(themes), forKey: userDefaultsKey)
    }
    
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodeThemes = try? JSONDecoder().decode([Theme].self, from: jsonData) {
            themes = decodeThemes
        }
    }
    
    // MARK: - Intent(s)
    
    func theme(at index: Int) -> Theme {
        let safeIndex = min(max(index, 0), themes.count - 1)
        return themes[safeIndex]
    }
    
    
    func insertTheme(named name: String, emojis: String? = nil, numberOfPairsOfCards: Int = 2, cardColor: String, at index: Int = 0) {
        let unique = (themes.max(by: { $0.id < $1.id })?.id ?? 0) + 1
        let theme = Theme(name: name, emojis: emojis ?? "", numberOfPairsOfCards: numberOfPairsOfCards, cardColor: cardColor, id: unique)
        let safeIndex = min(max(index, 0), themes.count)
        themes.insert(theme, at: safeIndex)
        
    }
    
    func removeTheme(at index: Int) {
        if themes.count > 1, themes.indices.contains(index) {
            themes.remove(at: index)
        }
    }
}
