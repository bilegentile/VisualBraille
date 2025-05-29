//
//  BrailleModel.swift
//  VisualBraille
//
//  Created by Beniamino Gentile on 18/02/25.
//
import Foundation

struct BrailleModel: Identifiable {
    var id = UUID()
    
    var dots: [Bool]
    var letter: String
}
