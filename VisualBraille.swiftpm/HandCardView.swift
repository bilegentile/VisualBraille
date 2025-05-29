//
//  SwiftUIView.swift
//  VisualBraille
//
//  Created by Beniamino Gentile on 23/02/25.
//

import SwiftUI

struct HandCardView: View {
    
    @Binding var thumbOrientation: String
    
    @Binding var finger: String
    
    @Binding var handImage: String
    
    @Binding var selectedDots: [Bool]
    
    @Binding var dotName: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(.white)
                //.frame(width: 400, height: 800)
            VStack {
                let allFalseCheck = selectedDots.allSatisfy {$0 == false}
                if allFalseCheck == true {
                    Text("\(thumbOrientation) THUMB \n and your \(finger) together \n to delete all the SELECTED DOTS!")
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.center)
                        .font(.title3)
                } else {
                    Text("\(thumbOrientation) THUMB \n and your \(finger) together \n to select the \(dotName) DOT")
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.center)
                        .font(.title3)
                }
                Image(decorative: handImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                BrailleSolutionDotsView(isSelected: $selectedDots)
                    .scaledToFit()
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.white)
                    }
            }
        }
        .scaledToFit()
    }
}

#Preview {
    HandCardView(thumbOrientation: .constant("LEFT"), finger: .constant("INDEX"), handImage: .constant("leftIndexPinch"), selectedDots: .constant([true, false, false, false, false, false]), dotName: .constant("FIRST"))
}
