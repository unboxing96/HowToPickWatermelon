//
//  ScoreTitleView.swift
//
//
//  Created by 김태현 on 2/25/24.
//

import SwiftUI

struct ScoreTitleView: View {
    @Binding var score: Int
    
    var body: some View {
        Text("You Have Picked:")
            .foregroundStyle(.black)
            .fontWeight(.bold)
            .font(.system(size: 30))
        
        Text("+\(score)")
            .foregroundStyle(.black)
            .fontWeight(.bold)
            .font(.system(size: 100))
        
        Text("The Sweetest\nWatermelons")
            .foregroundStyle(.black)
            .fontWeight(.bold)
            .font(.system(size: 30))
    }
}

#Preview {
    ScoreTitleView(score: .constant(0))
}
