//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Hayden Lueck on 2021-11-05.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
