//
//  MemoryGame.swift
//  Memorize
//
//  Created by Hayden Lueck on 2021-11-07.
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var themeName: String
    private(set) var themeColor: Color
    private(set) var themeIndex: Int
    private(set) var score: Int = 0
    
    private var indexOfFaceUpCard: Int?
    private var previouslyMismatchedCardIds: [String] = []
    
    mutating func choose(_ chosenCard: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == chosenCard.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfFaceUpCard {
                checkMatch(
                    chosenIndex: chosenIndex, potentialMatchIndex: potentialMatchIndex,
                    chosenCardId: chosenCard.id, potentialMatchId: cards[potentialMatchIndex].id
                )
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    private mutating func checkMatch(chosenIndex: Int, potentialMatchIndex: Int, chosenCardId: String, potentialMatchId: String) {
        if cards[chosenIndex].content == cards[potentialMatchIndex].content {
            cards[chosenIndex].isMatched = true
            cards[potentialMatchIndex].isMatched = true
            score += 2
        } else {
            if previouslyMismatchedCardIds.contains(chosenCardId) ||
                previouslyMismatchedCardIds.contains(cards[potentialMatchIndex].id)
            { score -= 1 }
            if !previouslyMismatchedCardIds.contains(chosenCardId) {
                previouslyMismatchedCardIds.append(chosenCardId)
            }
            if !previouslyMismatchedCardIds.contains(cards[potentialMatchIndex].id) {
                previouslyMismatchedCardIds.append(cards[potentialMatchIndex].id)
            }
        }
        indexOfFaceUpCard = nil
    }
    
    init(themeName: String, themeColor: Color, themeIndex: Int, numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        self.themeName = themeName
        self.themeColor = themeColor
        self.themeIndex = themeIndex
        
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var id = UUID().uuidString
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
