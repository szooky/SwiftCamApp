//
//  CameraSettingsModel.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 24/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import Foundation

class CameraSettingsModel {

    let apetures = [ApetureModel(blurRadius: 8.0, description: "1.4"),
                     ApetureModel(blurRadius: 6.0, description: "1.8"),
                     ApetureModel(blurRadius: 5.0, description: "2.0"),
                     ApetureModel(blurRadius: 3.0, description: "2.2"),
                     ApetureModel(blurRadius: 0.0, description: "4"),
                     ApetureModel(blurRadius: 1.0, description: "5.6"),
                     ApetureModel(blurRadius: 1.0, description: "11"),
                     ApetureModel(blurRadius: 1.0, description: "18")]

    let shutterSpeeds = [ShutterSpeedModel(exposure: 1.0, description: "A"),
                         ShutterSpeedModel(exposure: 1.0, description: "4000"),
                         ShutterSpeedModel(exposure: 1.0, description: "2000"),
                         ShutterSpeedModel(exposure: 1.0, description: "1000"),
                         ShutterSpeedModel(exposure: 1.0, description: "500"),
                         ShutterSpeedModel(exposure: 1.0, description: "250"),
                         ShutterSpeedModel(exposure: 1.0, description: "180x"),
                         ShutterSpeedModel(exposure: 1.0, description: "125"),
                         ShutterSpeedModel(exposure: 1.0, description: "60"),
                         ShutterSpeedModel(exposure: 1.0, description: "30"),
                         ShutterSpeedModel(exposure: 1.0, description: "15"),
                         ShutterSpeedModel(exposure: 1.0, description: "8"),
                         ShutterSpeedModel(exposure: 1.0, description: "4"),
                         ShutterSpeedModel(exposure: 1.0, description: "2"),
                         ShutterSpeedModel(exposure: 1.0, description: "1"),
                         ShutterSpeedModel(exposure: 1.0, description: "B")]

}
