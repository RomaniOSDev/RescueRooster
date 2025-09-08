//
//  RewardsView.swift
//  RescueRooster
//
//  Created by AI Assistant on 02.09.2025.
//

import SwiftUI

struct RewardsView: View {
    @StateObject private var rewardsService = RewardsService()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
            ZStack {
                // Background
                Image(.fireBack)
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    // Header
                    VStack(spacing: 8) {
                        HStack {
                            Button {
                                dismiss()
                            } label: {
                                Image(.backBTN)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }

                            Spacer()
                            
                            Image(.rewardsLabelRed)
                                .resizable()
                                .frame(width: 115, height: 60)
                            
                            Spacer()
                            
                            Image(.backBTN)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .opacity(0)
                        }.padding(.horizontal)
                    }
                    .padding(.top, 20)
                    
                    // Progress stats
                    HStack(spacing: 30) {
                        VStack {
                            Text("\(rewardsService.unlockedCount)")
                                .font(.system(size: 24, weight: .bold, design: .monospaced))
                                .foregroundColor(.white)
                            Text("Unlocked")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.white.opacity(0.8))
                        }
                        
                        VStack {
                            Text("\(RewardType.allCases.count)")
                                .font(.system(size: 24, weight: .bold, design: .monospaced))
                                .foregroundColor(.white)
                            Text("Total")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.white.opacity(0.8))
                        }
                        
                        VStack {
                            Text("\(Int(rewardsService.completionPercentage))%")
                                .font(.system(size: 24, weight: .bold, design: .monospaced))
                                .foregroundColor(.white)
                            Text("Complete")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.white.opacity(0.8))
                        }
                    }
                    .padding(.vertical, 20)
                    .padding(.horizontal, 30)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.black.opacity(0.3))
                    )
                    
                    // Rewards grid
                    ScrollView {
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 15) {
                            ForEach(rewardsService.rewards) { reward in
                                RewardCard(reward: reward)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                    }
                }
            }
            .navigationBarBackButtonHidden()
          
        .onAppear {
            rewardsService.loadRewards()
        }
    }
}

// MARK: - Reward Card
struct RewardCard: View {
    let reward: RewardModel
    
    var body: some View {
        ZStack{
            VStack(spacing: 8) {
                // Icon
                
                
                Image(reward.type.icon)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .opacity(reward.isUnlocked ? 1.0 : 0.4)
                
                
                // Title
                Text(reward.type.title)
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .foregroundColor(reward.isUnlocked ? .white : .gray)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                
                // Rarity badge
                Text(reward.type.rarity.name)
                    .font(.system(size: 8, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(
                        Capsule()
                            .fill(reward.type.rarity.color)
                    )
            }
            // Lock overlay for locked rewards
            if !reward.isUnlocked {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.black.opacity(0.6))
                    
                    Image(systemName: "lock.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                }
            }
        }
        .frame(width: 100, height: 120)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(reward.isUnlocked ?
                      Color.white.opacity(0.1) :
                      Color.gray.opacity(0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(reward.isUnlocked ?
                               reward.type.rarity.color :
                               Color.gray, lineWidth: 1)
                )
        )
        .scaleEffect(reward.isUnlocked ? 1.0 : 0.95)
        .animation(.easeInOut(duration: 0.2), value: reward.isUnlocked)
    }
}

#Preview {
    RewardsView()
}
