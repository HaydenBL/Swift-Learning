//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Hayden Lueck on 2021-11-07.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    @Published private var model = createGame(theme: themes[0])
    
    static func createGame(theme: Theme) -> MemoryGame<Character> {
        let numberOfPairsOfCards = theme.numberOfPairsOfCards > theme.emojis.count ? theme.emojis.count : theme.numberOfPairsOfCards
        let emojis = numberOfPairsOfCards < theme.emojis.count ? getEmojis(num: numberOfPairsOfCards, emojis: theme.emojis) : theme.emojis
        return MemoryGame<Character>(
            themeName: theme.name,
            themeColor: theme.color,
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
    
    var cards: Array<MemoryGame<Character>.Card> {
        return model.cards
    }
    
    var themeName: String {
        return model.themeName
    }
    
    var themeColor: Color {
        return model.themeColor
    }
    
    // MARK: - Intent(s)
    
    func startNewGame(themeIndex: Int) {
        self.model = EmojiMemoryGame.createGame(theme: EmojiMemoryGame.themes[themeIndex])
    }
    
    func choose(_ card: MemoryGame<Character>.Card) {
        model.choose(card)
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
                "🥴", "🤪", "😌", "🍭", "😪", "😀", "😃", "😊",
                "🥲", "😍", "😶‍🌫️", "🤩", "😞"
            ],
            numberOfPairsOfCards: 13,
            color: .red
        ),
        EmojiMemoryGame.Theme(
            name: "Foods",
            emojis: [
                "🍔", "🌭", "🌮", "🌯", "🥙", "🥗", "🥪", "🍕", "🍟",
                "🍖", "🍗", "🥓", "🍱", "🥘", "🧆", "🍲", "🍛", "🍜",
                "🍝", "🍣", "🍤", "🍿"
            ],
            numberOfPairsOfCards: 99,
            color: .orange
        ),
        EmojiMemoryGame.Theme(
            name: "Animals",
            emojis: [
                "🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨",
                "🐯", "🦁", "🐮", "🐷", "🐽", "🐸", "🐵"
            ],
            numberOfPairsOfCards: 16,
            color: .yellow
        ),
        EmojiMemoryGame.Theme(
            name: "Fruits",
            emojis: [
                "🍏", "🍐", "🍎", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓",
                "🫐", "🍈", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝", "🥐",
                "🥯", "🍞", "🥖", "🥨", "🧀", "🥚", "🍳", "🧈", "🥞",
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
            numberOfPairsOfCards: 99,
            color: .blue
        ),
        EmojiMemoryGame.Theme(
            name: "Vehicles",
            emojis: [
                "🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒",
                "🚐", "🛻", "🚚", "🚛", "🚜", "🚃", "🚟"
            ],
            numberOfPairsOfCards: 99,
            color: .purple
        ),
    ]
}
