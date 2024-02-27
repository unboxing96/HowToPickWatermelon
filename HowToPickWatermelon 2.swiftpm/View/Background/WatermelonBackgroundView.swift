//
//  WatermelonBackgroundView.swift
//
//
//  Created by 김태현 on 2/22/24.
//

import SwiftUI

struct WatermelonBackgroundView: View {
    var body: some View {
        Rectangle()
            .foregroundStyle(.gray)
            .opacity(0.3)
            .clipShape(.rect(cornerRadius: 5))
    }
}

#Preview {
    WatermelonBackgroundView()
}
