//
//  EmojiMemoryGameView.swift
//  Memorize3.0
//
//  Created by sun on 2021/11/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    // C
    var body: some View {
        NavigationView {
            VStack {
                Text("score: \(game.score)")
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                        ForEach(game.cards) { card in
                            CardView(card: card)
                                .aspectRatio(2/3, contentMode: .fit)
                                .onTapGesture {
                                    game.choose(card)
                                }
                        }
                    }
                }
                .foregroundColor(.red)
                
                Button {
                    game.startNewGame()
                } label: {
                    Text("New Game").font(.largeTitle)
                }
            }
            .padding()
            .navigationTitle("Memorize \(game.chosenTheme.name)!")
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
                
            }
        }
    }
}


























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
    }
}

