//
//  Theme.swift
//  Memorize
//
//  Created by Hayden Lueck on 2021-11-23.
//

import SwiftUI

struct Theme {
    var name: String
    var emojis: [Character]
    var numberOfPairsOfCards: Int
    var color: Color
    
    static let themes: [Theme] = [
        Theme(
            name: "Faces",
            emojis: [
                "ðĨī", "ðĪŠ", "ð", "ðŠ", "ð", "ð", "ðĨē", "ð",
                "ðķâðŦïļ", "ðĪĐ", "ð"
            ],
            numberOfPairsOfCards: 5,
            color: .red
        ),
        Theme(
            name: "Animals",
            emojis: [
                "ðķ", "ðą", "ð­", "ðđ", "ð°", "ðĶ", "ðŧ", "ðž", "ðĻ",
                "ðŊ", "ðĶ", "ðŪ", "ð·", "ðļ", "ðĩ"
            ],
            numberOfPairsOfCards: 16,
            color: .orange
        ),
        Theme(
            name: "Foods",
            emojis: [
                "ð", "ð­", "ðŪ", "ðŊ", "ðĨ", "ðĨ", "ðĨŠ", "ð", "ð",
                "ð", "ð", "ðĨ", "ðą", "ðĨ", "ð§", "ðē", "ð", "ð",
                "ð", "ðĢ", "ðĪ", "ðŋ"
            ],
            numberOfPairsOfCards: 99,
            color: .yellow
        ),
        Theme(
            name: "Fruits",
            emojis: [
                "ð", "ð", "ð", "ð", "ð", "ð", "ð", "ð", "ð",
                "ðŦ", "ð", "ð", "ð", "ðĨ­", "ð", "ðĨĨ", "ðĨ"
            ],
            numberOfPairsOfCards: 99,
            color: .green
        ),
        Theme(
            name: "Sports",
            emojis: [
                "â―ïļ", "ð", "ð", "âūïļ", "ðĨ", "ðū", "ð", "ð", "ðĨ",
                "ðą", "ðŠ", "ð", "ðļ", "ð", "ð", "ðĨ", "ð", "ðŠ",
                "ðĨ", "âģïļ", "ðđ", "ðĢ"
            ],
            numberOfPairsOfCards: 4,
            color: .blue
        ),
        Theme(
            name: "Vehicles",
            emojis: [
                "ð", "ð", "ð", "ð", "ð", "ð", "ð", "ð", "ð",
                "ð", "ðŧ", "ð", "ð", "ð", "ð", "ð"
            ],
            numberOfPairsOfCards: 99,
            color: .purple
        ),
    ]

}
