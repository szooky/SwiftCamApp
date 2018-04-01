//
//  CameraSettingsModel.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 24/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import Foundation

struct CameraSettings {
    var apeture = Apeture.all.first
    var shutterSpeed = ShutterSpeed.all.first
    var whiteBalance = WhiteBalance.all.first
}
