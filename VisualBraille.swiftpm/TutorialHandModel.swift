//
//  Untitled.swift
//  VisualBraille
//
//  Created by Beniamino Gentile on 23/02/25.
//
import Foundation

struct TutorialHandModel: Identifiable, Hashable {
    var id = UUID()
    var fingerName: String
    var fingerImage: String
    var selectedDots: [Bool]
    var dotName: String
}
