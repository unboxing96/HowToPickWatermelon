//
//  TutorialView.swift
//
//
//  Created by 김태현 on 2/21/24.
//

import SwiftUI
import SceneKit

struct TutorialView: View {
    @Binding var page: Page
    @State private var currentIndex: Int = 0
    @State private var watermelonViews: [WatermelonSceneView] = []
    @State private var selectedWatermelonIndex: Int?
    @State private var viewUpdateKey = UUID() // 뷰 갱신을 위한 key
    @State private var answer: Answer = .undefined
    @State private var feedbackButtonViewWidth: CGFloat = 0.0
    private let gridItems = [
        GridItem(.flexible(minimum: 0), spacing: 0),
        GridItem(.flexible(minimum: 0), spacing: 0)]

    
    var body: some View {
        let content = page.tutorialContent
        
        VStack(spacing: 0) {
            Text("\(content.title)")
            
            //            ZStack {
            //                ForEach(0..<watermelonViews.count, id: \.self) { index in
            //                    watermelonViews[index]
            //                        .offset(x: self.offsetForIndex(index), y: 0)
            //                        .animation(.easeInOut(duration: 1), value: currentIndex)
            //                }
            //            }
            
            ZStack {
                WatermelonBackgroundView()
                
                
                VStack(alignment: .leading, spacing: 0) {
                    FeedbackButtonView(answer: $answer)
                        .frame(width: feedbackButtonViewWidth)
                        .padding(.bottom, 20)
                        .padding(.horizontal, 360 * 0.03)
                        .border(.orange)
                    
                    LazyVGrid(columns: gridItems, spacing: 10) {
                        ForEach(0..<watermelonViews.count, id: \.self) { index in
                            watermelonViews[index]
                                .frame(width: 160, height: 160)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10) // 테두리 모양 정의
                                        .stroke(selectedWatermelonIndex == index ? Color.blue : Color.clear, lineWidth: 3) // 선택된 아이템에만 테두리 적용
                                )
                                .onTapGesture {
                                    selectedWatermelonIndex = index // 사용자가 탭할 때 선택된 인덱스 업데이트
                                }
                        }
                    }
                    .padding(.horizontal, 360 * 0.01)
                    .border(.orange)
                }
                .frame(width: 360)
            }

            Button {
                if answer == .correct {
                    page = page.navigateToNextPage(with: page)
                } else {
                    answer =
                    watermelonViews[selectedWatermelonIndex ?? 0]
                        .watermelon.isDelicious() == true ? .correct : .wrong
                    feedbackButtonViewWidth = 0.0
                    withAnimation(.snappy(duration: 0.4, extraBounce: 0.1)) {
                        feedbackButtonViewWidth = .infinity
                    }
                }
            } label: {
                AnswerButtonView(answer: $answer)
            }
        }
        .onAppear {
            print("onAppear")
            setupWatermelonViews(for: page)
            print(watermelonViews.count)
        }
        .onChange(of: page) { newValue in
            withAnimation {
                viewUpdateKey = UUID()
                currentIndex = 0
                answer = .undefined
                selectedWatermelonIndex = nil
                feedbackButtonViewWidth = 0.0
                setupWatermelonViews(for: newValue)
            }
        }
        .id(viewUpdateKey) // 이 key를 사용하여 뷰 갱신 강제
    }
    
    private func setupWatermelonViews(for page: Page) {
        
        print("setupWatermelonViews !!!!: \(page)")
        
        switch page {
        case .tutorialStripe:
            watermelonViews = [
                WatermelonSceneView(watermelon: Watermelon(
                    imgName: "wv1",
                    taste: .stripeWide)),
                WatermelonSceneView(watermelon: Watermelon(
                    imgName: "wv1",
                    taste: .stripeNarrow)),
                WatermelonSceneView(watermelon: Watermelon(
                    imgName: "wv1",
                    taste: .stripeWide)),
                WatermelonSceneView(watermelon: Watermelon(
                    imgName: "wv1",
                    taste: .stripeWide))
            ]
        case .tutorialSound:
            watermelonViews = [
                WatermelonSceneView(watermelon: Watermelon(
                    imgName: "watermelonTmp0",
                    taste: .soundHeavy)),
                WatermelonSceneView(watermelon: Watermelon(
                    imgName: "watermelonTmp2",
                    taste: .soundHeavy)),
                WatermelonSceneView(watermelon: Watermelon(
                    imgName: "watermelonTmp2",
                    taste: .soundClear))
            ]
        case .tutorialStem:
            watermelonViews = [
                WatermelonSceneView(watermelon: Watermelon(
                    imgName: "watermelonTmp2",
                    taste: .stemLarge)),
                WatermelonSceneView(watermelon: Watermelon(
                    imgName: "watermelonTmp2",
                    taste: .stemSmall)),
                WatermelonSceneView(watermelon: Watermelon(
                    imgName: "watermelonTmp2",
                    taste: .stemLarge))
            ]
        case .tutorialSpot:
            watermelonViews = [
                WatermelonSceneView(watermelon: Watermelon(
                    imgName: "watermelonTmp0",
                    taste: .spotOrange)),
                WatermelonSceneView(watermelon: Watermelon(
                    imgName: "watermelonTmp2",
                    taste: .spotWhite)),
                WatermelonSceneView(watermelon: Watermelon(
                    imgName: "watermelonTmp2",
                    taste: .spotWhite))
            ]
        default:
            break
        }
    }
    
    private func offsetForIndex(_ index: Int) -> CGFloat {
        let viewWidth = UIScreen.main.bounds.width
        let currentIndexOffset = CGFloat(currentIndex) * viewWidth
        let indexOffset = CGFloat(index) * viewWidth
        return indexOffset - currentIndexOffset
    }

}

#Preview {
    TutorialView(page: .constant(.tutorialStripe))
}
