//
//  CardShapeView.swift
//  Set
//
//  Created by Zafer CELALOGLU on 26.02.2025.
//

import SwiftUI

struct CardShapeView: View {
    let shape: Card.ShapeType
    let color: Color
    let shading: Card.Shading

    var body: some View {
        switch shape {
        case .diamond:
            DiamondShape()
                .fill(shading == .striped ? color.opacity(0.5) : color)
        case .rectangle:
            Rectangle()
                .fill(shading == .striped ? color.opacity(0.5) : color)
        case .oval:
            Ellipse()
                .fill(shading == .striped ? color.opacity(0.5) : color)
        }
    }
}
