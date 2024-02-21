//
//  GameView.swift
//
//
//  Created by 김태현 on 2/21/24.
//

import SwiftUI

struct GameView: View {
    @Binding var page: Page
    
    var body: some View {
        VStack {
            Text("Game")
            
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                page = .score
            }
        }
    }
}

#Preview {
    GameView(page: .constant(.game))
}
