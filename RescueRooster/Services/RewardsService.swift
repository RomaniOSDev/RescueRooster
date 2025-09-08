//
//  RewardsService.swift
//  RescueRooster
//
//  Created by AI Assistant on 02.09.2025.
//

import Foundation
import SwiftUI

class RewardsService: ObservableObject {
    @Published var rewards: [RewardModel] = []
    
    private let userDefaults = UserDefaults.standard
    private let rewardsKey = "unlocked_rewards"
    
    var unlockedCount: Int {
        rewards.filter { $0.isUnlocked }.count
    }
    
    var completionPercentage: Double {
        guard !rewards.isEmpty else { return 0.0 }
        return Double(unlockedCount) / Double(rewards.count) * 100.0
    }
    
    init() {
        loadRewards()
    }
    
    func loadRewards() {
        // Initialize all rewards
        rewards = RewardType.allCases.map { type in
            let isUnlocked = isRewardUnlocked(type)
            let unlockedAt = isUnlocked ? getUnlockDate(for: type) : nil
            return RewardModel(type: type, isUnlocked: isUnlocked, unlockedAt: unlockedAt)
        }
    }
    
    func checkAndUnlockRewards(for score: Int) {
        for rewardType in RewardType.allCases {
            if !isRewardUnlocked(rewardType) && score >= rewardType.requiredScore {
                unlockReward(rewardType)
            }
        }
    }
    
    func checkSpecialRewards(gameStats: GameStats) {
        // Check for special achievements
        checkEggCollectorReward(eggsCaught: gameStats.eggsCaught)
        checkTimeMasterReward(survivalTime: gameStats.survivalTime)
        checkPerfectionistReward(score: gameStats.score, livesLost: gameStats.livesLost)
    }
    
    private func checkEggCollectorReward(eggsCaught: Int) {
        if eggsCaught >= 5 && !isRewardUnlocked(.eggCollector) {
            unlockReward(.eggCollector)
        }
    }
    
    private func checkTimeMasterReward(survivalTime: Int) {
        if survivalTime >= 120 && !isRewardUnlocked(.timeMaster) { // 2 minutes
            unlockReward(.timeMaster)
        }
        if survivalTime >= 300 && !isRewardUnlocked(.survivor) { // 5 minutes
            unlockReward(.survivor)
        }
    }
    
    private func checkPerfectionistReward(score: Int, livesLost: Int) {
        if score >= 10000 && livesLost == 0 && !isRewardUnlocked(.perfectionist) {
            unlockReward(.perfectionist)
        }
    }
    
    private func unlockReward(_ type: RewardType) {
        let unlockDate = Date()
        userDefaults.set(unlockDate, forKey: "\(rewardsKey)_\(type.rawValue)_date")
        userDefaults.set(true, forKey: "\(rewardsKey)_\(type.rawValue)")
        
        // Update the rewards array
        if let index = rewards.firstIndex(where: { $0.type == type }) {
            rewards[index] = RewardModel(type: type, isUnlocked: true, unlockedAt: unlockDate)
        }
        
        print("🏆 Reward unlocked: \(type.title)")
    }
    
    private func isRewardUnlocked(_ type: RewardType) -> Bool {
        return userDefaults.bool(forKey: "\(rewardsKey)_\(type.rawValue)")
    }
    
    private func getUnlockDate(for type: RewardType) -> Date? {
        return userDefaults.object(forKey: "\(rewardsKey)_\(type.rawValue)_date") as? Date
    }
    
    func resetAllRewards() {
        for type in RewardType.allCases {
            userDefaults.removeObject(forKey: "\(rewardsKey)_\(type.rawValue)")
            userDefaults.removeObject(forKey: "\(rewardsKey)_\(type.rawValue)_date")
        }
        loadRewards()
    }
}

// MARK: - Game Stats
struct GameStats {
    let score: Int
    let eggsCaught: Int
    let survivalTime: Int // in seconds
    let livesLost: Int
    let gameEndReason: GameEndReason
}

enum GameEndReason {
    case timeUp
    case noLives
    case manual
}
