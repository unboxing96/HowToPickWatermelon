//
//  GoodBadButtonView.swift
//
//
//  Created by 김태현 on 2/22/24.
//

import SwiftUI

struct GoodBadButtonView: View {
    let text: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color.buttonLightOuter, lineWidth: 2)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color.buttonLightInner)
            )
            .frame(width: 155, height: 70)
            .overlay {
                Text(text)
                    .font(.system(size: 22))
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
            }
    }
}

#Preview {
    GoodBadButtonView(text: "Good")
}
