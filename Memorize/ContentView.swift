//
//  ContentView.swift
//  Memorize
//
//  Created by sun on 2021/09/26.
//

import SwiftUI

struct ContentView: View {
    let vehicleEmojis = ["🚙", "🛴", "✈️", "🛵", "⛵️", "🚎", "🚐", "🚛",
                      "🛻", "🏎", "🚂", "🚊", "🚀", "🚁", "🚢", "🛶",
                      "🛥", "🚞", "🚤", "🚲", "🚡", "🚕", "🚟", "🚃"]
    
    var animalEmojis = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼"]
    
    var foodEmojis = ["🍔", "🥐", "🍕", "🥗", "🥟", "🍣", "🍪", "🍚",
                      "🍝", "🥙", "🍭", "🍤", "🥞", "🍦", "🍛", "🍗"]
    
    @State var emojis = ["🚙", "🛴", "✈️", "🛵", "⛵️", "🚎", "🚐", "🚛",
                         "🛻", "🏎", "🚂", "🚊", "🚀", "🚁", "🚢", "🛶",
                         "🛥", "🚞", "🚤", "🚲", "🚡", "🚕", "🚟", "🚃"]
    
    var body: some View {
        NavigationView {
            VStack{
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                        ForEach(emojis[0..<emojis.count], id: \.self) {
                            CardView(content: $0).aspectRatio(2/3, contentMode: .fit)
                        }
                    }
                }
                .foregroundColor(.red)
                Spacer()
                HStack {
                    Spacer()
                    vehicleButton
                    Spacer()
                    foodButton // fork.knife
                    Spacer()
                    animalButton // pawprint.fill
                    Spacer()
                }
                .padding(.top)
            }
            .padding(.horizontal)
            .navigationTitle("Memorize!")
        }
    }
    
    var vehicleButton: some View {
        VStack {
            Button {
                emojis = vehicleEmojis
            } label: {
                VStack {
                    Image(systemName: "car.fill").font(.largeTitle)
                    Text("Vehicles").font(.footnote)
                }
            }
        }
    }
    
    var foodButton: some View {
        VStack {
            Button {
                emojis = foodEmojis
            } label: {
                VStack {
                    Image(systemName: "car.fill").font(.largeTitle)
                    Text("Food").font(.footnote)
                }
            }
        }
    }
    
    var animalButton: some View {
        VStack {
            Button {
                emojis = animalEmojis
            } label: {
                VStack {
                    Image(systemName: "car.fill").font(.largeTitle)
                    Text("Animals").font(.footnote)
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
