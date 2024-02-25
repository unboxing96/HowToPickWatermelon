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
    @State private var feedbackViewWidth: CGFloat = .infinity
    @State private var showAnswerResult = false
    
    private let gridItems = [
        GridItem(.flexible(minimum: 0), spacing: 0),
        GridItem(.flexible(minimum: 0), spacing: 0)]
    
    
    var body: some View {
        VStack(spacing: 0) {
            
            Text("Tutorial")
                .font(.system(size: 18))
                .fontWeight(.bold)
                .foregroundStyle(.gray)
                .opacity(0.8)
            
            ZStack {
                WatermelonBackgroundView()
                
                VStack(alignment: .leading, spacing: 0) {
                    TopicView(page: page)
                        .padding(.bottom)
                    
                    FeedbackView(answer: $answer, watermelonViews: watermelonViews, selectedIndex: selectedWatermelonIndex)
                        .frame(width: feedbackViewWidth)
                        .padding(.vertical)
                        .border(.green, width: 3)
                    
                    createLazyVGridView(
                        watermelonViews: watermelonViews,
                        selectedWatermelonIndex: selectedWatermelonIndex,
                        showAnswerResult: showAnswerResult
                    )
                    .padding(.bottom, 20)
                    .border(.red)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .border(.blue)
            }
            .padding(.horizontal)
            .padding(.top, 25)
            .padding(.bottom, 25)
            .border(.orange)
            
            createButtonView(
                answer: answer, page: page,
                evaluateStageAnswer: evaluateStageAnswer,
                selectedWatermelonIndex: selectedWatermelonIndex
            )
        }
        .onAppear {
            setupWatermelonViews(for: page)
        }
        .onChange(of: page) { newValue in
            withAnimation {
                setupWatermelonViews(for: newValue)
                viewUpdateKey = UUID()
                currentIndex = 0
                answer = .undefined
                selectedWatermelonIndex = nil
            }
        }
        .id(viewUpdateKey) // 이 key를 사용하여 뷰 갱신 강제
    }
    
    private func setupWatermelonViews(for page: Page) {
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
    
    private func evaluateStageAnswer() {
        switch answer {
        case .correct:
            withAnimation {
                page = page.navigateToNextPage(with: page)
            }
        default: // .wrong
            answer =
            watermelonViews[selectedWatermelonIndex ?? 0]
                .watermelon.isDelicious() == true ? .correct : .wrong
            feedbackViewWidth = 0.0
            withAnimation(.snappy(duration: 0.4, extraBounce: 0.1)) {
                feedbackViewWidth = .infinity
            }
        }
        
        showAnswerResult = true
    }
    
    @ViewBuilder
    private func createButtonView(answer: Answer, page: Page, evaluateStageAnswer: @escaping () -> Void, selectedWatermelonIndex: Int?) -> some View {
        if answer == .correct && page.rawValue != 4 {
            Button(action: {
                withAnimation {
                    self.page = page.navigateToNextPage(with: page)
                }
            }) {
                MoveToNextButtonView()
                    .padding(.vertical, 30)
            }
            .transition(.opacity)
        } else if answer == .correct && page.rawValue == 4 {
            Button(action: {
                withAnimation {
                    self.answer = .undefined
                    self.selectedWatermelonIndex = nil
                    self.page = page.navigateToNextPage(with: page)
                }
            }) {
                MoveToGameButtonView()
                    .padding(.vertical, 30)
            }
            .transition(.opacity)
        } else {
            Button(action: evaluateStageAnswer) {
                ConfirmButtonView()
                    .padding(.vertical, 30)
            }
            .disabled(selectedWatermelonIndex == nil)
            .transition(.opacity)
        }
    }
    
    func createLazyVGridView(watermelonViews: [WatermelonSceneView], selectedWatermelonIndex: Int?, showAnswerResult: Bool) -> some View {
        LazyVGrid(columns: gridItems, spacing: 10) {
            ForEach(0..<watermelonViews.count, id: \.self) { index in
                watermelonViews[index]
                    .frame(width: 158, height: 158)
                    .clipShape(.rect(cornerRadius: 10))
                    .overlay(
                        OverlayView(answer: $answer, selectedIndex: selectedWatermelonIndex, index: index, showAnswerResult: showAnswerResult)
                    )
                    .onTapGesture {
                        self.showAnswerResult = false
                        self.selectedWatermelonIndex = index
                    }
            }
        }
    }
}

#Preview {
    TutorialView(page: .constant(.tutorialStripe))
}
