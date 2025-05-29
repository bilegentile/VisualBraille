//
//  AlphabetExerciseView.swift
//  VisualBraille
//
//  Created by Beniamino Gentile on 19/02/25.
//
import SwiftUI

struct AlphabetExerciseView: View {
    @EnvironmentObject var handGestureProcessor: HandGestureProcessor
    
    @State private var correctAnswer: [Bool] = Array(repeating: false, count: 6)
    
    @State private var index = 1
    
    @State private var isCongratulationsShowing: Bool = false
    
    var body: some View {
        ZStack {
            HandTrackingView()
            VStack {
                HStack{
                    InstructionView(currentLetter: $handGestureProcessor.alphabetSession.alphabet[index].letter, index: $index)
                        .frame(width: 400, height: 400, alignment: .top)
                        .padding()
                }
                Spacer()
                BrailleDotsView(isSelected: $handGestureProcessor.proposedSolution)
                    .scaledToFit()
                    .padding()
                Spacer()
            }
        }
        .onAppear {
        }
        .onChange(of: handGestureProcessor.proposedSolution) { newValue in
            let proposedAnswer = newValue
            let testPassed = handGestureProcessor.checkCorrectAnswer(proposedAnswer: proposedAnswer, correctAnswer: handGestureProcessor.alphabetSession.alphabet[index].dots)
            if testPassed == true && index < 26 {
                index+=1
                handGestureProcessor.proposedSolution = Array(repeating: false, count: 6)
            } else if index >= 26 {
                index = 1
            }
        }
        .onDisappear {
        }
    }
}
