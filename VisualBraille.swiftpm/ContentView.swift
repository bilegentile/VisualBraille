import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var handGestureProcessor: HandGestureProcessor
    
    var body: some View {
        AlphabetExerciseView()
            .environmentObject(handGestureProcessor)
    }
}
