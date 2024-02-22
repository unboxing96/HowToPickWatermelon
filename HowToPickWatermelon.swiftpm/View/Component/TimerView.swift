//
//  TimerView.swift
//
//
//  Created by 김태현 on 2/22/24.
//

import SwiftUI

struct TimerView: View {
    var body: some View {
        Rectangle()
            .foregroundStyle(.gray)
            .opacity(0.5)
            .clipShape(.rect(cornerRadius: 5))
            .frame(width: 360, height: 50)
    }
}

#Preview {
    TimerView()
}
