//
//  SetGame.swift
//  Set
//
//  Created by Zafer CELALOGLU on 21.02.2025.
//

import Foundation
import SwiftUI

class SetGame {
    private(set) var deck: [Card] = []
    private(set) var cardsInPlay: [Card] = []
    private(set) var selectedCards: [Card] = []
    private(set) var mismatchedCards: [Card] = []
    private(set) var matchedCards: [Card] = []
    private(set) var score: Int = 0
    
    init() {
        newGame()
    }
    
    func newGame() {
        deck = generateDeck()
        cardsInPlay = Array(deck.prefix(12))
        deck.removeFirst(12)
        selectedCards = []
        mismatchedCards = []
        matchedCards = []
        score = 0
    }
    
    private func generateDeck() -> [Card] {
        var deck: [Card] = []
        for color in Card.CardColor.allCases {
            for shape in Card.ShapeType.allCases {
                for shading in Card.Shading.allCases {
                    for number in 1...3 {
                        let id = "\(color)\(shape)\(shading)\(number)"
                        deck.append(Card(id: id, color: color, shape: shape, shading: shading, number: number))
                    }
                }
            }
        }
        return deck.shuffled()
    }
    
    func selectCard(_ card: Card) {
        if selectedCards.count == 3 {
            selectedCards.removeAll()
            mismatchedCards.removeAll()
        }
        
        if let index = selectedCards.firstIndex(where: { $0.id == card.id }) {
            selectedCards.remove(at: index)
        } else {
            selectedCards.append(card)
            
            if selectedCards.count == 3 {
                if isSet(selectedCards) {
                    score += 10
                    matchedCards = selectedCards
                } else {
                    mismatchedCards = selectedCards
                }
            }
        }
    }
    
    private func isSet(_ cards: [Card]) -> Bool {
        guard cards.count == 3 else { return false }
        
        let colors = Set(cards.map { $0.color })
        let shapes = Set(cards.map { $0.shape })
        let shadings = Set(cards.map { $0.shading })
        let numbers = Set(cards.map { $0.number })
        
        return (colors.count == 1 || colors.count == 3) &&
               (shapes.count == 1 || shapes.count == 3) &&
               (shadings.count == 1 || shadings.count == 3) &&
               (numbers.count == 1 || numbers.count == 3)
    }
    
    func removeMatchedCards() {
        cardsInPlay.removeAll { matchedCards.contains($0) }
        
        matchedCards.removeAll()
        selectedCards.removeAll()
        
        if deck.count >= 3 {
            let newCards = Array(deck.prefix(3))
            cardsInPlay.append(contentsOf: newCards)
            deck.removeFirst(3)
        }
    }

    func dealThreeMoreCards() {
        if selectedCards.count == 3 && isSet(selectedCards) {
            cardsInPlay.removeAll { selectedCards.contains($0) }
            if deck.count >= 3 {
                let newCards = Array(deck.prefix(3))
                cardsInPlay.append(contentsOf: newCards)
                deck.removeFirst(3)
            }
            selectedCards = []
        } else {
            if deck.count >= 3 {
                let newCards = Array(deck.prefix(3))
                cardsInPlay.append(contentsOf: newCards)
                deck.removeFirst(3)
            }
        }
    }
}
