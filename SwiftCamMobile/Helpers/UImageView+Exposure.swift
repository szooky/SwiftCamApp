//
//  UImageView+Exposure.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 24/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

extension UIImageView {
    func exposure(withEV ev: CGFloat) {
        guard let exposure = CIFilter(name: "CIExposureAdjust") else { return }
        guard let image = image else { return }

        exposure.setValue(CIImage(image: image), forKey: kCIInputImageKey)
        exposure.setValue(ev, forKey: kCIInputEVKey)

        let ciContext  = CIContext(options: nil)
        guard let result = exposure.value(forKey: kCIOutputImageKey) as? CIImage else { return }

        let boundingRect = CGRect(x: 0,
                                  y: 0,
                                  width: image.size.width,
                                  height: image.size.height)

        guard let cgImage = ciContext.createCGImage(result, from: boundingRect) else { return}
        self.image = UIImage(cgImage: cgImage)
        contentMode = .scaleAspectFit
    }
    
}
