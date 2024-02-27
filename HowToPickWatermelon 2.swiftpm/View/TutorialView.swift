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
    @State private var viewUpdateKey = UUID()
    @State private var answer: Answer = .undefined
    @State private var feedbackViewWidth: CGFloat = .infinity
    @State private var showAnswerResult = false
    @State private var feedbackString: String = ""
    
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
                .padding(.top, 25)
            
            ZStack {
                WatermelonBackgroundView()
                
                VStack(alignment: .leading, spacing: 0) {
                    TopicView(page: page)
                        .padding(.bottom)
                    
                    FeedbackView(answer: $answer, page: page, feedbackString: feedbackString, watermelonViews: watermelonViews, selectedIndex: selectedWatermelonIndex)
                        .padding(.vertical)
                        .frame(minWidth: 0, maxWidth: feedbackViewWidth)
                    
                    createLazyVGridView(
                        watermelonViews: watermelonViews,
                        selectedWatermelonIndex: selectedWatermelonIndex,
                        showAnswerResult: showAnswerResult
                    )
                    .padding(.bottom, 20)
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            .padding(.horizontal)
            .padding(.top, 25)
            .padding(.bottom, 25)
            
            createButtonView(
                answer: answer, page: page,
                evaluateStageAnswer: evaluateStageAnswer,
                selectedWatermelonIndex: selectedWatermelonIndex
            )
        }
        .frame(maxWidth: 400, maxHeight: 700)
        .onAppear {
            setupWatermelonViews(for: page)
        }
        .onChange(of: page) { newValue in
            withAnimation {
                setupWatermelonViews(for: newValue)
                viewUpdateKey = UUID()
                answer = .undefined
                selectedWatermelonIndex = nil
            }
        }
        .id(viewUpdateKey)
    }
    
    private func setupWatermelonViews(for page: Page) {
        
        let tasteCriteria = page.tutorialContent.taste
        
        
        let filteredWatermelons = watermelonData.filter { watermelon in
            tasteCriteria.contains(watermelon.taste)
        }
        
        
        var selectedWatermelons: [Watermelon]
        switch page {
        case .tutorialStripe:
            selectedWatermelons = filteredWatermelons.count > 4 ? Array(filteredWatermelons.shuffled().prefix(4)) : filteredWatermelons
        default:
            selectedWatermelons = filteredWatermelons.count > 4 ? Array(filteredWatermelons.prefix(4)) : filteredWatermelons
        }
        
        
        watermelonViews = selectedWatermelons.map { WatermelonSceneView(watermelon: $0, page: page) }
    }
    
    
    //    private func offsetForIndex(_ index: Int) -> CGFloat {
    //        let viewWidth = UIScreen.main.bounds.width
    //        let currentIndexOffset = CGFloat(currentIndex) * viewWidth
    //        let indexOffset = CGFloat(index) * viewWidth
    //        return indexOffset - currentIndexOffset
    //    }
    
    private func evaluateStageAnswer() {
        switch answer {
        case .correct:
            withAnimation {
                feedbackString = watermelonViews[selectedWatermelonIndex ?? 0].watermelon.feedbackText
                page = page.navigateToNextPage(with: page)
            }
        default:
            answer =
            watermelonViews[selectedWatermelonIndex ?? 0]
                .watermelon.isDelicious() == true ? .correct : .wrong
            feedbackViewWidth = 0.0
            feedbackString = watermelonViews[selectedWatermelonIndex ?? 0].watermelon.feedbackText
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
                MoveToNextButtonView(text: "Move To Next")
                    .padding(.vertical, 30)
            }
            .transition(.opacity)
        } else if answer == .correct && page.rawValue == 4 {
            Button(action: {
                withAnimation {
                    self.answer = .undefined
                    self.selectedWatermelonIndex = nil
                    self.page = page.navigateToNextPage(with: page)
                    UserDefaults.standard.set(true, forKey: "tutorialCompleted")
                }
            }) {
                MoveToNextButtonView(text: "Let's Play The Game")
                    .padding(.vertical, 30)
            }
            .transition(.opacity)
        } else {
            Button(action: evaluateStageAnswer) {
                TutorialButtonView(text: "Pick A Sweet Watermelon")
                    .padding(.vertical, 30)
            }
            .disabled(selectedWatermelonIndex == nil)
            .transition(.opacity)
        }
    }
    
    func createLazyVGridView(watermelonViews: [WatermelonSceneView], selectedWatermelonIndex: Int?, showAnswerResult: Bool) -> some View {
        LazyVGrid(columns: gridItems, spacing: 10) {
            ForEach(watermelonViews.indices, id: \.self) { index in
                watermelonViews[index]
                    .frame(width: 158, height: 158)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        OverlayView(answer: $answer, selectedIndex: selectedWatermelonIndex, index: index, showAnswerResult: showAnswerResult)
                    )
                    .onTapGesture {
                        self.showAnswerResult = false
                        self.selectedWatermelonIndex = index
                        let selectedTaste = self.watermelonViews[index].watermelon.taste
                    }
            }
        }
    }
    
}

#Preview {
    TutorialView(page: .constant(.tutorialStripe))
}
