//
//  RescoreViewModel.swift
//  RescueRooster
//
//  Created by Роман Главацкий on 08.09.2025.
//
import Foundation
import SwiftUI

enum GameState {
    case playing
    case paused
    case gameOver
}

final class RescoreViewModel: ObservableObject {
    private let rewardsService = RewardsService()
    @Published var fireEntrys: [FireEntryModel] = [
        FireEntryModel(icon: .entry1, isGood: true, isEgg: false),
        FireEntryModel(icon: .entry2, isGood: true, isEgg: false),
        FireEntryModel(icon: .entry3, isGood: true, isEgg: false),
        FireEntryModel(icon: .entry4, isGood: true, isEgg: false),
        FireEntryModel(icon: .entry5, isGood: true, isEgg: false),
        FireEntryModel(icon: .entry6, isGood: true, isEgg: false),
        FireEntryModel(icon: .entry7, isGood: true, isEgg: false),
        FireEntryModel(icon: .entry8, isGood: true, isEgg: false),
        FireEntryModel(icon: .entry9, isGood: true, isEgg: false),
        FireEntryModel(icon: .entry10, isGood: true, isEgg: false),
        FireEntryModel(icon: .entry11, isGood: true, isEgg: false),
        FireEntryModel(icon: .entry12, isGood: true, isEgg: false),
        FireEntryModel(icon: .entry13, isGood: true, isEgg: false),
        FireEntryModel(icon: .entry14, isGood: true, isEgg: false),
        FireEntryModel(icon: .entry15, isGood: true, isEgg: false),
        FireEntryModel(icon: .entry16, isGood: true, isEgg: false),
        FireEntryModel(icon: .entry17, isGood: true, isEgg: false),
        FireEntryModel(icon: .entry18, isGood: true, isEgg: false),
        FireEntryModel(icon: .entry19, isGood: false, isEgg: false),
        FireEntryModel(icon: .egg, isGood: true, isEgg: true),
        FireEntryModel(icon: .entry20, isGood: false, isEgg: false),
        FireEntryModel(icon: .entry21, isGood: false, isEgg: false),
        FireEntryModel(icon: .entry22, isGood: false, isEgg: false),
        FireEntryModel(icon: .entry23, isGood: false, isEgg: false),
        FireEntryModel(icon: .entry24, isGood: false, isEgg: false),
        FireEntryModel(icon: .entry25, isGood: false, isEgg: false),
        FireEntryModel(icon: .entry26, isGood: false, isEgg: false),
        FireEntryModel(icon: .entry27, isGood: false, isEgg: false),
        FireEntryModel(icon: .entry28, isGood: false, isEgg: false),
        FireEntryModel(icon: .entry29, isGood: false, isEgg: false),
        FireEntryModel(icon: .entry30, isGood: false, isEgg: false),
    ]
    
    @Published var score: Int = 0
    @Published var eggs: Int = 3
    @Published var gameState: GameState = .playing
    @Published var fallingObjects: [FireEntryModel] = []
    @Published var timeRemaining: Int = 60 // 1 minute in seconds
    
    // Game statistics for rewards
    private var eggsCaught: Int = 0
    private var livesLost: Int = 0
    private var gameStartTime: Date?
    
    private var gameTimer: Timer?
    private var spawnTimer: Timer?
    private var timeTimer: Timer?
    
    // Game constants
    private let maxEggs = 3
    private let scorePerGoodItem = 50
    private let timeBonusForEgg = 30 // +30 seconds for catching an egg
    private var screenHeight: CGFloat = 800 // Default fallback
    private var screenWidth: CGFloat = 400 // Default fallback
    
    func startGame() {
        gameState = .playing
        score = 0
        eggs = 3
        timeRemaining = 60 // Reset to 1 minute
        fallingObjects = []
        
        // Reset game statistics
        eggsCaught = 0
        livesLost = 0
        gameStartTime = Date()
        
        startGameLoop()
        startSpawning()
        startTimeCountdown()
    }
    
    func pauseGame() {
        gameState = .paused
        stopTimers()
    }
    
    func resumeGame() {
        gameState = .playing
        startGameLoop()
        startSpawning()
        startTimeCountdown()
    }
    
    func restartGame() {
        stopTimers()
        startGame()
    }
    
