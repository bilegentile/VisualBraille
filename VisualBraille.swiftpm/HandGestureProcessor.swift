//
//  HandGestureProcessor.swift
//  VisualBraille
//
//  Created by Beniamino Gentile on 17/02/25.
//
import Foundation
import Vision
import UIKit

class HandGestureProcessor: ObservableObject {
    
    @Published var leftHand = HandModel()
    @Published var rightHand = HandModel()
    
    @Published var userHandBrailleInput = [false, false, false, false, false, false]
    
    @Published var proposedSolution = [false, false, false, false, false, false]
    
    @Published var alphabetSession = BrailleViewModel()
    
    @MainActor
    /// Analyzes the positions of fingers and takes action based on their position.
    func leftHandMap(fingers: [VNHumanHandPoseObservation.JointName: VNRecognizedPoint]) {
        
        guard let thumbTipPoint = fingers[.thumbTip], thumbTipPoint.confidence > 0.8 else {
            return
        }
        
        leftHand.thumbTipCGPoint = getLeftFingerCGPoint(thumbTipPoint)
        leftHand.thumbTip = convertHandPoints(leftHand.thumbTipCGPoint)
        
        // Check for Index Finger
        if let indexTipPoint = fingers[.indexTip], indexTipPoint.confidence > 0.75 {
            leftHand.indexTipCGPoint = getLeftFingerCGPoint(indexTipPoint)
            leftHand.indexTip = convertHandPoints(leftHand.indexTipCGPoint)
            let isPinched = fingerRecognized(thumbTipCG: leftHand.thumbTipCGPoint, otherFinger: leftHand.indexTipCGPoint, fingerName: "Left Index")
            userHandBrailleInput[0] = isPinched
            if isPinched == true {
                proposedSolution[0] = true
            }
        }
        
        // Check for Middle Finger
        if let middleTipPoint = fingers[.middleTip], middleTipPoint.confidence > 0.75 {
            leftHand.middleTipCGPoint = getLeftFingerCGPoint(middleTipPoint)
            leftHand.middleTip = convertHandPoints(leftHand.middleTipCGPoint)
            let isPinched = fingerRecognized(thumbTipCG: leftHand.thumbTipCGPoint, otherFinger: leftHand.middleTipCGPoint, fingerName: "Left Middle")
            userHandBrailleInput[1] = isPinched
            if isPinched == true {
                proposedSolution[1] = true
            }
        }
        
        // Check for Ring Finger
        if let ringTipPoint = fingers[.ringTip], ringTipPoint.confidence > 0.75 {
            leftHand.ringTipCGPoint = getLeftFingerCGPoint(ringTipPoint)
            leftHand.ringTip = convertHandPoints(leftHand.ringTipCGPoint)
            let isPinched = fingerRecognized(thumbTipCG: leftHand.thumbTipCGPoint, otherFinger: leftHand.ringTipCGPoint, fingerName: "Left Ring")
            userHandBrailleInput[2] = isPinched
            if isPinched == true {
                proposedSolution[2] = true
            }
        }
        
        // Check for Little Finger
        if let littleTipPoint = fingers[.littleTip], littleTipPoint.confidence > 0.75 {
            leftHand.littleTipCGPoint = getLeftFingerCGPoint(littleTipPoint)
            leftHand.littleTip = convertHandPoints(leftHand.littleTipCGPoint)
            let isPinched = fingerRecognized(thumbTipCG: leftHand.thumbTipCGPoint, otherFinger: leftHand.littleTipCGPoint, fingerName: "Left Little")
            if isPinched == true {
                resetLeftHand()
            }
        }
    }
    
