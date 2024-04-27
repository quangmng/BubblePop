//
//  ContentView.swift
//  BubblePop
//
//  Created by Quang Minh Nguyen on 28/3/2024.
//

import SwiftUI

struct ContentView: View {
    //Declaring Vars
    
    @State var playerName: String
    @State var timerValue: Double
    @State var playerScore: Double
    @State var bubbleNum: Double
    @State private var askName = false
    @State private var playNow: Bool = false
    @State private var enterName: Bool = false
    @State private var setupBubble: Bool = false
    @State private var hiScore: Bool = false
    
    
    var body: some View {
        NavigationStack{
            ZStack {
                //Title of game & background image
                Image("mainScreen")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                VStack {
                    Text("Bubble Pop!")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundStyle(.mainMenu)
                    Spacer()
                    
                    //New Game button, with .alert asking for player name and passes value to GameplayView()
                    Button(action: {
                        askName.toggle()
                    }, label: {
                        Image(systemName: "gamecontroller.fill")
                        Text("New Game!")
                    })
                    .alert("Please enter your name", isPresented: $askName) {
                        TextField("Name pls", text: $playerName)
                        Button("Cancel", action: {
                            
                        })
                        Button("Play!", action: {
                            if playerName.trimmingCharacters(in: .whitespaces).isEmpty {
                                        // Generate a random alphanumeric string as the player name
                                        playerName = randomAlphanumericString(length: 6)
                                func randomAlphanumericString(length: Int) -> String {
                                    let lettersAndNumbers = "abcdefghijklmnopqrstuvwxyz0123456789"
                                    return String((0..<length).compactMap{ _ in lettersAndNumbers.randomElement() })
                                    }
                                }
                            UserDefaults.standard.set(playerName, forKey: "PlayerName")
                            playNow.toggle()
                           
                        })
                        
                    }
                    
                    //Modifiers for navigating to GameplayView() & customising button
                    .navigationDestination(isPresented: $playNow, destination:{ GameplayView(
                        playerName: $playerName,
                        timerValue: $timerValue,
                        score: bubbleNum, gameplay: GameplayViewModel(
                            timeLimit: timerValue,
                            bubbleNum: bubbleNum,
                            leaderboard: LeaderboardViewModel(), playerName: playerName))
                    })
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    .font(.title)
                    .padding()
                    
                    HStack {
                        //Settings button, with a sheet showing about halfway of the screen. Has a grabber on top for asthetics.
                        Button(action: {
                            setupBubble.toggle()
                            
                        }, label: {
                            Image(systemName: "gearshape.fill")
                            Text("Settings")
                        })
                        //Modifiers for sheet appearance & button customisations
                        .sheet(isPresented: $setupBubble){
                        } content: {
                            SettingsView(timerValue: $timerValue, bubbleNum: $bubbleNum)
                                .presentationDetents([.height(500), .height(650)])
                        }
                        .buttonStyle(.borderedProminent)
                        .font(Font.system(size: 16))
                        .padding(.leading, 2)
                        
                        
                        //Leaderboard button, with a sheet occupying whole screen.
                        Button(action: {
                            hiScore.toggle()
                        }, label: {
                            Image(systemName: "list.number")
                            Text("Leaderboard")
                        })
                        //Modifiers for sheet & button appearance
                        .sheet(isPresented: $hiScore){
                        } content: {
                            LeaderboardView(playerName: $playerName, playerScore: $playerScore)
                                
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.orange)
                        .font(Font.system(size: 16))
                        .padding(.leading, 5)
                    }
                    
                    Spacer()
                    // Footer text
                    Text("© 2024 [quangmng](https://github.com/quangmng)")
                        .foregroundStyle(.mainMenu)
                }
                .padding(25)
                
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View{
        ContentView(playerName: "", timerValue: 60, playerScore: 0, bubbleNum: 15)
    }
}

