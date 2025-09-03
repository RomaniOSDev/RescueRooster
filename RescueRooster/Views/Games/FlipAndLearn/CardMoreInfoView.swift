//
//  CardMoreInfoView.swift
//  RescueRooster
//
//  Created by Роман Главацкий on 03.09.2025.
//

import SwiftUI

struct CardMoreInfoView: View {
    let card: FlipLearn
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            Image(.fireBack)
                .resizable()
                .ignoresSafeArea()
            VStack {
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(.closeBut)
                            .resizable()
                            .frame(width: 50, height: 50)
                    }

                }
                VStack{
                    Image(card.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 145)
                    Text(card.description)
                        .padding()
                        .font(.system(size: 32, weight: .bold, design: .monospaced))
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.5)
                        
                }
                .padding(30)
                .background {
                    Image(.backCard)
                        .resizable()
                        
                }
                
                Spacer()
            }.padding()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    CardMoreInfoView(card: FlipLearn.Axe)
}
