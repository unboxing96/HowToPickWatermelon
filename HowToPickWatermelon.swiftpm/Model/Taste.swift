//
//  Taste.swift
//  HowToPickWatermelon
//
//  Created by 김태현 on 2/21/24.
//

import Foundation

enum Taste: Int, CaseIterable {
    case stripeNarrow = 0
    case stripeWide
    case stemDried
    case stemFresh
    case soundClear
    case soundHeavy
    case spotOrange
    case spotWhite
    
    func description() -> String {
        switch self {
        case .stripeNarrow, .stripeWide:
            return "Stripes"
        case .stemDried, .stemFresh:
            return "Stem"
        case .soundClear, .soundHeavy:
            return "Sound"
        case .spotOrange, .spotWhite:
            return "Spot"
        }
    }
}
