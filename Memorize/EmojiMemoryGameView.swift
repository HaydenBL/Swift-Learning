//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Hayden Lueck on 2021-11-05.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var game: EmojiMemoryGame
  
//    var body: some View {
//        VStack {
//            content
//            shuffleButton
//        }
//        .padding()
//    }
    
    var body: some View {
        NavigationView {
            content
                .navigationTitle(game.themeName)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        Text("Score: \(game.score)")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                        shuffleButton
                    }
                }
        }
        .navigationViewStyle(.stack)
    }
    
    @State private var dealt = Set<String>()
  
    private func deal(_ card: EmojiMemoryGame.Card) {
        print("Before insert: \(dealt)")
        print("Inserting \(card.id)")
        dealt.insert(card.id)
        let bah = dealt
        print("After insert: \(dealt)")
    }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        print("dealt: \(dealt)")
        let bah = dealt
        return !dealt.contains(card.id)
    }
    
    var content: some View {
        VStack {
            themeSelector.frame(maxWidth: .infinity)
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
                    Color.clear
                } else {
                    CardView(card: card)
                        .padding(4)
                        .transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity))
                        .onTapGesture {
                            withAnimation {
                                game.choose(card)
                            }
                        }
                }
            }
            .onAppear {
                withAnimation {
                    for card in game.cards {
                        deal(card)
                    }
                }
            }
            .foregroundColor(game.themeColor)
            .padding(.horizontal)
        }
    }
    
    var shuffleButton: some View {
        Button("Shuffle") {
            withAnimation{
                game.shuffle()
            }
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
                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                    .padding(6)
                    .opacity(0.5)
                Text(String(card.content))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(.linear(duration: 1).repeatForever(autoreverses: false))
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }.cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.7
        static let fontSize: CGFloat = 32
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
