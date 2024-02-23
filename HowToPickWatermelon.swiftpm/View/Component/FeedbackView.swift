//
//  FeedbackView.swift
//
//
//  Created by 김태현 on 2/22/24.
//

import SwiftUI

struct FeedbackView: View {
    @Binding var answer: Answer
    
    var body: some View {
        Rectangle()
            .foregroundStyle(answer == .correct ? .green : answer == .wrong ? .red : .gray)
            .opacity(0.5)
            .clipShape(.rect(cornerRadius: 5))
            .frame(height: 70)
    }
}

#Preview {
    FeedbackView(answer: .constant(.undefined))
}
