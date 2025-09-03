//
//  ContentView.swift
//  RescueRooster
//
//  Created by Роман Главацкий on 02.09.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack(alignment: .bottom){
            Group {
                switch selectedTab {
                case 0: NewsForFireView()
                case 1: GamesView()
                case 2: InfoView()
                case 3: SettingView()
                default: NewsForFireView()
                }
            }
            Spacer()
            // Кастомный TabBar
            HStack {
                TabBarButton(
                    imageName: .newsItem,
                    isSelected: selectedTab == 0
                ) {
                    selectedTab = 0
                }
                Spacer()
                TabBarButton(
                    imageName: .gameItem,
                    isSelected: selectedTab == 1
                ) {
                    selectedTab = 1
                }
                Spacer()
                TabBarButton(
                    imageName: .infoItem,
                    isSelected: selectedTab == 2
                ) {
                    selectedTab = 2
                }
                Spacer()
                TabBarButton(
                    imageName: .settingsItem,
                    isSelected: selectedTab == 3
                ) {
                    selectedTab = 3
                }
            }
            .padding(.horizontal)
            .padding()
            .background(Color.white.opacity(0.6))
            .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: -2)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

struct TabBarButton: View {
    let imageName: ImageResource
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 50)
        }
    }
}

#Preview {
    ContentView()
}
