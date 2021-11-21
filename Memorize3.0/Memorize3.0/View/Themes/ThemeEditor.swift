//
//  ThemeEditor.swift
//  Memorize3.0
//
//  Created by sun on 2021/11/21.
//

import SwiftUI

struct ThemeEditor: View {
    @Binding var theme: Theme
    
    @Environment(\.presentationMode) private var presentatioMode
    
    var body: some View {
        NavigationView {
            Form {
                nameSection
                removeEmojiSection
                addEmojiSection
                cardPairSection
                cardColorSection
            }
            .navigationTitle("\(theme.name)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                doneButton
            }
        }
    }
    
    private var doneButton: some View {
        Button("Done") {
            if presentatioMode.wrappedValue.isPresented && theme.emojis.count >= 2 {
                presentatioMode.wrappedValue.dismiss()
            }
        }
    }
    
    private var nameSection: some View {
        Section(header: Text("theme name")) {
            TextField("Theme name", text: $theme.name)
        }
    }
    
    private var removeEmojiSection: some View {
        Section(header: Text("Emojis"), footer: Text("Tap To Remove: More than Two needed!")) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 20))]) {
                ForEach(theme.emojis.map { String($0) }, id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            withAnimation {
                                if theme.emojis.count > 2 {
                                theme.emojis.removeAll { String($0) == emoji}
                                }
                            }
                            
                        }
                }
            }
        }
    }
    
    @State private var emojisToAdd = ""
    
    private var addEmojiSection: some View {
        Section(header: Text("add Emojis")) {
            TextField("Emojis", text: $emojisToAdd)
                .onChange(of: emojisToAdd) { emoji in
                    addEmojis(emoji)
                }
        }
        
    }
    
    private func addEmojis(_ emojis: String) {
        withAnimation {
            theme.emojis = (emojis + theme.emojis)
                .filter { $0.isEmoji }
                .removingDuplicateCharacters
        }
    }
    
    private var cardPairSection: some View {
        Section(header: Text("Card Count")) {
            Stepper("\(theme.numberOfPairsOfCards) Pairs", value: $theme.numberOfPairsOfCards, in: theme.emojis.count < 2 ?  2...2 : 2...theme.emojis.count)
        }
    }
    
    @State var myColor: Color = .red
    
    private var cardColorSection: some View {
        if #available(iOS 15.0, *) {
            return Section("COLOR") {
                ColorPicker("Card is \(theme.cardColor)", selection: $myColor, supportsOpacity: false)
            }
        } else {
            return Section(header: Text("Color")) {
                ColorPicker("Card is \(theme.cardColor)", selection: $myColor, supportsOpacity: false)
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeEditor(theme: .constant(ThemeStore(named: "preview").themes[1]))
    }
}
