//
//  LeaderboardView.swift
//  BubblePop
//
//  Created by Quang Minh Nguyen on 28/3/2024.
//

import SwiftUI

struct LeaderboardView: View {
    
    @State private var playersScores: [PlayersInfo] = []
    @Binding var playerName: String
    @Binding var playerScore: Double
    
    var body: some View {
        ZStack{
            Color.mainMenu.ignoresSafeArea()
            VStack{
                Label("Leaderboard", systemImage: "list.number")
                    .frame(alignment: .bottom)
                    .foregroundStyle(.red)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .padding(.top, 15)
                Text("(Shows top 15. Swipe down to close)")
                    .foregroundStyle(.red)
                Spacer()
                List(playersScores.sorted(by: {$0.playerScore > $1.playerScore}).prefix(15)){
                    
                    playerScore in
                    Text("\(playerScore.playerName): \(playerScore.playerScore)")
                    
                }
                .onAppear(){
                    loadPlayers()
                    //savePlayerScore()
                }
            }
        }
    }

    private func loadPlayers() {
        if let data = UserDefaults.standard.data(forKey: "PlayerScores") {
            let decoder = JSONDecoder()
            if let decodedPlayerScores = try? decoder.decode([PlayersInfo].self, from: data) {
                playersScores = decodedPlayerScores
            }
        }
    }
}
    /*func savePlayerScore() {
        let newPlayerScore = PlayersInfo(playerName: playerName, playerScore: Int(playerScore))
        playersScores.append(newPlayerScore)
        let encoder = JSONEncoder()
        if let encoded = try?
            encoder.encode(playersScores) {
            UserDefaults.standard.set(encoded, forKey: "PlayerScores")
        }
    }
}*/


#Preview {
    LeaderboardView(playerName: .constant(""), playerScore: .constant(0))
}
