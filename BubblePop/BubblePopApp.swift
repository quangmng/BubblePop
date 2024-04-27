//
//  BubblePopApp.swift
//  BubblePop
//
//  Created by Quang Minh Nguyen on 28/3/2024.
//

import SwiftUI

@main
struct BubblePopApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(playerName: "", timerValue: 0, playerScore: 0, bubbleNum: 0)
        }
    }
}
