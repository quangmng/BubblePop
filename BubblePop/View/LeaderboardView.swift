//
//  LeaderboardView.swift
//  BubblePop
//
//  Created by Quang Minh Nguyen on 28/3/2024.
//

import SwiftUI

struct LeaderboardView: View {
    @State private var playersScores: [PlayersInfo] = []
    var playerName: String
    var playerScore: Int
    var body: some View {
        VStack{
            
            Label("Leaderboard", systemImage: "list.number")
                .foregroundStyle(.red)
                .font(.largeTitle)
            Spacer()
            List(playersScores.sorted(by: {$0.playerScore > $1.playerScore}))
            {
                playerScore in
                Text("Player \(playerScore.playerName):\(playerScore.playerScore)")
            }
            Spacer()
                .onAppear(){
                    loadPlayerScores()
                    //savePlayerScores()
                }
        }
    }
    private func loadPlayerScores() {
        if let data = UserDefaults.standard.data(forKey: "PlayerScores") {
            let decoder = JSONDecoder()
            if let decodedPlayerScores = try? decoder.decode([PlayersInfo].self, from: data) {
                playersScores = decodedPlayerScores
            }
        }
    }
    private func savePlayerScore() {
        let newPlayerScore = PlayersInfo(playerName: playerName, playerScore: playerScore)
        playersScores.append(newPlayerScore)
        let encoder = JSONEncoder()
        if let encoded = try?
            encoder.encode(playersScores) {
            UserDefaults.standard.set(encoded, forKey: "PlayerScores")
        }
    }
}

#Preview {
    LeaderboardView(playerName: "", playerScore: 0)
}
