//
//  HomeTitleView.swift
//
//
//  Created by 김태현 on 2/25/24.
//

import SwiftUI

struct HomeTitleView: View {
    var body: some View {
        Text("How To Pick")
            .foregroundStyle(.primary)
            .fontWeight(.bold)
            .font(.system(size: 40))
            .padding(.top, 30)
        
        Text("Watermelon")
            .foregroundStyle(.primary)
            .fontWeight(.bold)
            .font(.system(size: 50))
    }
}

#Preview {
    HomeTitleView()
}
