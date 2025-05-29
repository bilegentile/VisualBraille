//
//  DottedLineView.swift
//  VisualBraille
//
//  Created by Beniamino Gentile on 22/02/25.
//
import SwiftUI

struct DottedLineView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Path { path in
                    let midX = geometry.size.width / 2
                    path.move(to: CGPoint(x: midX, y: 0))
                    path.addLine(to: CGPoint(x: midX, y: geometry.size.height))
                }
                .stroke(style: StrokeStyle(lineWidth: 2, dash: [5, 5])) // Dotted line pattern
                .foregroundStyle(.black)
                
                HStack {
                    Text("Left Hand")
                        .font(.headline)
                        .foregroundStyle(.black)
                        .padding(.trailing, 20)
                    
                    Text("Right Hand")
                        .font(.headline)
                        .foregroundStyle(.black)
                        .padding(.leading, 20)
                }
                .frame(width: geometry.size.width, height: 40)
                .position(x: geometry.size.width / 2, y: 20)
            }
        }
    }
}
