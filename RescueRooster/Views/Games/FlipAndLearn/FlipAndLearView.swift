//
//  FlipAndLearView.swift
//  RescueRooster
//
//  Created by Роман Главацкий on 02.09.2025.
//

import SwiftUI

struct FlipAndLearView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image(.fireBack)
                    .resizable()
                    .ignoresSafeArea()
                ScrollView {
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(FlipLearn.allCases, id: \.self) { card in
                            NavigationLink {
                                CardMoreInfoView(card: card)
                            } label: {
                                Image(card.icon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                        }
                    }.padding()
                        .padding(.horizontal, 30)
                }
            }
        }
    }
}

#Preview {
    FlipAndLearView()
}