    func tapObject(at location: CGPoint) {
        guard gameState == .playing else { return }
        
        for index in fallingObjects.indices {
            let object = fallingObjects[index]
            let objectRect = CGRect(
                x: object.xPosition - 25,
                y: object.yPosition - 25,
                width: 50,
                height: 50
            )
            
            if objectRect.contains(location) && object.isVisible {
                handleObjectTap(object, at: index)
                break
            }
        }
    }
    
    private func handleObjectTap(_ object: FireEntryModel, at index: Int) {
        // Hide the object
        fallingObjects[index].isVisible = false
        
        if object.isEgg {
            // Add life (max 3) and time bonus
            if eggs < maxEggs {
                eggs += 1
            }
            timeRemaining += timeBonusForEgg // +30 seconds for catching an egg
            eggsCaught += 1 // Track for rewards
            print("🥚 Egg caught! +30 seconds. Time remaining: \(timeRemaining)")
        } else if object.isGood {
            // Add score
            score += scorePerGoodItem
        } else {
            // Remove life
            eggs -= 1
            livesLost += 1 // Track for rewards
            if eggs <= 0 {
                gameOver()
            }
        }
        
        // Check for score-based rewards
        rewardsService.checkAndUnlockRewards(for: score)
    }
    
    private func startGameLoop() {
        gameTimer = Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { _ in
            self.updateGame()
        }
    }
    
    private func startSpawning() {
        spawnTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { _ in
            self.spawnObject()
        }
    }
    
    private func startTimeCountdown() {
        timeTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.gameState == .playing {
                self.timeRemaining -= 1
                if self.timeRemaining <= 0 {
                    self.gameOver()
                }
            }
        }
    }
    
    private func stopTimers() {
        gameTimer?.invalidate()
        spawnTimer?.invalidate()
        timeTimer?.invalidate()
        gameTimer = nil
        spawnTimer = nil
        timeTimer = nil
    }
    
    private func updateGame() {
        guard gameState == .playing else { return }
        
        // Update falling objects - only move down, no rotation
        var indicesToRemove: [Int] = []
        
        for index in fallingObjects.indices {
            // Only move down - no rotation, no horizontal movement
            fallingObjects[index].yPosition += fallingObjects[index].fallSpeed
            
            // Remove objects that fell off screen (with some buffer)
            let objectSize: CGFloat = 50
            if fallingObjects[index].yPosition > screenHeight + objectSize {
                indicesToRemove.append(index)
            }
        }
        
        // Remove objects that fell off screen (in reverse order to avoid index issues)
        for index in indicesToRemove.reversed() {
            fallingObjects.remove(at: index)
        }
    }
    
    func updateScreenDimensions(width: CGFloat, height: CGFloat) {
        screenWidth = width
        screenHeight = height
        print("📱 Screen dimensions updated: \(width) x \(height)")
    }
    
    private func spawnObject() {
        guard gameState == .playing else { return }
        
        if let randomObject = fireEntrys.randomElement() {
            var newObject = randomObject
            // Set random X position within screen bounds (with margin for object size)
            let objectSize: CGFloat = 50
            let margin: CGFloat = 25
            let minX = margin
            let maxX = screenWidth - margin - objectSize
            
            newObject.xPosition = CGFloat.random(in: minX...maxX)
            newObject.yPosition = -objectSize // Start from top (above screen)
            newObject.isVisible = true
            newObject.rotation = 0 // No rotation - items fall straight down
            newObject.fallSpeed = 3.0
            
            print("🔄 Spawning object at x: \(newObject.xPosition), y: \(newObject.yPosition), screen: \(screenWidth)x\(screenHeight)")
            fallingObjects.append(newObject)
        }
    }
    
    private func gameOver() {
        gameState = .gameOver
        stopTimers()
        
        // Check for special rewards
        let survivalTime = gameStartTime.map { Int(Date().timeIntervalSince($0)) } ?? 0
        let gameStats = GameStats(
            score: score,
            eggsCaught: eggsCaught,
            survivalTime: survivalTime,
            livesLost: livesLost,
            gameEndReason: eggs <= 0 ? .noLives : .timeUp
        )
        
        rewardsService.checkSpecialRewards(gameStats: gameStats)
        
        print("🎮 Game Over - Score: \(score), Eggs: \(eggsCaught), Time: \(survivalTime)s, Lives Lost: \(livesLost)")
    }
}
