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
        VStack {
            HighScoreTitleView()
                .border(.red)
            
            ScoreTitleView(score: $score)
                .padding(.vertical, 30)
            
            ScoreButtonView(page: $page, pageToGo: .game)
                .padding(.bottom)
                .padding(.top, 80)
            
            ScoreButtonView(page: $page, pageToGo: .home)
                .padding(.bottom)
        }
        .onDisappear {
            print("ScoreView onDisappear !!!")
            score = 0
        }
    }
}

#Preview {
    ScoreView(page: .constant(.score), score: .constant(0))
}
