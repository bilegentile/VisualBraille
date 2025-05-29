//
//  SwiftUIView.swift
//  VisualBraille
//
//  Created by Beniamino Gentile on 23/02/25.
//

import SwiftUI

struct RightHandTutorialView: View {
    @State private var rightTutorialHands = [
        TutorialHandModel(fingerName: "RIGHT INDEX", fingerImage: "rightIndexPinch", selectedDots: [false, false, false, true ,false, false], dotName: "FOURTH"),
        TutorialHandModel(fingerName: "RIGHT MIDDLE", fingerImage: "rightMiddlePinch", selectedDots: [false, false, false, false ,true, false], dotName: "FIFTH"),
        TutorialHandModel(fingerName: "RIGHT RING", fingerImage: "rightRingPinch", selectedDots: [false, false, false, false ,false, true], dotName: "SIXTH"),
        TutorialHandModel(fingerName: "RIGHT LITTLE", fingerImage: "rightLittlePinch", selectedDots: [false, false, false, false ,false, false], dotName: "")
    ]
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .top){
                    Text("RIGHT HAND TUTORIAL")
                        .font(.title)
                        .padding()
                }
                Spacer()
                Text("Pinch your")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
                HStack{
                    ForEach($rightTutorialHands, id: \.self){ hand in
                        HandCardView(thumbOrientation: .constant("RIGHT"), finger: hand.fingerName, handImage: hand.fingerImage, selectedDots: hand.selectedDots, dotName: hand.dotName)
                            .scaledToFit()
                            .padding()
                    }
                }
                .padding()
                NavigationLink {
                    AlphabetExerciseView()
                } label: {
                    Label("Next", systemImage: "chevron.right")
                        .foregroundStyle(.black)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.yellow)
                                .frame(width: 100, height: 40)
                        }
                }
            }
        }
    }
}

#Preview {
    RightHandTutorialView()
}
