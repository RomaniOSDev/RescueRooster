//
//  QuizGameView.swift
//  RescueRooster
//
//  Created by Роман Главацкий on 02.09.2025.
//

import SwiftUI

struct QuizGameView: View {
    let level: QuizLevel
    @StateObject private var quizService = QuizService()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Image(.fireBack)
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header
                Image(.quizQuestionLabel)
                    .resizable()
                    .frame(width: 150, height: 130)
                
                // Question content
                if let question = quizService.currentQuestion {
                    VStack(spacing: 20) {
                        // Question
                        Text(question.question)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.black.opacity(0.3))
                                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3)
                            )
                            .padding(.horizontal)
                        
                        // Answer options
                        VStack(spacing: 12) {
                            ForEach(Array(question.options.enumerated()), id: \.offset) { index, option in
                                Button(action: {
                                    if quizService.selectedAnswerIndex == nil {
                                        quizService.selectAnswer(index)
                                    }
                                }) {
                                    HStack {
                                        Spacer()
                                        Text(option)
                                            .font(.system(size: 30, weight: .bold, design: .monospaced))
                                            .foregroundColor(.black)
                                            .multilineTextAlignment(.center)
                                            .minimumScaleFactor(0.5)
                                        
                                        Spacer()
                                        
                                    }
                                    .padding(30)
                                    .background {
                                        Image(getAnswerBackgroundImage(for: index, question: question))
                                            .resizable()
                                                                                            }
                                }
                                .disabled(quizService.selectedAnswerIndex != nil)
                            }
                        }
                    }
                }
                
                Spacer()
                
                // Submit button
              
                    Button(action: {
                        quizService.submitAnswer()
                    }) {
                        Image(.nextButton)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 80)
                            .opacity(quizService.selectedAnswerIndex != nil ? 1 : 0.5)
                    }
                    .disabled(quizService.selectedAnswerIndex == nil)
                
            }
            .padding(.bottom, 30)
            .padding()
        }
        .onAppear {
            quizService.startQuiz(level: level)
        }
        .fullScreenCover(isPresented: $quizService.showResult) {
            QuizResultView(quizService: quizService, level: level)
        }
    }
    
    //MARK: - Private func
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
    
    private func getAnswerBackgroundColor(for index: Int, question: QuizQuestion) -> Color {
        guard let selectedIndex = quizService.selectedAnswerIndex else {
            return Color.white.opacity(0.2)
        }
        
        if selectedIndex == index {
            // Selected answer
            if index == question.correctAnswerIndex {
                return Color.green.opacity(0.8) // Correct answer - green
            } else {
                return Color.red.opacity(0.8) // Wrong answer - red
            }
        } else if index == question.correctAnswerIndex {
            // Show correct answer even if not selected
            return Color.green.opacity(0.6)
        } else {
            return Color.white.opacity(0.2)
        }
    }
    
    private func getAnswerBackgroundImage(for index: Int, question: QuizQuestion) -> ImageResource {
        guard let selectedIndex = quizService.selectedAnswerIndex else {
            return .entyAnswer
        }
        
        if selectedIndex == index {
            // Selected answer
            if index == question.correctAnswerIndex {
                return .goodAnswer // Correct answer - green
            } else {
                return .badAnswer // Wrong answer - red
            }
        } else if index == question.correctAnswerIndex {
            // Show correct answer even if not selected
            return .goodAnswer
        } else {
            return .entyAnswer
        }
    }
    
    private func getAnswerBorderColor(for index: Int, question: QuizQuestion) -> Color {
        guard let selectedIndex = quizService.selectedAnswerIndex else {
            return Color.clear
        }
        
        if selectedIndex == index {
            if index == question.correctAnswerIndex {
                return Color.green
            } else {
                return Color.red
            }
        } else if index == question.correctAnswerIndex {
            return Color.green
        } else {
            return Color.clear
        }
    }
    
    private func getAnswerIcon(for index: Int, question: QuizQuestion) -> String {
        guard let selectedIndex = quizService.selectedAnswerIndex else {
            return "circle"
        }
        
        if selectedIndex == index {
            if index == question.correctAnswerIndex {
                return "checkmark.circle.fill"
            } else {
                return "xmark.circle.fill"
            }
        } else if index == question.correctAnswerIndex {
            return "checkmark.circle.fill"
        } else {
            return "circle"
        }
    }
}

#Preview {
    QuizGameView(level: .easy)
}
