//
//  ThemeChooser.swift
//  Memorize3.0
//
//  Created by sun on 2021/11/21.
//

import SwiftUI

struct ThemeChooser: View {
    @EnvironmentObject var store: ThemeStore
    
//    @State var games: [Theme: EmojiMemoryGame]
    
    // is this the right place...? gonna go away with heap...
    //    @StateObject var game: EmojiMemoryGame()
    @State var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.themes) { theme in
                    NavigationLink(destination: EmojiMemoryGameView(game: EmojiMemoryGame(theme: theme))) {
                        themeRow(for: theme)
                    }
                    .gesture(editMode == .active ? tapToOpenThemeEditor(for: theme) : nil)
                }
                .onDelete { indexSet in
                    store.themes.remove(atOffsets: indexSet)
                }
                .onMove { fromOffsets, toOffset in
                    store.themes.move(fromOffsets: fromOffsets, toOffset: toOffset)
                }
            }
            .listStyle(.inset)
            .navigationTitle("Memorize")
            .sheet(item: $themeToEdit) { theme in
//                ThemeEditor()
                Text("Gonna be replaced with ThemeEditor!")
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) { //, content: <#T##() -> _#>)
                    Image(systemName: "plus")
                        .foregroundColor(.blue)
                }
                ToolbarItem { EditButton() }
            }
            .environment(\.editMode, $editMode)
        }
    }
    
    @State private var themeToEdit: Theme?
    
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
                    Text("\(String(theme.numberOfPairsOfCards)) pairs from \(theme.emojis)" )
                }
            }
        }
    }
    
    private func tapToOpenThemeEditor(for theme: Theme) -> some Gesture {
        TapGesture()
            .onEnded {
                themeToEdit = store.themes[theme]
            }
    }
}


//
//struct ThemeChooser_Previews: PreviewProvider {
//    static var previews: some View {
//        ThemeChooser()
//    }
//}
