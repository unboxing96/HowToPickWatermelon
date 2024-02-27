//
//  TutorialButtonView.swift
//
//
//  Created by 김태현 on 2/22/24.
//

import SwiftUI

struct TutorialButtonView: View {
    let text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.buttonLightOuter, lineWidth: 2)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.buttonLightInner)
                )
                .frame(width: 350, height: 70)
            
            Text(text)
                .foregroundColor(.black)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    TutorialButtonView(text: "Confirm The Answer")
}
