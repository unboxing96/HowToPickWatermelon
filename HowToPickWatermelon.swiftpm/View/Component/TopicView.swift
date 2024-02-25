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
            .frame(height: 60)
            .overlay {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Round \(page.rawValue)")
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .foregroundStyle(.gray)
                        .opacity(0.8)
                    HStack(alignment: .bottom, spacing: 0) {
                        Text("Pick the sweetest ")
                            .font(.system(size: 21))
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                        Text(page.tutorialContent.title)
                            .font(.system(size: 24))
                             .fontWeight(.bold)
                             .foregroundStyle(.black)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(.top, 10)
            .border(.red)
    }
}

#Preview {
    TopicView(page: .tutorialStripe)
}
