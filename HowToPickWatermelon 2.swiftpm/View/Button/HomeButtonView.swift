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
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(pageToGo == .game && !isTutorialCompleted ? Color.grayMid : Color.buttonLightOuter, lineWidth: 2)
                    .shadow(radius: 20)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(pageToGo == .game && !isTutorialCompleted ? Color.grayLight : Color.buttonLightInner)
                    )
                
                Text(pageToGo == .tutorialStripe ? "Tutorial" : "Game")
                    .foregroundStyle(pageToGo == .game && !isTutorialCompleted ? Color.grayMid : .black)
                    .font(.system(size: 22))
                    .fontWeight(.semibold)
            }
            .frame(width: 250, height: 65)
        }
        .disabled(pageToGo == .game && !isTutorialCompleted)
    }
}

#Preview {
    HomeButtonView(page: .constant(.home), pageToGo: .tutorialStripe)
}
