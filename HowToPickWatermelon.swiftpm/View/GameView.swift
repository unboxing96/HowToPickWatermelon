//
//  GameView.swift
//
//
//  Created by 김태현 on 2/21/24.
//

import SwiftUI
import SceneKit

struct GameView: View {
    @Binding var page: Page
    @State private var currentIndex: Int = 0
    @State private var watermelonGameViews: [WatermelonSceneView] = []
    @State private var viewUpdateKey = UUID() // 뷰 갱신을 위한 key
    @State private var answer: Answer = .undefined
    @State private var feedbackButtonViewWidth: CGFloat = 0.0
    @State private var progressValue: Double = 1.0
    
    var body: some View {
        VStack(spacing: 0) {
            TimerView()
            
            ZStack {
                FeedbackButtonView(answer: $answer)
                    .frame(width: feedbackButtonViewWidth)
                    .padding(.bottom, 20)
                    .padding(.horizontal, 360 * 0.03)
                    .border(.orange)
                
                ForEach(0..<watermelonGameViews.count, id: \.self) { index in
                    watermelonGameViews[index]
                        .offset(x: offsetForIndex(index), y: 0)
                        .animation(.easeInOut(duration: 1), value: currentIndex)
                        .frame(width: 300, height: 400)
                }
            }
            .background(WatermelonBackgroundView())
            .animation(.easeInOut(duration: 1), value: currentIndex)
            
            switch answer {
            case .correct:
                Button {
                    moveToNextView()
                } label: {
                    ProgressButtonView(answer: $answer)
                }
            case .wrong:
                ProgressButtonView(answer: $answer)
            default: // .undefined
                HStack(spacing: 20) {
                    Button {
                        evaluateAnswer(trial: .good)
                        generateFeedback()
                    } label: {
                        GoodBadButtonView(text: "Good")
                    }
                    .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
                    
                    Button {
                        evaluateAnswer(trial: .bad)
                        generateFeedback()
                    } label: {
                        GoodBadButtonView(text: "Bad")
                    }
                    .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
                }
            }
        }
        .onAppear {
            setupWatermelonGameViews(for: page)
            DispatchQueue.main.asyncAfter(deadline: .now() + 20.0) {
                page = .score
            }
        }
        .onChange(of: currentIndex) { newValue in
            withAnimation {
                viewUpdateKey = UUID()
                answer = .undefined
                feedbackButtonViewWidth = 0.0
            }
        }
        .id(viewUpdateKey) // 이 key를 사용하여 뷰 갱신 강제
    }
    
    private func setupWatermelonGameViews(for page: Page) {
        let imageNames = ["wv1", "wv2", "wv3", "wc1", "wc2"]
        
        for _ in 1...20 {
            let imageName = imageNames.randomElement()!
            let taste = Taste.allCases.randomElement()!
            watermelonGameViews.append(
                WatermelonSceneView(watermelon: Watermelon(
                    imgName: imageName,
                    taste: taste)
                )
            )
        }
    }
    
    private func offsetForIndex(_ index: Int) -> CGFloat {
        let viewWidth = UIScreen.main.bounds.width
        return CGFloat(index - currentIndex) * viewWidth
    }
    
    private func moveToNextView() {
        withAnimation {
            currentIndex = min(currentIndex + 1, watermelonGameViews.count - 1)
            answer = .undefined
            progressValue = 1.0
        }
    }
    
    private func evaluateAnswer(trial: Trial) {
        let isGood = watermelonGameViews[currentIndex].watermelon.isDelicious()
        answer = isGood && trial == .good
        ? .correct : !isGood && trial == .bad
        ? .correct : .wrong
    }
    
    private func generateFeedback() {
        feedbackButtonViewWidth = 0.0
        withAnimation(.snappy(duration: 0.4, extraBounce: 0.1)) {
            feedbackButtonViewWidth = 340
        }
    }
}

#Preview {
    GameView(page: .constant(.tutorialStripe))
}
