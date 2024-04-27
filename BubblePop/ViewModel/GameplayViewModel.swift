//
//  GameplayViewModel.swift
//  BubblePop
//
//  Created by Quang Minh Nguyen on 25/4/2024.
//

import Foundation
import UIKit
import SwiftUI


class GameplayViewModel: ObservableObject{
    
    //Declaring vars
    @Published var bubbleRefreshInterval: TimeInterval = 1.0
    @Published var bubbles: [BubblesModel] = []
    @Published var score: Double = 0
    @Published var timerValue: Double
    @Published var isGameOver: Bool = false
    @Published var countdown: Int = 3
    @Published var showCountdown: Bool = true
    @Published var showRestartButton: Bool = false
    private var lastPoppedBubbleColor: Color? = nil
    private var comboCount = 0
    private var safeAreaInsets: UIEdgeInsets = .zero
    var bubbleRefreshTimer: Timer?
    var gameTimer: Timer?
    var bubbleNum: Double
    var leaderboard: LeaderboardViewModel
    var playerName: String
    var initTimerValue: Double
    
    var highestScore: PlayersInfo? {
        leaderboard.topScoreEntry
    }
    
    // Initialising vars
    init(timeLimit: Double, bubbleNum: Double, leaderboard: LeaderboardViewModel, playerName: String) {
        self.initTimerValue = timeLimit
        self.bubbleNum = bubbleNum
        self.timerValue = timeLimit
        self.leaderboard = leaderboard
        self.playerName = playerName
    }

    
    
