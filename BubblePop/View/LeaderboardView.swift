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
            
            Label("Hi Scores!", systemImage: "")
                .foregroundStyle(.red)
                .font(.title)
            Spacer()
            List(playersScores.sorted(by: {$0.playerScore > $1.playerScore}))
            {
                playerScore in
                Text("\(playerScore.playerName):\(playerScore.playerScore)")
            }
            
            Spacer()
        }
    }
}

#Preview {
    LeaderboardView(playerName: "", playerScore: 0)
}
