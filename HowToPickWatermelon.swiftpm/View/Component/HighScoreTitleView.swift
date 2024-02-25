//
//  HighScoreTitleView.swift
//
//
//  Created by 김태현 on 2/25/24.
//

import SwiftUI

struct HighScoreTitleView: View {
    @State private var highScore: Int = UserDefaults.standard.integer(forKey: "highScore")
    
    var body: some View {
        Text("High Score: \(highScore)")
            .foregroundStyle(.gray)
            .opacity(0.5)
            .fontWeight(.bold)
            .font(.system(size: 20))
    }
}

#Preview {
    HighScoreTitleView()
}
