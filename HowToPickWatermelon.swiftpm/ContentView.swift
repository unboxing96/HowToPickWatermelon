import SwiftUI

struct ContentView: View {
    @State private var page: Page = .home
    
    var body: some View {
        VStack {
            switch page {
            case .home:
                HomeView(page: $page)
            case .tutorialStripe, .tutorialSound, .tutorialStem, .tutorialSpot:
                TutorialView(page: $page)
            case .game:
                GameView(page: $page)
            case .score:
                ScoreView(page: $page)
            }
        }
    }
}
