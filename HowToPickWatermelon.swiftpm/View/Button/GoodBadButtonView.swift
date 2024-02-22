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
        Rectangle()
            .foregroundStyle(.gray)
            .opacity(0.5)
            .clipShape(.rect(cornerRadius: 10))
            .frame(width: 155, height: 70)
            .overlay {
                Text(text)
            }
    }
}

#Preview {
    GoodBadButtonView(text: "Good")
}
