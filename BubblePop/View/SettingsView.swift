//
//  SettingsView.swift
//  BubblePop
//
//  Created by Quang Minh Nguyen on 28/3/2024.
//

import SwiftUI

struct SettingsView: View {
    //Declaring vars, obtain timerValue from ContentView()
    @State private var timerInput = ""
    @Binding var timerValue: Double
    @Binding var bubbleNum: Double

    var body: some View {
        ZStack{
            Color.mainMenu.ignoresSafeArea()
            VStack{
                //Title
                Label("Settings", systemImage: "gearshape.fill")
                    .padding(50)
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundStyle(.blue)
                Spacer()
                //Timer slider
                Text("Game time?")
                Slider(value: $timerValue, in: 0...60, step: 1)
                    .frame(width: 250)
                Text(" \(Int(timerValue)) second(s)")
                    .padding(.bottom, 50)
                
                //Bubble Slider
                Text("Max bubbles?")
                Slider(value: $bubbleNum, in: 0...15, step: 1)
                    .frame(width: 250)
                Text(" \(Int(bubbleNum)) bubble(s)")
                    .padding()
                Spacer()
                
                 
                 
            }
        }
    }
}

#Preview {
    SettingsView(timerValue: .constant(0), bubbleNum: .constant(0))
}
