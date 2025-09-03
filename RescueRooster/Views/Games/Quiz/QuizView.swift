//
//  QuizView.swift
//  RescueRooster
//
//  Created by Роман Главацкий on 02.09.2025.
//

import SwiftUI

struct QuizView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image(.fireBack)
                    .resizable()
                    .ignoresSafeArea()
                VStack{
                    Image(.chooseLevel)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Image(.easyBut)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Image(.mediumBut)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Image(.hardBut)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }.padding()
                    .padding(.horizontal, 30)
            }
        }
    }
}

#Preview {
    QuizView()
}
