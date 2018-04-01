//
//  ImageFilter.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 31/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import CoreImage

typealias ImageFilterKeyValue = (ImageFilter, Any?)

enum ImageFilter: String {
    case exposure = "CIExposureAdjust"
    case gaussianBlur = "CIGaussianBlur"
    case motionBlur = "CIMotionBlur"
    case temperatureAndTint = "CITemperatureAndTint"

    var valueKey: String {
        switch self {
        case .exposure:
            return kCIInputEVKey
        case .gaussianBlur:
            return kCIInputRadiusKey
        case .motionBlur:
            return kCIInputRadiusKey
        case .temperatureAndTint:
            return "inputNeutral"
        }
    }
}
