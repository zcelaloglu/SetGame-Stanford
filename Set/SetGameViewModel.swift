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
        objectWillChange.send()
    }
    
    func dealThreeMoreCards() {
        game.dealThreeMoreCards()
        objectWillChange.send()
    }
    
    func selectCard(_ card: Card) {
        game.selectCard(card)
        objectWillChange.send()
    }
    
    func removeMatchedCards() {
        game.removeMatchedCards()
        objectWillChange.send()
    }
}
