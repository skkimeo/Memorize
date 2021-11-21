//
//  ThemeChooser.swift
//  Memorize3.0
//
//  Created by sun on 2021/11/21.
//

import SwiftUI

struct ThemeChooser: View {
    @EnvironmentObject var store: ThemeStore
    
    // is this the right place...? gonna go away with heap...
    //    @StateObject var game: EmojiMemoryGame()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.themes) { theme in
                    NavigationLink(destination: EmojiMemoryGameView(game: EmojiMemoryGame(theme: theme))) {
                        themeRow(for: theme)
                    }
                }
            }
            .listStyle(.inset)
            .navigationTitle("Memorize")
        }
    }
    
    private func themeRow(for theme: Theme) -> some View {
        VStack(alignment: .leading) {
            Text(theme.name)
                .foregroundColor(.blue)
                .font(.system(size: 25))
                .bold()
            HStack {
                if theme.numberOfPairsOfCards == theme.emojis.count {
                    Text("All of \(theme.emojis)")
                } else {
                    Text("\(String(theme.numberOfPairsOfCards)) pairs from \(theme.emojis)" )
                }
            }
        }
    }
}



struct ThemeChooser_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChooser()
    }
}
