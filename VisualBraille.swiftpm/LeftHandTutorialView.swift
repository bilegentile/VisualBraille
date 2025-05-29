//
//  SwiftUIView.swift
//  VisualBraille
//
//  Created by Beniamino Gentile on 23/02/25.
//

import SwiftUI

struct LeftHandTutorialView: View {
    @State private var leftTutorialHands = [
        TutorialHandModel(fingerName: "LEFT INDEX", fingerImage: "leftIndexPinch", selectedDots: [true, false, false, false ,false, false], dotName: "FIRST"),
        TutorialHandModel(fingerName: "LEFT MIDDLE", fingerImage: "leftMiddlePinch", selectedDots: [false, true, false, false ,false, false], dotName: "SECOND"),
        TutorialHandModel(fingerName: "LEFT RING", fingerImage: "leftRingPinch", selectedDots: [false, false, true, false ,false, false], dotName: "THIRD"),
        TutorialHandModel(fingerName: "LEFT LITTLE", fingerImage: "leftLittlePinch", selectedDots: [false, false, false, false ,false, false], dotName: "")
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .top){
                    Text("LEFT HAND TUTORIAL")
                        .font(.title)
                        .padding()
                }
                Spacer()
                Text("Pinch your")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
                HStack{
                    ForEach($leftTutorialHands, id: \.self){ hand in
                        HandCardView(thumbOrientation: .constant("LEFT"), finger: hand.fingerName, handImage: hand.fingerImage, selectedDots: hand.selectedDots, dotName: hand.dotName)
                            .scaledToFit()
                            .padding()
                    }
                }
                .padding()
                Spacer()
                NavigationLink {
                    RightHandTutorialView()
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
    LeftHandTutorialView()
}
