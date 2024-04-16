//
//  ContentView.swift
//  BubblePop
//
//  Created by Quang Minh Nguyen on 28/3/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var playerName: String = UserDefaults.standard.string(forKey: "Anon") ?? ""
    @State private var playNow: Bool = false
    @State private var enterName: Bool = false
    @State private var setupBubble: Bool = false
    @State private var hiScore: Bool = false
    var body: some View {
        NavigationStack {
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
                        playNow.toggle()
                     }, label: {
                     Image(systemName: "gamecontroller.fill")
                     Text("New Game!")
                     })
                    .navigationDestination(isPresented: $playNow, destination:{ GameplayView(playerName: "")})
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
                            .navigationDestination(isPresented: $setupBubble, destination:{
                                SettingsView()})
                            .buttonStyle(.borderedProminent)
                            .font(.title3)
                            .padding()
                        
                        
                        
                            Button(action: {
                                hiScore.toggle()
                            }, label: {
                                Image(systemName: "list.number")
                                Text("Leaderboard")
                            })
                            .navigationDestination(isPresented: $hiScore, destination:{ LeaderboardView(playerName: "", playerScore: 0)})
                            .buttonStyle(.borderedProminent)
                            .tint(.orange)
                            .font(.title3)
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
#Preview {
    ContentView()
}
    /*struct ContentView_Previews: PreviewProvider {
        static var previews: some View{
            ContentView()
        }
    }*/

