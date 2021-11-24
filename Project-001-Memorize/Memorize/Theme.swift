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
                "🥴", "🤪", "😌", "😪", "😃", "😊", "🥲", "😍",
                "😶‍🌫️", "🤩", "😞"
            ],
            numberOfPairsOfCards: 5,
            color: .red
        ),
        Theme(
            name: "Animals",
            emojis: [
                "🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨",
                "🐯", "🦁", "🐮", "🐷", "🐸", "🐵"
            ],
            numberOfPairsOfCards: 16,
            color: .orange
        ),
        Theme(
            name: "Foods",
            emojis: [
                "🍔", "🌭", "🌮", "🌯", "🥙", "🥗", "🥪", "🍕", "🍟",
                "🍖", "🍗", "🥓", "🍱", "🥘", "🧆", "🍲", "🍛", "🍜",
                "🍝", "🍣", "🍤", "🍿"
            ],
            numberOfPairsOfCards: 99,
            color: .yellow
        ),
        Theme(
            name: "Fruits",
            emojis: [
                "🍎", "🍏", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓",
                "🫐", "🍈", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝"
            ],
            numberOfPairsOfCards: 99,
            color: .green
        ),
        Theme(
            name: "Sports",
            emojis: [
                "⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏",
                "🎱", "🪀", "🏓", "🏸", "🏒", "🏑", "🥍", "🏏", "🪃",
                "🥅", "⛳️", "🏹", "🎣"
            ],
            numberOfPairsOfCards: 4,
            color: .blue
        ),
        Theme(
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
