//
//  GamesView.swift
//  RescueRooster
//
//  Created by Роман Главацкий on 02.09.2025.
//

import SwiftUI

struct GamesView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image(.fireBack)
                    .resizable()
                    .ignoresSafeArea()
                VStack(spacing: 30) {
                    NavigationLink {
                        RewardsView()
                    } label: {
                        Image(.rewardsLabel)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 100)
                    }
                    NavigationLink {
                        FlipAndLearView()
                    } label: {
                        Image(.flipLabel)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    NavigationLink {
                        QuizView()
                    } label: {
                        Image(.quizLabel)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    NavigationLink {
                        RescoreboosterView()
                    } label: {
                        Image(.rescoreLabel)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }

                }
                .frame(maxWidth: 260)
                .padding()
            }
        }
    }
}

#Preview {
    GamesView()
}
