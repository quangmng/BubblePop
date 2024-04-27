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
    @Published var bubbles: [BubblesModel] = []
    @Published var score: Double = 0
    @Published var timerValue: Double
    @Published var isGameOver: Bool = false
//    @StateObject var leaderboard: LeaderboardViewModel
    var timer: Timer?
    var bubbleNum: Double
    init(timeLimit: Double, bubbleNum: Double) {
        self.timerValue = timeLimit
        self.bubbleNum = bubbleNum
    }
    
    func startGame() {
        // Start or resume the game timer
        isGameOver = false
                score = 0
                bubbles.removeAll()
                //timer?.invalidate()
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                    self?.timeTick()
                }
                generateBubbles()
            
    }
    
    func timeTick() {
        if timerValue > 0 {
            timerValue -= 1
        } else {
            endGame()
        }
    }
    func generateBubbles() {
        let targetBubbleCount = Int(bubbleNum)

            while bubbles.count < targetBubbleCount {
                let newBubble = generateBubbleOnChance()
                if !isOverlapping(newBubble) {
                    bubbles.append(newBubble)
                }
            }
        }
    
    func generateBubbleOnChance() -> BubblesModel {
            let pick = Int.random(in: 1...100)
        let (color, score) = getBubbleProperties(chance: pick)
            let position = randomPosition()
            return BubblesModel(colour: color, score: score, position: position)
        }
    
    func createBubbles() -> BubblesModel {
        // Generate and place new bubbles on the screen
        // Implement logic considering bubble probabilities
        let randomValue = Int.random(in: 1...100)
        let bubbleProperties = getBubbleProperties(chance: randomValue)
        let position = randomPosition() // Ensure this method accounts for non-overlapping placement.
        return BubblesModel(colour: bubbleProperties.colour, score: bubbleProperties.score, position: position)
    }
    
    func distance(between a: CGPoint, and b: CGPoint) -> CGFloat {
        return sqrt(pow(b.x - a.x, 2) + pow(b.y - a.y, 2))
    }
    
    func isOverlapping(_ newBubble: BubblesModel) -> Bool {
        for bubble in bubbles {
            if distance(between: bubble.position, and: newBubble.position) < bubble.size {
                return true
            }
        }
        return false
    }

    
    
    
    func bubbleTapped(bubble: BubblesModel) {
        // Handle scoring and bubble removal
        score += Double(bubble.score)
        bubbles.removeAll(where: { $0.id == bubble.id })
    }
    

    func randomPosition() -> CGPoint {
            let inset: CGFloat = 150  // Adjust this to ensure bubbles are not too close to the screen edge
            let minX = inset
            let maxX = UIScreen.main.bounds.width - inset
            let minY = inset
            let maxY = UIScreen.main.bounds.height - inset
            return CGPoint(x: .random(in: minX...maxX), y: .random(in: minY...maxY))
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
            return (.gray, 0)   // Fallback, should never be used
        }
    }
    private func endGame() {
        // End the game, update high scores if necessary
        isGameOver.toggle()
        timer?.invalidate()
        bubbles.removeAll()
        
        
    }
}
    

    
    


