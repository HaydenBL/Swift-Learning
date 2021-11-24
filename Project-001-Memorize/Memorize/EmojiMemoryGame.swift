//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Hayden Lueck on 2021-11-07.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    typealias Card = MemoryGame<Character>.Card
    
    @Published private var model = createGame(theme: themes[0], themeIndex: 0)
    
    static func createGame(theme: Theme, themeIndex: Int) -> MemoryGame<Character> {
        let numberOfPairsOfCards = theme.numberOfPairsOfCards > theme.emojis.count ? theme.emojis.count : theme.numberOfPairsOfCards
        let emojis = numberOfPairsOfCards < theme.emojis.count ? getEmojis(num: numberOfPairsOfCards, emojis: theme.emojis) : theme.emojis
        return MemoryGame<Character>(
            themeName: theme.name,
            themeColor: theme.color,
            themeIndex: themeIndex,
            numberOfPairsOfCards: numberOfPairsOfCards
        ) { index in emojis[index] }
    }
    
    private static func getEmojis(num: Int, emojis: [Character]) -> [Character] {
        var result: [Character] = []
        for _ in 0..<num {
            var emoji: Character?
            repeat {
                emoji = emojis.randomElement()
            } while result.contains(emoji!)
            result.append(emoji!)
        }
        return result
    }
    
    var cards: Array<Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    var themeName: String {
        return model.themeName
    }
    
    var themeColor: Color {
        return model.themeColor
    }
    
    var themeIndex: Int {
        return model.themeIndex
    }
    
    // MARK: - Intent(s)
    
    func startNewGame(themeIndex: Int) {
        self.model = EmojiMemoryGame.createGame(theme: EmojiMemoryGame.themes[themeIndex], themeIndex: themeIndex)
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle();
    }
    
    // MARK: - Data Structures
    
    struct Theme {
        var name: String
        var emojis: [Character]
        var numberOfPairsOfCards: Int
        var color: Color
    }
    
    // MARK - Constants
    
    static let themes: [EmojiMemoryGame.Theme] = [
        EmojiMemoryGame.Theme(
            name: "Faces",
            emojis: [
                "🥴", "🤪", "😌", "😪", "😃", "😊", "🥲", "😍",
                "😶‍🌫️", "🤩", "😞"
            ],
            numberOfPairsOfCards: 5,
            color: .red
        ),
        EmojiMemoryGame.Theme(
            name: "Animals",
            emojis: [
                "🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨",
                "🐯", "🦁", "🐮", "🐷", "🐸", "🐵"
            ],
            numberOfPairsOfCards: 16,
            color: .orange
        ),
        EmojiMemoryGame.Theme(
            name: "Foods",
            emojis: [
                "🍔", "🌭", "🌮", "🌯", "🥙", "🥗", "🥪", "🍕", "🍟",
                "🍖", "🍗", "🥓", "🍱", "🥘", "🧆", "🍲", "🍛", "🍜",
                "🍝", "🍣", "🍤", "🍿"
            ],
            numberOfPairsOfCards: 99,
            color: .yellow
        ),
        EmojiMemoryGame.Theme(
            name: "Fruits",
            emojis: [
                "🍎", "🍏", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓",
                "🫐", "🍈", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝"
            ],
            numberOfPairsOfCards: 99,
            color: .green
        ),
        EmojiMemoryGame.Theme(
            name: "Sports",
            emojis: [
                "⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏",
                "🎱", "🪀", "🏓", "🏸", "🏒", "🏑", "🥍", "🏏", "🪃",
                "🥅", "⛳️", "🏹", "🎣"
            ],
            numberOfPairsOfCards: 4,
            color: .blue
        ),
        EmojiMemoryGame.Theme(
            name: "Vehicles",
            emojis: [
                "🚕", "🚗", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒",
                "🚐", "🛻", "🚚", "🚛", "🚜", "🚃", "🚟"
            ],
            numberOfPairsOfCards: 99,
            color: .purple
        ),
    ]
}