    @MainActor
    /// Analyzes the positions of fingers and takes action based on their position.
    func rightHandMap(fingers: [VNHumanHandPoseObservation.JointName: VNRecognizedPoint]) {
        
        guard let thumbTipPoint = fingers[.thumbTip], thumbTipPoint.confidence > 0.8 else {
            return
        }
        
        rightHand.thumbTipCGPoint = getRightFingerCGPoint(thumbTipPoint)
        rightHand.thumbTip = convertHandPoints(rightHand.thumbTipCGPoint)
        
        // Check for Index Finger
        if let indexTipPoint = fingers[.indexTip], indexTipPoint.confidence > 0.75 {
            rightHand.indexTipCGPoint = getRightFingerCGPoint(indexTipPoint)
            rightHand.indexTip = convertHandPoints(rightHand.indexTipCGPoint)
            let isPinched = fingerRecognized(thumbTipCG: rightHand.thumbTipCGPoint, otherFinger: rightHand.indexTipCGPoint, fingerName: "Right Index")
            userHandBrailleInput[3] = isPinched
            if isPinched == true {
                proposedSolution[3] = true
            }
        }
        
        // Check for Middle Finger
        if let middleTipPoint = fingers[.middleTip], middleTipPoint.confidence > 0.75 {
            rightHand.middleTipCGPoint = getRightFingerCGPoint(middleTipPoint)
            rightHand.middleTip = convertHandPoints(rightHand.middleTipCGPoint)
            let isPinched = fingerRecognized(thumbTipCG: rightHand.thumbTipCGPoint, otherFinger: rightHand.middleTipCGPoint, fingerName: "Right Middle")
            userHandBrailleInput[4] = isPinched
            if isPinched == true {
                proposedSolution[4] = true
            }
        }
        
        // Check for Ring Finger
        if let ringTipPoint = fingers[.ringTip], ringTipPoint.confidence > 0.75 {
            rightHand.ringTipCGPoint = getRightFingerCGPoint(ringTipPoint)
            rightHand.ringTip = convertHandPoints(rightHand.ringTipCGPoint)
            let isPinched = fingerRecognized(thumbTipCG: rightHand.thumbTipCGPoint, otherFinger: rightHand.ringTipCGPoint, fingerName: "Right Ring")
            userHandBrailleInput[5] = isPinched
            if isPinched == true {
                proposedSolution[5] = true
            }
            
        }
        
        // Check for Little Finger
        if let littleTipPoint = fingers[.littleTip], littleTipPoint.confidence > 0.75 {
            rightHand.littleTipCGPoint = getRightFingerCGPoint(littleTipPoint)
            rightHand.littleTip = convertHandPoints(rightHand.littleTipCGPoint)
            let isPinched = fingerRecognized(thumbTipCG: rightHand.thumbTipCGPoint, otherFinger: rightHand.littleTipCGPoint, fingerName: "Right Little")
            if isPinched == true {
                resetRightHand()
            }
        }
    }
    
    /// Converts the given recognized point into a CGPoint.
    func getLeftFingerCGPoint(_ finger: VNRecognizedPoint) -> CGPoint {
        return CGPoint(x: finger.location.x , y: 0.95 - finger.location.y)
    }
    
    func getRightFingerCGPoint(_ finger: VNRecognizedPoint) -> CGPoint {
        return CGPoint(x: finger.location.x , y: 1.05 - finger.location.y)
    }
    
    /// Calculates the squared distance between two CGPoints.
    func cgPointDistanceSquared(from: CGPoint, to: CGPoint) -> CGFloat {
        return (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
    }
    
    /// Determines if fingers are recognized based on the distance between their positions.
    func fingerRecognized(thumbTipCG: CGPoint, otherFinger: CGPoint, fingerName: String) -> Bool {
        //let distance = cgPointDistanceSquared(from: thumbTipCG, to: otherFinger)
        let distance = thumbTipCG.distance(from: otherFinger)
        //print("Distance between points is \(distance)")
        if distance < 0.01{
            //playMajorChord(root: 67, finger: fingerName) // G V
            print("Il Pollice e il \(fingerName) sono vicini")
            print(proposedSolution)
            return true
        }
        return false
    }
    
    func resetLeftHand() {
        proposedSolution[0] = false
        proposedSolution[1] = false
        proposedSolution[2] = false
    }
    
    func resetRightHand() {
        proposedSolution[3] = false
        proposedSolution[4] = false
        proposedSolution[5] = false
    }
    
    func checkCorrectAnswer(proposedAnswer: [Bool], correctAnswer: [Bool]) -> Bool {
        let allFalseCheck = proposedAnswer.allSatisfy { $0 == false }
        if !allFalseCheck && proposedAnswer.elementsEqual(correctAnswer) {
            return true
        }
        return false
    }
    
    // Convert Vision coordinate system to SwiftUI coordinate system
    @MainActor
    private func convertHandPoints(_ point: CGPoint) -> CGPoint {
        let screenSize = UIScreen.main.bounds.size
        let y = point.x * screenSize.height
        let x = point.y * (screenSize.width)
        return CGPoint(x: x, y: y)
    }
    
}
