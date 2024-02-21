//
//  ScoreView.swift
//
//
//  Created by 김태현 on 2/21/24.
//

import SwiftUI

struct ScoreView: View {
    @Binding var page: Page
    
    var body: some View {
        VStack {
            Text("ScoreView")
            
            Button {
                page = .game
            } label: {
                Text("Retry")
            }
            
            Button {
                page = .home
            } label: {
                Text("Go to Home")
            }
        }
    }
}

#Preview {
    ScoreView(page: .constant(.score))
}
