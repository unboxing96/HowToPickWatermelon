//
//  ConfirmButtonView.swift
//
//
//  Created by 김태현 on 2/22/24.
//

import SwiftUI

struct ConfirmButtonView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(.gray)
            .opacity(0.5)
            .frame(width: 360, height: 70)
            .overlay {
                Text("Confirm The Answer")
            }
    }
}

#Preview {
    ConfirmButtonView()
}
