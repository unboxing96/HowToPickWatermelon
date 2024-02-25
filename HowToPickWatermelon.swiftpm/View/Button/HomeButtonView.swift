//
//  HomeButtonView.swift
//
//
//  Created by 김태현 on 2/25/24.
//

import SwiftUI

struct HomeButtonView: View {
    @Binding var page: Page
    let pageToGo: Page
    
    private var isTutorialCompleted: Bool {
        UserDefaults.standard.bool(forKey: "tutorialCompleted")
    }
    
    var body: some View {
        Button {
            withAnimation {
                page = pageToGo
            }
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(pageToGo == .game && !isTutorialCompleted ? .gray : .green)
                .opacity(0.5)
                .frame(width: 250, height: 65)
                .overlay {
                    Text(pageToGo == .tutorialStripe ? "Tutorial" : "Game")
                        .foregroundStyle(pageToGo == .game && !isTutorialCompleted ? .gray : .black)
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                }
        }
//        .disabled(pageToGo == .game && !isTutorialCompleted)
    }
}

#Preview {
    HomeButtonView(page: .constant(.home), pageToGo: .tutorialStripe)
}
