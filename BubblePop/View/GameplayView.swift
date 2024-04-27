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
    @State private var restartGame: Bool = false
    @State private var setupGame: Bool = false
    @ObservedObject var gameplay: GameplayViewModel
    let leaderboardVM = LeaderboardViewModel()
    
    
    var body: some View {
        ZStack{
            Color.mainMenu.ignoresSafeArea()
            VStack{
                //Title
                Label("POP!", systemImage: "gamecontroller.fill")
                    .font(.title)
                    .fontWeight(.black)
                //Game properties
                Text("Score: \(Int(gameplay.score)) - Time Left: \(Int(gameplay.timerValue))")
                if let highScore = gameplay.highestScore {
                                Text("🏆 High Score: \(highScore.playerScore) by \(highScore.playerName)")
                                    .font(.headline)
                                    .padding()
                                    .background(Color.secondary.opacity(0.1))
                                    .cornerRadius(8)
                            }
                
                Spacer()
                //Game logic
                GeometryReader { geometry in
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
                        let safeArea = geometry.safeAreaInsets
                        let additionalPadding: CGFloat = 200
                        // Add additional padding if needed
                        gameplay.updateSafeAreaInsets(
                                top: safeArea.top,
                                bottom: safeArea.bottom + additionalPadding,
                                leading: safeArea.leading,
                                trailing: safeArea.trailing
                            )
            
                        gameplay.leaderboard.loadPlayers()
                        gameplay.startCountdown()
                    }
                    
                    // Countdown overlay
                    if gameplay.showCountdown {
                        ZStack {
                            // Semi-transparent background
                            Color.mainMenu.opacity(90)
                                .edgesIgnoringSafeArea(.all)
                                
                            // Countdown Text
                            Text(gameplay.countdown > 0 ? "\(gameplay.countdown)" : "POP!")
                                .font(Font.system(size: 80, weight: .bold, design: .rounded))
                                .foregroundColor(.blue)
                                .transition(.scale)
                                
                        }
                        .animation(.easeInOut, value: gameplay.countdown)
                    }
                }
                
                // TIme's Up alert
                .alert(isPresented: $gameplay.isGameOver) {
                    Alert(title: Text("Time's Up, \(playerName)!"), message: Text("Your Score was: \(Int(gameplay.score))"), dismissButton: .default(Text("OK")){
                            showScore.toggle()
                            restartGame.toggle()
                        })
                    }
                
                // LeaderboardView in Sheet
                    .sheet(isPresented: $showScore, content: {
                        LeaderboardView(playerName: $playerName, playerScore: $gameplay.score)
                        
                        
                    })
            }
            
            VStack{
            // Restart button only visible when the game is over
                if restartGame == true {
                    Button("Restart Game", systemImage: "arrow.circlepath") {
                        gameplay.resetGame()
                        restartGame.toggle()
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    
                }
            }
        }
    }
}
struct GameplayView_Previews: PreviewProvider {
    static var previews: some View {
        GameplayView(
            playerName: .constant("Player"), timerValue: .constant(10), score: 0, gameplay: GameplayViewModel(timeLimit: 10, bubbleNum: 10, leaderboard: LeaderboardViewModel(), playerName: "Player")
        )
    }
}
