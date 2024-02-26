//
//  FeedbackView.swift
//
//
//  Created by 김태현 on 2/22/24.
//

import SwiftUI

struct FeedbackView: View {
    @Binding var answer: Answer
    var page: Page
    var feedbackString: String
    var watermelonViews: [WatermelonSceneView]
    var selectedIndex: Int?
    
    var body: some View {
        ZStack {
            createMarkView()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Rectangle()
                .foregroundStyle(answer == .correct ? Color.buttonMidInner : answer == .wrong ? .red : .gray)
                .opacity(0.5)
                .clipShape(.rect(cornerRadius: 5))
                .frame(height: 80)
                .overlay {
                    if answer != .undefined {
                        if let index = selectedIndex, watermelonViews.indices.contains(index) {
                            // 안전하게 인덱스 접근
                            Text(feedbackString)
                                .foregroundStyle(.black)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 40)
                                .padding(.trailing, 10)
                        }
                    } else {
                        if page == .game, let index = selectedIndex, watermelonViews.indices.contains(index) {
                            Text(watermelonViews[index].watermelon.taste.description())
                                .foregroundStyle(Color.grayDark)
                                .font(.system(size: 20))
                                .fontWeight(.heavy)
                        } else {
                            // 기본값 또는 page가 .game이 아닌 경우
                            Text("?")
                                .foregroundStyle(Color.grayDark)
                                .font(.system(size: 20))
                                .fontWeight(.heavy)
                        }
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
                .offset(CGSize(width: -15, height: -25))
        case .wrong:
            Image("exclamationMark")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 70, height: 70)
                .offset(CGSize(width: -15, height: -25))
        default:
            EmptyView()
        }
    }
}

#Preview {
    FeedbackView(answer: .constant(.undefined), page: .tutorialStripe, feedbackString: "feedback", watermelonViews: [])
}
