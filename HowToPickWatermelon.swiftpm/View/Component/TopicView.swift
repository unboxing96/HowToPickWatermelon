//
//  TopicView.swift
//
//
//  Created by 김태현 on 2/22/24.
//

import SwiftUI

struct TopicView: View {
    var body: some View {
        Rectangle()
            .foregroundStyle(.gray)
            .opacity(0.5)
            .clipShape(.rect(cornerRadius: 5))
            .frame(width: 360, height: 60)
    }
}

#Preview {
    TopicView()
}
