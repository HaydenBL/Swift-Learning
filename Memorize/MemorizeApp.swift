//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Hayden Lueck on 2021-11-05.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
