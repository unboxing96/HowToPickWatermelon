////
////  TutorialViewTemp.swift
////
////
////  Created by 김태현 on 2/21/24.
////
//
//import SwiftUI
//import SceneKit
//
//struct TutorialViewTemp: View {
//    @Binding var page: Page
//    @State private var currentIndex: Int = 0
//    @State private var watermelonViews: [WatermelonSceneView] = []
//    @State private var viewUpdateKey = UUID() // 뷰 갱신을 위한 key
//    
//    var body: some View {
//        let content = page.tutorialContent
//        
//        VStack {
//            Text("\(content.title)")
//            
//            ZStack {
//                ForEach(0..<watermelonViews.count, id: \.self) { index in
//                    watermelonViews[index]
//                        .offset(x: self.offsetForIndex(index), y: 0)
//                        .animation(.easeInOut(duration: 1), value: currentIndex)
//                }
//            }
//            
//            HStack {
//                Button("Prev") {
//                    withAnimation {
//                        currentIndex = (currentIndex - 1 + watermelonViews.count) % watermelonViews.count
//                        print("currentIndex: \(currentIndex)")
//                    }
//                }
//                
//                Button("Next") {
//                    withAnimation {
//                        currentIndex = (currentIndex + 1) % watermelonViews.count
//                        print("currentIndex: \(currentIndex)")
//                    }
//                }
//            }
//            
//            Button {
//                page = page.navigateToNextPage(with: page)
//            } label: {
//                Text("Move to Next")
//            }
//        }
//        .onAppear {
//            print("onAppear")
//            setupWatermelonViews(for: page)
//        }
//        .onChange(of: page) { newValue in
//            withAnimation {
//                viewUpdateKey = UUID()
//                currentIndex = 0
//                setupWatermelonViews(for: newValue)
//            }
//        }
//        .id(viewUpdateKey) // 이 key를 사용하여 뷰 갱신 강제
//    }
//    
//    private func setupWatermelonViews(for page: Page) {
//        
//        print("setupWatermelonViews !!!!: \(page)")
//        
//        switch page {
//        case .tutorialStripe:
//            watermelonViews = [
//                WatermelonSceneView(watermelon: Watermelon(
//                    imgName: "wv1",
//                    taste: .stripeWide)),
//                WatermelonSceneView(watermelon: Watermelon(
//                    imgName: "wd3",
//                    taste: .stripeNarrow)),
//                WatermelonSceneView(watermelon: Watermelon(
//                    imgName: "wv2",
//                    taste: .stripeWide))
//            ]
//        case .tutorialSound:
//            watermelonViews = [
//                WatermelonSceneView(watermelon: Watermelon(
//                    imgName: "watermelonTmp0",
//                    taste: .soundHeavy)),
//                WatermelonSceneView(watermelon: Watermelon(
//                    imgName: "watermelonTmp2",
//                    taste: .soundHeavy)),
//                WatermelonSceneView(watermelon: Watermelon(
//                    imgName: "watermelonTmp2",
//                    taste: .soundClear))
//            ]
//        case .tutorialStem:
//            watermelonViews = [
//                WatermelonSceneView(watermelon: Watermelon(
//                    imgName: "watermelonTmp2",
//                    taste: .stemFresh)),
//                WatermelonSceneView(watermelon: Watermelon(
//                    imgName: "watermelonTmp2",
//                    taste: .stemDried)),
//                WatermelonSceneView(watermelon: Watermelon(
//                    imgName: "watermelonTmp2",
//                    taste: .stemFresh))
//            ]
//        case .tutorialSpot:
//            watermelonViews = [
//                WatermelonSceneView(watermelon: Watermelon(
//                    imgName: "watermelonTmp0",
//                    taste: .spotOrange)),
//                WatermelonSceneView(watermelon: Watermelon(
//                    imgName: "watermelonTmp2",
//                    taste: .spotWhite)),
//                WatermelonSceneView(watermelon: Watermelon(
//                    imgName: "watermelonTmp2",
//                    taste: .spotWhite))
//            ]
//        default:
//            break
//        }
//    }
//    
//    private func offsetForIndex(_ index: Int) -> CGFloat {
//        let viewWidth = UIScreen.main.bounds.width
//        let currentIndexOffset = CGFloat(currentIndex) * viewWidth
//        let indexOffset = CGFloat(index) * viewWidth
//        return indexOffset - currentIndexOffset
//    }
//
//}
//
//#Preview {
//    TutorialViewTemp(page: .constant(.tutorialStripe))
//}
