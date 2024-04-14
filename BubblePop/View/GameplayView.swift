//
//  GameplayView.swift
//  BubblePop
//
//  Created by Quang Minh Nguyen on 28/3/2024.
//

import SwiftUI

struct GameplayView: View {
    var playerName: String
    @State private var score: Int = 0
    @State private var isGameFinished: Bool = false
    var body: some View {
        VStack{
            Text("Game Started!")
            /*Text("~~Game goes here~~")
            Text("*Game goes here*")
            Text("**Game goes here**")
            Text("***Game goes here***")
            Text("`Game goes here`")
            Text("[Game goes here](https://example.com)")*/
            Spacer()
            Text("\(playerName)")
            Spacer()
            Button("Finish Game"){
                score = Int.random(in: 0...100)
                isGameFinished = true
            }
            Spacer()
        }
        .sheet(isPresented: $isGameFinished, content: {
            LeaderboardView(playerName: playerName, playerScore: score)
        })
    }
}

#Preview {
    GameplayView(playerName: "")
}
