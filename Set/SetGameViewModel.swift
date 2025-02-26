//
//  SetGameViewModel.swift
//  Set
//
//  Created by Zafer CELALOGLU on 21.02.2025.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    @Published private var game = SetGame()
    
    var score: Int {
        game.score
    }
    
    var cardsInPlay: [Card] {
        game.cardsInPlay
    }
    
    var selectedCards: [Card] {
        game.selectedCards
    }
    
    var mismatchedCards: [Card] {
        game.mismatchedCards
    }
    
    var matchedCards: [Card] {
        game.matchedCards
    }
    
    var deck: [Card] {
        game.deck
    }
    
    func newGame() {
        game.newGame()
    }
    
    func dealThreeMoreCards() {
        game.dealThreeMoreCards()
    }
    
    func selectCard(_ card: Card) {
        game.selectCard(card)
    }
    
    func removeMatchedCards() {
        game.removeMatchedCards()
    }
}
