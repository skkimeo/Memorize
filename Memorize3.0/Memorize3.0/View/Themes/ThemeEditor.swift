//
//  ThemeEditor.swift
//  Memorize3.0
//
//  Created by sun on 2021/11/21.
//

import SwiftUI

struct ThemeEditor: View {
    @Binding var theme: Theme
    @EnvironmentObject var store: ThemeStore
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                nameSection
                removeEmojiSection
                addEmojiSection
                cardPairSection
                cardColorSection
            }
            .navigationTitle("\(name)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                doneButton
            }
        }
    }
    
    private var doneButton: some View {
        Button("Done") {
            if presentationMode.wrappedValue.isPresented && candidateEmojis.count >= 2 {
                saveAllEdits()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    private func saveAllEdits() {
        theme.name = name
        theme.emojis = candidateEmojis
        theme.numberOfPairsOfCards = min(numberOfPairs, candidateEmojis.count)
    }
    
    @State private var name: String
    
    init(theme: Binding<Theme>) {
        self._theme = theme
        self._name = State(initialValue: theme.wrappedValue.name)
        self._candidateEmojis = State(initialValue: theme.wrappedValue.emojis)
        self._numberOfPairs = State(initialValue: theme.wrappedValue.numberOfPairsOfCards)
    }
    
    private var nameSection: some View {
        Section(header: Text("theme name")) {
            TextField("Theme name", text: $name)
        }
    }
    
    @State private var candidateEmojis: String
    
    private var removeEmojiSection: some View {
        Section(header: Text("Emojis"), footer: Text("Tap To Remove: More than Two needed!")) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 20))]) {
                ForEach(candidateEmojis.map { String($0) }, id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            withAnimation {
                                if candidateEmojis.count > 2 {
                                candidateEmojis.removeAll { String($0) == emoji}
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
                    addAsCandidateEmojis(emoji)
                }
        }
        
    }
    
    private func addAsCandidateEmojis(_ emojis: String) {
        withAnimation {
            candidateEmojis = (emojis + candidateEmojis)
                .filter { $0.isEmoji }
                .removingDuplicateCharacters
        }
    }
    
    @State var numberOfPairs: Int
    
    private var cardPairSection: some View {
        Section(header: Text("Card Count")) {
            Stepper("\(numberOfPairs) Pairs", value: $numberOfPairs, in: candidateEmojis.count < 2 ?  2...2 : 2...candidateEmojis.count)
                .onChange(of: candidateEmojis) { _ in
                    numberOfPairs = max(2, min(numberOfPairs, candidateEmojis.count))
                }
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

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        ThemeEditor(theme: .constant(ThemeStore(named: "preview").themes[1]))
//    }
//}
