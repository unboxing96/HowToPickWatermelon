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
    
    var body: some View {
        let content = page.tutorialContent
        
        VStack {
            Text("\(content.title)")
            
            ZStack {
                ForEach(0..<watermelonViews.count, id: \.self) { index in
                    watermelonViews[index]
                        .offset(x: self.offsetForIndex(index), y: 0)
                        .animation(.easeInOut(duration: 1), value: currentIndex)
                }
            }
            
            HStack {
                Button("Prev") {
                    withAnimation {
                        currentIndex = (currentIndex - 1 + watermelonViews.count) % watermelonViews.count
                        print("currentIndex: \(currentIndex)")
                    }
                }
                
                Button("Next") {
                    withAnimation {
                        currentIndex = (currentIndex + 1) % watermelonViews.count
                        print("currentIndex: \(currentIndex)")
                    }
                }
            }
            
            Button {
                page = page.navigateToNextPage(with: page)
            } label: {
                Text("Move to Next")
            }
        }
        .onAppear {
            setupWatermelonViews(for: page)
            print("page in onAppear: \(page)")
        }
        .onChange(of: page) { newValue in
            setupWatermelonViews(for: newValue)
            print("page in onChange: \(page)")
        }
    }
    
    private func setupWatermelonViews(for page: Page) {
        switch page {
        case .tutorialStripe:
            watermelonViews = [
                WatermelonSceneView(watermelon: Watermelon(
                    imgName: "watermelonTmp0",
                    taste: .stripeWide)),
                WatermelonSceneView(watermelon: Watermelon(
                    imgName: "watermelonTmp2",
                    taste: .stripeNarrow)),
                WatermelonSceneView(watermelon: Watermelon(
                    imgName: "watermelonTmp2",
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
                    imgName: "watermelonTmp0",
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
