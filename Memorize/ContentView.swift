//
//  ContentView.swift
//  Memorize
//
//  Created by sun on 2021/09/26.
//

import SwiftUI

struct ContentView: View {
    var vechicleEmojis = ["🚙", "🛴", "✈️", "🛵", "⛵️", "🚎", "🚐", "🚛",
                          "🛻", "🏎", "🚂", "🚊", "🚀", "🚁", "🚢", "🛶",
                          "🛥", "🚞", "🚤", "🚲", "🚡", "🚕", "🚟", "🚃"]
    var foodEmojis = ["🍔"]
    var aminalEmojis = ["🐶"]
    
    @State var emojiCount = 24
    
    var body: some View {
        NavigationView {
            VStack{
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                        ForEach(vechicleEmojis[0..<emojiCount], id: \.self) {
                            CardView(content: $0).aspectRatio(2/3, contentMode: .fit)
                        }
                    }
                }
                .foregroundColor(.red)
                Spacer()
                HStack {
                    Spacer()
                    ThemeButton(name: "Vehicles", icon: "car.fill")
                    Spacer()
                    ThemeButton(name: "Food", icon: "car.fill") // fork.knife
                    Spacer()
                    ThemeButton(name: "Animals", icon: "car.fill") // pawprint.fill
                    Spacer()
                }
                .padding(.top)
            }
            .padding(.horizontal)
            .navigationTitle("Memorize!")
        }
    }
}

struct ThemeButton: View {
    var name: String
    var icon: String
    
    var body: some View {
        VStack {
            Button {
                //some kind of action(shuffle on click)
            } label: {
                VStack {
                    Image(systemName: icon).font(.largeTitle)
                    Text(name).font(.footnote)
                }
            }
        }
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}






















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.light)
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}
