//
//  BubblesModel.swift
//  BubblePop
//
//  Created by Quang Minh Nguyen on 15/4/2024.
//

import Foundation
import SwiftUI

struct BubblesModel: Identifiable {
    let id = UUID()
    var colour: Color
    var score: Int
    var position: CGPoint
    static let size: CGFloat = 60
}
