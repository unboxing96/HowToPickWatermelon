//
//  ScoreView.swift
//
//
//  Created by 김태현 on 2/21/24.
//

import SwiftUI

struct ScoreView: View {
    @Binding var page: Page
    @Binding var score: Int
    
    var body: some View {
        VStack(spacing: 0) {
            HighScoreTitleView()
                .padding(.bottom)
            
            ScoreTitleView(score: $score)
                .padding(.vertical, 30)
            
            ScoreButtonView(page: $page, pageToGo: .game)
                .padding(.bottom)
                .padding(.top, 102)
            
            ScoreButtonView(page: $page, pageToGo: .home)
        }
        .onDisappear {
            score = 0
        }
    }
}

#Preview {
    ScoreView(page: .constant(.score), score: .constant(0))
}
