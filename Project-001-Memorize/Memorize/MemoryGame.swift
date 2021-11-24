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
    private(set) var score: Int = 0
    
    private var indexOfFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach{ cards[$0].isFaceUp = $0 == newValue } }
    }
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
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfFaceUpCard = chosenIndex
            }
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
    }
    
    mutating func shuffle() {
        cards.shuffle();
    }
    
    init(themeName: String, themeColor: Color, numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        self.themeName = themeName
        self.themeColor = themeColor
        
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        let id = UUID().uuidString
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        let content: CardContent
        
        var bonusTimeLimit: TimeInterval = 6
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate: Date?
        
        var pastFaceUpTime: TimeInterval = 0
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
        
    }
}

extension Array {
    var oneAndOnly: Element? {
        count == 1 ? first : nil
    }
}
