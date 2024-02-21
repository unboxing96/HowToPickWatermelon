import SwiftUI

struct ContentView: View {
    @State private var page: Page = .home
    
    var body: some View {
        VStack {
            switch page {
            case .home:
                HomeView()
            case .tutorialStripe:
                TutorialView()
            case .tutorialSound:
                TutorialView()
            case .tutorialStem:
                TutorialView()
            case .tutorialSpot:
                TutorialView()
            case .game:
                GameView()
            case .score:
                ScoreView()
            }
        }
    }
}
