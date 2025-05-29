//
//  File.swift
//  VisualBraille
//
//  Created by Beniamino Gentile on 16/02/25.
//

import Foundation

enum AppError: Error {
    case camera
    case vision
    
    var alertDescription: String {
        switch self {
        case .camera:
            return "Failed to access the camera. Please try again."
        case .vision:
            return "Hand tracking failed. Please try again."
        }
    }
}
