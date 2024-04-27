//
//  LeaderboardView.swift
//  BubblePop
//
//  Created by Quang Minh Nguyen on 28/3/2024.
//

import SwiftUI

struct LeaderboardView: View {
    // Declaring Vars
    @Binding var playerName: String
    @Binding var playerScore: Double
    @ObservedObject var leaderboard = LeaderboardViewModel()
    
    var body: some View {
        ZStack{
            Color.mainMenu.ignoresSafeArea()
            VStack{
                // Title
                Label("Leaderboard", systemImage: "list.number")
                    .frame(alignment: .bottom)
                    .foregroundStyle(.red)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .padding(.top, 15)
                Text("(Shows top 15. Swipe down to close)")
                    .foregroundStyle(.red)
                Spacer()
                // ListView, shows 15 max scores
                List(leaderboard.playerScores.prefix(15)) {
                    playerScore in
                    Text("\(playerScore.playerName): \(playerScore.playerScore) pts.")
                    }
                .onAppear(){
                    leaderboard.loadPlayers()
                }
            }
        }
    }
}

#Preview {
    LeaderboardView(playerName: .constant(""), playerScore: .constant(0))
}
