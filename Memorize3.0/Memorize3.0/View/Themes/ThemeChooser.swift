//
//  ThemeChooser.swift
//  Memorize3.0
//
//  Created by sun on 2021/11/21.
//

import SwiftUI

struct ThemeChooser: View {
    @EnvironmentObject var store: ThemeStore {
        willSet {
//            if store.themes != newValue.themes {
            print("movedddddd \(store.themes)")
            games = [:]
            updateGames(from: newValue.themes)
//            }
        }
    }
    
    @State private var games = [Theme: EmojiMemoryGame]()
    
    @State private var lastPlayedGame : EmojiMemoryGame?
    
    
    private func updateGames(from: [Theme]) {
        var games = [Theme: EmojiMemoryGame]()
        store.themes.filter { $0.emojis.count >= 2 }.forEach { theme in
            games.updateValue(EmojiMemoryGame(theme: theme), forKey: theme)
        }
        self.games = games
    }
    
    @State private var editMode: EditMode = .inactive
    
    
    private func getdestination(for theme: Theme) -> some View{
//        print("vts \(games)")
        print("vts----------")
//        updateGames()
        print("vts \(theme)")
        print("vts \(store.themes.contains(theme))")
//        if games[theme.id] == nil {
//            games.updateValue(EmojiMemoryGame(theme: theme), forKey: theme.id)
////            return
//        }
        if games[theme] == nil {
            let newGame = EmojiMemoryGame(theme: theme)
            games.updateValue(newGame, forKey: theme)
            print("editted...!for \(theme)")
            return EmojiMemoryGameView(game: newGame)
        }
        return EmojiMemoryGameView(game: games[theme]!)
    }
    
    var body: some View {
        NavigationView {
            if !games.isEmpty {
            List {
                ForEach(store.themes.filter { $0.emojis.count > 1 }) { theme in
//                    NavigationLink(destination: EmojiMemoryGameView(game: EmojiMemoryGame(theme: theme))) {
                    NavigationLink(destination: getdestination(for: theme)) {
                        themeRow(for: theme)
                    }
                    .gesture(editMode == .active ? tapToOpenThemeEditor(for: theme) : nil)
                }
                .onDelete { indexSet in
                    indexSet.forEach { store.removeTheme(at: $0) }
                }
                .onMove { fromOffsets, toOffset in
                    store.themes.move(fromOffsets: fromOffsets, toOffset: toOffset)
                    print("after move: \(store.themes)")
                    print([1, 2, 3] != [2, 3, 1] ? "move yes" : "move no")
                }
            }
            .listStyle(.inset)
            .navigationTitle("Memorize")
            .sheet(item: $themeToEdit) {
                print("vtennnnnd")
                removeNewThemeOnDismissIfInvalid()
            } content: { theme in
                ThemeEditor(theme: $store.themes[theme])
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) { addThemeButton }
                ToolbarItem { EditButton() }
            }
            .environment(\.editMode, $editMode)
            } else {
                
            }
        }
        .stackNavigationViewStyleIfiPad()
        .onAppear { updateGames(from: store.themes) }
        .onChange(of: store.themes) { newTheme in
            games = [:]
            updateGames(from: newTheme)
        }
    }
    
    @State private var themeToEdit: Theme?
    
    private func removeNewThemeOnDismissIfInvalid() {
        if let newButInvalidTheme = store.themes.first {
            if newButInvalidTheme.emojis.count < 2 {
                store.removeTheme(at: 0)
            }
        }
    }
    
    private func themeRow(for theme: Theme) -> some View {
        VStack(alignment: .leading) {
            Text(theme.name)
                .foregroundColor(.blue)
//                .foregroundColor(theme.cardColor)
                .font(.system(size: 25))
                .bold()
            HStack {
                if theme.numberOfPairsOfCards == theme.emojis.count {
                    Text("All of \(theme.emojis)")
                } else {
                    Text("\(String(theme.numberOfPairsOfCards)) pairs from \(theme.emojis)")
                }
            }
            .lineLimit(1)
        }
    }
    
    private func tapToOpenThemeEditor(for theme: Theme) -> some Gesture {
        TapGesture()
            .onEnded {
                themeToEdit = store.themes[theme]
            }
    }
    
    private var addThemeButton: some View {
        Button {
            store.insertTheme(named: "new", cardColor: "blue")
            themeToEdit = store.themes.first
        } label : {
            Image(systemName: "plus")
                .foregroundColor(.blue)
        }
    }
}


//
//struct ThemeChooser_Previews: PreviewProvider {
//    static var previews: some View {
//        ThemeChooser()
//    }
//}
