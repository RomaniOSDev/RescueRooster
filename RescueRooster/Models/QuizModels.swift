//
//  QuizModels.swift
//  RescueRooster
//
//  Created by Роман Главацкий on 02.09.2025.
//

import SwiftUI

// MARK: - Quiz Models
enum QuizLevel: String, CaseIterable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    
    var completedIcon: ImageResource {
        switch self {
            
        case .easy:
            return .easyComp
        case .medium:
            return .mediumComp
        case .hard:
            return .hardComp
        }
    }
    
    var icon: ImageResource {
        switch self {
            
        case .easy:
            return .easyBut
        case .medium:
            return .mediumBut
        case .hard:
            return .hardBut
        }
    }
    
    var emoji: String {
        switch self {
        case .easy: return "🟢"
        case .medium: return "🟡"
        case .hard: return "🔴"
        }
    }
    
    var color: String {
        switch self {
        case .easy: return "green"
        case .medium: return "orange"
        case .hard: return "red"
        }
    }
}

struct QuizQuestion: Identifiable, Codable {
    let id = UUID()
    let question: String
    let options: [String]
    let correctAnswerIndex: Int
    let explanation: String?
    
    enum CodingKeys: String, CodingKey {
        case question, options, correctAnswerIndex, explanation
    }
}

struct QuizData {
    static let easyQuestions: [QuizQuestion] = [
        QuizQuestion(
            question: "What number do you call in case of fire?",
            options: ["102", "101", "100"],
            correctAnswerIndex: 1,
            explanation: "101 is the emergency number for fire services in many countries."
        ),
        QuizQuestion(
            question: "What color is a fire truck usually?",
            options: ["Red", "Blue", "Green"],
            correctAnswerIndex: 0,
            explanation: "Fire trucks are typically red to make them easily visible."
        ),
        QuizQuestion(
            question: "What tool sprays water on fire?",
            options: ["Axe", "Hose", "Helmet"],
            correctAnswerIndex: 1,
            explanation: "A hose is used to spray water on fires to extinguish them."
        ),
        QuizQuestion(
            question: "What does a smoke detector do?",
            options: ["Makes alarm", "Turns on light", "Opens doors"],
            correctAnswerIndex: 0,
            explanation: "Smoke detectors make an alarm sound when they detect smoke."
        ),
        QuizQuestion(
            question: "What do firefighters wear on their head?",
            options: ["Cap", "Helmet", "Mask"],
            correctAnswerIndex: 1,
            explanation: "Firefighters wear helmets to protect their heads from falling debris."
        ),
        QuizQuestion(
            question: "What do you do if clothes catch fire?",
            options: ["Run fast", "Stop Drop Roll", "Jump high"],
            correctAnswerIndex: 1,
            explanation: "Stop, Drop, and Roll is the correct way to extinguish fire on clothing."
        ),
        QuizQuestion(
            question: "What protects hands from heat?",
            options: ["Boots", "Suit", "Gloves"],
            correctAnswerIndex: 2,
            explanation: "Fire-resistant gloves protect firefighters' hands from heat and flames."
        ),
        QuizQuestion(
            question: "What shoes do firefighters wear?",
            options: ["Sneakers", "Boots", "Sandals"],
            correctAnswerIndex: 1,
            explanation: "Firefighters wear special boots that protect their feet from heat and sharp objects."
        ),
        QuizQuestion(
            question: "What sound warns people of a fire truck?",
            options: ["Siren", "Bell", "Horn"],
            correctAnswerIndex: 0,
            explanation: "Sirens are used to warn people that a fire truck is approaching."
        ),
        QuizQuestion(
            question: "What tool can break a door?",
            options: ["Axe", "Hose", "Radio"],
            correctAnswerIndex: 0,
            explanation: "An axe is used by firefighters to break through doors and walls."
        )
    ]
    
