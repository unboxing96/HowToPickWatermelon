//
//  TimerView.swift
//
//
//  Created by 김태현 on 2/22/24.
//

import SwiftUI

struct TimerView: View {
    @Binding var remainingTime: CGFloat // 남은 시간
    let totalTime: CGFloat // 전체 시간, 초기화에 사용됩니다.
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundStyle(.gray)
                    .opacity(0.5)
                    .clipShape(.rect(cornerRadius: 5))
                    .frame(width: geometry.size.width)
                
                Rectangle()
                    .foregroundStyle(.blue)
                    .opacity(0.5)
                    .clipShape(.rect(cornerRadius: 5))
                    .frame(width: geometry.size.width * (remainingTime / totalTime))
            }
        }
        .frame(height: 30)
        .padding(.horizontal)
    }
}

#Preview {
    TimerView(remainingTime: .constant(20), totalTime: 20)
}
