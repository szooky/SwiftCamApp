//
//  GradientDirection.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 31/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

enum GradientDirection {
    case leftToRight
    case rightToLeft

    var startPoint: CGPoint {
        switch self {
        case .leftToRight: return CGPoint(x: 0.0, y: 1.0)
        case .rightToLeft: return CGPoint(x: 1.0, y: 1.0)
        }
    }

    var endPoint: CGPoint {
        switch self {
        case .leftToRight: return CGPoint(x: 1.0, y: 1.0)
        case .rightToLeft: return CGPoint(x: 0.0, y: 1.0)
        }
    }
}
