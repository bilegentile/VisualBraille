//
//  SwiftUIView.swift
//  VisualBraille
//
//  Created by Beniamino Gentile on 23/02/25.
//

import SwiftUI

struct CongratulationView: View {
    @Binding var isCongratulationsShowing : Bool
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.black)
                .frame(width: 600, height: 400)
                .scaledToFit()
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 350, height: 225)
                        .scaledToFill()
                        .foregroundStyle(.white)
                        .opacity(0.8)
                }
                .overlay {
                    VStack(spacing: 50){
                        Text("🎉 Congratulations! 🎉 \n 🎊 You learned the Braille Alphabet 🎊")
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.black)
                            .font(.largeTitle)
                            .padding()
                        NavigationLink {
                            WelcomeView()
                        } label: {
                            Label("Make a Review!", systemImage: "books.vertical.fill")
                                .foregroundStyle(.white)
                                .background {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.yellow)
                                        .frame(width: 200, height: 60)
                                }
                        }
                        .onTapGesture {
                            isCongratulationsShowing = false
                        }
                        
                    }
                }
        }
    }
}

#Preview {
    CongratulationView(isCongratulationsShowing: .constant(true))
}
