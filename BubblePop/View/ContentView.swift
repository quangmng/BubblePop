//
//  ContentView.swift
//  BubblePop
//
//  Created by Quang Minh Nguyen on 28/3/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var playerName: String = ""
    var body: some View {
        NavigationView{
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
                    
                    NavigationLink(destination: GameplayView(playerName: "")) {
                        Button(action: {}){
                            Image(systemName: "gamecontroller.fill")
                            Text("New Game!")
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.green)
                        .font(.title)
                    }
                    
                    
                    /* Button(action: {
                     
                     }, label: {
                     Image(systemName: "gamecontroller.fill")
                     Text("New Game!")
                     })
                     .buttonStyle(.borderedProminent)
                     .tint(.green)
                     .font(.title)
                     
                     .padding()*/
                    HStack{
                        NavigationLink(destination: SettingsView()) {
                            Button(action: {}, label: {
                                Image(systemName: "gearshape.fill")
                                Text("Settings")
                            })
                            .buttonStyle(.borderedProminent)
                            .font(.title3)
                            
                            .padding()
                        }
                        
                        NavigationLink(destination: SettingsView()) {
                            Button(action: {}, label: {
                                Image(systemName: "list.number")
                                Text("Leaderboard")
                            })
                            .buttonStyle(.borderedProminent)
                            .tint(.orange)
                            .font(.title3)
                        }
                    }
                    Spacer()
                    /*NavigationLink(
                     destination: GameplayView(),
                     label:{Text("New Game!")
                     .font(.title)
                     .foregroundStyle(.green)
                     })
                     .padding(50)*/
                    
                    NavigationLink(
                        destination: LeaderboardView(playerName: "", playerScore: 0),
                        label:{Text("Hi Scores")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.blue)
                        })
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

