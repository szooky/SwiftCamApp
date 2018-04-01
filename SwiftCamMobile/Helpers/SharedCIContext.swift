//
//  CIContext+Singleton.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 25/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

class SharedCIContext {
    static let sharedInstance = SharedCIContext()
    let ciContext  = CIContext(options: nil)
    private init() {}
}
