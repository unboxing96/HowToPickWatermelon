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
    @State private var feedbackViewWidth: CGFloat = .infinity
    @State private var progressValue: Double = 1.0
    @State private var hasOnAppearedBeenExecuted = false
    @State private var totalTime: CGFloat = 20 // 총 시간을 설정합니다.
    @State private var remainingTime: CGFloat = 20 // 남은 시간을 설정합니다.
    @State private var isButtonDisabled: Bool = true
    @State private var feedbackString: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            TimerView(remainingTime: $remainingTime, totalTime: totalTime)
                .padding(.top, 20)
            
            ZStack {
                WatermelonBackgroundView()
                
                VStack(alignment: .leading, spacing: 0) {
                    FeedbackView(answer: $answer, feedbackString: feedbackString, watermelonViews: watermelonGameViews, selectedIndex: currentIndex)
                        .frame(width: feedbackViewWidth)
                        .padding(.top, 20)
                        .border(.red)
                    
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
                .border(.blue)
            }
            .padding(20)
            .animation(.easeInOut(duration: 1), value: currentIndex)
            
            createButtonView()
                .padding(.bottom, 30)
        }
        .onAppear {
            if !hasOnAppearedBeenExecuted {
                setupWatermelonGameViews(for: page)
                startTimer()
                hasOnAppearedBeenExecuted = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                self.isButtonDisabled = false
            }
        }
        .onChange(of: currentIndex) { newValue in
            withAnimation {
                var transaction = Transaction()
                transaction.disablesAnimations = true
                withTransaction(transaction) {
                    viewUpdateKey = UUID()
                }
                answer = .undefined
                self.isButtonDisabled = true
            }
        }
        .id(viewUpdateKey) // 이 key를 사용하여 뷰 갱신 강제
    }
    
    private func setupWatermelonGameViews(for page: Page) {
        let selectedWatermelons = watermelonData.count >= 20 ? Array(watermelonData.shuffled().prefix(20)) : Array(watermelonData.shuffled())
        watermelonGameViews = selectedWatermelons.map { WatermelonSceneView(watermelon: $0) }
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
        
        feedbackString = watermelonGameViews[currentIndex].watermelon.feedbackText
    }
    
    private func generateFeedback() {
        feedbackViewWidth = 0.0
        withAnimation(.snappy(duration: 0.4, extraBounce: 0.1)) {
            feedbackViewWidth = .infinity
        }
    }
    
    private func startTimer() {
        // 타이머 시작 로직
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            withAnimation(.linear(duration: 0.25)) {
                if self.remainingTime > 0 {
                    self.remainingTime -= 0.25
                    self.startTimer()
                } else {
                    saveHighScore()
                    page = .score
                }
            }
        }
    }
    
    @ViewBuilder
    private func createButtonView() -> some View {
        switch answer {
        case .correct:
            HStack {
                Button {
                    print("correct !!!!")
                    score += 1
                    moveToNextView()
                } label: {
                    MoveToNextButtonView(text: "Move To Next")
                }
            }
            .frame(maxWidth: .infinity)
        case .wrong:
            HStack {
                Button {
                    print("wrong !!!!")
                    moveToNextView()
                } label: {
                    MoveToNextButtonView(text: "Move To Next")
                }
            }
            .frame(maxWidth: .infinity)
        default: // .undefined
            HStack(spacing: 30) {
                Button {
                    evaluateAnswer(trial: .good)
                    generateFeedback()
                } label: {
                    GoodBadButtonView(text: "Sweet")
                }
                .disabled(isButtonDisabled)
                .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
                
                Button {
                    evaluateAnswer(trial: .bad)
                    generateFeedback()
                } label: {
                    GoodBadButtonView(text: "Bland")
                }
                .disabled(isButtonDisabled)
                .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    private func saveHighScore() {
        let highScore = UserDefaults.standard.integer(forKey: "highScore")
        if score > highScore {
            UserDefaults.standard.set(score, forKey: "highScore")
        }
    }
}

#Preview {
    GameView(page: .constant(.tutorialStripe), score: .constant(0))
}
