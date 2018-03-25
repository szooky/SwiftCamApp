//
//  CIContext+Singleton.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 25/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

class CIContextSingleton {
    static let sharedInstance = CIContextSingleton()
    let ciContext  = CIContext(options: nil)
    private init() {}
}
