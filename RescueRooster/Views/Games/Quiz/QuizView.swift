//
//  QuizView.swift
//  RescueRooster
//
//  Created by Роман Главацкий on 02.09.2025.
//

import SwiftUI

struct QuizView: View {
    @StateObject private var quizService = QuizService()
    @State private var selectedLevel: QuizLevel?
    
    var body: some View {
            ZStack {
                Image(.fireBack)
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Image(.chooseLevel)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    // Level buttons
                    VStack(spacing: 15) {
                        ForEach(QuizLevel.allCases, id: \.self) { level in
                            NavigationLink(destination: QuizGameView(level: level)) {
                                Image(level.icon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                        }
                    }
                    
                    
                   
                }
                .padding()
                .padding(.horizontal, 30)
                .padding(.bottom, 30)
            }
    }
    
    private func getLevelColor(_ level: QuizLevel) -> Color {
        switch level {
        case .easy:
            return .green
        case .medium:
            return .orange
        case .hard:
            return .red
        }
    }
}

#Preview {
    QuizView()
}
