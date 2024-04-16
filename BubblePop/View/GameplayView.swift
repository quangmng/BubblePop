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
            Label("Game Started!", systemImage: "")
                .font(.title)
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
        .alert(isPresented: $isGameFinished, content: {
            Alert(title: Text("Game Finished!"),  dismissButton: Alert.Button.cancel(Text("OK")))
        })
        /*.sheet(isPresented: $isGameFinished, content: {
            LeaderboardView(playerName: playerName, playerScore: score)
                .padding(.top)
        })*/
        
    }
}

#Preview {
    GameplayView(playerName: "")
}
