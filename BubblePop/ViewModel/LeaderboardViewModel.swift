//
//  LeaderboardViewModel.swift
//  BubblePop
//
//  Created by Quang Minh Nguyen on 26/4/2024.
//

import Foundation
class LeaderboardViewModel: ObservableObject {
    
    @Published var playerScores: [PlayersInfo] = []
    //Load top index (highest score)
    var topScoreEntry: PlayersInfo? {
            playerScores.sorted { $0.playerScore > $1.playerScore }.first
        }
    // Load player details
    func loadPlayers() {
        guard let data = UserDefaults.standard.data(forKey: "PlayerScores") else { return }
        let decoder = JSONDecoder()
        if let decoded = try? decoder.decode([PlayersInfo].self, from: data) {
            playerScores = decoded.sorted { $0.playerScore > $1.playerScore }
        }
    }
    
    // Save the current player's score at the end of the game
    func savePlayerScore(playerName: String, score: Int) {
        // Load the current leaderboard scores
        loadPlayers()
        
        // Check if the player already has a score and update it if the new score is higher
        if let index = playerScores.firstIndex(where: { $0.playerName == playerName }) {
            if score > playerScores[index].playerScore {
                playerScores[index].playerScore = score
            }
        } else {
            // If the player isn't on the leaderboard, add them
            let newPlayerScore = PlayersInfo(playerName: playerName, playerScore: score)
            playerScores.append(newPlayerScore)
        }
        
        // Sort the scores and keep the top scores only if necessary
        playerScores.sort { $0.playerScore > $1.playerScore }
        if playerScores.count > 15 {
            playerScores = Array(playerScores.prefix(15))
        }
        
        // Save the updated leaderboard
        saveScores()
    }
    // Writing to a persistent file
    private func saveScores() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(playerScores) {
            UserDefaults.standard.set(encoded, forKey: "PlayerScores")
        }
    }
}


    



