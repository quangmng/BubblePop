//
//  SettingsView.swift
//  BubblePop
//
//  Created by Quang Minh Nguyen on 28/3/2024.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var leaderboardViewModel = LeaderboardViewModel()
    @State private var timerInput = ""
    @State private var timerValue: Double = 0
    @State private var bubbleNum: Double = 0
    @State private var playerName: String = ""
    
    var body: some View {
        
        Label("Welcome!", systemImage: "")
            .font(.title)
            .fontWeight(.black)
            .foregroundStyle(.green)
        Spacer()
        
        Text("Please enter your name:")
        TextField("Enter Name", text: $leaderboardViewModel.playerName)// $ to bind value
            .padding()
        
        Text("Game time?")
        Slider(value: $timerValue, in: 0...60, step: 1)
        Text(" \(Int(timerValue))")
            .padding()
        
        Text("Max bubbles?")
        Slider(value: $bubbleNum, in: 0...50, step: 1)
        Text(" \(Int(bubbleNum))")
            .padding()
        
        NavigationLink(destination: GameplayView(playerName: playerName),
                       label: {Text("Start Game!")
            .font(.title)})
        .padding(20)
            Spacer()
            
            .onDisappear{
                UserDefaults.standard.set(playerName, forKey: "playerName")
    }
    }
}

#Preview {
    SettingsView()
}
