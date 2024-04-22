//
//  Bubbles.swift
//  BubblePop
//
//  Created by Quang Minh Nguyen on 15/4/2024.
//

import Foundation
import SwiftUI

struct Bubble: Identifiable{
    let id = UUID()
    var colour: Color
    //var position: CGPoint
    var score: Int
    var probability: Float
}
let bubbleTypes = [
    Bubble(colour: .red, score: 1, probability: 0.40),
    Bubble(colour: .pink, score: 2, probability: 0.30),
    Bubble(colour: .green, score: 5, probability: 0.15),
    Bubble(colour: .blue, score: 8, probability: 0.10),
    Bubble(colour: .black, score: 10, probability: 0.05)
]
