//
//  ShutterSpeedModel.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 24/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

struct ShutterSpeed: Displayable {
    var description: String
    var exposure: CGFloat
    var motionBlurRadius: CGFloat

    static let all = [ShutterSpeed(description: "A", exposure: 0.5, motionBlurRadius: 0.0),
                      ShutterSpeed(description: "4000", exposure: -6.0, motionBlurRadius: 0.0),
                      ShutterSpeed(description: "2000", exposure: -5.0, motionBlurRadius: 0.0),
                      ShutterSpeed(description: "1000", exposure: -4.0, motionBlurRadius: 0.0),
                      ShutterSpeed(description: "500", exposure: -3.0, motionBlurRadius: 0.0),
                      ShutterSpeed(description: "250", exposure: -2.0, motionBlurRadius: 0.0),
                      ShutterSpeed(description: "180x", exposure: -1.0, motionBlurRadius: 0.0),
                      ShutterSpeed(description: "125", exposure: 0.0, motionBlurRadius: 0.0),
                      ShutterSpeed(description: "60", exposure: 1.0, motionBlurRadius: 1.0),
                      ShutterSpeed(description: "30", exposure: 2.0, motionBlurRadius: 20.0),
                      ShutterSpeed(description: "15", exposure: 3.0, motionBlurRadius: 50.0),
                      ShutterSpeed(description: "8", exposure: 4.0, motionBlurRadius: 80.0),
                      ShutterSpeed(description: "4", exposure: 5.0, motionBlurRadius: 100.0),
                      ShutterSpeed(description: "2", exposure: 6.0, motionBlurRadius: 200.0),
                      ShutterSpeed(description: "1", exposure: 7.0, motionBlurRadius: 300.0)]
}
