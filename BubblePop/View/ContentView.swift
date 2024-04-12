//
//  ContentView.swift
//  BubblePop
//
//  Created by Quang Minh Nguyen on 28/3/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            
            Image("mainScreen")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                Text("Bubble Pop!")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.mint)
                Spacer()
                

                NavigationLink(
                    destination: SettingsView(),
                    label:{Text("New Game!")
                            .font(.title)
                            .foregroundStyle(.green)
                    })
                .padding(50)
                
                NavigationLink(
                    destination: LeaderboardView(),
                    label:{Text("Hi Scores")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .foregroundStyle(.blue)
                    })
                Spacer()
            }
            .padding()
            
            
            .padding()
        }
    }
}
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View{
            ContentView()
        }
    }
