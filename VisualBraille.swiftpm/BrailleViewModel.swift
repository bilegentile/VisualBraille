//
//  BrailleViewModel.swift
//  VisualBraille
//
//  Created by Beniamino Gentile on 18/02/25.
//
import Foundation

class BrailleViewModel {
    var alphabet = [
        BrailleModel(dots: [false, false, false, false, false, false], letter: "Blank"),
        BrailleModel(dots: [true, false, false, false, false, false], letter: "A"),
        BrailleModel(dots: [true, true, false, false, false, false], letter: "B"),
        BrailleModel(dots: [true, false, false, true, false, false], letter: "C"),
        BrailleModel(dots: [true, false, false, true, true, false], letter: "D"),
        BrailleModel(dots: [true, false, false, false, true, false], letter: "E"),
        BrailleModel(dots: [true, true, false, true, false, false], letter: "F"),
        BrailleModel(dots: [true, true, false, true, true, false], letter: "G"),
        BrailleModel(dots: [true, true, false, false, true, false], letter: "H"),
        BrailleModel(dots: [false, true, false, true, false, false], letter: "I"),
        BrailleModel(dots: [false, true, false, true, true, false], letter: "J"),
        BrailleModel(dots: [true, false, true, false, false, false], letter: "K"),
        BrailleModel(dots: [true, true, true, false, false, false], letter: "L"),
        BrailleModel(dots: [true, false, true, true, false, false], letter: "M"),
        BrailleModel(dots: [true, false, true, true, true, false], letter: "N"),
        BrailleModel(dots: [true, false, true, false, true, false], letter: "O"),
        BrailleModel(dots: [true, true, true, true, false, false], letter: "P"),
        BrailleModel(dots: [true, true, true, true, true, false], letter: "Q"),
        BrailleModel(dots: [true, true, true, false, true, false], letter: "R"),
        BrailleModel(dots: [false, true, true, true, false, false], letter: "S"),
        BrailleModel(dots: [false, true, true, true, true, false], letter: "T"),
        BrailleModel(dots: [true, false, true, false, false, true], letter: "U"),
        BrailleModel(dots: [true, true, true, false, false, true], letter: "V"),
        BrailleModel(dots: [false, true, false, true, true, true], letter: "W"),
        BrailleModel(dots: [true, false, true, true, false, true], letter: "X"),
        BrailleModel(dots: [true, false, true, true, true, true], letter: "Y"),
        BrailleModel(dots: [true, false, true, false, true, true], letter: "Z")
    ]
}
