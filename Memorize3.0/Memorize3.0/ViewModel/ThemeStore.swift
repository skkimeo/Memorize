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
            storeInUserDefaults()
        }
    }
    
    init(named name: String) {
        self.name = name
        restoreFromUserDefaults()
        if themes.isEmpty {
            print("Uh-oh empty themes...inserting defaults...")
            insertTheme(named: "AnimalFaces", emojis: "🐶🐱🐭🐹🐰🦊🐻🐼🐻‍❄️🐨🐯🦁🐷🐵", numberOfPairsOfCards: 8, color: Color(rgbaColor: RGBAColor(255, 143, 20, 1)))
            insertTheme(named: "Food", emojis: "🍔🥐🍕🥗🥟🍣🍪🍚🍝🥙🍭🍤🥞🍦🍛🍗", numberOfPairsOfCards: 10, color:Color(rgbaColor: RGBAColor(86, 178, 62, 1)))
            insertTheme(named: "Vehicles", emojis: "🚗🛴✈️🛵⛵️🚎🚐🚛🚂🚊🚀🚁🚢🛶🛥🚞🚟🚃", numberOfPairsOfCards: 5, color: Color(rgbaColor: RGBAColor(248, 218, 9, 1)))
            insertTheme(named: "Hearts", emojis: "❤️🧡💛💚💙💜", numberOfPairsOfCards: 4, color: Color(rgbaColor: RGBAColor(229, 108, 204, 1)))
            insertTheme(named: "Sports", emojis: "⚽️🏀🏈⚾️🎾🏉🥏🏐🎱🏓🏸🏒🥊🚴‍♂️🏊🧗‍♀️🤺🏇🏋️‍♀️⛸⛷🏄🤼", numberOfPairsOfCards: 12)
            insertTheme(named: "Weather", emojis: "☀️🌪☁️☔️❄️", numberOfPairsOfCards: 3, color: Color(rgbaColor: RGBAColor(37, 75, 240, 1)))
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
//        UserDefaults.standard.set(try? JSONEncoder().encode([Theme]()), forKey: userDefaultsKey)
//        for theme in themes { print("storedthemeColor: \(theme.color)") }
    }
    
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodeThemes = try? JSONDecoder().decode([Theme].self, from: jsonData) {
            themes = decodeThemes
//            for theme in themes { print("restoredthemeColor: \(theme.color)") }
        }
    }
    
    // MARK: - Intent(s)
    
    func theme(at index: Int) -> Theme {
        let safeIndex = min(max(index, 0), themes.count - 1)
        return themes[safeIndex]
    }
    
    
    func insertTheme(named name: String, emojis: String? = nil, numberOfPairsOfCards: Int = 2, color: Color = Color(rgbaColor: RGBAColor(243, 63, 63, 1)), at index: Int = 0) {
        let unique = (themes.max(by: { $0.id < $1.id })?.id ?? 0) + 1
        let theme = Theme(name: name, emojis: emojis ?? "", numberOfPairsOfCards: numberOfPairsOfCards, color: RGBAColor(color: color), id: unique)
        let safeIndex = min(max(index, 0), themes.count)
        themes.insert(theme, at: safeIndex)
        
    }
    
    func removeTheme(at index: Int) {
        if themes.count > 1, themes.indices.contains(index) {
            themes.remove(at: index)
        }
    }
}
