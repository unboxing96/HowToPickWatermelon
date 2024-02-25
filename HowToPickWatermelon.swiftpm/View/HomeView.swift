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
    
    var body: some View {
        VStack(spacing: 0) {
            HomeTitleView()
            
            WatermelonSceneView(watermelon: Watermelon(
                imgBodyName: "wv1",
                imgStemName: "stemTextureDried1",
                taste: .stemSmall,
                feedbackTextForWrong: "This is Too Sweet",
                feedbackTextForCorrect: "This is Too Sweet"
            ))
            .frame(width: 330, height: 450)
            
            HomeButtonView(page: $page, pageToGo: .tutorialStripe)
                .padding(.bottom)
            
            HomeButtonView(page: $page, pageToGo: .game)
                .padding(.bottom, 60)
        }
    }
}

#Preview {
    HomeView(page: .constant(.home))
}
