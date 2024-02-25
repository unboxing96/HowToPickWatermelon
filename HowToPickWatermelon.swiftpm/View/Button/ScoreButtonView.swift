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
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.buttonLightOuter, lineWidth: 2)
                    .frame(width: 250, height: 65)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.buttonLightInner)
                    .frame(width: 250, height: 65)
                
                Text(pageToGo == .game ? "Retry" : "Home")
                    .foregroundColor(.black)
                    .font(.system(size: 22))
                    .fontWeight(.semibold)
            }
        }
    }
}

#Preview {
    ScoreButtonView(page: .constant(.home), pageToGo: .tutorialStripe)
}
