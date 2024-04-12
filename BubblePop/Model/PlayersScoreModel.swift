//
//  Players.swift
//  BubblePop
//
//  Created by Quang Minh Nguyen on 28/3/2024.
//

import Foundation


struct PlayersScore: Codable, Identifiable {
    var id = UUID()
    let playerName: String
    var playerScroe: Int
}
