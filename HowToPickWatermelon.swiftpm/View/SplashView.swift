//
//  SplashView.swift
//
//
//  Created by 김태현 on 2/25/24.
//

import SwiftUI

struct SplashView: View {
    @Binding var show: Bool
    @State private var positionY: CGFloat = UIScreen.main.bounds.height
    @State private var rotation: Double = 0
    @State private var opacity: Double = 1
    
    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
                .opacity(opacity)
            
            Image("wv1") // 이미지 이름 "splashImage" 가정
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .rotationEffect(Angle.degrees(rotation))
                .opacity(opacity)
                .position(x: UIScreen.main.bounds.width / 2, y: positionY + 200 )
        }
        .onAppear {
            // 바닥에서 중앙으로 올라오는 애니메이션
            withAnimation(.spring(blendDuration: 1.0)) {
                positionY = UIScreen.main.bounds.height / 2
            }
            
            // 회전 애니메이션
            withAnimation(Animation.easeInOut(duration: 2.5)) {
                rotation += 1080
                opacity = 0
            }
            
            // 애니메이션이 완전히 끝난 후에 뷰 숨김
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                show = false
            }
        }
    }
}


#Preview {
    SplashView(show: .constant(true))
}
