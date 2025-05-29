//
//  File.swift
//  VisualBraille
//
//  Created by Beniamino Gentile on 16/02/25.
//
import SwiftUI
import Vision

struct CameraView: UIViewControllerRepresentable {
    @Binding var leftFingers: [VNHumanHandPoseObservation.JointName: VNRecognizedPoint]
    @Binding var rightFingers: [VNHumanHandPoseObservation.JointName: VNRecognizedPoint]
    
    @EnvironmentObject var handGestureProcessor: HandGestureProcessor

    func makeUIViewController(context: Context) -> CameraViewController {
        let cameraViewController = CameraViewController()
        cameraViewController.leftPointsDetected = { points in
            leftFingers = points
            self.handGestureProcessor.leftHandMap(fingers: leftFingers)
        }
        
        cameraViewController.rightPointsDetected = { points in
            rightFingers = points
            self.handGestureProcessor.rightHandMap(fingers: rightFingers)
            
        }
        return cameraViewController
    }

    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {}
}
