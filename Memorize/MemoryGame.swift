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
    
    private var indexOfFaceUpCard: Int?
    
    mutating func choose(_ chosenCard: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == chosenCard.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                indexOfFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
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
    }
    
    struct Card: Identifiable {
        var id = UUID().uuidString
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
    }
}
