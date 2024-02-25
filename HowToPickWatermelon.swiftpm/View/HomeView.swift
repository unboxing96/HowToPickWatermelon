//
//  HomeView.swift
//
//
//  Created by 김태현 on 2/21/24.
//

import SwiftUI
import SceneKit

struct HomeView: View {
    @Binding var page: Page
    @State private var showSwipeIndicator = true
    
    var body: some View {
        VStack(spacing: 0) {
            HomeTitleView()
            
            WatermelonSceneView(watermelon: Watermelon(
                imgBodyName: "wv1",
                imgStemName: "stemTextureDried1",
                taste: .stemDried,
                feedbackText: ""
            ), page: page)
            .frame(width: 330, height: 450)
            
            HomeButtonView(page: $page, pageToGo: .tutorialStripe)
                .padding(.bottom)
            
            HomeButtonView(page: $page, pageToGo: .game)
                .padding(.bottom, 55)
        }
    }
}

#Preview {
    HomeView(page: .constant(.home))
}
