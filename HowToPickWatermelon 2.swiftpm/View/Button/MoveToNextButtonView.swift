//
//  MoveToNextButtonView.swift
//  
//
//  Created by 김태현 on 2/24/24.
//

import SwiftUI

struct MoveToNextButtonView: View {
    let text: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.buttonDarkInner)
            .frame(width: 340, height: 70)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.buttonDarkOuter, lineWidth: 2)
            )
            .overlay {
                Text(text)
                    .font(.system(size: 22))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
    }
}

#Preview {
    MoveToNextButtonView(text: "Move To Next")
}
