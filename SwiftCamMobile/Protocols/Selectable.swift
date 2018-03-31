//
//  CameraControlDelegate.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 31/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import Foundation

protocol Selectable: class {
    func didSelect(index: Int, in control: Any?)
}
