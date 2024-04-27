//
//  PlayersModel.swift
//  BubblePop
//
//  Created by Quang Minh Nguyen on 28/3/2024.
//

import Foundation
struct PlayersInfo: Identifiable, Codable{
    var id = UUID()
    var playerName: String
    var playerScore: Int
}
