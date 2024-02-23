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
            Text("Score: \(score)")
            
            Button {
                score = 0
                page = .game
            } label: {
                Text("Retry")
            }
            
            Button {
                score = 0
                page = .home
            } label: {
                Text("Go to Home")
            }
        }
    }
}

#Preview {
    ScoreView(page: .constant(.score), score: .constant(0))
}
