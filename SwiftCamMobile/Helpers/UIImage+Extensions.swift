//
//  UIImage+Extensions.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 24/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

extension Optional where Wrapped == UIImage {
    func copy() -> UIImage? {
        guard let cgImage = self?.cgImage?.copy() else {
            return nil
        }
        return UIImage(cgImage: cgImage,
                       scale: self!.scale,
                       orientation: self!.imageOrientation)

    }
}


//class CameraFilter {
//    private func apply(on image: UIImage, _ filterType: CameraFilterType, withValue value: Any?, forKey key: String) -> UIImage? {
//        guard let filter = CIFilter(name: filterType.rawValue) else { return nil }
//
//        filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
//        filter.setValue(value, forKey: key)
//
//        guard let result = filter.value(forKey: kCIOutputImageKey) as? CIImage else { return nil }
//        let boundingRect = CGRect(x: 0,
//                                  y: 0,
//                                  width: image.size.width,
//                                  height: image.size.height)
//
//        guard let cgImage = CIContextSingleton.sharedInstance.ciContext.createCGImage(result, from: boundingRect) else { return nil}
//        return UIImage(cgImage: cgImage)
//    }
//
//    func exposure(on image: UIImage, withEV ev: CGFloat?) -> UIImage? {
//        guard let ev = ev else { return nil }
//        return apply(on: image, .exposure, withValue: ev, forKey: kCIInputEVKey)
//    }
//
//    func gaussianBlur(on image: UIImage, withRadius radius: CGFloat?) -> UIImage? {
//        guard let radius = radius else { return nil }
//        return apply(on: image, .gaussianBlur, withValue: radius, forKey: kCIInputRadiusKey)
//    }
//
//    func motionBlur(on image: UIImage, withRadius radius: CGFloat?) -> UIImage? {
//        guard let radius = radius else { return nil}
//        return apply(on: image, .motionBlur, withValue: radius, forKey: kCIInputRadiusKey)
//    }
//
//    func whiteBalance(on image: UIImage, temperature: CGFloat?) -> UIImage? {
//        guard let temperature = temperature else { return nil}
//        let value = CIVector(cgPoint: CGPoint(x: temperature, y: 0.0))
//        return apply(on: image, .temperatureAndTint, withValue: value, forKey: "inputNeutral")
//    }
//}

