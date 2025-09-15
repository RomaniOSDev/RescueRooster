//
//  SettingView.swift
//  RescueRooster
//
//  Created by Роман Главацкий on 02.09.2025.
//

import SwiftUI
import StoreKit

struct SettingView: View {
    @State private var showResetAlert = false
    @StateObject private var rewardsService = RewardsService()
    
    var body: some View {
        ZStack {
            Image(.fireBack)
                .resizable()
                .ignoresSafeArea()
            VStack {
                
                Button {
                    if let url = URL(string: "https://www.termsfeed.com/live/7955fb12-36e2-4c06-97b4-d1a27051cd66") {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    Image(.privacyBut)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
                Button {
                    SKStoreReviewController.requestReview()
                } label: {
                    Image(.rateBut)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
                Button {
                    showResetAlert = true
                } label: {
                    Text("Reset Progress")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accent)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }
                .padding(20)

            }.padding(100)
        }
        .alert("Reset Progress", isPresented: $showResetAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Reset", role: .destructive) {
                resetAllData()
            }
        } message: {
            Text("Are you sure you want to reset all progress? This action cannot be undone.")
        }
    }
    
    private func resetAllData() {
        // Reset rewards
        rewardsService.resetAllRewards()
        
        // Reset quiz data (if any saved data exists)
        UserDefaults.standard.removeObject(forKey: "quiz_best_scores")
        UserDefaults.standard.removeObject(forKey: "quiz_completed_levels")
        
        // Reset RescoreBooster game statistics
        UserDefaults.standard.removeObject(forKey: "game_best_score")
        UserDefaults.standard.removeObject(forKey: "game_total_eggs_caught")
        UserDefaults.standard.removeObject(forKey: "game_total_play_time")
        UserDefaults.standard.removeObject(forKey: "game_games_played")
        
        // Reset other game data
        UserDefaults.standard.removeObject(forKey: "flip_game_progress")
        UserDefaults.standard.removeObject(forKey: "flip_game_completed_cards")
        
        print("✅ All data reset successfully")
    }
}

#Preview {
    SettingView()
}
