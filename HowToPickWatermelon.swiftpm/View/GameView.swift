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
    @Binding var score: Int
    @State private var currentIndex: Int = 0
    @State private var watermelonGameViews: [WatermelonSceneView] = []
    @State private var viewUpdateKey = UUID() // 뷰 갱신을 위한 key
    @State private var answer: Answer = .undefined
    @State private var feedbackViewWidth: CGFloat = 0.0
    @State private var progressValue: Double = 1.0
    @State private var hasOnAppearedBeenExecuted = false
    
    var body: some View {
        VStack(spacing: 0) {
            TimerView()
                .padding(.top, 20)
            
            ZStack {
                WatermelonBackgroundView()
                
                VStack(alignment: .leading, spacing: 0) {
                    FeedbackView(answer: $answer)
                        .frame(width: feedbackViewWidth)
                        .padding(.top, 20)
                        .border(.orange)
                    
                    ZStack {
                        ForEach(0..<watermelonGameViews.count, id: \.self) { index in
                            watermelonGameViews[index]
                                .offset(x: offsetForIndex(index), y: 0)
                                .animation(.easeInOut(duration: 1), value: currentIndex)
                                .padding(.top, 15)
                                .padding(.bottom, 30)
                                .border(.orange)
                        }
                    }
                }
                .padding(.horizontal)
                .border(.orange)
            }
            .padding(20)
            .animation(.easeInOut(duration: 1), value: currentIndex)
            
            switch answer {
            case .correct:
                Button {
                    score += 1
                    moveToNextView()
                } label: {
                    ProgressButtonView(answer: $answer)
                        .padding(.bottom, 30)
                }
            case .wrong:
                ProgressButtonView(answer: $answer)
                    .padding(.bottom, 30)
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
                .padding(.bottom, 30)
            }
        }
        .onAppear {
            print("onAppear !!!!")
            setupWatermelonGameViews(for: page)
            if !hasOnAppearedBeenExecuted {
                DispatchQueue.main.asyncAfter(deadline: .now() + 100.0) {
                    page = .score
                }
                hasOnAppearedBeenExecuted = true
            }
        }
        .onChange(of: currentIndex) { newValue in
            withAnimation {
                viewUpdateKey = UUID()
                answer = .undefined
                feedbackViewWidth = 0.0
            }
        }
        .id(viewUpdateKey) // 이 key를 사용하여 뷰 갱신 강제
        .onDisappear {
            print("onDiappear !!!!")
            answer = .undefined
            feedbackViewWidth = 0.0
            hasOnAppearedBeenExecuted = false
        }
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
        answer = isGood && trial == .good ? .correct
        : !isGood && trial == .bad ? .correct
        : .wrong
    }
    
    private func generateFeedback() {
        feedbackViewWidth = 0.0
        withAnimation(.snappy(duration: 0.4, extraBounce: 0.1)) {
            feedbackViewWidth = .infinity
        }
    }
}

#Preview {
    GameView(page: .constant(.tutorialStripe), score: .constant(0))
}
