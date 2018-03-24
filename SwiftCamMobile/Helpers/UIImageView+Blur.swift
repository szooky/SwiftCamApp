//
//  UIImage+Blur.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 24/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

extension UIImageView {
    func blur(withRadius radius: CGFloat) {
        guard let blur = CIFilter(name: "CIGaussianBlur") else { return }
        guard let image = image else { return }

        blur.setValue(CIImage(image: image), forKey: kCIInputImageKey)
        blur.setValue(radius, forKey: kCIInputRadiusKey)

        let ciContext  = CIContext(options: nil)
        guard let result = blur.value(forKey: kCIOutputImageKey) as? CIImage else { return }

        let boundingRect = CGRect(x: 0,
                                  y: 0,
                                  width: frame.width,
                                  height: frame.height)

        guard let cgImage = ciContext.createCGImage(result, from: boundingRect) else { return}
        self.image = UIImage(cgImage: cgImage)
    }
}
