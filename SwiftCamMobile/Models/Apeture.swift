//
//  ApetureModel.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 24/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

struct Apeture: Displayable {
    var blurRadius: CGFloat
    var description: String

    static let all = [Apeture(blurRadius: 40.0, description: "1.4"),
                       Apeture(blurRadius: 25.0, description: "1.8"),
                       Apeture(blurRadius: 15.0, description: "2.0"),
                       Apeture(blurRadius: 10.0, description: "2.2"),
                       Apeture(blurRadius: 5.0, description: "3.5"),
                       Apeture(blurRadius: 4.0, description: "5.6"),
                       Apeture(blurRadius: 3.0, description: "11"),
                       Apeture(blurRadius: 0.0, description: "18")]
}
