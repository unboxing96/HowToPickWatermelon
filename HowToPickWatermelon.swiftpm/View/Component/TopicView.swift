//
//  TopicView.swift
//
//
//  Created by 김태현 on 2/22/24.
//

import SwiftUI

struct TopicView: View {
    let text: String
    
    var body: some View {
        Rectangle()
            .foregroundStyle(.clear)
            .clipShape(.rect(cornerRadius: 5))
            .frame(height: 60)
            .overlay {
                Text(text)
                    .font(.system(size: 24))
            }
    }
}

#Preview {
    TopicView(text: "Stripes")
}
