//
//  SendableOutputBuffer.swift
//  VisualBraille
//
//  Created by Beniamino Gentile on 16/02/25.
//
import AVFoundation

struct SendableOutputBuffer: @unchecked Sendable {
    let output: AVCaptureOutput
    let sampleBuffer: CMSampleBuffer
    let connection: AVCaptureConnection
}
