//
//  Watermelon.swift
//
//
//  Created by 김태현 on 2/21/24.
//

import Foundation
import SceneKit

struct Watermelon {
    let imgName: String
    let taste: Taste
    let interaction: Bool = false
    let feedbackTextForWrong: String = "Wrong"
    let feedbackTextForCorrect: String = "Correct"
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
