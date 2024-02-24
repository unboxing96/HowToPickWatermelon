//
//  OverlayView.swift
//
//
//  Created by 김태현 on 2/24/24.
//

import SwiftUI

struct OverlayView: View {
    @Binding var answer: Answer
    var selectedIndex: Int?
    var index: Int
    var showAnswerResult: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10) // 테두리 모양 정의
            .fill(
                getForegroundColor()
                    .opacity(0.1)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        getStrokeColor(),
                        lineWidth: 3
                    )
            )
    }
    
    func getStrokeColor() -> Color {
        if showAnswerResult {
            return selectedIndex == index ? (answer == .correct ? Color.green : Color.red) : Color.clear
        } else {
            return selectedIndex == index ? Color.blue : Color.clear
        }
    }
    
    func getForegroundColor() -> Color {
        if showAnswerResult {
            return selectedIndex == index ? (answer == .correct ? Color.green : Color.red) : Color.clear
        } else {
            return Color.clear
        }
    }
}

#Preview {
    OverlayView(answer: .constant(.undefined), selectedIndex: 0, index: 0, showAnswerResult: false)
}
