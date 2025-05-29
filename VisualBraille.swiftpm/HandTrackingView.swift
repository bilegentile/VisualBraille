//
//  SwiftUIView.swift
//  VisualBraille
//
//  Created by Beniamino Gentile on 16/02/25.
//

import SwiftUI
import AVFoundation
import Vision

struct HandTrackingView: View {
    @State private var leftFingers: [VNHumanHandPoseObservation.JointName: VNRecognizedPoint] = [:]
    @State private var rightFingers: [VNHumanHandPoseObservation.JointName: VNRecognizedPoint] = [:]
    
    @EnvironmentObject var handGestureProcessor: HandGestureProcessor
    
    var body: some View {
        ZStack {
            CameraView(leftFingers: $leftFingers, rightFingers: $rightFingers)
            
            Circle()
                .fill(.blue)
                .frame(width: 15)
                .position(x: handGestureProcessor.leftHand.thumbTip.x,
                          y: handGestureProcessor.leftHand.thumbTip.y)
            
            Circle()
                .fill(.blue)
                .frame(width: 15)
                .position(x: handGestureProcessor.leftHand.indexTip.x,
                          y: handGestureProcessor.leftHand.indexTip.y)
            
            Circle()
                .fill(.blue)
                .frame(width: 15)
                .position(x: handGestureProcessor.leftHand.middleTip.x,
                          y: handGestureProcessor.leftHand.middleTip.y)
            
            Circle()
                .fill(.blue)
                .frame(width: 15)
                .position(x: handGestureProcessor.leftHand.ringTip.x,
                          y: handGestureProcessor.leftHand.ringTip.y)
            
            Circle()
                .fill(.blue)
                .frame(width: 15)
                .position(x: handGestureProcessor.leftHand.littleTip.x,
                          y: handGestureProcessor.leftHand.littleTip.y)
            
            //RIGHT HAND
            
            Circle()
                .fill(.yellow)
                .frame(width: 15)
                .position(x: handGestureProcessor.rightHand.thumbTip.x,
                          y: handGestureProcessor.rightHand.thumbTip.y)
            
            Circle()
                .fill(.yellow)
                .frame(width: 15)
                .position(x: handGestureProcessor.rightHand.indexTip.x,
                          y: handGestureProcessor.rightHand.indexTip.y)
            
            Circle()
                .fill(.yellow)
                .frame(width: 15)
                .position(x: handGestureProcessor.rightHand.middleTip.x,
                          y: handGestureProcessor.rightHand.middleTip.y)
            
            Circle()
                .fill(.yellow)
                .frame(width: 15)
                .position(x: handGestureProcessor.rightHand.ringTip.x,
                          y: handGestureProcessor.rightHand.ringTip.y)
            
            Circle()
                .fill(.yellow)
                .frame(width: 15)
                .position(x: handGestureProcessor.rightHand.littleTip.x,
                          y: handGestureProcessor.rightHand.littleTip.y)
            
            DottedLineView()
        }
        .edgesIgnoringSafeArea(.all)
    }

}

#Preview {
    HandTrackingView()
}

