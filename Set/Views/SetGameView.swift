//
//  ContentView.swift
//  Set
//
//  Created by Zafer CELALOGLU on 21.02.2025.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var viewModel: SetGameViewModel

    var body: some View {
        VStack(spacing: .zero) {
            header
            content
            bottomBar
        }
        .background(Color.white)
    }

    private var header: some View {
        Text("Score: \(viewModel.score)")
            .font(.largeTitle)
            .padding()
            .frame(maxWidth: .infinity)
    }

    private var content: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 16) {
                    AspectVGrid(
                        viewModel.cardsInPlay,
                        aspectRatio: 2/3
                    ) { card in
                        CardView(card: card, viewModel: viewModel)
                    }
                }
                .frame(maxWidth: .infinity, minHeight: geometry.size.height)
            }
        }
    }

    private var bottomBar: some View {
        HStack {
            Button("New Game") {
                viewModel.newGame()
            }
            .buttonStyle(.bordered)
            Spacer()
            Button("Deal 3 More Cards") {
                viewModel.dealThreeMoreCards()
            }
            .buttonStyle(.bordered)
            .disabled(viewModel.deck.isEmpty)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

#Preview {
    SetGameView(viewModel: SetGameViewModel())
}
