//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Hayden Lueck on 2021-11-07.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    private let START_THEME_INDEX = 0
    
    typealias Card = MemoryGame<Character>.Card
    
    @Published private var model: MemoryGame<Character>
    @Published private(set) var themeIndex: Int {
        didSet {
            model = EmojiMemoryGame.createGame(themeIndex: themeIndex)
        }
    }
    
    init() {
        themeIndex = START_THEME_INDEX
        model = EmojiMemoryGame.createGame(themeIndex: START_THEME_INDEX)
    }
    
    static func createGame(themeIndex: Int) -> MemoryGame<Character> {
        let theme = Theme.themes[themeIndex]
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
    
    var cards: Array<Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    var theme: Theme {
        return Theme.themes[themeIndex]
    }
    
    // MARK: - Intent(s)
    
    func startNewGame() {
        self.model = EmojiMemoryGame.createGame(themeIndex: self.themeIndex)
    }
    
    func setTheme(themeIndex: Int) {
        self.themeIndex = themeIndex
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle();
    }
    
}
