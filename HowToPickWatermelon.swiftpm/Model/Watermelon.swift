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
}
