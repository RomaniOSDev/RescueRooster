//
//  Rescorebooster.swift
//  RescueRooster
//
//  Created by Роман Главацкий on 02.09.2025.
//

import SwiftUI

struct RescoreboosterView: View {
    @StateObject var viewModel = RescoreViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            // Background
            Image(.fireBack)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                
                
                // Top UI
                
                HStack(alignment: .top) {
                    // Lives (eggs) - Left
                    VStack{
                        // Timer - Top
                        TimeDisplayView(timeRemaining: viewModel.timeRemaining)
                            .padding(.top, 10)
                        HStack(spacing: 5) {
                            ForEach(0..<3, id: \.self) { index in
                                Image(.egg)
                                    .resizable()
                                    .frame(width: 33, height: 40)
                                    .opacity(index < viewModel.eggs ? 1.0 : 0.3)
                            }
                        }
                        .padding(.leading, 20)
                        
                    }
                    
                    Spacer()
                    
                    // Score - Center
                    ScoreRescoreView(score: viewModel.score)
                        .frame(width: 150, height: 150)
                    
                    Spacer()
                    
                    // Control buttons - Right
                    VStack {
                        Button(action: {
                            if viewModel.gameState == .playing {
                                viewModel.pauseGame()
                            } else if viewModel.gameState == .paused {
                                viewModel.resumeGame()
                            }
                        }) {
                            Image(.pauseBut)
                                .resizable()
                                .frame(width: 75, height: 40)
                        }
                        
                        Button(action: {
                            viewModel.restartGame()
                        }) {
                            Image(.restartBut)
                                .resizable()
                                .frame(width: 75, height: 40)
                        }
                    }
                    .padding(.trailing, 20)
                }
                .padding(.top, 20)
                
                Spacer()
                
                // Game area
                GeometryReader { geometry in
                    ZStack {
                        // Falling objects
                        ForEach(viewModel.fallingObjects) { object in
                            if object.isVisible && 
                               object.yPosition >= -50 && 
                               object.yPosition <= geometry.size.height + 50 &&
                               object.xPosition >= 0 && 
                               object.xPosition <= geometry.size.width {
                                Image(object.icon)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .position(x: object.xPosition, y: object.yPosition)
                                    .onTapGesture {
                                        viewModel.tapObject(at: CGPoint(x: object.xPosition, y: object.yPosition))
                                    }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onTapGesture { location in
                        viewModel.tapObject(at: location)
                    }
                    .onAppear {
                        // Update screen dimensions for proper positioning
                        viewModel.updateScreenDimensions(
                            width: geometry.size.width,
                            height: geometry.size.height
                        )
                    }
                }
                
                Spacer()
            }
            
            // Game Over Overlay
            if viewModel.gameState == .gameOver {
                GameOverView(
                    score: viewModel.score,
                    onRestart: {
                        viewModel.restartGame()
                    },
                    onBack: {
                        dismiss()
                    }
                )
            }
            
            // Pause Overlay
            if viewModel.gameState == .paused {
                PauseOverlay(
                    onResume: {
                        viewModel.resumeGame()
                    },
                    onRestart: {
                        viewModel.restartGame()
                    },
                    onBack: {
                        dismiss()
                    }
                )
            }
        }
        .onAppear {
            viewModel.startGame()
        }
        .onDisappear {
            viewModel.pauseGame()
        }
    }
}

// MARK: - Game Over View
struct GameOverView: View {
    let score: Int
    let onRestart: () -> Void
    let onBack: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("Game Over")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("Score: \(score)")
                    .font(.title)
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    Button(action: onRestart) {
                        Text("Play Again")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    
                    Button(action: onBack) {
                        Text("Back to Menu")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 50)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.black.opacity(0.8))
            )
            .padding(.horizontal, 40)
        }
    }
}

// MARK: - Pause Overlay
struct PauseOverlay: View {
    let onResume: () -> Void
    let onRestart: () -> Void
    let onBack: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("Paused")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    Button(action: onResume) {
                        Text("Resume")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    
                    Button(action: onRestart) {
                        Text("Restart")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .cornerRadius(10)
                    }
                    
                    Button(action: onBack) {
                        Text("Back to Menu")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 50)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.black.opacity(0.8))
            )
            .padding(.horizontal, 40)
        }
    }
}

#Preview {
    RescoreboosterView()
}
