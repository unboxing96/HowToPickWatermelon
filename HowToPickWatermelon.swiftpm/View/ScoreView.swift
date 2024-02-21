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
        Text("ScoreView")
    }
}

#Preview {
    ScoreView(page: .constant(.score))
}
