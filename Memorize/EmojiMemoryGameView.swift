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
        VStack {
            themeSelector.frame(maxWidth: .infinity)
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                if card.isMatched && card.isFaceUp {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card)
                        .padding(4)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            }
            .foregroundColor(game.themeColor)
            .padding(.horizontal)
        }
    }
    
    var themeSelector: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 95))]) {
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
        GeometryReader { geometry in
            ZStack {
                let cardShape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    cardShape.fill().foregroundColor(.white)
                    cardShape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                        .padding(6)
                        .opacity(0.5)
                    Text(String(card.content))
                        .font(font(in: geometry.size))
                } else if card.isMatched {
                    cardShape.opacity(0)
                } else {
                    cardShape.fill()
                }
                
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    private static func getGame() -> EmojiMemoryGame {
        let game = EmojiMemoryGame()
        game.startNewGame(themeIndex: 4)
        game.choose(game.cards.first!)
        return game
    }
    
    static var previews: some View {
        let game = self.getGame()
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
    }
}