    static let mediumQuestions: [QuizQuestion] = [
        QuizQuestion(
            question: "What protects a firefighter's body from heat?",
            options: ["Suit", "Gloves", "Boots"],
            correctAnswerIndex: 0,
            explanation: "Fire-resistant suits protect firefighters' bodies from extreme heat."
        ),
        QuizQuestion(
            question: "Where should you never block in a building?",
            options: ["Exit", "Window", "Stairs"],
            correctAnswerIndex: 0,
            explanation: "Exits should never be blocked as they are essential escape routes."
        ),
        QuizQuestion(
            question: "What gas detector warns of danger?",
            options: ["Smoke detector", "Alarm clock", "Flashlight"],
            correctAnswerIndex: 0,
            explanation: "Smoke detectors warn of dangerous gases and smoke in the air."
        ),
        QuizQuestion(
            question: "What liquid is most used to fight fire?",
            options: ["Water", "Oil", "Fuel"],
            correctAnswerIndex: 0,
            explanation: "Water is the most commonly used liquid to extinguish fires."
        ),
        QuizQuestion(
            question: "What symbol shows the way out?",
            options: ["Exit sign", "Stop sign", "Speed sign"],
            correctAnswerIndex: 0,
            explanation: "Exit signs show the way to emergency exits in buildings."
        ),
        QuizQuestion(
            question: "What should you never play with indoors?",
            options: ["Matches", "Toys", "Keys"],
            correctAnswerIndex: 0,
            explanation: "Matches should never be played with indoors as they can start fires."
        ),
        QuizQuestion(
            question: "What part of the fire truck carries water?",
            options: ["Tank", "Ladder", "Siren"],
            correctAnswerIndex: 0,
            explanation: "The tank on a fire truck carries water to fight fires."
        ),
        QuizQuestion(
            question: "What device lets firefighters talk to each other?",
            options: ["Phone", "Radio", "Bell"],
            correctAnswerIndex: 1,
            explanation: "Radios allow firefighters to communicate with each other during emergencies."
        ),
        QuizQuestion(
            question: "What should you do if you see fire?",
            options: ["Run away", "Call 101", "Hide"],
            correctAnswerIndex: 1,
            explanation: "If you see a fire, you should immediately call the emergency number 101."
        ),
        QuizQuestion(
            question: "What protects eyes and breathing in smoke?",
            options: ["Mask", "Gloves", "Boots"],
            correctAnswerIndex: 0,
            explanation: "Masks protect firefighters' eyes and breathing from smoke and toxic gases."
        )
    ]
    
    static let hardQuestions: [QuizQuestion] = [
        QuizQuestion(
            question: "What spreads faster, smoke or fire?",
            options: ["Smoke", "Fire", "Water"],
            correctAnswerIndex: 0,
            explanation: "Smoke spreads faster than fire and can be more dangerous due to toxic gases."
        ),
        QuizQuestion(
            question: "How often should smoke detectors be tested?",
            options: ["Once a year", "Once a week", "Monthly"],
            correctAnswerIndex: 2,
            explanation: "Smoke detectors should be tested monthly to ensure they work properly."
        ),
        QuizQuestion(
            question: "What is the safest way to go down in smoke?",
            options: ["Run fast", "Crawl low", "Jump high"],
            correctAnswerIndex: 1,
            explanation: "Crawling low helps avoid smoke, which rises and is less dense near the floor."
        ),
        QuizQuestion(
            question: "Where should fire extinguishers be kept?",
            options: ["Near exits", "In closets", "In the attic"],
            correctAnswerIndex: 0,
            explanation: "Fire extinguishers should be kept near exits for easy access during emergencies."
        ),
        QuizQuestion(
            question: "What should you do before opening a door in fire?",
            options: ["Check heat", "Kick it", "Ignore it"],
            correctAnswerIndex: 0,
            explanation: "You should check if the door is hot before opening it, as it may indicate fire on the other side."
        ),
        QuizQuestion(
            question: "What type of fire does water not stop?",
            options: ["Oil fire", "Wood fire", "Paper fire"],
            correctAnswerIndex: 0,
            explanation: "Water should not be used on oil fires as it can cause the fire to spread."
        ),
        QuizQuestion(
            question: "What should you close behind when escaping?",
            options: ["Doors", "Windows", "Ladders"],
            correctAnswerIndex: 0,
            explanation: "Closing doors behind you helps slow the spread of fire and smoke."
        ),
        QuizQuestion(
            question: "What is the first step in Stop Drop Roll?",
            options: ["Run", "Stop", "Shout"],
            correctAnswerIndex: 1,
            explanation: "The first step in Stop Drop Roll is to STOP moving immediately."
        ),
        QuizQuestion(
            question: "What helps firefighters see in dark smoke?",
            options: ["Flashlight", "Whistle", "Boots"],
            correctAnswerIndex: 0,
            explanation: "Flashlights help firefighters see through dark smoke during rescue operations."
        ),
        QuizQuestion(
            question: "What's the safest meeting place outside home?",
            options: ["Safe spot", "Garage", "Street corner"],
            correctAnswerIndex: 0,
            explanation: "A designated safe spot away from the building is the safest meeting place."
        )
    ]
    
    static func getQuestions(for level: QuizLevel) -> [QuizQuestion] {
        switch level {
        case .easy:
            return easyQuestions
        case .medium:
            return mediumQuestions
        case .hard:
            return hardQuestions
        }
    }
}

