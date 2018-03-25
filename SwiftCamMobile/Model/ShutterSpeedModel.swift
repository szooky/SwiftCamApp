//
//  ShutterSpeedModel.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 24/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

struct ShutterSpeed: CameraParameterProtocol {
    var exposure: CGFloat
    var description: String

    static let all = [ShutterSpeed(exposure: 0.5, description: "A"),
                        ShutterSpeed(exposure: -6.0, description: "4000"),
                        ShutterSpeed(exposure: -5.0, description: "2000"),
                        ShutterSpeed(exposure: -4.0, description: "1000"),
                        ShutterSpeed(exposure: -3.0, description: "500"),
                        ShutterSpeed(exposure: -2.0, description: "250"),
                        ShutterSpeed(exposure: -1.0, description: "180x"),
                        ShutterSpeed(exposure: 0.0, description: "125"),
                        ShutterSpeed(exposure: 1.0, description: "60"),
                        ShutterSpeed(exposure: 2.0, description: "30"),
                        ShutterSpeed(exposure: 3.0, description: "15"),
                        ShutterSpeed(exposure: 4.0, description: "8"),
                        ShutterSpeed(exposure: 5.0, description: "4"),
                        ShutterSpeed(exposure: 6.0, description: "2"),
                        ShutterSpeed(exposure: 7.0, description: "1"),
                        ShutterSpeed(exposure: 10.0, description: "B")]
}
