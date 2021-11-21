//
//  ThemeStore.swift
//  Memorize3.0
//
//  Created by sun on 2021/11/21.
//

import SwiftUI

class ThemeStore: ObservableObject {
    @Published var themes = [Theme]()
    
    init() {
        loadThemes()
        if themes.isEmpty {
            themes.append(Theme(name: "Vehicles", emojis: "🚗🛴✈️🛵⛵️🚎🚐🚛🚂🚊🚀🚁🚢🛶🛥🚞🚟🚃", numberOfPairsOfCards: 5, cardColor: "red"))
            themes.append(Theme(name: "AnimalFaces", emojis: "🐶🐱🐭🐹🐰🦊🐻🐼🐻‍❄️🐨🐯🦁🐷🐵", numberOfPairsOfCards: 8, cardColor: "green"))
            themes.append(Theme(name: "Food", emojis: "🍔🥐🍕🥗🥟🍣🍪🍚🍝🥙🍭🍤🥞🍦🍛🍗", numberOfPairsOfCards: 10, cardColor: "blue"))
            themes.append(Theme(name: "Hearts", emojis: "❤️🧡💛💚💙💜", numberOfPairsOfCards: 4, cardColor: "orange"))
            themes.append(Theme(name: "Sprots", emojis: "⚽️🏀🏈⚾️🎾🏉🥏🏐🎱🏓🏸🏒🥊🚴‍♂️🏊🧗‍♀️🤺🏇🏋️‍♀️⛸⛷🏄🤼", numberOfPairsOfCards: 12, cardColor: "gray"))
            themes.append(Theme(name: "Weather", emojis: "☀️🌪☁️☔️❄️", numberOfPairsOfCards: 3, cardColor: "pink"))
        }
    }
    
    // MARK: - Save & Load Themes
    
    private func saveThemes() {
        
    }
    
    private func loadThemes() {
        
    }
    
    // MARK: - Add and Remove Themes
    
    private func addTheme() {
        
    }
    
    private func removeTheme() {
        
    }
    
    
    
}
