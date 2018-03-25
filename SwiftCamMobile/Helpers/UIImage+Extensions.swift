//
//  UIImage+Extensions.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 24/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

enum CameraFilter: String {
    case exposure = "CIExposureAdjust"
    case blur = "CIGaussianBlur"
}

extension UIImageView {
    private func apply(_ filterType: CameraFilter, withValue value: Any?, forKey key: String) {
        guard let filter = CIFilter(name: filterType.rawValue) else { return }
        guard let image = image else { return }

        filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
        filter.setValue(value, forKey: key)

        guard let result = filter.value(forKey: kCIOutputImageKey) as? CIImage else { return }
        let boundingRect = CGRect(x: 0,
                                  y: 0,
                                  width: image.size.width,
                                  height: image.size.height)

        guard let cgImage = CIContextSingleton.sharedInstance.ciContext.createCGImage(result, from: boundingRect) else { return}
        self.image = UIImage(cgImage: cgImage)
    }

    func exposure(withEV ev: CGFloat?) {
        guard let ev = ev else { return }
        apply(.exposure, withValue: ev, forKey: kCIInputEVKey)
    }

    func blur(withRadius radius: CGFloat?) {
        guard let radius = radius else { return }
        apply(.blur, withValue: radius, forKey: kCIInputRadiusKey)
    }
}
