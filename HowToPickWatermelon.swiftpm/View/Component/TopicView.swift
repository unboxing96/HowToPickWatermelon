//
//  TopicView.swift
//
//
//  Created by 김태현 on 2/22/24.
//

import SwiftUI

struct TopicView: View {
    let page: Page
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(.clear)
            .frame(height: 70)
            .overlay {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Round \(page.rawValue)")
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .foregroundStyle(.gray)
                        .opacity(0.8)
                    Text(page.tutorialContent.title)
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.top, 10)
            }
    }
}

#Preview {
    TopicView(page: .tutorialStripe)
}
