//
//  ContentView.swift
//  Memorize
//
//  Created by Hayden Lueck on 2021-11-05.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        ScrollView {
            themeSelector.frame(maxWidth: .infinity)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
        .foregroundColor(viewModel.color)
        .padding(.horizontal)
    }
    
    let circle: some View = Circle()
        .fill(.blue)
        .frame(width: 40, height: 40)
        .onTapGesture {
            print("tap!")
        }
    
    var themeSelectorRow: some View {
        HStack {
            ForEach(0..<3) { _ in
                Spacer()
                circle
            }
            Spacer()
        }.padding(.bottom)
    }
    
    var themeSelector: some View {
        VStack {
            themeSelectorRow
            themeSelectorRow
        }
    }
    
}

struct CardView: View {
    let card: MemoryGame<Character>.Card
    
    var body: some View {
        ZStack {
            let cardShape = RoundedRectangle(cornerRadius: 25.0)
            if card.isFaceUp {
                cardShape.fill().foregroundColor(.white)
                cardShape.strokeBorder(lineWidth: 3)
                Text(String(card.content)).font(.largeTitle)
            } else if card.isMatched {
                cardShape.opacity(0)
            } else {
                cardShape.fill()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
    }
}
