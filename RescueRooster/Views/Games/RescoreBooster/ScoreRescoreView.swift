//
//  ScoreRescoreView.swift
//  RescueRooster
//
//  Created by Роман Главацкий on 08.09.2025.
//

import SwiftUI

struct ScoreRescoreView: View {
    var score: Int
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(.scoreLabel)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text("\(score)")
                    .font(.system(size: geo.size.width * 0.2, weight: .heavy, design: .monospaced))
                    .offset(y: geo.size.height * 0.05)
            }
        }
    }
}

#Preview {
    ScoreRescoreView(score: 450)
        .frame(width: 250, height: 250)
}
