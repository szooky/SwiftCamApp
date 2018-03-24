//
//  ApetureModel.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 24/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

struct Apeture: CameraParameterProtocol {
    var blurRadius: CGFloat
    var description: String

    static let all = [Apeture(blurRadius: 8.0, description: "1.4"),
                       Apeture(blurRadius: 6.0, description: "1.8"),
                       Apeture(blurRadius: 5.0, description: "2.0"),
                       Apeture(blurRadius: 3.0, description: "2.2"),
                       Apeture(blurRadius: 0.0, description: "4"),
                       Apeture(blurRadius: 1.0, description: "5.6"),
                       Apeture(blurRadius: 1.0, description: "11"),
                       Apeture(blurRadius: 1.0, description: "18")]
}