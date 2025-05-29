//
//  SwiftUIView.swift
//  VisualBraille
//
//  Created by Beniamino Gentile on 22/02/25.
//

import SwiftUI

struct BrailleSolutionDotsView: View {
    
    @Binding var isSelected: [Bool]
    
    var body: some View {
        ZStack{
            VStack(alignment: .center){
                Grid {
                    GridRow {
                        Circle()
                            .foregroundStyle(.black)
                            .frame(width: isSelected[0] ? 20 : 10, height: isSelected[0] ? 20 : 10)
                        
                        Circle()
                            .foregroundStyle(.black)
                            .frame(width: isSelected[3] ? 20 : 10, height: isSelected[3] ? 20 : 10)
                    }
                    GridRow {
                        Circle()
                            .foregroundStyle(.black)
                            .frame(width: isSelected[1] ? 20 : 10, height: isSelected[1] ? 20 : 10)
                        Circle()
                            .foregroundStyle(.black)
                            .frame(width: isSelected[4] ? 20 : 10, height: isSelected[4] ? 20 : 10)
                    }
                    GridRow {
                        Circle()
                            .foregroundStyle(.black)
                            .frame(width: isSelected[2] ? 20 : 10, height: isSelected[2] ? 20 : 10)
                        Circle()
                            .foregroundStyle(.black)
                            .frame(width: isSelected[5] ? 20 : 10, height: isSelected[5] ? 20 : 10)
                    }
                }
            }
            .scaledToFit()
        }
    }

}

#Preview {
    BrailleSolutionDotsView(isSelected: .constant([true, false, false, false, false , false]))
}
