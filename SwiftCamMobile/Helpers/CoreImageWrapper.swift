//
//  CoreImageWrapper.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 30/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit
import CoreImage

class CoreImageWrapper {
    class func apply(_ settings: CameraSettings, to image: UIImage, isBackground: Bool) -> UIImage? {
        var filters = [ImageFilterKeyValue]()

        filters.append((.motionBlur, settings.shutterSpeed?.motionBlurRadius))
        filters.append((.exposure, settings.shutterSpeed?.exposure))
        filters.append((.temperatureAndTint, settings.whiteBalance?.temperatureVector))

        if isBackground {
            filters.append((.gaussianBlur, settings.apeture?.blurRadius))
        }

        return apply(filters, to: image)
    }

     private class func apply(_ filters: [(ImageFilter, Any?)], to image: UIImage) -> UIImage? {
        var ciImage = CIImage(image: image)
        let ciContext = SharedCIContext.sharedInstance.ciContext
        let boundingRect = CGRect(origin: .zero, size: image.size)

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
