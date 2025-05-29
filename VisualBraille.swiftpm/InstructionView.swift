//
//  SwiftUIView.swift
//  VisualBraille
//
//  Created by Beniamino Gentile on 19/02/25.
//

import SwiftUI

struct InstructionView: View {
    
    @EnvironmentObject var handGestureProcessor: HandGestureProcessor
    
    @Binding var currentLetter: String
    
    @Binding var index: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.black)
                .frame(width: 350, height: 225)
                .scaledToFit()
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 350, height: 225)
                        .scaledToFit()
                        .foregroundStyle(.white)
                        .opacity(0.8)
                }
                .overlay {
                    VStack{
                        HStack {
                            Spacer()
                            Text("\(index)/26")
                                .padding()
                        }
                        Text("Write the \(currentLetter) letter!")
                            .foregroundStyle(.black)
                            .font(.largeTitle)
                            .padding()
                        BrailleSolutionDotsView(isSelected: $handGestureProcessor.alphabetSession.alphabet[index].dots)
                            .scaledToFill()
                            .padding()
                    }
                }
        }
    }
}

#Preview {
    InstructionView(currentLetter: .constant("A"), index: .constant(1))
        .environmentObject(HandGestureProcessor())
}
