//
//  SwiftUIView.swift
//  VisualBraille
//
//  Created by Beniamino Gentile on 22/02/25.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(decorative: "appIcon")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 50, style: .continuous))
                    .padding()
                Text("Welcome to VisualBraille!")
                    .font(.largeTitle)
                Text("by Beniamino Gentile")
                    .font(.subheadline)
                    .fontWeight(.light)
                    .padding()
                Text("In this app you will learn the Braille alphabet throught a visual interactive experience! \n You will use your hands and the camera to write letters in Braille.")
                    .multilineTextAlignment(.center)
                    .padding()
                Text("Be sure to stay in a well lit place and show the front of your hands to the camera!")
                HStack {
                    Image(decorative: "leftOpenHand")
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .padding()
                NavigationLink {
                    LeftHandTutorialView()
                } label: {
                    Label("Let's go!", systemImage: "chevron.right")
                        .foregroundStyle(.black)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.yellow)
                                .frame(width: 100, height: 40)
                        }
                            
                    
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview { 
    WelcomeView()
}
