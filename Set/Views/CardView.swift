//
//  CardView.swift
//  Set
//
//  Created by Zafer CELALOGLU on 26.02.2025.
//
import SwiftUI

struct CardView: View {
    let card: Card
    @ObservedObject var viewModel: SetGameViewModel

    var isSelected: Bool { viewModel.selectedCards.contains { $0.id == card.id } }
    var isMismatched: Bool { viewModel.mismatchedCards.contains { $0.id == card.id } }
    var isMatched: Bool { viewModel.matchedCards.contains { $0.id == card.id } }
    
    var body: some View {
        ZStack {
            background
            content
        }
        .onTapGesture {
            if viewModel.matchedCards.count == 3 {
                withAnimation(.easeInOut(duration: 0.5)) {
                    viewModel.removeMatchedCards()
                }
            } else {
                withAnimation(.easeInOut(duration: 0.2)) {
                    viewModel.selectCard(card)
                }
            }
        }
    }

    var background: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.white)
            .aspectRatio(2/3, contentMode: .fit)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(borderColor, lineWidth: 2)
                    .padding(2)
            )
    }

    var content: some View {
        VStack {
            ForEach(0..<card.number, id: \.self) { _ in
                CardShapeView(
                    shape: card.shape,
                    color: card.color.toColor,
                    shading: card.shading
                )
                .aspectRatio(2, contentMode: .fit)
            }
        }
        .padding()
    }

    var borderColor: Color {
        if isMatched {
            return .green
        } else if isMismatched {
            return .red
        }
        return isSelected ? .orange : .black
    }
}
