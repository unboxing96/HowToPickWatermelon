//
//  ScoreButtonView.swift
//
//
//  Created by 김태현 on 2/25/24.
//

import SwiftUI

struct ScoreButtonView: View {
    @Binding var page: Page
    let pageToGo: Page
    
    var body: some View {
        Button {
            withAnimation {
                page = pageToGo
            }
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.gray)
                .opacity(0.5)
                .frame(width: 250, height: 65)
                .overlay {
                    Text(pageToGo == .game ? "Retry" : "Home")
                        .foregroundStyle(.black)
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                }
        }
    }
}

#Preview {
    ScoreButtonView(page: .constant(.home), pageToGo: .tutorialStripe)
}
