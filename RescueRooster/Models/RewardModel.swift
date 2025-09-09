//
//  RewardModel.swift
//  RescueRooster
//
//  Created by AI Assistant on 02.09.2025.
//

import SwiftUI

// MARK: - Reward Types
enum RewardType: String, CaseIterable, Identifiable {
    case firstScore = "first_score"
    case score100 = "score_100"
    case score500 = "score_500"
    case score1000 = "score_1000"
    case score2500 = "score_2500"
    case score5000 = "score_5000"
    case score10000 = "score_10000"
    case score25000 = "score_25000"
    case score50000 = "score_50000"
    case firstEgg = "first_egg"
    case eggCollector = "egg_collector"
    case timeMaster = "time_master"
    case survivor = "survivor"
    case perfectionist = "perfectionist"
    case legend = "legend"
    
    var id: String { rawValue }
    
    // Required score to unlock this reward
    var requiredScore: Int {
        switch self {
        case .firstScore: return 50
        case .score100: return 100
        case .score500: return 500
        case .score1000: return 1000
        case .score2500: return 2500
        case .score5000: return 5000
        case .score10000: return 10000
        case .score25000: return 25000
        case .score50000: return 50000
        case .firstEgg: return 200
        case .eggCollector: return 1000
        case .timeMaster: return 1500
        case .survivor: return 3000
        case .perfectionist: return 7500
        case .legend: return 15000
        }
    }
    
    // Reward title
    var title: String {
        switch self {
        case .firstScore: return "First Steps"
        case .score100: return "Century"
        case .score500: return "Half Thousand"
        case .score1000: return "Thousand"
        case .score2500: return "Two and Half"
        case .score5000: return "Five Thousand"
        case .score10000: return "Ten Thousand"
        case .score25000: return "Twenty Five K"
        case .score50000: return "Fifty Thousand"
        case .firstEgg: return "Egg Hunter"
        case .eggCollector: return "Egg Collector"
        case .timeMaster: return "Time Master"
        case .survivor: return "Survivor"
        case .perfectionist: return "Perfectionist"
        case .legend: return "Legend"
        }
    }
    
    // Reward description
    var description: String {
        switch self {
        case .firstScore: return "Score your first 50 points"
        case .score100: return "Reach 100 points"
        case .score500: return "Reach 500 points"
        case .score1000: return "Reach 1,000 points"
        case .score2500: return "Reach 2,500 points"
        case .score5000: return "Reach 5,000 points"
        case .score10000: return "Reach 10,000 points"
        case .score25000: return "Reach 25,000 points"
        case .score50000: return "Reach 50,000 points"
        case .firstEgg: return "Catch your first egg"
        case .eggCollector: return "Catch 5 eggs in total"
        case .timeMaster: return "Survive for 2 minutes"
        case .survivor: return "Survive for 5 minutes"
        case .perfectionist: return "Reach 10,000 without losing a life"
        case .legend: return "Reach 25,000 points in one game"
        }
    }
    
    // Icon resource (you'll add the actual icons)
    var icon: ImageResource {
        switch self {
        case .firstScore: return .rew1
        case .score100: return .rew2
        case .score500: return .rew3
        case .score1000: return .rew4
        case .score2500: return .rew5
        case .score5000: return .rew6
        case .score10000: return .rew7
        case .score25000: return .rew8
        case .score50000: return .rew9
        case .firstEgg: return .rew10
        case .eggCollector: return .rew11
        case .timeMaster: return .rew12
        case .survivor: return .rew13
        case .perfectionist: return .rew14
        case .legend: return .rew15
        }
    }
    
    // Rarity level
    var rarity: RewardRarity {
        switch self {
        case .firstScore, .score100, .firstEgg: return .common
        case .score500, .score1000, .eggCollector: return .uncommon
        case .score2500, .score5000, .timeMaster: return .rare
        case .score10000, .survivor: return .epic
        case .score25000, .perfectionist: return .legendary
        case .score50000, .legend: return .mythic
        }
    }
}

// MARK: - Reward Rarity
enum RewardRarity: String, CaseIterable {
    case common = "common"
    case uncommon = "uncommon"
    case rare = "rare"
    case epic = "epic"
    case legendary = "legendary"
    case mythic = "mythic"
    
    var color: Color {
        switch self {
        case .common: return .gray
        case .uncommon: return .green
        case .rare: return .blue
        case .epic: return .purple
        case .legendary: return .orange
        case .mythic: return .red
        }
    }
    
    var name: String {
        switch self {
        case .common: return "Common"
        case .uncommon: return "Uncommon"
        case .rare: return "Rare"
        case .epic: return "Epic"
        case .legendary: return "Legendary"
        case .mythic: return "Mythic"
        }
    }
}

// MARK: - Reward Model
struct RewardModel: Identifiable {
    let id: String
    let type: RewardType
    let isUnlocked: Bool
    let unlockedAt: Date?
    
    init(type: RewardType, isUnlocked: Bool = false, unlockedAt: Date? = nil) {
        self.id = type.rawValue
        self.type = type
        self.isUnlocked = isUnlocked
        self.unlockedAt = unlockedAt
    }
}

