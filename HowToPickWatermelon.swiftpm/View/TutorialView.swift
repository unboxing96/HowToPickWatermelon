//
//  TutorialView.swift
//
//
//  Created by 김태현 on 2/21/24.
//

import SwiftUI

struct TutorialView: View {
    @Binding var page: Page
    
    var body: some View {
        let content = page.tutorialContent
        
        VStack {
            Text("\(content.title)")
        }
    }
}

#Preview {
    TutorialView(page: .constant(.tutorialStripe))
}
