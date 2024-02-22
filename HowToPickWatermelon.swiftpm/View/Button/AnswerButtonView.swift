//
//  AnswerButtonView.swift
//  
//
//  Created by 김태현 on 2/22/24.
//

import SwiftUI

struct AnswerButtonView: View {
    @Binding var answer: Correct
    
    var body: some View {
        Rectangle()
            .foregroundStyle(.gray)
            .opacity(0.5)
            .clipShape(.rect(cornerRadius: 10))
            .frame(width: 360, height: 70)
            .overlay {
                answer == .correct ? Text("Move To Next") : Text("Confirm The Answer")
            }
    }
}

#Preview {
    AnswerButtonView(answer: .constant(.undefined))
}
