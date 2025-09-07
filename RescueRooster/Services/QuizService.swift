//
//  QuizService.swift
//  RescueRooster
//
//  Created by Роман Главацкий on 02.09.2025.
//

import Foundation
import Combine

// MARK: - Quiz Service
class QuizService: ObservableObject {
    @Published var currentQuestionIndex = 0
    @Published var selectedAnswerIndex: Int?
    @Published var score = 0
    @Published var isQuizCompleted = false
    @Published var showResult = false
    @Published var questions: [QuizQuestion] = []
    @Published var currentLevel: QuizLevel = .easy
    
    private var userAnswers: [Int] = []
    
    func startQuiz(level: QuizLevel) {
        currentLevel = level
        questions = QuizData.getQuestions(for: level)
        currentQuestionIndex = 0
        selectedAnswerIndex = nil
        score = 0
        isQuizCompleted = false
        showResult = false
        userAnswers = []
    }
    
    func selectAnswer(_ answerIndex: Int) {
        selectedAnswerIndex = answerIndex
    }
    
    func submitAnswer() {
        guard let selectedIndex = selectedAnswerIndex else { return }
        
        userAnswers.append(selectedIndex)
        
        if selectedIndex == questions[currentQuestionIndex].correctAnswerIndex {
            score += 1
        }
        
        // Add delay to show the correct answer before moving to next question
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if self.currentQuestionIndex < self.questions.count - 1 {
                self.currentQuestionIndex += 1
                self.selectedAnswerIndex = nil
            } else {
                self.isQuizCompleted = true
                self.showResult = true
            }
        }
    }
    
    func resetQuiz() {
        currentQuestionIndex = 0
        selectedAnswerIndex = nil
        score = 0
        isQuizCompleted = false
        showResult = false
        userAnswers = []
    }
    
    var currentQuestion: QuizQuestion? {
        guard currentQuestionIndex < questions.count else { return nil }
        return questions[currentQuestionIndex]
    }
    
    var progress: Double {
        guard !questions.isEmpty else { return 0 }
        return Double(currentQuestionIndex + 1) / Double(questions.count)
    }
    
    var percentage: Int {
        guard !questions.isEmpty else { return 0 }
        return Int((Double(score) / Double(questions.count)) * 100)
    }
    
    var isCorrectAnswer: Bool {
        guard let selectedIndex = selectedAnswerIndex,
              let currentQuestion = currentQuestion else { return false }
        return selectedIndex == currentQuestion.correctAnswerIndex
    }
    
    func getScoreMessage() -> String {
        let percentage = self.percentage
        
        switch percentage {
        case 90...100:
            return "Excellent! You're a fire safety expert! 🔥"
        case 80..<90:
            return "Great job! You know fire safety well! 👍"
        case 70..<80:
            return "Good work! Keep learning about fire safety! 📚"
        case 60..<70:
            return "Not bad! Review fire safety basics! 📖"
        default:
            return "Keep studying fire safety! You can do better! 💪"
        }
    }
    
    func getScoreColor() -> String {
        let percentage = self.percentage
        
        switch percentage {
        case 90...100:
            return "green"
        case 70..<90:
            return "orange"
        default:
            return "red"
        }
    }
}
