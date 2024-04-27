//
//  BubbleView.swift
//  BubblePop
//
//  Created by Quang Minh Nguyen on 26/4/2024.
//

import SwiftUI

struct BubbleView: View {
    var bubble: BubblesModel
    var body: some View {
        Circle()
            .fill(bubble.colour)
            .frame(width: BubblesModel.size, height: BubblesModel.size)
    }
}

struct BubbleView_Previews: PreviewProvider {
    static var previews: some View {
        // Create an example bubble for the preview
        let exampleBubble = BubblesModel(colour: .black, score: 5, position: CGPoint(x: 100, y: 100))
        BubbleView(bubble: exampleBubble)
    }
}
