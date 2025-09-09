//
//  SettingView.swift
//  RescueRooster
//
//  Created by Роман Главацкий on 02.09.2025.
//

import SwiftUI
import StoreKit

struct SettingView: View {
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

            }.padding(100)
        }
    }
}

#Preview {
    SettingView()
}
