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
        Text("Game")
    }
}

#Preview {
    GameView(page: .constant(.game))
}
