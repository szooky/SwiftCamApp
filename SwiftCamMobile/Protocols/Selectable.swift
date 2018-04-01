//
//  CameraControlDelegate.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 31/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import Foundation

protocol Selectable: class {
    var currentIndex: Int { get set }
    var components: [Displayable] { get set }
    var delegate: SelectableControlDelegate? { get set }
}

protocol SelectableControlDelegate: class {
    func didSelect(index: Int, in control: Selectable?)
}
