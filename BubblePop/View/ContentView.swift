//
//  ContentView.swift
//  BubblePop
//
//  Created by Quang Minh Nguyen on 28/3/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var leaderboardViewModel = LeaderboardViewModel()
    @State private var playerName: String = ""
    @State private var askName = false
    @State private var playNow: Bool = false
    @State private var enterName: Bool = false
    @State private var setupBubble: Bool = false
    @State private var hiScore: Bool = false
    var body: some View {
        NavigationStack{
            ZStack {
                
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
                    
                    
                    Button(action: {
                        askName.toggle()
                    }, label: {
                        Image(systemName: "gamecontroller.fill")
                        Text("New Game!")
                    })
                    .alert("Please enter your name", isPresented: $askName) {
                        TextField("Name pls", text: $playerName)
                        Button("OK", action: {
                            playNow.toggle()
                        })
                        //.onDisappear {UserDefaults.standard.set(playerName, forKey: "Anon")}
                    }
                    .navigationDestination(isPresented: $playNow, destination:{ GameplayView(playerName: playerName)})
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    .font(.title)
                    .padding()
                    
                    HStack {
                        Button(action: {
                            setupBubble.toggle()
                            
                        }, label: {
                            Image(systemName: "gearshape.fill")
                            Text("Settings")
                        })
                        /*.navigationDestination(isPresented: $setupBubble, destination:{
                            SettingsView()})*/
                        .sheet(isPresented: $setupBubble){
                        } content: {
                         SettingsView()
                                .presentationDetents([.medium, .large])
                        }
                        .buttonStyle(.borderedProminent)
                        .font(Font.system(size: 16))
                        .padding(.leading, 2)
                        
                        
                        
                        Button(action: {
                            hiScore.toggle()
                        }, label: {
                            Image(systemName: "list.number")
                            Text("Leaderboard")
                        })
                        /*.navigationDestination(isPresented: $hiScore, destination:{ LeaderboardView(playerName: "", playerScore: 0)})*/
                        .sheet(isPresented: $hiScore){
                        } content: {
                            LeaderboardView(playerName: "", playerScore: 0)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.orange)
                        .font(Font.system(size: 16))
                        .padding(.leading, 5)
                    }
                    
                    Spacer()
                    
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
        ContentView()
    }
}

