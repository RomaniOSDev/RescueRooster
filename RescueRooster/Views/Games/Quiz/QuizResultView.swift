//
//  QuizResultView.swift
//  RescueRooster
//
//  Created by Роман Главацкий on 02.09.2025.
//

import SwiftUI

struct QuizResultView: View {
    @ObservedObject var quizService: QuizService
    let level: QuizLevel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Image(.fireBack)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Image(level.completedIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
                
                // Result header
                VStack(spacing: 15) {
                    // Percentage
                    Text("\(quizService.percentage)%")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 2)
                }
                
                // Score message
                Text(quizService.getScoreMessage())
                    .font(.headline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                // Detailed results
                VStack(spacing: 15) {
                    Text("Quiz Summary")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    VStack(spacing: 10) {
                        ResultRow(
                            title: "Correct Answers",
                            value: "\(quizService.score)",
                            color: .green
                        )
                        
                        ResultRow(
                            title: "Wrong Answers",
                            value: "\(quizService.questions.count - quizService.score)",
                            color: .red
                        )
                        
                        ResultRow(
                            title: "Total Questions",
                            value: "\(quizService.questions.count)",
                            color: .blue
                        )
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.black.opacity(0.3))
                            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3)
                    )
                    .padding(.horizontal)
                }
                
                Spacer()
                
                // Action buttons
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(.backBut)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    
                    Button(action: {
                        quizService.resetQuiz()
                        dismiss()
                    }) {
                        Image(.nextButton)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
                .padding(.bottom, 30)
            }
            .padding()
        }
    }
    
    private func getScoreColor() -> Color {
        switch quizService.getScoreColor() {
        case "green":
            return .green
        case "orange":
            return .orange
        default:
            return .red
        }
    }
    
    private func getLevelColor() -> Color {
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

struct ResultRow: View {
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        HStack {
            Text(title)
                .font(.body)
                .foregroundColor(.white)
            
            Spacer()
            
            Text(value)
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(color)
        }
    }
}

#Preview {

    
    QuizResultView(quizService: QuizService(), level: .easy)
}
