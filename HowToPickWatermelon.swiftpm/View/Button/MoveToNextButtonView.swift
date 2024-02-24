//
//  MoveToNextButtonView.swift
//  
//
//  Created by 김태현 on 2/24/24.
//

import SwiftUI

struct MoveToNextButtonView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color.blue, lineWidth: 3)
            .foregroundStyle(.gray)
            .opacity(0.5)
            .frame(width: 360, height: 70)
            .overlay {
                Text("Move To Next")
            }
    }
}

#Preview {
    MoveToNextButtonView()
}
