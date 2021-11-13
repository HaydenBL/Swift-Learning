//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Hayden Lueck on 2021-11-05.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        NavigationView {
            content
                .navigationTitle(game.themeName)
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        Text("Score: \(game.score)")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                }
        }
        .navigationViewStyle(.stack)
    }
    
    var content: some View {
        ScrollView {
            themeSelector.frame(maxWidth: .infinity)
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
        .foregroundColor(game.themeColor)
        .padding(.horizontal)
    }
    
    var themeSelector: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 95))], spacing: 20) {
            ForEach(0..<EmojiMemoryGame.themes.count) { i in
                let firstEmoji = EmojiMemoryGame.themes[i].emojis[0]
                let color = EmojiMemoryGame.themes[i].color
                let selected = i == game.themeIndex
                ThemeButton(emoji: firstEmoji, color: color, selected: selected)
                    .onTapGesture {
                        game.startNewGame(themeIndex: i)
                    }
            }
        }
    }
    
    struct ThemeButton: View {
        let emoji: Character
        let color: Color
        let selected: Bool
        
        var body: some View {
            ZStack {
                Circle()
                    .strokeBorder(selected ? color : Color(UIColor.systemBackground), lineWidth: 4)
                    .background(Color(UIColor.systemBackground))
                    .frame(width: 55, height: 55)
                Circle()
                    .fill(color)
                    .frame(width: 40, height: 40)
                Text(String(emoji))
            }
        }
    }
    
}

struct CardView: View {
    let card: EmojiMemoryGame.Card
    
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
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
    }
}
