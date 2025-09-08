//
//  FireEntryModel.swift
//  RescueRooster
//
//  Created by Роман Главацкий on 02.09.2025.
//

import SwiftUI
import Foundation

// MARK: - Fire Entry Model
struct FireEntryModel: Identifiable {
    let id = UUID()
    let icon: ImageResource
    let isGood: Bool
    let isEgg: Bool
    
    // Position for falling animation
    var xPosition: CGFloat = 0
    var yPosition: CGFloat = -100
    var isVisible: Bool = true
    
    // Animation properties
    var fallSpeed: CGFloat = 3.0
    var rotation: Double = 0
    
    mutating func updatePosition() {
        // Only move down, never up - no rotation
        yPosition += fallSpeed
    }
    
    mutating func resetPosition(screenWidth: CGFloat) {
        xPosition = CGFloat.random(in: 25...(screenWidth - 25)) // Random X position within screen bounds
        yPosition = -50 // Start from top of screen (above visible area)
        isVisible = true
        rotation = 0
        fallSpeed = 3.0 // Ensure consistent downward movement
    }
}