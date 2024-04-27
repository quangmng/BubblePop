//
//  GameplayView.swift
//  BubblePop
//
//  Created by Quang Minh Nguyen on 28/3/2024.
//

import SwiftUI

struct GameplayView: View{
    
    //Declaring Vars
    @Binding var playerName: String
    @Binding var timerValue: Double
    @State var bubbles: [BubblesModel] = []
    @State var score: Double
    @State private var showScore: Bool = false
    @StateObject var leaderboard: LeaderboardViewModel

    @StateObject var gameplay: GameplayViewModel
    
    var body: some View {
        ZStack{
            Color.mainMenu.ignoresSafeArea()
            VStack{
                //Title
                Label("Game Started!", systemImage: "gamecontroller.fill")
                    .font(.title)
                    .fontWeight(.black)
                //Game properties
                Text("Score: \(Int(gameplay.score)) - Time Left: \(Int(gameplay.timerValue))")
                Spacer()
                //Game logic
                ZStack{
                    ForEach(gameplay.bubbles) { bubble in
                        BubbleView(bubble: bubble)
                            .position(x: bubble.position.x, y: bubble.position.y)
                            .onTapGesture {
                                gameplay.bubbleTapped(bubble: bubble)
                                        }
                                }
                }
                .onAppear {
                    gameplay.timerValue = timerValue
                    gameplay.startGame()
                }
                
               

                //            .onReceive(timerValue) { _ in
                //                if timerValue > 0 {
                //                    timerValue -= 1
                //                    if bubbles.count < 30 {
                //                        let bubblesToAdd = min(5, 15 - bubbles.count) // Add up to 5 new bubbles, but don't exceed 15 total
                //                        for _ in 0..<bubblesToAdd {
                //  gameplay.generateAndAddbubble()
                //                        }
                //                    }
                //                } else {
                //                    timerValue.upstream.connect().cancel()
                //                    $gameplay.isGameOver = true
                //                }
                //            }
                //.navigationBarBackButtonHidden(true)
                
                
                
                
                
                .alert(isPresented: $gameplay.isGameOver) {
                    Alert(title: Text("Time's Up, \(playerName)!"), message: Text("Your Score was: \(Int(gameplay.score))"), dismissButton: .default(Text("OK")){
                            leaderboard.saveScores()
                            showScore.toggle()
                        })
                    }
                
                
                    .sheet(isPresented: $showScore, content: {
                        LeaderboardView(playerName: $playerName, playerScore: $gameplay.score)
                        
                    })
                
                
            }
        }
    }
}
struct GameplayView_Previews: PreviewProvider {
    static var previews: some View {
        GameplayView(
            playerName: .constant("Player"), timerValue: .constant(10), score: 0, gameplay: GameplayViewModel(timeLimit: 60, bubbleNum: 10)
        )
    }
}
