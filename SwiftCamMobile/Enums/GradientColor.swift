//
//  GradientColor.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 31/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

enum GradientColor {
    case blackToOpaque

    var values: [CGColor] {
        switch self {
        case .blackToOpaque: return [UIColor.black.cgColor, UIColor.white.withAlphaComponent(0).cgColor]
        }
    }
}
