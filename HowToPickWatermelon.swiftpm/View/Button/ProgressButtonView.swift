//
//  ProgressButtonView.swift
//
//
//  Created by 김태현 on 2/22/24.
//

import SwiftUI

struct ProgressButtonView: View {
    @Binding var answer: Answer
    @State private var loadingBarWidth: CGFloat = 360.0
    
    var body: some View {
        
        switch answer {
        case .wrong:
            Rectangle()
                .foregroundStyle(.gray)
                .opacity(0.5)
                .clipShape(.rect(cornerRadius: 10))
                .frame(width: 360, height: 70)
                .overlay {
                    Rectangle()
                        .foregroundStyle(.black)
                        .clipShape(.rect(cornerRadius: 10))
                        .frame(width: loadingBarWidth, height: 70)
                        .onAppear {
                            withAnimation(.linear(duration: 2)) {
                                loadingBarWidth = 0.0
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                answer = .correct
                            }
                        }
                }
        default: // case: .correct
            Rectangle()
                .foregroundStyle(.gray)
                .opacity(0.5)
                .clipShape(.rect(cornerRadius: 10))
                .frame(width: 360, height: 70)
                .overlay {
                    Text("Move To Next")
                }
        }
    }
}

#Preview {
    ProgressButtonView(answer: .constant(.undefined))
}
