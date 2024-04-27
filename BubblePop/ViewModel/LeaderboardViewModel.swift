//
//  LeaderboardViewModel.swift
//  BubblePop
//
//  Created by Quang Minh Nguyen on 26/4/2024.
//

import Foundation
class LeaderboardViewModel: ObservableObject {
    @Published var playerScores: [PlayersInfo] = []
    
    func loadPlayers() {
        guard let data = UserDefaults.standard.data(forKey: "PlayerScores") else { return }
        let decoder = JSONDecoder()
        if let decodedPlayerScores = try? decoder.decode([PlayersInfo].self, from: data) {
            self.playerScores = decodedPlayerScores.sorted { $0.playerScore > $1.playerScore }
        }
    }
    //    func addNewScore(playerName: String, score: Int) {
    //            let newScore = PlayersInfo(playerName: playerName, playerScore: score)
    //            playerScores.append(newScore)
    //            playerScores.sort { $0.playerScore > $1.playerScore }
    //            if playerScores.count > 15 {
    //                playerScores = Array(playerScores.prefix(15))
    //            }
    //            saveScores()
    //        }
    //    func saveScores() {
    //            let encoder = JSONEncoder()
    //            if let encoded = try? encoder.encode(playerScores) {
    //                UserDefaults.standard.set(encoded, forKey: "PlayerScores")
    //        }
    //    }
    //    func savePlayerScore() {
    //        let newPlayerScore = PlayersInfo(playerName: playerName, playerScore: Int(playerScore))
    //        playersScores.append(newPlayerScore)
    //        let encoder = JSONEncoder()
    //        if let encoded = try?
    //            encoder.encode(playersScores) {
    //            UserDefaults.standard.set(encoded, forKey: "PlayerScores")
    //        }
    //    }
    //}
}
    



