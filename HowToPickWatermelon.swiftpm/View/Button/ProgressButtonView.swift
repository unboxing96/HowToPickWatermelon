////
////  ProgressButtonView.swift
////
////
////  Created by 김태현 on 2/22/24.
////
//
//import SwiftUI
//
//struct ProgressButtonView: View {
//    @Binding var answer: Answer
//    @State private var progress: CGFloat = 1.0
//    
//    var body: some View {
//        
//        VStack(alignment: .leading, spacing: 0) {
//            switch answer {
//            case .wrong:
//                Rectangle()
//                    .foregroundStyle(.gray)
//                    .opacity(0.5)
//                    .clipShape(.rect(cornerRadius: 10))
//                    .frame(width: 360, height: 70)
//                    .overlay(
//                        GeometryReader { geometry in
//                            Rectangle() // 진행 상태를 나타내는 Rectangle
//                                .foregroundStyle(.black)
//                                .clipShape(RoundedRectangle(cornerRadius: 10))
//                                .frame(width: geometry.size.width * progress, height: 70)
//                                .animation(.linear(duration: 2), value: progress)
//                                .onAppear {
//                                    progress = 0 // 진행 상태를 0으로 설정하여 애니메이션 시작
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                                        answer = .correct
//                                    }
//                                }
//                        }
//                    )
//            default: // case: .correct
//                Rectangle()
//                    .foregroundStyle(.gray)
//                    .opacity(0.5)
//                    .clipShape(.rect(cornerRadius: 10))
//                    .frame(width: 360, height: 70)
//                    .overlay {
//                        Text("Move To Next")
//                    }
//            }
//        }
//    }
//}
//
//#Preview {
//    ProgressButtonView(answer: .constant(.undefined))
//}
