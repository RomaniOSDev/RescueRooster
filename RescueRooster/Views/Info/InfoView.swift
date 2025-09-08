//
//  InfoView.swift
//  RescueRooster
//
//  Created by Роман Главацкий on 02.09.2025.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        ZStack {
            Image(.fireBack)
                .resizable()
                .ignoresSafeArea()
            VStack{

                Image(.infoLabel)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .padding()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    InfoView()
}
