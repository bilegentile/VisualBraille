import SwiftUI

@main
struct MyApp: App {
    
    @StateObject var handGestureProcessor = HandGestureProcessor()
    
    var body: some Scene {
        WindowGroup {
            WelcomeView()
                .environmentObject(handGestureProcessor)
                .preferredColorScheme(.light)
        }
        
    }
}
