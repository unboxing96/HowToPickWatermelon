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
                imgName: "wv1",
                taste: .stemSmall
            ))
            .frame(width: 330, height: 450)
            
            HomeButtonView(page: $page, pageToGo: .tutorialStripe)
                .padding(.bottom)
            
            HomeButtonView(page: $page, pageToGo: .game)
                .padding(.bottom, 35)
        }
    }
}

#Preview {
    HomeView(page: .constant(.home))
}
