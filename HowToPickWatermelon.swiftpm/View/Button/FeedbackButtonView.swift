//
//  FeedbackButtonView.swift
//
//
//  Created by 김태현 on 2/22/24.
//

import SwiftUI

struct FeedbackButtonView: View {
    @Binding var answer: Correct
    
    var body: some View {
        Rectangle()
            .foregroundStyle(answer == .correct ? .green : answer == .wrong ? .red : .clear)
            .opacity(0.5)
            .clipShape(.rect(cornerRadius: 10))
            .frame(width: 340, height: 70)
    }
}

#Preview {
    FeedbackButtonView(answer: .constant(.undefined))
}
