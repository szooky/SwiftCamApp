//
//  CoreImageWrapper.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 30/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit
import CoreImage

enum ImageFilterType: String {
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


class CoreImageWrapper {
     class func apply(_ filters: [(ImageFilterType, Any?)], to image: UIImage) -> UIImage? {
        var ciImage = CIImage(image: image)
        let ciContext = CIContextSingleton.sharedInstance.ciContext
        let boundingRect = CGRect(x: 0,
                                  y: 0,
                                  width: image.size.width,
                                  height: image.size.height)

        for (filterType, filterValue) in filters {
            guard let filter = CIFilter(name: filterType.rawValue) else { return nil }
            filter.setValue(ciImage, forKey: kCIInputImageKey)
            filter.setValue(filterValue, forKey: filterType.valueKey)
            ciImage = filter.value(forKey: kCIOutputImageKey) as? CIImage
        }

        guard let resultCiImage = ciImage else { return nil }
        guard let cgImage = ciContext.createCGImage(resultCiImage, from: boundingRect) else { return nil }
        return UIImage(cgImage: cgImage)
    }
}
