//
//  Card.swift
//  Set
//
//  Created by Zafer CELALOGLU on 21.02.2025.
//

import Foundation
import SwiftUICore

struct Card: Equatable, Identifiable {
    let id: String
    let color: CardColor
    let shape: ShapeType
    var shading: Shading
    let number: Int
    var borderColor: CardBorderColor = .black
    var isSelected = false
    var isMatched = false
    
    enum CardColor: CaseIterable {
        case red, green, purple
    }
    
    enum ShapeType: CaseIterable {
        case diamond, rectangle, oval
    }
    
    enum CardBorderColor: CaseIterable {
        case black, yellow, green, red
    }
    
    enum Shading: CaseIterable {
        case solid, striped, open
    }

    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Card.CardColor {
    var toColor: Color {
        switch self {
        case .red:
            return .red
        case .green:
            return .green
        case .purple:
            return .purple
        }
    }
}
