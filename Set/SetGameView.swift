//
//  ContentView.swift
//  Set
//
//  Created by Zafer CELALOGLU on 21.02.2025.
//

import SwiftUI

struct SetGameView: View {
    @StateObject var viewModel: SetGameViewModel
    
    var body: some View {
        VStack {
            Text("Score: \(viewModel.score)")
                .font(.largeTitle)
                .padding()
            
            GeometryReader { geometry in
                VStack {
                    cards
                    HStack {
                        Button("New Game") {
                            viewModel.newGame()
                        }
                        Spacer()
                        Button("Deal 3 More Cards") {
                            viewModel.dealThreeMoreCards()
                        }
                        .disabled(viewModel.deck.isEmpty)
                    }
                    .padding()
                    .background(Color.white)
                }
            }
        }
    }
    
    var cards: some View {
        ScrollView {
            AspectVGrid(
                viewModel.cardsInPlay,
                aspectRatio: 2/3
            ) { card in
                CardView(
                    card: card,
                    isSelected: viewModel.selectedCards
                        .contains { $0.id == card.id },
                    isMismatched: viewModel.mismatchedCards
                        .contains { $0.id == card.id },
                    isMatched: viewModel.matchedCards
                        .contains { $0.id == card.id }
                )
                .contentShape(Rectangle()) // Ensure the entire card is tappable
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
            .padding()
        }
    }
}

struct CardView: View {
    let card: Card
    var isSelected: Bool
    var isMismatched: Bool
    var isMatched: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .aspectRatio(2/3, contentMode: .fit)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(borderColor, lineWidth: 2)
                        .padding(4)
                )
            
            VStack {
                ForEach(0..<card.number, id: \.self) { _ in
                    cardShape
                        .foregroundColor(card.color.toColor)
                        .aspectRatio(2, contentMode: .fit)
                }
            }
            .padding()
        }
    }
    
    @ViewBuilder
    var cardShape: some View {
        let color = card.color.toColor
        switch card.shape {
        case .diamond:
            Diamond()
                .fill(card.shading == .striped ? color.opacity(0.5) : color)
        case .rectangle:
            Rectangle()
                .fill(card.shading == .striped ? color.opacity(0.5) : color)
        case .oval:
            Ellipse()
                .fill(card.shading == .striped ? color.opacity(0.5) : color)
        }
    }
    
    var borderColor: Color {
        if isMatched {
            return .green
        } else if isMismatched {
            return .red
        }
        return isSelected ? .orange : .black
    }
    
    struct Diamond: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
            path.closeSubpath()
            return path
        }
    }
}

#Preview {
    SetGameView(viewModel: SetGameViewModel())
}
