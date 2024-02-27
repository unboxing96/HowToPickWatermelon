//
//  TimerView.swift
//
//
//  Created by 김태현 on 2/22/24.
//

import SwiftUI

struct TimerView: View {
    @Binding var remainingTime: CGFloat
    let totalTime: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundStyle(.gray)
                    .opacity(0.5)
                    .clipShape(.rect(cornerRadius: 5))
                    .frame(width: geometry.size.width)
                
                Rectangle()
                    .foregroundStyle(Color.buttonDarkInner)
                    .clipShape(.rect(cornerRadius: 5))
                    .frame(width: geometry.size.width * (remainingTime / totalTime))
                
                Text("Timer")
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.leading, 10)
            }
        }
        .frame(height: 30)
        .padding(.horizontal)
    }
}

#Preview {
    TimerView(remainingTime: .constant(20), totalTime: 20)
}
