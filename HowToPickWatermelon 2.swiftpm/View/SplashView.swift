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
            Color.buttonLightInner
                .ignoresSafeArea()
                .opacity(opacity)
            
            Image("splash")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .rotationEffect(Angle.degrees(rotation))
                .opacity(opacity)
                .position(x: UIScreen.main.bounds.width / 2, y: positionY)
        }
        .onAppear {
            
            withAnimation(.spring(blendDuration: 1.5)) {
                positionY = UIScreen.main.bounds.height / 2
            }
            
            
            withAnimation(Animation.easeInOut(duration: 2.0)) {
                rotation += 1080
            }
            
            
            withAnimation(Animation.easeInOut(duration: 1.5).delay(0.5)) {
                opacity = 0
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                show = false
            }
        }
    }
}


#Preview {
    SplashView(show: .constant(true))
}
