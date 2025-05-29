//
//  SwiftUIView.swift
//  VisualBraille
//
//  Created by Beniamino Gentile on 18/02/25.
//

import SwiftUI

struct BrailleDotsView: View {
    
    @Binding var isSelected: [Bool]
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 50){
            VStack(alignment: .leading){
                ZStack{
                    Circle()
                        .stroke(isSelected[0] ? .white : .black, lineWidth: 6)
                        .background {
                            Circle()
                                .foregroundStyle(isSelected[0] ? .black : .white)
                                .opacity(0.2)
                        }
                    Text("1")
                        .foregroundStyle(isSelected[0] ? .white : .black)
                        .font(.largeTitle)
                }
                ZStack{
                    Circle()
                        .stroke(isSelected[1] ? .white : .black, lineWidth: 6)
                        .background {
                            Circle()
                                .foregroundStyle(isSelected[1] ? .black : .white)
                                .opacity(0.2)
                        }
                    Text("2")
                        .foregroundStyle(isSelected[1] ? .white : .black)
                        .font(.largeTitle)
                }
                ZStack{
                    Circle()
                        .stroke(isSelected[2] ? .white : .black, lineWidth: 6)
                        .background {
                            Circle()
                                .foregroundStyle(isSelected[2] ? .black : .white)
                                .opacity(0.2)
                        }
                    Text("3")
                        .foregroundStyle(isSelected[2] ? .white : .black)
                        .font(.largeTitle)
                }
            }
            .scaledToFill()
            VStack(alignment: .trailing){
                ZStack{
                    Circle()
                        .stroke(isSelected[3] ? .white : .black, lineWidth: 6)
                        .background {
                            Circle()
                                .foregroundStyle(isSelected[3] ? .black : .white)
                                .opacity(0.2)
                        }
                    Text("4")
                        .foregroundStyle(isSelected[3] ? .white : .black)
                        .font(.largeTitle)
                }
                ZStack{
                    Circle()
                        .stroke(isSelected[4] ? .white : .black, lineWidth: 6)
                        .background {
                            Circle()
                                .foregroundStyle(isSelected[4] ? .black : .white)
                                .opacity(0.2)
                        }
                    Text("5")
                        .foregroundStyle(isSelected[4] ? .white : .black)
                        .font(.largeTitle)
                }
                ZStack{
                    Circle()
                        .stroke(isSelected[5] ? .white : .black, lineWidth: 6)
                        .background {
                            Circle()
                                .foregroundStyle(isSelected[5] ? .black : .white)
                                .opacity(0.2)
                        }
                    Text("6")
                        .foregroundStyle(isSelected[5] ? .white : .black)
                        .font(.largeTitle)
                }
            }
            .scaledToFill()
        }
    }
}

#Preview {
    BrailleDotsView(isSelected: .constant([true, false, false, false, false , false]))
}
