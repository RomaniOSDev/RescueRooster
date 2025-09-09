//
//  TimeDisplayView.swift
//  RescueRooster
//
//  Created by AI Assistant on 02.09.2025.
//

import SwiftUI

struct TimeDisplayView: View {
    let timeRemaining: Int
    
    var body: some View {
        VStack(spacing: 4) {
            Text("TIME")
                .font(.system(size: 12, weight: .bold, design: .monospaced))
                .foregroundColor(.white)
                .shadow(color: .black, radius: 1)
            
            Text(formatTime(timeRemaining))
                .font(.system(size: 24, weight: .bold, design: .monospaced))
                .foregroundColor(timeRemaining <= 10 ? .red : .white)
                .shadow(color: .black, radius: 2)
                .animation(.easeInOut(duration: 0.3), value: timeRemaining)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.black.opacity(0.6))
        )
    }
    
    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%d:%02d", minutes, remainingSeconds)
    }
}

#Preview {
    ZStack {
        Color.blue
        TimeDisplayView(timeRemaining: 45)
    }
}

