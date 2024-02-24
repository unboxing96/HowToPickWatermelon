//
//  Page.swift
//
//
//  Created by 김태현 on 2/21/24.
//

import Foundation

enum Page: Int {
    case home = 0
    case tutorialStripe
    case tutorialSound
    case tutorialStem
    case tutorialSpot
    case game
    case score
}

extension Page {
    var tutorialContent: TutorialPageContent {
        switch self {
        case .tutorialStripe:
            return TutorialPageContent(
                title: "Which stripes look delicious?",
                taste: [.stripeNarrow, .stripeWide]
            )
        case .tutorialSound:
            return TutorialPageContent(
                title: "Sound",
                taste: [.soundClear, .soundHeavy]
            )
        case .tutorialStem:
            return TutorialPageContent(
                title: "Stem",
                taste: [.stemSmall, .stemLarge]
            )
        case .tutorialSpot:
            return TutorialPageContent(
                title: "Spot",
                taste: [.spotOrange, .spotWhite]
            )
        default:
            return TutorialPageContent(
                title: "Stripe",
                taste: [.stripeNarrow, .stripeWide]
            )
        }
    }
}

extension Page {
    func navigateToNextPage(with page: Page) -> Page {
        let nextRawValue = page.rawValue + 1
        return Page(rawValue: nextRawValue) ?? Page.home
    }
}
