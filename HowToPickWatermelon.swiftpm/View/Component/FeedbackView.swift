//
//  FeedbackView.swift
//
//
//  Created by 김태현 on 2/22/24.
//

import SwiftUI

struct FeedbackView: View {
    @Binding var answer: Answer
    var watermelonViews: [WatermelonSceneView]
    var selectedIndex: Int?
    
    var body: some View {
        Rectangle()
            .foregroundStyle(answer == .correct ? .green : answer == .wrong ? .red : .gray)
            .opacity(0.5)
            .clipShape(.rect(cornerRadius: 5))
            .frame(height: 60)
            .overlay {
                if answer != .undefined {
                    if let selectedIndex {
                        Text(watermelonViews[selectedIndex]
                            .watermelon
                            .getFeedbackText(answer: answer))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    }
                } else {
                    Text("?")
                }
            }
    }
}

#Preview {
    FeedbackView(answer: .constant(.undefined), watermelonViews: [])
}
