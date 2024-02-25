import SwiftUI

struct ContentView: View {
    @State private var page: Page = .home
    @State private var score: Int = 0
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack {
                switch page {
                case .home:
                    HomeView(page: $page)
                case .tutorialStripe, .tutorialSound, .tutorialStem, .tutorialSpot:
                    TutorialView(page: $page)
                case .game:
                    GameView(page: $page, score: $score)
                case .score:
                    ScoreView(page: $page, score: $score)
                }
            }
        }
    }
}
