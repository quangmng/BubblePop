//
//  SettingsView.swift
//  BubblePop
//
//  Created by Quang Minh Nguyen on 28/3/2024.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var timerInput = ""
    @State private var timerValue: Double = 0
    @State private var bubbleNum: Double = 0
    
    var body: some View {
        
        Label("Settings", systemImage: "")
            .font(.title)
            .fontWeight(.black)
            .foregroundStyle(.blue)
        Spacer()
       /*
        Text("Please enter your name:")
        TextField("Enter Name", text: $leaderboardViewModel.playerName)// $ to bind value
            .padding()*/
        
        Text("Game time?")
        Slider(value: $timerValue, in: 0...60, step: 1)
        Text(" \(Int(timerValue))")
            .padding()
            /*.onChange(of: timerValue, perform: { value in
                timerInput = "\(Int(value))"
            })*/
        
        Text("Max bubbles?")
        Slider(value: $bubbleNum, in: 0...50, step: 1)
        Text(" \(Int(bubbleNum))")
            .padding()
        Spacer()
        
        /*NavigationLink(destination: GameplayView(playerName: playerName),
            label: {Text("Start Game!")
            .font(.title)})
        .padding(20)
            Spacer()
            
            .onDisappear{
                UserDefaults.standard.set(playerName, forKey: "playerName")
    }*/
    }
}

#Preview {
    SettingsView()
}
