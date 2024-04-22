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
    @State private var showScore: Bool = false
    var body: some View {
        ZStack{
            Color.mainMenu.ignoresSafeArea()
            VStack{
                Label("Game Started!", systemImage: "")
                    .font(.title)
                Spacer()
                Text("Score: \(score) - Time Remaining: ")
                Spacer()
                Button("Finish Game"){
                    score = Int.random(in: 0...100)
                    isGameFinished = true
                }
                Spacer()
            }
            
            .alert(isPresented: $isGameFinished) {
                Alert(title: Text("Time's Up!"), message: Text("Your Score was: \(score)"), dismissButton: .default(Text("OK")){
                    showScore.toggle()
                })
            }
            
            
            
            .sheet(isPresented: $showScore, content: {
             LeaderboardView(playerName: playerName, playerScore: score)
             .padding(.top)
             })
        }
    }
}

#Preview {
    GameplayView(playerName: "")
}
