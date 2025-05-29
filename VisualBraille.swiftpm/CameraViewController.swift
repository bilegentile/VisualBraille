//
//  SwiftUIView.swift
//  VisualBraille
//
//  Created by Beniamino Gentile on 16/02/25.
//

import UIKit
import AVFoundation
import Vision
import SwiftUI

class CameraViewController: UIViewController {
    private let videoDataOutputQueue = DispatchQueue(label: "CameraFeedDataOutput", qos: .userInteractive)
    private var cameraFeedSession: AVCaptureSession?
    var leftPointsDetected: (([VNHumanHandPoseObservation.JointName: VNRecognizedPoint]) -> Void)?
    var rightPointsDetected: (([VNHumanHandPoseObservation.JointName: VNRecognizedPoint]) -> Void)?
    
    private var videoPreviewLayer = AVCaptureVideoPreviewLayer()
    
    // Vision request to detect human hand poses.
    private let handPoseRequest: VNDetectHumanHandPoseRequest = {
        let request = VNDetectHumanHandPoseRequest()
        request.maximumHandCount = 2
        return request
    }()
    
    var pointsProcessorHandler: (([CGPoint]) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        do {
#if targetEnvironment(simulator)
            try setupAVSessionOnMac()
#endif
        try setupAVSession()
        } catch let error as AppError {
            showErrorAlert(error)
        } catch {
            showErrorAlert(.camera)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        cameraFeedSession?.stopRunning()
        super.viewWillDisappear(animated)
    }

    func setupAVSession() throws {
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else {
            throw AppError.camera
        }

        guard let deviceInput = try? AVCaptureDeviceInput(device: videoDevice) else {
            throw AppError.camera
        }

        let session = AVCaptureSession()
        session.beginConfiguration()
        session.sessionPreset = .high

        guard session.canAddInput(deviceInput) else { throw AppError.camera }
        session.addInput(deviceInput)

        let dataOutput = AVCaptureVideoDataOutput()
        if session.canAddOutput(dataOutput) {
            session.addOutput(dataOutput)
            dataOutput.alwaysDiscardsLateVideoFrames = true
            dataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)]
            dataOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
        } else {
            throw AppError.camera
        }

        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.connection?.videoOrientation = .landscapeRight
        view.layer.addSublayer(videoPreviewLayer)
        videoPreviewLayer.frame = view.bounds

        session.commitConfiguration()
        session.startRunning()
        cameraFeedSession = session
    }
    
    func setupAVSessionOnMac() throws {
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else {
            throw AppError.camera
        }

        guard let deviceInput = try? AVCaptureDeviceInput(device: videoDevice) else {
            throw AppError.camera
        }

        let session = AVCaptureSession()
        session.beginConfiguration()
        session.sessionPreset = .high

        guard session.canAddInput(deviceInput) else { throw AppError.camera }
        session.addInput(deviceInput)

        let dataOutput = AVCaptureVideoDataOutput()
        if session.canAddOutput(dataOutput) {
            session.addOutput(dataOutput)
            dataOutput.alwaysDiscardsLateVideoFrames = true
            dataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)]
            dataOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
        } else {
            throw AppError.camera
        }

        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.connection?.videoOrientation = .portrait
        view.layer.addSublayer(videoPreviewLayer)
        videoPreviewLayer.frame = view.bounds

        session.commitConfiguration()
        session.startRunning()
        cameraFeedSession = session
    }
    
    private func showErrorAlert(_ error: AppError) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension CameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func actorCaptureOutput(_ params: SendableOutputBuffer) async {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(params.sampleBuffer) else {
            return
        }
        self.captureHandPose(in: pixelBuffer)
    }
    
    nonisolated public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        let sendableParams = SendableOutputBuffer(output: output, sampleBuffer: sampleBuffer, connection: connection)
        
        Task {
            await actorCaptureOutput(sendableParams)
        }
    }
    
    func captureHandPose(in pixelBuffer: CVPixelBuffer) {
        let handler = VNImageRequestHandler(
            cvPixelBuffer: pixelBuffer,
            orientation: .right,
            options: [:]
        )
        
        var fingerTips: [CGPoint] = []

        do {
            try handler.perform([handPoseRequest])
            guard let results = handPoseRequest.results?.prefix(2), !results.isEmpty else {
                DispatchQueue.main.async {
                    //self.handGestureProcessor.reset()
                }
                return
            }
            
            let halfScreenSize = UIScreen.main.bounds.size.width / 2
            
            var recognizedPoints: [VNRecognizedPoint] = []
        
            try results.forEach { observation in
                if try convertHandPoints(observation.recognizedPoint(.wrist).location).x < halfScreenSize {
                    let fingers = try observation.recognizedPoints(.all)
                    
                    self.leftPointsDetected?(fingers)
                } else {
                    let fingers = try observation.recognizedPoints(.all)
                    self.rightPointsDetected?(fingers)
                }
            }
            
            fingerTips = recognizedPoints.filter {
                $0.confidence > 0.9
            }
            .map {
                CGPoint(x: $0.location.x, y: 1 - $0.location.y)
            }

        } catch {
            DispatchQueue.main.async {
                self.showErrorAlert(.vision)
            }
            print("Hand tracking failed: \(error)")
        }
    }
    
    // Convert Vision coordinate system to SwiftUI coordinate system
    @MainActor
    private func convertHandPoints(_ point: CGPoint) -> CGPoint {
        let screenSize = UIScreen.main.bounds.size
        return CGPoint(x: (1 - point.y) * (screenSize.width), y: point.x * screenSize.height)
    }
}

extension CGAffineTransform {
    @MainActor static var verticalFlip = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -1)
}

