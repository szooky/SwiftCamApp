//
//  WhiteBalance.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 25/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

struct WhiteBalance: Displayable {
    var temperature: CGFloat
    var description: String

    var temperatureVector: CIVector {
        return CIVector(cgPoint: CGPoint(x: temperature, y: 0))
    }

    static let all = [WhiteBalance(temperature: 2000.0, description: "2000K"),
                      WhiteBalance(temperature: 3000.0, description: "3000K"),
                      WhiteBalance(temperature: 6500.0, description: "6500K"),
                      WhiteBalance(temperature: 70000.0, description: "7000K"),
                      WhiteBalance(temperature: 150000.0, description: "9000K")]
}
