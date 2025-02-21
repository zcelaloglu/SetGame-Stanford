//
//  AspectVGrid.swift
//  Set
//
//  Created by Zafer CELALOGLU on 21.02.2025.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    var items: [Item]
    var aspectRatio: CGFloat
    var minimumWidth: CGFloat = 65
    let content: (Item) -> ItemView
    
    init(_ items: [Item], aspectRatio: CGFloat, minimumWidth: CGFloat = 65, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.minimumWidth = minimumWidth
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            let width = max(minimumWidth, widthThatFits(count: items.count, in: geometry.size, aspectRatio: aspectRatio))
            LazyVGrid(columns: [GridItem(.adaptive(minimum: width), spacing: 0)], spacing: 4) {
                ForEach(items) { item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
    }
    
    private func widthThatFits(count: Int, in size: CGSize, aspectRatio: CGFloat) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            let rowCount = (count / columnCount).rounded(.up)
            if rowCount * height < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
        } while columnCount < count
        return min(size.width / count, size.width)
    }
}
