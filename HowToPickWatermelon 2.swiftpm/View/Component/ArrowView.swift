//
//  ArrowView.swift
//  
//
//  Created by 김태현 on 2/26/24.
//

import SwiftUI

struct ArrowView: View {
    var showSwipeIndicator: Bool
    
    var body: some View {
        VStack {
            Image(systemName: "arrowshape.turn.up.backward.fill")
                .foregroundStyle(Color.buttonDarkOuter)
                .font(.system(size: 30))
            Text("Swipe!")
                .foregroundStyle(Color.buttonDarkOuter)
                .font(.system(size: 14))
                .fontWeight(.heavy)
        }
        .transition(.opacity)
        .rotationEffect(Angle(degrees: -20))
        .animation(.snappy, value: showSwipeIndicator)
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.trailing)
        .padding(.bottom, 150)
    }
}

#Preview {
    ArrowView(showSwipeIndicator: true)
}