    // Start the countdown, then start game
        func startCountdown() {
            isGameOver = false
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
                guard let strongSelf = self else { return }
                
                if strongSelf.countdown > 0 {
                    // Update the countdown
                    strongSelf.countdown -= 1
                } else {
                    // When countdown finishes, start the game and hide countdown
                    timer.invalidate()
                    strongSelf.showCountdown = false
                    strongSelf.startGame()
                }
            }
        }
    
    func startGame() {
        // Start the game
        isGameOver = false
        playerName = UserDefaults.standard.string(forKey: "PlayerName")!
        score = 0
        bubbles.removeAll()
        gameTimer?.invalidate()
        bubbleRefreshTimer?.invalidate()
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.timeTick()
        }
        generateBubbles()
        scheduleBubbleRefreshTimer()
            
    }
    
    private func timeTick() {
        if timerValue > 0 {
            timerValue -= 1
            // Speed up the bubble refresh rate for the last 10 seconds
            if timerValue <= 10 {
                bubbleRefreshInterval -= 0.05
            }
        } else {
            endGame()
        }
    }
    
    private func scheduleBubbleRefreshTimer() {
        // Invalidate any existing timer
        bubbleRefreshTimer?.invalidate()
        _ = max(bubbleRefreshInterval, 0.45)
        bubbleRefreshTimer = Timer.scheduledTimer(withTimeInterval: bubbleRefreshInterval, repeats: false) { [weak self] _ in
            self?.refreshBubbles()
            // Only reschedule the timer if the game isn't over
            if !(self?.isGameOver ?? true) {
                self?.scheduleBubbleRefreshTimer()
            }
        }
    }
    
    func generateBubbles() {
        let targetBubbleCount = Int(bubbleNum)

            while bubbles.count < targetBubbleCount {
                let newBubble = createBubbles()
                if !isOverlapping(newBubble) {
                    bubbles.append(newBubble)
                }
            }
        }
    
    // Generate and place new bubbles on the screen
    func createBubbles() -> BubblesModel {
        let randomValue = Int.random(in: 1...100)
        let bubbleProperties = getBubbleProperties(chance: randomValue)
        let position = randomPosition()
        return BubblesModel(colour: bubbleProperties.colour, score: bubbleProperties.score, position: position)
    }
    
    // Bubble distance
    func distance(between a: CGPoint, and b: CGPoint) -> CGFloat {
        return sqrt(pow(b.x - a.x, 2) + pow(b.y - a.y, 2))
    }
    
    // Avoiding overlap balloons
    func isOverlapping(_ newBubble: BubblesModel) -> Bool {
        for bubble in bubbles {
            if distance(between: bubble.position, and: newBubble.position) < BubblesModel.size {
                return true
            }
        }
        return false
    }

    // Adapting safe area for generateBubbles() (avoiding various device bezels/bounds)
    func updateSafeAreaInsets(top: CGFloat, bottom: CGFloat, leading: CGFloat, trailing: CGFloat) {
            safeAreaInsets = UIEdgeInsets(top: top, left: leading, bottom: bottom, right: trailing)
        // Now that there're safe area insets, regenerate bubbles with correct positions
            generateBubbles()
        }
    
    
    func bubbleTapped(bubble: BubblesModel) {
        var bubbleScore = Double(bubble.score)
        // Check if the current bubble color matches the last popped bubble color
        if bubble.colour == lastPoppedBubbleColor {
            // Increase the combo count if it's a consecutive pop of the same color
            comboCount += 1
        } else {
            // Reset combo count if the color is different
            comboCount = 1
            lastPoppedBubbleColor = bubble.colour
        }
        // Apply the combo bonus if applicable (for comboCount > 1)
        if comboCount > 1 {
            bubbleScore *= 1.5
        }
        // Update the total score and round to the nearest integer
        score += round(bubbleScore)
        
        // Remove the tapped bubble from the array
        bubbles.removeAll(where: { $0.id == bubble.id })
    }

    func randomPosition() -> CGPoint {
        
        let horizontalPadding: CGFloat = 40
        let verticalPadding: CGFloat = 80
        let minX = safeAreaInsets.left + horizontalPadding
        let maxX = UIScreen.main.bounds.width - safeAreaInsets.right - horizontalPadding
        let minY = safeAreaInsets.top + verticalPadding
        let maxY = UIScreen.main.bounds.height - safeAreaInsets.bottom - verticalPadding
           // Generate and return a random position within the safe area bounds.
           return CGPoint(
               x: CGFloat.random(in: minX...maxX),
               y: CGFloat.random(in: minY...maxY)
           )
    }
    

    
    func refreshBubbles() {
        // Remove a random number of bubbles (not more than half for continuity)
        let bubblesToRemove = Int.random(in: 1...max(1, bubbles.count / 2))
        bubbles.shuffle()
        for _ in 0..<bubblesToRemove {
                if !bubbles.isEmpty {
                    bubbles.removeLast()
                }
            }
        //bubbles.removeLast(bubblesToRemove)
        
        // Determine the new number of bubbles to add, which can be up to the max set by the player
        let bubblesToAdd = Int.random(in: 1...Int(bubbleNum))
        
        // Generate the new bubbles ensuring not exceed the maximum bubbleNum
        let newBubbleCount = min(bubblesToAdd, Int(bubbleNum) - bubbles.count)
        for _ in 0..<newBubbleCount {
            let newBubble = createBubbles()
            // Ensure the new bubble does not overlap with existing ones
            if !isOverlapping(newBubble) {
                bubbles.append(newBubble)
            } else {
                // If it does overlap, try to generate another one
                let anotherNewBubble = createBubbles()
                if !isOverlapping(anotherNewBubble) {
                    bubbles.append(anotherNewBubble)
                }
            }
        }
    }
    
    func getBubbleProperties(chance: Int) -> (colour: Color, score: Int) {
        switch chance {
        case 1...40:
            return (.red, 1)    // 40% chance, 1 point
        case 41...70:
            return (.pink, 2)   // 30% chance, 2 points
        case 71...85:
            return (.green, 5)  // 15% chance, 5 points
        case 86...95:
            return (.blue, 8)   // 10% chance, 8 points
        case 96...100:
            return (.black, 10) // 5% chance, 10 points
        default:
            return (.white, 0)   // Fallback, should never be used
        }
    }

    func resetGame() {
        score = 0
        countdown = 3
        showRestartButton.toggle()
        showCountdown = true
        timerValue = initTimerValue
        comboCount = 0
        bubbleRefreshInterval = 1.0
        startCountdown()
        
    }
    
    private func endGame() {
        // End the game, update high scores
        isGameOver = true
        showRestartButton = true
        bubbles.removeAll()
        gameTimer?.invalidate()
        gameTimer = nil
        bubbleRefreshTimer?.invalidate()
        bubbleRefreshTimer = nil
        lastPoppedBubbleColor = nil
        comboCount = 0
        leaderboard.savePlayerScore(playerName: playerName, score: Int(score))
    }
    
}
    

    
    


