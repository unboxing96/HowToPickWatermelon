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
        ZStack {
            createMarkView()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Rectangle()
                .foregroundStyle(answer == .correct ? .green : answer == .wrong ? .red : .gray)
                .opacity(0.5)
                .clipShape(.rect(cornerRadius: 5))
                .frame(height: 70)
                .overlay {
                    if answer != .undefined {
                        if let selectedIndex {
                            Text(watermelonViews[selectedIndex]
                                .watermelon
                                .feedbackText)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 45)
                        }
                    } else {
                        Text("?")
                    }
                }
        }
    }
    
    @ViewBuilder
    private func createMarkView() -> some View {
        switch answer {
        case .correct:
            Image("checkMark")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 70, height: 70)
                .offset(CGSize(width: -10, height: -15))
        case .wrong:
            Image("exclamationMark")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 70, height: 70)
                .offset(CGSize(width: -10, height: -15))
        default:
            EmptyView()
        }
    }
}

#Preview {
    FeedbackView(answer: .constant(.undefined), watermelonViews: [])
}
