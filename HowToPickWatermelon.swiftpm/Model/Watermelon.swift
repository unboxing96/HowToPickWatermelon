//
//  Watermelon.swift
//
//
//  Created by 김태현 on 2/21/24.
//

import Foundation
import SceneKit

struct Watermelon {
    let imgBodyName: String
    let imgStemName: String
    let taste: Taste
    let feedbackTextForWrong: String
    let feedbackTextForCorrect: String
}

extension Watermelon {
    func isDelicious() -> Bool {
        switch self.taste {
        case .stripeNarrow, .soundClear, .stemSmall, .spotOrange:
            return true
        default:
            return false
        }
    }
    
    func getFeedbackText(answer: Answer) -> String {
        switch answer {
        case .correct:
            return self.feedbackTextForCorrect
        case .wrong:
            return self.feedbackTextForWrong
        default:
            return ""
        }
    }
}
