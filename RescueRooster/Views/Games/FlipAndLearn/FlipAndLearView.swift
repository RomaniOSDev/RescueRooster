//
//  FlipAndLearView.swift
//  RescueRooster
//
//  Created by Роман Главацкий on 02.09.2025.
//

import SwiftUI

struct FlipAndLearView: View {
    var body: some View {
        ZStack {
            Image(.fireBack)
                .resizable()
                .ignoresSafeArea()
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    FlipAndLearView()
}
